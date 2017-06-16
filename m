Received: from eggs.gnu.org ([2001:4830:134:3::10]:43908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dLot4-0004Sv-Si
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dLot0-0007iM-VU
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:53:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55055
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dLot0-0007hs-P3
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:53:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5GAmatq108737
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 06:53:53 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2b4d382ans-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 06:53:52 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 16 Jun 2017 20:53:49 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <8760g01eae.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<20170609022813.GF26521@umbus.fritz.box>
	<20170609113631.229dd346@bahia.ttt.fr.ibm.com>
	<20170609102832.GL26521@umbus.fritz.box>
	<20170609170913.2e6526c3@bahia.ttt.fr.ibm.com>
	<20170611093842.GA13479@umbus>
	<20170613094302.1cb4012c@bahia.ttt.fr.ibm.com>
	<8760g01eae.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Date: Fri, 16 Jun 2017 16:23:38 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fuf0w6dp.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v4 0/6] spapr/xics: fix migration of older
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>

Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:

> Greg Kurz <groug@kaod.org> writes:
>
>> On Sun, 11 Jun 2017 17:38:42 +0800
>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>
>>> On Fri, Jun 09, 2017 at 05:09:13PM +0200, Greg Kurz wrote:
>>> > On Fri, 9 Jun 2017 20:28:32 +1000
>>> > David Gibson <david@gibson.dropbear.id.au> wrote:
>>> >   
>>> > > On Fri, Jun 09, 2017 at 11:36:31AM +0200, Greg Kurz wrote:  
>>> > > > On Fri, 9 Jun 2017 12:28:13 +1000
>>> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
>>> > > >     
>>> > 1) start guest
>>> > 
>>> > qemu-system-ppc64 \
>>> >  -nodefaults -nographic -snapshot -no-shutdown -serial mon:stdio \
>>> >  -device virtio-net,netdev=netdev0,id=net0 \
>>> >  -netdev bridge,id=netdev0,br=virbr0,helper=/usr/libexec/qemu-bridge-helper \
>>> >  -device virtio-blk,drive=drive0,id=blk0 \
>>> >  -drive file=/home/greg/images/sle12-sp1-ppc64le.qcow2,id=drive0,if=none \
>>> >  -machine type=pseries,accel=tcg -cpu POWER8
>
> Strangely, your command line does not have multiple threads. Need to see
> what is the side effect of enabling MTTCG by default here.
>
>>> > 
>>> > 2) migrate
>>> > 
>>> > 3) destination crashes (immediately or after very short delay) or
>>> > hangs  
>>> 
>>> Ok.  I'll bisect it when I can, but you might well get to it first.
>>> 
>>> 
>>
>> Heh, maybe you didn't see in my mail but I did bisect:
>>
>> f0b0685d6694a28c66018f438e822596243b1250 is the first bad commit
>> commit f0b0685d6694a28c66018f438e822596243b1250
>> Author: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> Date:   Thu Apr 27 10:48:23 2017 +0530
>>
>>     tcg: enable MTTCG by default for PPC64 on x86
>
> Let me have a look at it.

Interesting problem here, I see that when the migration is completed on
source and there is a crash on destination:

[   56.185314] Unable to handle kernel paging request for data at address 0x5deadbeef0000108
[   56.185401] Faulting instruction address: 0xc000000000277bc8

   0xc000000000277bb8 <+168>:	ld      r7,8(r4)
   0xc000000000277bbc <+172>:	ld      r6,0(r4)                  <========
   0xc000000000277bc0 <+176>:	ori     r8,r8,56302
   0xc000000000277bc4 <+180>:	rldicr  r8,r8,32,31
   0xc000000000277bc8 <+184>:	std     r7,8(r6)

r4 = 0xf0000000000107a0
r6 = 0x5deadbeef0000100

Code at 0xc000000000277bbc <+172>, gave junk value in r6, that leads to
the guest crash. When I inspect the memory on source and destination in
qemu monitor, I get the following differences:

diff -u s.txt d.txt 
--- s.txt	2017-06-16 10:34:39.657221125 +0530
+++ d.txt	2017-06-16 10:34:18.452238305 +0530
@@ -8,8 +8,8 @@
 f000000000010760: 0x20de0b00 0x000000f0 0x60040100 0x000000f0
 f000000000010770: 0x00000000 0x00000000 0x0004036d 0x000000c0
 f000000000010780: 0x6c000100 0xf8ff3f00 0x7817f977 0x000000c0
-f000000000010790: 0x15000000 0x00000000 0xffffffff 0x01000000
-f0000000000107a0: 0x3090a96d 0x000000c0 0x3090a96d 0x000000c0
+f000000000010790: 0x01000000 0x00000000 0xffffffff 0x01000000
+f0000000000107a0: 0x000100f0 0xeedbea5d 0x000200f0 0xeedbea5d
 f0000000000107b0: 0x00000000 0x00000000 0x00d0a96d 0x000000c0
 f0000000000107c0: 0x28000000 0xf8ff3f00 0x8852cc77 0x000000c0
 f0000000000107d0: 0x00000000 0x00000000 0xffffffff 0x01000000

Source had a valid address at 0xf0000000000107a0, while garbage on the
destination.

Some observations:

* Source updates the memory location (probably atomic_cmpxchg), but the
  updated page didnt get transferred to the destination
  
* Getting rid of atomic_cmpxchg tcg ops in ldarx/stdcx, makes migration
  work fine. MTTCG running with 1 cpu.

While I continue debugging, any hints would help.

Regards
Nikunj
