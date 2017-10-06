Received: from eggs.gnu.org ([2001:4830:134:3::10]:58322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1e0Nk9-0002EB-O4
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1e0Nk4-0004YS-15
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:12:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1e0Nk3-0004Xq-Ow
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:12:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9689Nmn047036
	for <qemu-devel@nongnu.org>; Fri, 6 Oct 2017 04:12:15 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2de4r9m4r6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 04:12:15 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 6 Oct 2017 09:12:13 +0100
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <1507275993.25065.142.camel@kernel.crashing.org>
References: <20171005164959.26024-1-clg@kaod.org>
	<87poa0g62t.fsf@localhost.localdomain.i-did-not-set--mail-host-address--so-tickle-me>
	<1507275993.25065.142.camel@kernel.crashing.org>
Date: Fri, 06 Oct 2017 13:41:57 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <87shewk84y.fsf@localhost.localdomain.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 0/2] disable the decrementer interrupt when
 a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?utf-8?Q?C=C3=A9dr?= =?utf-8?Q?ic?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2017-10-06 at 11:40 +0530, Nikunj A Dadhania wrote:
>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>=20
>> > Hello,
>> >=20
>> > When a CPU is stopped with the 'stop-self' RTAS call, its state
>> > 'halted' is switched to 1 and, in this case, the MSR is not taken into
>> > account anymore in the cpu_has_work() routine. Only the pending
>> > hardware interrupts are checked with their LPCR:PECE* enablement bit.
>> >=20
>> > If the DECR timer fires after 'stop-self' is called and before the CPU
>> > 'stop' state is reached, the nearly-dead CPU will have some work to do
>> > and the guest will crash. This case happens very frequently with the
>> > not yet upstream P9 XIVE exploitation mode. In XICS mode, the DECR is
>> > occasionally fired but after 'stop' state, so no work is to be done
>> > and the guest survives.
>> >=20
>> > I suspect there is a race between the QEMU mainloop triggering the
>> > timers and the TCG CPU thread but I could not quite identify the root
>> > cause. To be safe, let's disable the decrementer interrupt in the LPCR
>> > when the CPU is halted and reenable it when the CPU is restarted.
>>=20
>> Moreover, disabling the DECR in the reset path solves the TCG multi cpu
>> reboot case, as reboot path does not call stop-cpu rtas call.
>
> SHouldn't we do it in set_papr too and only turn it on for the boot CPU
> and in start-cpu RTAS call ? Same with the other PECEs in fact...

Yes, +1 for that

Regards
Nikunj
