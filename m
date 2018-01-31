Received: from eggs.gnu.org ([2001:4830:134:3::10]:43967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nitin.lnx@gmail.com>) id 1egwMx-0005jK-Ga
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:40:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nitin.lnx@gmail.com>) id 1egwMt-0000Hb-Cj
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:40:23 -0500
Received: from mail-yw0-x229.google.com ([2607:f8b0:4002:c05::229]:39701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nitin.lnx@gmail.com>) id 1egwMt-0000Gp-6g
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:40:19 -0500
Received: by mail-yw0-x229.google.com with SMTP id v196so8161320ywc.6
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 09:40:18 -0800 (PST)
MIME-Version: 1.0
From: Nitin Saxena <nitin.lnx@gmail.com>
Date: Wed, 31 Jan 2018 23:09:57 +0530
Message-ID: <CAB995MuXpvBiiZHHNaBSHxPr1HiqFKmLfnaL2NedF69DtgfaQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [AARCH64]How to provide ssh key to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi,

I am able to successfully launch xenial-server-cloudimg-arm64-uefi1.img
(cloud image) using following command

================
qemu-system-aarch64 \
    -smp 2 \
    -m 1024 \
    -M virt \
    -cpu cortex-a57 \
    -bios QEMU_EFI.fd \
    -nographic \
    -device virtio-blk-device,drive=image \
    -drive
if=none,id=image,file=ubuntu-16.04-server-cloudimg-arm64-uefi1.img \
    -device virtio-blk-device,drive=cloud \
    -drive if=none,id=cloud,file=cloud.img \
    -device virtio-net-device,netdev=user0 \
    -netdev user,id=user0 \
    -redir tcp:2222::22
====================


I want to use combination of -kernel argument (instead of -bios and UEFI
image). I did this with ext4 xenial image provided by ubuntu.

=================
qemu-system-aarch64 -enable-kvm -m 512 -smp 4 -cpu host \
    -M virt,gic_version=3 -nographic \
    -kernel boot/vmlinuz-4.4.0-112-generic --append "console=ttyAMA0
root=/dev/vda rw"  \
    -drive file=xenial-server-cloudimg-arm64.img,if=virtio,aio=threads \
    -netdev user,id=user0 -device virtio-net,netdev=user0 \
    -redir tcp:2222::22
====================

Using above command VM launches successfully and login prompt comes. The
only problem is I haven't provided ssh key through -drive=cloud hence I am
not able to login above VM launch. So I tried with following qemu command

==================
qemu-system-aarch64 -enable-kvm -m 512 -smp 4 -cpu host \
    -M virt,gic_version=3 -nographic \
    -kernel boot/vmlinuz-4.4.0-112-generic --append "console=ttyAMA0
root=/dev/vda rw"  \
    -drive file=xenial-server-cloudimg-arm64.img,if=virtio,aio=threads \
    -device virtio-blk-device,drive=cloud \
    -drive if=none,id=cloud,file=cloud.img \
    -netdev user,id=user0 -device virtio-net,netdev=user0 \
    -redir tcp:2222::22
==================

Addition of highlighted command crashes VM. Can somebody help about what I
am doing wrong here? I find hard in searching internet who has tried
launching VM this way instead of using UEFI image.

Thanks,
Nitin
