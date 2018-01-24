Received: from eggs.gnu.org ([208.118.235.92]:35194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eeCth-0005s6-Jk
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 23:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eeCtG-00040F-DB
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 23:42:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eeCtG-0003uU-2J
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 23:42:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6EB881DE4
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 04:42:22 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Wed, 24 Jan 2018 12:42:16 +0800
Message-Id: <20180124044216.12461-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: Fix CID for VMDK afl image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, famz@redhat.com

The descriptor block in the image, which includes the CID to verify, has been
invalid since the reference image was added. Since commit 9877860e7bd we report
this error earlier than the "file too large", so 059.out mismatches.

Instead of fixing the output, we fix the image descriptor, because the code
path we want to exercise is actually the invalid image size.

The binary change is generated along the operations of:

  $ bunzip2 afl9.vmdk.bz2
  $ qemu-img create -f qcow2 fix.vmdk 1G
  $ dd if=afl9.vmdk.bz2 of=fix.vmdk bs=512 count=1 conv=notrunc
  $ mv fix.vmdk afl9.vmdk
  $ bzip2 afl9.vmdk

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/sample_images/afl9.vmdk.bz2 | Bin 178 -> 618 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

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
