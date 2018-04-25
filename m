Received: from eggs.gnu.org ([2001:4830:134:3::10]:38624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBKJk-0000A8-2c
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBKJg-00072J-UE
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:18:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37368 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fBKJg-000722-PF
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:18:36 -0400
Date: Wed, 25 Apr 2018 14:18:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180425131833.GK30024@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <c0eaa5d5-7b1a-74f9-1d34-d8ac7cff3546@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0eaa5d5-7b1a-74f9-1d34-d8ac7cff3546@gmx.com>
Subject: Re: [Qemu-devel] ridiculously slow VM memory performance on Ryzen
 CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Apr 25, 2018 at 05:48:42PM +0800, Qu Wenruo wrote:
> Hi,
> 
> When testing IO heavy work on my VM backed by Ryzen 1700 CPU, I turned
> to brd modules, but surprisingly, the speed is even slower than some HDD:
> 
> ---
> $ sudo modprobe brd rd_nr=1 rd_size=1048576
> $ dd if=/dev/zero of=/dev/ram0 bs=1M count=1024
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1.1 GB, 1.0 GiB) copied, 9.9928 s, 107 MB/s
> ---
> 107MB is pretty lame...
> Even some HDD could be faster than this.

You are sure that QEMU is actually using KVM, and not TCG emulation
mode, as that could account for such terrible numbers. The QEMU
argv would confirm this or can query it live with

   virsh qemu-monitor-command --hmp $GUESTNAME "info kvm"

> On host, it's much better:
> ---
> $ if=/dev/zero of=/dev/ram0 bs=1M count=1024
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1.1 GB, 1.0 GiB) copied, 0.754641 s, 1.4 GB/s
> ---
> 
> For host hardware:
> CPU: Ryzen 1700 All cores @ 3.8G
> Mem: DDR4 2400 dual channel (8G x 2)
> 
> For host software:
> Kernel:       4.16.3-1-ARCH
> Qemu:         2.11.1-2
> Distribution: Archlinux
> 
> VM setup is mostly default setup done by libvirt.

Ideally please share the guest XML description from 'virsh dumpxml $GUESTNAME'
and the corresponding QEMU argv from /var/log/libvirt/qemu/$GUESTNAME.log

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
