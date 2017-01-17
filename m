Received: from eggs.gnu.org ([2001:4830:134:3::10]:36475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTUMf-000367-E1
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTUMa-0002R1-H3
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:03:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTUMa-0002Q2-9Y
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:03:52 -0500
Date: Tue, 17 Jan 2017 12:03:49 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170117140349.GI3491@thinpad.lan.raisama.net>
References: <20170116195452.23532-1-ehabkost@redhat.com>
	<20170117133914.GA14855@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170117133914.GA14855@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] i386: Support "-cpu host" on TCG too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

On Tue, Jan 17, 2017 at 01:39:14PM +0000, Richard W.M. Jones wrote:
> On Mon, Jan 16, 2017 at 05:54:52PM -0200, Eduardo Habkost wrote:
> > Change the meaning of "-cpu host" to "enable all features
> > supported by the accelerator in the current host", so that it can
> > be used to enable/query all features supported by TCG.
> > 
> > To make sure "host" is still at the end of the list in "-cpu
> > help", add a "ordering" field that will be used when sorting the
> > CPU model list.
> > 
> > Cc: Richard Henderson <rth@twiddle.net>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  target/i386/cpu-qom.h |  4 ++--
> >  target/i386/cpu.c     | 26 +++++---------------------
> >  2 files changed, 7 insertions(+), 23 deletions(-)
> > 
> > diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
> > index 8cd607e9a2..75618919e3 100644
> > --- a/target/i386/cpu-qom.h
> > +++ b/target/i386/cpu-qom.h
> > @@ -47,7 +47,7 @@ typedef struct X86CPUDefinition X86CPUDefinition;
> >  /**
> >   * X86CPUClass:
> >   * @cpu_def: CPU model definition
> > - * @kvm_required: Whether CPU model requires KVM to be enabled.
> > + * @ordering: Ordering on the "-cpu help" CPU model list.
> >   * @migration_safe: See CpuDefinitionInfo::migration_safe
> >   * @parent_realize: The parent class' realize handler.
> >   * @parent_reset: The parent class' reset handler.
> > @@ -62,7 +62,7 @@ typedef struct X86CPUClass {
> >      /* Should be eventually replaced by subclass-specific property defaults. */
> >      X86CPUDefinition *cpu_def;
> >  
> > -    bool kvm_required;
> > +    int ordering;
> >      bool migration_safe;
> >  
> >      /* Optional description of CPU model.
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index ec6eaf215c..e0ca8c0288 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -1549,7 +1549,7 @@ static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
> >      X86CPUClass *xcc = X86_CPU_CLASS(oc);
> >      uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
> >  
> > -    xcc->kvm_required = true;
> > +    xcc->ordering = 9; /* Show it last on "-cpu help" */
> >  
> >      host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
> >      x86_cpu_vendor_words2str(host_cpudef.vendor, ebx, edx, ecx);
> > @@ -1563,8 +1563,7 @@ static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
> >  
> >      xcc->cpu_def = &host_cpudef;
> >      xcc->model_description =
> > -        "KVM processor with all supported host features "
> > -        "(only available in KVM mode)";
> > +        "Enables all features supported by the accelerator in the current host";
> >  
> >      /* level, xlevel, xlevel2, and the feature words are initialized on
> >       * instance_init, because they require KVM to be initialized.
> > @@ -2075,13 +2074,6 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
> >      Error *err = NULL;
> >      strList **next = missing_feats;
> >  
> > -    if (xcc->kvm_required && !kvm_enabled()) {
> > -        strList *new = g_new0(strList, 1);
> > -        new->value = g_strdup("kvm");;
> > -        *missing_feats = new;
> > -        return;
> > -    }
> > -
> >      xc = X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))));
> >  
> >      x86_cpu_load_features(xc, &err);
> > @@ -2129,7 +2121,7 @@ static void listflags(FILE *f, fprintf_function print, const char **featureset)
> >      }
> >  }
> >  
> > -/* Sort alphabetically by type name, listing kvm_required models last. */
> > +/* Sort alphabetically by type name, respecting X86CPUClass::ordering. */
> >  static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b)
> >  {
> >      ObjectClass *class_a = (ObjectClass *)a;
> > @@ -2138,9 +2130,8 @@ static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b)
> >      X86CPUClass *cc_b = X86_CPU_CLASS(class_b);
> >      const char *name_a, *name_b;
> >  
> > -    if (cc_a->kvm_required != cc_b->kvm_required) {
> > -        /* kvm_required items go last */
> > -        return cc_a->kvm_required ? 1 : -1;
> > +    if (cc_a->ordering != cc_b->ordering) {
> > +        return cc_a->ordering - cc_b->ordering;
> >      } else {
> >          name_a = object_class_get_name(class_a);
> >          name_b = object_class_get_name(class_b);
> > @@ -3191,13 +3182,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
> >      Error *local_err = NULL;
> >      static bool ht_warned;
> >  
> > -    if (xcc->kvm_required && !kvm_enabled()) {
> > -        char *name = x86_cpu_class_get_model_name(xcc);
> > -        error_setg(&local_err, "CPU model '%s' requires KVM", name);
> > -        g_free(name);
> > -        goto out;
> > -    }
> > -
> >      if (cpu->apic_id == UNASSIGNED_APIC_ID) {
> >          error_setg(errp, "apic-id property was not initialized properly");
> >          return;
> 
> FYI libvirt will also need changing.  Currently it reports:
> 
>   Original error from libvirt: unsupported configuration: CPU mode 'host-passthrough' for x86_64 qemu domain on x86_64 host is not supported by hypervisor [code=67 int1=-1]
> 

I'm not sure libvirt should translate "host-passthrough" to "-cpu
host" with TCG. The documented semantics of "host-passthrough"
are probably more specific, and may not make sense for TCG.

-- 
Eduardo
