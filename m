Received: from eggs.gnu.org ([2001:4830:134:3::10]:36092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dxpgo-0004BM-MM
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 03:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dxpgl-0002Ak-I5
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 03:26:26 -0400
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:37525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dxpgl-00027V-Bf
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 03:26:23 -0400
Received: from player774.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id E571010B03F
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 09:26:12 +0200 (CEST)
Date: Fri, 29 Sep 2017 09:25:52 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170929092552.44e4401c@bahia.lan>
In-Reply-To: <20170929084111.09780a0b@nial.brq.redhat.com>
References: <150633285374.14880.11614678065344980502.stgit@bahia.lan>
	<20170925154134.7b4b8cde@nial.brq.redhat.com>
	<20170925174857.6021d0a0@bahia.lan>
	<20170925234730.29b7b919@bahia.lan>
	<20170927141956.1bd6a3bd@nial.brq.redhat.com>
	<20170927173232.3a305c99@bahia.lan>
	<20170929084111.09780a0b@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: move registration of
 "host" CPU core type to machine code
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>
List-ID: <qemu-devel.nongnu.org>

On Fri, 29 Sep 2017 08:41:11 +0200
Igor Mammedov <imammedo@redhat.com> wrote:
[...]
> > > I don't see from this commit a reason why it can't be done in cpu-models.c
> > > dependencies here are
> > >   mfpvr() - which probably should work without KVM    
> > 
> > Correct.
> >   
> > >   ppc_cpu_class_by_pvr() - should work fine if 'host' type is being
> > >                            registered as the last among the other CPU types    
> > 
> > We have:
> > 
> > ppc_cpu_class_by_pvr()
> >  object_class_get_list()
> >   object_class_foreach()
> >    object_class_foreach_tramp()
> >     type_initialize()
> >      type_get_parent()
> > 
> > type_initialize() recursively initializes all parent types, and
> > type_get_parent() aborts if the parent type isn't registered yet,
> > which may happen as long as all type_init() functions haven't been
> > called => ppc_cpu_class_by_pvr() cannot be safely called from a
> > type_init() function.  
> I don't get what you are trying to say,
> could you be more specific about what parent type might be not
> registered?

With the patch below applied, TYPE_CPU isn't registered at the
time we call ppc_cpu_class_by_pvr().

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index cb5777afa0b4..4445a292d578 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -123,8 +123,6 @@ static bool kvmppc_is_pr(KVMState *ks)
     return kvm_vm_check_extension(ks, KVM_CAP_PPC_GET_PVINFO) != 0;
 }
 
-static int kvm_ppc_register_host_cpu_type(void);
-
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     cap_interrupt_unset = kvm_check_extension(s, KVM_CAP_PPC_UNSET_IRQ);
@@ -163,8 +161,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
                         "VM to stall at times!\n");
     }
 
-    kvm_ppc_register_host_cpu_type();
-
     return 0;

 }
 
@@ -2487,7 +2483,7 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
     return pvr_pcc;
 }
 
-static int kvm_ppc_register_host_cpu_type(void)
+int kvm_ppc_register_host_cpu_type(void)
 {
     TypeInfo type_info = {
         .name = TYPE_HOST_POWERPC_CPU,
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index d6be38ecafbd..a46c5a36402a 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -71,6 +71,7 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
 
 bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
 
+int kvm_ppc_register_host_cpu_type(void);
 #else
 
 static inline uint32_t kvmppc_get_tbfreq(void)
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index c6399a3a0d0d..b6e02c583836 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10766,6 +10766,9 @@ static void ppc_cpu_register_types(void)
 {
     type_register_static(&ppc_cpu_type_info);
     type_register_static(&ppc_vhyp_type_info);
+#ifdef CONFIG_KVM
+    kvm_ppc_register_host_cpu_type();
+#endif
 }
 
 type_init(ppc_cpu_register_types)
