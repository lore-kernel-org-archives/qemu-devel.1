Received: from eggs.gnu.org ([2001:4830:134:3::10]:47467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dPm6I-0004Ia-LY
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dPm6F-0006Sy-Dy
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:43:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dPm6F-0006SY-82
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:43:55 -0400
Date: Tue, 27 Jun 2017 16:43:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170627084348.GG14166@lemon.lan>
References: <20170615163813.7255-1-stefanha@redhat.com>
	<20170615163813.7255-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170615163813.7255-2-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio-pci: use ioeventfd even when
 KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>

On Thu, 06/15 17:38, Stefan Hajnoczi wrote:
> Old kvm.ko versions only supported a tiny number of ioeventfds so
> virtio-pci avoids ioeventfds when kvm_has_many_ioeventfds() returns 0.
> 
> Do not check kvm_has_many_ioeventfds() when KVM is disabled since it
> always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d6462a6f
> ("memory: emulate ioeventfd") it has been possible to use ioeventfds in
> qtest or TCG mode.
> 
> This patch makes -device virtio-blk-pci,iothread=iothread0 work even
> when KVM is disabled.
> 
> I have tested that virtio-blk-pci works under TCG both with and without
> iothread.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

This one was dropped out from Kevin's pull request but the iotest case update on
068 which depends on it is merged. Now the test fails for me:

068 2s ... - output mismatch (see 068.out.bad)
--- /stor/work/qemu/tests/qemu-iotests/068.out	2017-06-27 16:22:55.003815188 +0800
+++ 068.out.bad	2017-06-27 16:41:37.903626275 +0800
@@ -12,9 +12,8 @@
 === Saving and reloading a VM state to/from a qcow2 image (-object iothread,id=iothread0 -set device.hba0.iothread=iothread0) ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
+qemu-system-x86_64: -device virtio-scsi-pci,id=hba0: ioeventfd is required for iothread
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm 0
-(qemu) quit
+(qemu) qemu-system-x86_64: -device virtio-scsi-pci,id=hba0: ioeventfd is required for iothread
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
-*** done
+(qemu) *** done
Failures: 068
Failed 1 of 1 tests

Fam
