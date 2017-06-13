Received: from eggs.gnu.org ([2001:4830:134:3::10]:35582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dKhCs-0006Ch-HT
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dKhCo-0002Yi-In
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:29:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dKhCo-0002YI-91
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:29:42 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5D8Shfv116973
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 04:29:40 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2b29nuh43v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 04:29:39 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 13 Jun 2017 18:29:37 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170613094302.1cb4012c@bahia.ttt.fr.ibm.com>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<20170609022813.GF26521@umbus.fritz.box>
	<20170609113631.229dd346@bahia.ttt.fr.ibm.com>
	<20170609102832.GL26521@umbus.fritz.box>
	<20170609170913.2e6526c3@bahia.ttt.fr.ibm.com>
	<20170611093842.GA13479@umbus>
	<20170613094302.1cb4012c@bahia.ttt.fr.ibm.com>
Date: Tue, 13 Jun 2017 13:59:29 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760g01eae.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>

Greg Kurz <groug@kaod.org> writes:

> On Sun, 11 Jun 2017 17:38:42 +0800
> David Gibson <david@gibson.dropbear.id.au> wrote:
>
>> On Fri, Jun 09, 2017 at 05:09:13PM +0200, Greg Kurz wrote:
>> > On Fri, 9 Jun 2017 20:28:32 +1000
>> > David Gibson <david@gibson.dropbear.id.au> wrote:
>> >   
>> > > On Fri, Jun 09, 2017 at 11:36:31AM +0200, Greg Kurz wrote:  
>> > > > On Fri, 9 Jun 2017 12:28:13 +1000
>> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
>> > > >     
>> > > > > On Thu, Jun 08, 2017 at 03:42:32PM +0200, Greg Kurz wrote:    
>> > > > > > I've provided answers for all comments from the v3 review that I deliberately
>> > > > > > don't address in v4.      
>> > > > > 
>> > > > > I've merged patches 1-4.  5 & 6 I'm still reviewing.
>> > > > >     
>> > > > 
>> > > > Cool. FYI, I forgot to mention that I only tested with KVM.
>> > > > 
>> > > > I'm now trying with TCG and I hit various guest crash on
>> > > > the destination (using your ppc-for-2.10 branch WITHOUT
>> > > > my patches):    
>> > > 
>> > > Drat.  What's your reproducer for this crash?
>> > >   
>> > 
>> > 1) start guest
>> > 
>> > qemu-system-ppc64 \
>> >  -nodefaults -nographic -snapshot -no-shutdown -serial mon:stdio \
>> >  -device virtio-net,netdev=netdev0,id=net0 \
>> >  -netdev bridge,id=netdev0,br=virbr0,helper=/usr/libexec/qemu-bridge-helper \
>> >  -device virtio-blk,drive=drive0,id=blk0 \
>> >  -drive file=/home/greg/images/sle12-sp1-ppc64le.qcow2,id=drive0,if=none \
>> >  -machine type=pseries,accel=tcg -cpu POWER8

Strangely, your command line does not have multiple threads. Need to see
what is the side effect of enabling MTTCG by default here.

>> > 
>> > 2) migrate
>> > 
>> > 3) destination crashes (immediately or after very short delay) or
>> > hangs  
>> 
>> Ok.  I'll bisect it when I can, but you might well get to it first.
>> 
>> 
>
> Heh, maybe you didn't see in my mail but I did bisect:
>
> f0b0685d6694a28c66018f438e822596243b1250 is the first bad commit
> commit f0b0685d6694a28c66018f438e822596243b1250
> Author: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> Date:   Thu Apr 27 10:48:23 2017 +0530
>
>     tcg: enable MTTCG by default for PPC64 on x86

Let me have a look at it.

Regards,
Nikunj
