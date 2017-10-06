Received: from eggs.gnu.org ([2001:4830:134:3::10]:35543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1e0Lq8-0003F6-D6
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1e0Lq5-0001Y4-6Z
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:10:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1e0Lq4-0001WU-Ts
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:10:25 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9669FMY039969
	for <qemu-devel@nongnu.org>; Fri, 6 Oct 2017 02:10:19 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ddy32e3d2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 02:10:19 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 6 Oct 2017 16:10:17 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20171005164959.26024-1-clg@kaod.org>
References: <20171005164959.26024-1-clg@kaod.org>
Date: Fri, 06 Oct 2017 11:40:02 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <87poa0g62t.fsf@localhost.localdomain.i-did-not-set--mail-host-address--so-tickle-me>
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
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> Hello,
>
> When a CPU is stopped with the 'stop-self' RTAS call, its state
> 'halted' is switched to 1 and, in this case, the MSR is not taken into
> account anymore in the cpu_has_work() routine. Only the pending
> hardware interrupts are checked with their LPCR:PECE* enablement bit.
>
> If the DECR timer fires after 'stop-self' is called and before the CPU
> 'stop' state is reached, the nearly-dead CPU will have some work to do
> and the guest will crash. This case happens very frequently with the
> not yet upstream P9 XIVE exploitation mode. In XICS mode, the DECR is
> occasionally fired but after 'stop' state, so no work is to be done
> and the guest survives.
>
> I suspect there is a race between the QEMU mainloop triggering the
> timers and the TCG CPU thread but I could not quite identify the root
> cause. To be safe, let's disable the decrementer interrupt in the LPCR
> when the CPU is halted and reenable it when the CPU is restarted.

Moreover, disabling the DECR in the reset path solves the TCG multi cpu
reboot case, as reboot path does not call stop-cpu rtas call.

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 3e20b1d886..c5150ee590 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -86,6 +86,15 @@ static void spapr_cpu_reset(void *opaque)
     cs->halted =3D 1;
=20
     env->spr[SPR_HIOR] =3D 0;
+    /* Disable DECR for secondary cpus */
+    if (cs !=3D first_cpu) {
+        if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
+            env->spr[SPR_LPCR] &=3D ~LPCR_DEE;
+        } else {
+            /* P7 and P8 both have same bit for DECR */
+            env->spr[SPR_LPCR] &=3D ~LPCR_P8_PECE3;
+        }
+    }
 }
=20
 static void spapr_cpu_destroy(PowerPCCPU *cpu)


Regards
Nikunj
