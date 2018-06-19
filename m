Received: from eggs.gnu.org ([2001:4830:134:3::10]:56488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fVEY9-0003WX-KD
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fVEY4-0005Yv-Q7
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:11:49 -0400
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:51239)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fVEY4-0005Uq-G4
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:11:44 -0400
Received: from player739.ha.ovh.net (unknown [10.109.122.46])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 2334F161F9
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 13:11:35 +0200 (CEST)
Date: Tue, 19 Jun 2018 13:11:28 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180619131128.17a22f15@bahia.lan>
In-Reply-To: <152937387811.15330.6346338944477555198@sif>
References: <152700944859.346734.1389264286134807488.stgit@bahia.lan>
	<152937387811.15330.6346338944477555198@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11.2] spapr: make pseries-2.11 the
 default machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Mon, 18 Jun 2018 21:04:38 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Quoting Greg Kurz (2018-05-22 12:17:28)
> > The spapr capability framework was introduced in QEMU 2.12. It allows
> > to have an explicit control on how host features are exposed to the
> > guest. This is especially needed to handle migration between hetero-
> > geneous hosts (eg, POWER8 to POWER9). It is also used to expose fixes/
> > workarounds against speculative execution vulnerabilities to guests.
> > The framework was hence backported to QEMU 2.11.1, especially these
> > commits:
> > 
> > 0fac4aa93074 spapr: Add pseries-2.12 machine type
> > 9070f408f491 spapr: Treat Hardware Transactional Memory (HTM) as an
> >  optional capability
> > 
> > 0fac4aa93074 has the confusing effect of making pseries-2.12 the default
> > machine type for QEMU 2.11.1, instead of the expected pseries-2.11. This
> > patch changes the default machine back to pseries-2.11.
> > 
> > Unfortunately, 9070f408f491 enforces the HTM capability for pseries-2.11.
> > This isn't supported by TCG and breaks 'make check'. So this patch also
> > adds a hack to turn HTM off when using TCG.  
> 
> I noticed this ends up breaking TCG migration for 2.11.2 -> 2.12, I
> get this on the target side even when specifying -machine
> pseries-2.11,cap-htm=off for both ends:
> 
>   qemu-system-ppc64: cap-htm higher level (1) in incoming stream than on destination (0)
>   qemu-system-ppc64: error while loading state for instance 0x0 of device 'spapr'
>   qemu-system-ppc64: load of migration failed: Invalid argument
> 
> I'm not sure we care all that much about it but it's a regression from 2.11.1
> at least. The main issue seems to be the default caps for 2.11.2 for TCG are
> now different from 2.11 and 2.12+, but spapr_cap_##cap##_needed still assumes
> everything is the same across all these versions and as such opts not to
> migrate cap-htm=off, since that's the default for 2.11.2. This results in the
> target assuming the source was using the default, which is cap-htm=on,
> and since that disagrees with the spapr->eff we get a failure.
> 
> It seems spapr_cap_##cap##_needed needs to be fixed up to address that,
> but I'm not sure how best to deal with backward compatibility in that case.
> Any ideas? If it ends up being a trade-off I think forward compatibility is
> more important.
> 

Yeah, we shouldn't change the default since it affects the migration logic :-\

The motivation behind this hack is to fix TCG based 'make check', because
it doesn't pass cap-htm=off, and thus can't run with pseries-2.11.

Another possibility is to let the default as is, and to disable HTM after the
default caps have been applied.

Something like that squashed into this patch:

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 82043e60e78b..26e6be043b18 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -285,11 +285,6 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
 
     caps = smc->default_caps;
 
-    /* HACK for 2.11.2: fix make check */
-    if (tcg_enabled()) {
-        caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
-    }
-
     if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
                           0, spapr->max_compat_pvr)) {
         caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
@@ -405,6 +400,11 @@ void spapr_caps_reset(sPAPRMachineState *spapr)
         }
     }
 
+    /* HACK for 2.11.2: fix make check */
+    if (tcg_enabled()) {
+        spapr->eff.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
+    }
+
     /* .. then apply those caps to the virtual hardware */
 
     for (i = 0; i < SPAPR_CAP_NUM; i++) {
---------------------

This allows:
- TCG 'make check' to be happy with pseries-2.11
- 2.11.2 --> 2.12 migration and backward

> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr.c      |    4 ++--
> >  hw/ppc/spapr_caps.c |    5 +++++
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 1a2dd1f597d9..6499a867520f 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3820,7 +3820,7 @@ static void spapr_machine_2_12_class_options(MachineClass *mc)
> >      /* Defaults for the latest behaviour inherited from the base class */
> >  }
> > 
> > -DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
> > +DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
> > 
> >  /*
> >   * pseries-2.11
> > @@ -3842,7 +3842,7 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
> >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
> >  }
> > 
> > -DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
> > +DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
> > 
> >  /*
> >   * pseries-2.10
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 7b229517be38..82043e60e78b 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -285,6 +285,11 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
> > 
> >      caps = smc->default_caps;
> > 
> > +    /* HACK for 2.11.2: fix make check */
> > +    if (tcg_enabled()) {
> > +        caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
> > +    }
> > +
> >      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
> >                            0, spapr->max_compat_pvr)) {
> >          caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
> >   
