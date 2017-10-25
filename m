Received: from eggs.gnu.org ([2001:4830:134:3::10]:58116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e7LmE-0002BJ-Qr
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e7LmB-0006Wo-P3
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:31:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e7LmB-0006Uy-Iz
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:31:19 -0400
Date: Wed, 25 Oct 2017 21:31:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171025133115.GA23458@lemon>
References: <BC29A004BA570342A4CC0044A3845572CFCE5592@H3CMLB12-EX.srv.huawei-3com.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BC29A004BA570342A4CC0044A3845572CFCE5592@H3CMLB12-EX.srv.huawei-3com.com>
Subject: Re: [Qemu-devel] Block format 'raw' does not support the option
 'locking' when disable image locking with option locking=off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changlimin <changlimin@h3c.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Wed, 10/25 08:15, Changlimin wrote:
> Hi,
> When running Oracle RAC, one image is shared between multiple vms, so I want to disable locking with option locking=off, But Block format 'raw' does not support the option 'locking'.
> How to disable locking?
> 
> The version is git e822e81e350825dd94f41ee2538ff1432b812eb9
> 
> The command line is
> -drive file=/var/lib/libvirt/images/r0605-share.img,format=raw,if=none,id=drive-virtio-disk1,cache=directsync,aio=native,locking=off \
> -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0xa,drive=drive-virtio-disk1,id=virtio-disk1 \

Hi, in this case you probably want to use share-rw=on:

 -device virtio-blk-pci,share-rw=on,scsi=off,...

The -drive option is the same. This is more semantically correct than
locking=off as it means "the device can share the image with other QEMUs".

But for really disabling locking with "locking=off", the right syntax is:

 -drive file.filename=/var/lib/...,file.locking=off \

or alternatively:

 -drive driver=file,filename=/var/lib/...,locking=off \

Fam
