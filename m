Received: from eggs.gnu.org ([2001:4830:134:3::10]:47063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ehcha-00087H-0f
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:52:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ehchY-0007kj-RW
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:52:30 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri,  2 Feb 2018 13:23:10 +0800
Message-Id: <20180202052310.7870-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3] iotests: Fix CID for VMDK afl image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com

This reverts commit 76bf133c4 which updated the reference output, and
fixed the reference image, because the code path we want to exercise is
actually the invalid image size.

The descriptor block in the image, which includes the CID to verify, has been
invalid since the reference image was added. Since commit 9877860e7bd we report
this error earlier than the "file too large", so 059.out mismatches.

The binary change is generated along the operations of:

  $ bunzip2 afl9.vmdk.bz2
  $ qemu-img create -f vmdk fix.vmdk 1G
  $ dd if=afl9.vmdk of=fix.vmdk bs=512 count=1 conv=notrunc
  $ mv fix.vmdk afl9.vmdk
  $ bzip2 afl9.vmdk

Signed-off-by: Fam Zheng <famz@redhat.com>

---

v3: Skip test when ENOMEM. [Max, Eric]

v2: Fix commit message "qcow2 -> vmdk". [Kevin]
    Revert 76bf133c4.
---
 tests/qemu-iotests/059                         |   5 ++---
 tests/qemu-iotests/059.out                     |   2 +-
 tests/qemu-iotests/sample_images/afl9.vmdk.bz2 | Bin 178 -> 618 bytes
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 40f89eae18..530bbbe6ce 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -152,9 +152,8 @@ done
 echo
 echo "=== Testing afl image with a very large capacity ==="
 _use_sample_img afl9.vmdk.bz2
-# The sed makes this test pass on machines with little RAM
-# (and also with 32 bit builds)
-_img_info | sed -e 's/Cannot allocate memory/Invalid argument/'
+_img_info | grep -q 'Cannot allocate memory' && _notrun "Insufficent memory, skipped test"
+_img_info
 _cleanup_test_img
 
 # success, all done
diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index 1ac5d56233..f6dce7947c 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2358,5 +2358,5 @@ Offset          Length          Mapped to       File
 0x140000000     0x10000         0x50000         TEST_DIR/t-s003.vmdk
 
 === Testing afl image with a very large capacity ===
-qemu-img: Could not open 'TEST_DIR/afl9.IMGFMT': Could not open 'TEST_DIR/afl9.IMGFMT': Invalid argument
+qemu-img: Can't get image size 'TEST_DIR/afl9.IMGFMT': File too large
 *** done
diff --git a/tests/qemu-iotests/sample_images/afl9.vmdk.bz2 b/tests/qemu-iotests/sample_images/afl9.vmdk.bz2
index 03615d36a12425cf4240bab86f4cfe648db14572..9fcd0af45a815431acf4689e0845ecf2d333cd58 100644
GIT binary patch
literal 618
zcmV-w0+szjT4*^jL0KkKSvgW7ssIN3|NsBH-Q9UpfAhclU70`s-*NE~5QvC~h=_=Y
zh>D2n*q*=vygR634445h35k;?00h9835kMW00004$iPepVE{Bqk)uhJ^wfGLr=)3s
zhM5CR88jLh7)B;cA*K)*6GmuECPU3o4NWG5O#pg>Ak#xY8Z^<M8Z>CrMt}oD38Ns$
z02n}M0LdjZ&}cLPqd+nPKmn$j0iXe(02%-d27nnJriN-uE+X&cz@Bj4BBfd|yV!NB
zwqkL}nW3AI5x^jp=t%^F1pxqp)v#n#)j$zcm1xqv(!$2d*5%vF{5RPWnOV8-^tE<(
zU~%&}Y0uNu*9Wt=yS^8PkC&gPueZO%IG;aD{l#sG`<Af;l1Pnwpi9I75FkQ`LLhd8
z6(9f*2s+N5=%bwp80ddrD6>m4Ho*fsHXdM<jtl*zKvRiTx7Ugy1|Nl<Ns!z;1dvhy
z=`SDHh~{u|1ZodC(_lzezQ)I*Kv2z|PZ@!SJjlVzwGdx2iu#W}dI{t+T&dDWT^LPy
zg3NouEM=V~7GvZQS1CXy676F6mJXWGgW!KTr+E$OspGYCjWmuwa^<Bc>_(-i7fPIW
zA+~n9iy_f)g8B2RILhd%F)dZ5f?7pFLw)@;Ncl<JE}gvMrfh{elT#3gLjY6r8xY4O
z)UO#pv=WYptukn<DuoMH2ip%k?V^k!rjQirK^RC<Brw>3Bz9<|!xm0F{45K+gg8#n
z4FNAJ!<X|3Vq+lyV4=xZ;>AN0<K=%c4A2ruB!4rGvWm!KFrvd4PyfZ-kxmpO4pfM$
EfLnqQYXATM

literal 178
zcmV;j08RfwT4*^jL0KkKS>A08g#Z9x|HJ$H)ZJi0004xF0SE*D03g5s00IDLSQelF
ziVX^$pfWNUJrmRhn2k52pQ;Rs0EQC;(S%|!m`2~BZ@b++;etskRJUVl!Kt)wu7?VN
zl;%JdqX2?TgsNVJP?87M*MvL1qQnBkCES&?0@MeaN-bL4;bDzxmMm|da4fuh!=#fu
g@i9R@5z!av{9tA<GGr!3hi~HUNT&)C8_l7xpl%OKQ2+n{

-- 
2.14.3
