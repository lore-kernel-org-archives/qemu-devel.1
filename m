Received: from eggs.gnu.org ([2001:4830:134:3::10]:43945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f3hKA-0008AL-ID
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f3hK6-0002lT-2Q
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:15:34 -0400
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:42983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f3hK5-0002ky-S8
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:15:30 -0400
Received: by mail-io0-x22c.google.com with SMTP id d5so26060635iob.9
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 05:15:29 -0700 (PDT)
References: <20180401084848.36725-1-jiangshanlai@gmail.com>
	<20180404114709.45118-1-jiangshanlai@gmail.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <941b5dc2-739b-08c1-4f3a-a3a2d2818734@gmail.com>
Date: Wed, 4 Apr 2018 20:15:23 +0800
MIME-Version: 1.0
In-Reply-To: <20180404114709.45118-1-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4] migration: add capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Xu Wang <gnawux@gmail.com>, qemu-devel@nongnu.org, "James O . D . Hunt" <james.o.hunt@intel.com>, Peng Tao <bergwolf@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>



On 04/04/2018 07:47 PM, Lai Jiangshan wrote:
> 1) What's this
> 
> When the migration capability 'bypass-shared-memory'
> is set, the shared memory will be bypassed when migration.
> 
> It is the key feature to enable several excellent features for
> the qemu, such as qemu-local-migration, qemu-live-update,
> extremely-fast-save-restore, vm-template, vm-fast-live-clone,
> yet-another-post-copy-migration, etc..
> 
> The philosophy behind this key feature, including the resulting
> advanced key features, is that a part of the memory management
> is separated out from the qemu, and let the other toolkits
> such as libvirt, kata-containers (https://github.com/kata-containers)
> runv(https://github.com/hyperhq/runv/) or some multiple cooperative
> qemu commands directly access to it, manage it, provide features on it.
> 
> 2) Status in real world
> 
> The hyperhq(http://hyper.sh  http://hypercontainer.io/)
> introduced the feature vm-template(vm-fast-live-clone)
> to the hyper container for several years, it works perfect.
> (see https://github.com/hyperhq/runv/pull/297).
> 
> The feature vm-template makes the containers(VMs) can
> be started in 130ms and save 80M memory for every
> container(VM). So that the hyper containers are fast
> and high-density as normal containers.
> 
> kata-containers project (https://github.com/kata-containers)
> which was launched by hyper, intel and friends and which descended
> from runv (and clear-container) should have this feature enabled.
> Unfortunately, due to the code confliction between runv&cc,
> this feature was temporary disabled and it is being brought
> back by hyper and intel team.
> 
> 3) How to use and bring up advanced features.
> 
> In current qemu command line, shared memory has
> to be configured via memory-object.
> 
> a) feature: qemu-local-migration, qemu-live-update
> Set the mem-path on the tmpfs and set share=on for it when
> start the vm. example:
> -object \
> memory-backend-file,id=mem,size=128M,mem-path=/dev/shm/memory,share=on \
> -numa node,nodeid=0,cpus=0-7,memdev=mem
> 
> when you want to migrate the vm locally (after fixed a security bug
> of the qemu-binary, or other reason), you can start a new qemu with
> the same command line and -incoming, then you can migrate the
> vm from the old qemu to the new qemu with the migration capability
> 'bypass-shared-memory' set. The migration will migrate the device-state
> *ONLY*, the memory is the origin memory backed by tmpfs file.
> 
> b) feature: extremely-fast-save-restore
> the same above, but the mem-path is on the persistent file system.
> 
> c)  feature: vm-template, vm-fast-live-clone
> the template vm is started as 1), and paused when the guest reaches
> the template point(example: the guest app is ready), then the template
> vm is saved. (the qemu process of the template can be killed now, because
> we need only the memory and the device state files (in tmpfs)).
> 
> Then we can launch one or multiple VMs base on the template vm states,
> the new VMs are started without the “share=on”, all the new VMs share
> the initial memory from the memory file, they save a lot of memory.
> all the new VMs start from the template point, the guest app can go to
> work quickly.
> 
> The new VM booted from template vm can’t become template again,
> if you need this unusual chained-template feature, you can write
> a cloneable-tmpfs kernel module for it.
> 
> The libvirt toolkit can’t manage vm-template currently, in the
> hyperhq/runv, we use qemu wrapper script to do it. I hope someone add
> “libvrit managed template” feature to libvirt.
> 
> d) feature: yet-another-post-copy-migration
> It is a possible feature, no toolkit can do it well now.
> Using nbd server/client on the memory file is reluctantly Ok but
> inconvenient. A special feature for tmpfs might be needed to
> fully complete this feature.
> No one need yet another post copy migration method,
> but it is possible when some crazy man need it.

Excellent work. :）

It's a brilliant feature that can improve our production a lot.

Reviewed-by: Xiao Guangrong <xiaoguangrong@tencent.com>
