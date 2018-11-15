Received: from eggs.gnu.org ([2001:4830:134:3::10]:37958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gNFUI-0007xl-Jx
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gNFUF-0001g9-Ui
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:07:06 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gNFU9-0001P8-49
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:06:59 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20181115110638euoutp02d88e183dc5edc365c3318765f98cfc8d~nR3zUD2DA0191901919euoutp02i
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 11:06:38 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Message-ID: <c07f77c0-a746-90c8-1e06-6dd5dc836a57@samsung.com>
Date: Thu, 15 Nov 2018 14:06:36 +0300
MIME-Version: 1.0
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
References: <CGME20181115110637eucas1p29916ac0e321b6379d44270b87257a0b2@eucas1p2.samsung.com>
Subject: [Qemu-devel]  Are FreeBSD guest images working?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org

> Hi, the list,
> 
> I am trying to boot a FreeBSD guest but failed.  It hangs at the
> kernel booting phase:
> 
> /boot/ker]el/kernel text=0x14ed860 data=0x132538+0x4baa68 syms=[0x8+0x159ee8+0x8
> Booting...
> (nothing more)
> 
> It's just as simple as downloading the image and boot so I can't think
> of anything strange within my procedures so far:
> 
> https://wiki.qemu.org/Hosts/BSD#FreeBSD
> 
> I also tried the latest image here:
> 
> https://download.freebsd.org/ftp/releases/VM-IMAGES/11.2-RELEASE/amd64/Latest/FreeBSD-11.2-RELEASE-amd64.qcow2.xz
> 
> but it's having the same problem as 11.0.
> 
> Am downloading an fresh ISO, but before I continue I'm just curious on
> whether anyone is using these images and whether there's quick answers
> to what I have encountered.
> 
> Thanks in advance,
> 
> -- 
> Peter Xu

Hi,
I have one VM with FreeBSD-11.2-RELEASE-amd64.qcow2 image and it works
fine under qemu 2.12.1. But it's controlled by libvirt + virt-manager,
so it has a bit more cmdline arguments than in wiki.

In general, those images has serial console disabled by default.

Creating the following file in VM fs:
[root@freebsd ~]# cat /boot/loader.conf 
boot_multicons="YES"
boot_serial="YES"
comconsole_speed="115200"
console="comconsole,vidconsole"

allows me to successfully boot with:
# qemu-system-x86_64 -machine accel=kvm -m 2048  \
      -cpu host -enable-kvm -nographic -smp 2 \
      -drive if=virtio,file=./FreeBSD-11.2-RELEASE-amd64.qcow2,format=qcow2

Best regards, Ilya Maximets.
