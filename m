Received: from eggs.gnu.org ([2001:4830:134:3::10]:49984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dHndY-0005q5-Mq
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 04:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dHndU-0007JW-Kn
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 04:45:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dHndU-0007Hp-Du
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 04:45:16 -0400
Date: Mon, 5 Jun 2017 10:45:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170605104508.1419d7af@nial.brq.redhat.com>
In-Reply-To: <1ee3ccf0-2d91-86ec-628c-d50ae3ffbe22@cn.fujitsu.com>
References: <1ee3ccf0-2d91-86ec-628c-d50ae3ffbe22@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Memory Hotplug : Does QEmu support cold-plugged
 memory?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Michal Hocko <mhocko@kernel.org>

On Mon, 5 Jun 2017 15:53:02 +0800
Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

> Hi all,
> 
> I want to boot up a system with some removable memory.
> 
> So, i used '-object' and '-device' to cold-plug memory
> in QEmu as following :
> 
> ./x86_64-softmmu/qemu-system-x86_64 \
> 	...
> 	-object memory-backend-ram,id=mem3,size=128M \
> 	-device pc-dimm,id=dimm3,memdev=mem3 \
> 	...
> 
> then i want to hot-remove this memory by 'device-del' and
> 'object-del'.
> 
> But, unfortunately, I can't remove the memory device.
> 
> And, in guest OS, I found the memory's removable feature is 0,
> But, in QEmu monitor with 'info memory-devices', I found the
> hotplugged is false and hotpluggable is true.
It's issue in the guest side kernel.
In short it's not guarantied that guest kernel would be able
to hotremove DIMM module (even if hardware is capable of) since
kernel might use its memory as not MOVABLE, so DIMM might be
temporally or permanently pinned by kernel allocations.

There is ongoing refactoring/cleanup work upstream, that
tries to make memhotplug behavior consistent/reasonable.

If you are interested, I'd suggest to review/test changes that
Michal works on upstream, to make sure that refactoring won't
break your usecase.

You can find the latest series Michal posted at:
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1410289.html


> 
> Could you help me:
> 
> 1, Can the ram based memory-backend be plugged like above?
yes, it can be used as above
 
> 2, Does the 'info memory-devices' command show a wrong info?
nope,
command shows hotpluggable status the way hw (qemu) sees it

> 3, Can file memory backend(memory-backend-file) be cold-plugged?
yes, it can.

[...]
