Received: from eggs.gnu.org ([2001:4830:134:3::10]:58434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e9iTY-0007nZ-TT
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 22:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e9iTX-0007EK-Pz
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 22:09:52 -0400
Date: Tue, 31 Oct 2017 19:09:42 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CAFEAcA_rOYq8NuhrbnJc4D7M+EenXPkPeqTBBJJzoBnAPxVLnw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1710311909010.1707@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710171708130.27209@sstabellini-ThinkPad-X260>
	<CAFEAcA9zXAmNPL8TsLKSPbm8Er_KLK8Ubwth6=nL6WD87OmBQw@mail.gmail.com>
	<CAFEAcA8jwN81ZBCLA8HW=q5GAWKmZ=kAZAP9vGNN8RYkzYe=Pw@mail.gmail.com>
	<alpine.DEB.2.10.1710310959490.13766@sstabellini-ThinkPad-X260>
	<CAFEAcA_8cimWtic=2OdvCmAN-mJ5MGGnVzDGYA5VgXGJG-fKhw@mail.gmail.com>
	<alpine.DEB.2.10.1710311147570.13766@sstabellini-ThinkPad-X260>
	<CAFEAcA_rOYq8NuhrbnJc4D7M+EenXPkPeqTBBJJzoBnAPxVLnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] aarch64: advertise the GIC system register
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, julien.grall@arm.com, qemu-arm <qemu-arm@nongnu.org>

On Tue, 31 Oct 2017, Peter Maydell wrote:
> On 31 October 2017 at 18:51, Stefano Stabellini <sstabellini@kernel.org> wrote:
> > On Tue, 31 Oct 2017, Peter Maydell wrote:
> >> On 31 October 2017 at 17:01, Stefano Stabellini <sstabellini@kernel.org> wrote:
> >> > Fixing QEMU is harder than I expected. Would it be possible to update
> >> > id_aa64pfr0 at CPU reset time? Like cpu->id_aa64pfr0 |= 0x01000000; ?
> >>
> >> At that point we've already called register_cp_regs_for_features(),
> >> which is where we read cpu->id_aa64pfr0 when we're creating the
> >> cpreg. So if you change it after that it's too late. But that
> >> function is called at CPU realize time, which is before we've
> >> created the GIC object...
> >
> > What about something along the lines of
> >
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 9e18b41..0851071 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -1401,6 +1400,10 @@ static void machvirt_init(MachineState *machine)
> >              object_property_set_link(cpuobj, OBJECT(secure_sysmem),
> >                                       "secure-memory", &error_abort);
> >          }
> > +        if (vms->gic_version == 3) {
> > +            ARMCPU *cpu = ARM_CPU(cpuobj);
> > +            cpu->id_aa64pfr0 |= 0x01000000;
> > +        }
> >
> >          object_property_set_bool(cpuobj, true, "realized", NULL);
> >          object_unref(cpuobj);
> 
> Definitely not -- the virt board should not be poking about inside the
> internals of the CPU object.
> 
> The slightly cleaned up version of this idea is that you give the
> CPU an object property for "claim the GICv3 registers exist in the
> ID registers" and have virt.c set it. That feels like an ugly
> workaround for something we really ought not to have to tell the
> board about at all, though.

Something like the following?

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9e18b41..369d36b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1401,6 +1401,9 @@ static void machvirt_init(MachineState *machine)
             object_property_set_link(cpuobj, OBJECT(secure_sysmem),
                                      "secure-memory", &error_abort);
         }
+        if (vms->gic_version == 3) {
+            object_property_set_bool(cpuobj, true, "gicv3-sysregs", NULL);
+        }
 
         object_property_set_bool(cpuobj, true, "realized", NULL);
         object_unref(cpuobj);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 88578f3..259cad1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1690,6 +1690,7 @@ static Property arm_cpu_properties[] = {
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
+    DEFINE_PROP_BOOL("gicv3-sysregs", ARMCPU, gicv3_sysregs, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 89d49cd..0015b37 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -657,6 +657,9 @@ struct ARMCPU {
     /* Should CPU start in PSCI powered-off state? */
     bool start_powered_off;
 
+    /* GICv3 sysregs present */
+    bool gicv3_sysregs;
+
     /* Current power state, access guarded by BQL */
     ARMPSCIState power_state;
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 37af750..6f21900 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4687,7 +4687,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_AA64PFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = cpu->id_aa64pfr0 },
+              .resetvalue = cpu->gicv3_sysregs ? (cpu->id_aa64pfr0|0x01000000) :
+                  cpu->id_aa64pfr0 },
             { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
