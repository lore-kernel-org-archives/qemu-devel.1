Received: from eggs.gnu.org ([2001:4830:134:3::10]:47749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1csVUa-0004tF-7Q
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1csVUX-0003N5-0A
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:19:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1csVUW-0003MN-Nz
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:19:28 -0400
Date: Mon, 27 Mar 2017 11:19:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170327141919.GH28530@thinpad.lan.raisama.net>
References: <20170324203645.12828-1-ehabkost@redhat.com>
	<20170327131059.4580f299@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170327131059.4580f299@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] i386: Don't override -cpu options
 on -cpu host/max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Collin L . Walling" <walling@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Mar 27, 2017 at 01:10:59PM +0200, Igor Mammedov wrote:
> On Fri, 24 Mar 2017 17:36:45 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > The existing code for "host" and "max" CPU models overrides every
> > single feature in the CPU object at realize time, even the ones
> > that were explicitly enabled or disabled by the user using
> > "feat=on" or "feat=off", while features set using +feat/-feat are
> > kept.
> > 
> > This means "-cpu host,+invtsc" works as expected, while
> > "-cpu host,invtsc=on" doesn't.
> > 
> > This was a known bug, already documented in a comment inside
> > x86_cpu_expand_features(). What makes this bug worse now is that
> > libvirt 3.0.0 and newer now use "feat=on|off" instead of
> > +feat/-feat when it detects a QEMU version that supports it (see
> > libvirt commit d47db7b16dd5422c7e487c8c8ee5b181a2f9cd66).
> > 
> > Change the feature property getter/setter to set a
> > env->user_features field, to keep track of features that were
> > explicitly changed using QOM properties. Then make the
> > max_features code not override user features when handling "-cpu
> > host" and "-cpu max".
> > 
> > This will also allow us to remove the plus_features/minus_features
> > hack in the future, but I plan to do that after 2.9.0 is
> > released.
> > 
> > Reported-by: Jiri Denemark <jdenemar@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  target/i386/cpu.h |  2 ++
> >  target/i386/cpu.c | 33 +++++++++++++++++++++------------
> >  2 files changed, 23 insertions(+), 12 deletions(-)
> > 
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 07401ad9fe..c4602ca80d 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -1147,6 +1147,8 @@ typedef struct CPUX86State {
> >      uint32_t cpuid_vendor3;
> >      uint32_t cpuid_version;
> >      FeatureWordArray features;
> > +    /* Features that were explicitly enabled/disabled */
> > +    FeatureWordArray user_features;
> >      uint32_t cpuid_model[12];
> >  
> >      /* MTRRs */
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 7aa762245a..5f2addbf75 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -3373,15 +3373,20 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
> >      GList *l;
> >      Error *local_err = NULL;
> >  
> > -    /*TODO: cpu->max_features incorrectly overwrites features
> > -     * set using "feat=on|off". Once we fix this, we can convert
> > +    /*TODO: Now cpu->max_features doesn't overwrite features
> > +     * set using QOM properties, and we can convert
> >       * plus_features & minus_features to global properties
> >       * inside x86_cpu_parse_featurestr() too.
> >       */
> >      if (cpu->max_features) {
> >          for (w = 0; w < FEATURE_WORDS; w++) {
> > -            env->features[w] =
> > -                x86_cpu_get_supported_feature_word(w, cpu->migratable);
> > +            /* Override only features that weren't not set explicitly
> > +             * by the user.
> s/not// or if it was intended rephrase to avoid double negation.

I will fix that, thanks for spotting it.

> 
> > +             */
> > +            env->features[w] &= env->user_features[w];
> it probably should be assert to catch features not set via property,
> which shouldn't be there in the first place, I don't like silent
> filtering that happens here.

I wouldn't like to add an assert() so late in the 2.9 schedule.
But you are right that having anything present in
(env->features & ~env->user_features) would be a bug somewhere
else, and this line is not necessary.

> 
> > +            env->features[w] |=
> > +                x86_cpu_get_supported_feature_word(w, cpu->migratable) &
> > +                ~env->user_features[w];
> >          }
> >      }
> >  
> > @@ -3692,15 +3697,17 @@ static void x86_cpu_unrealizefn(DeviceState *dev, Error **errp)
> >  }
> >  
> >  typedef struct BitProperty {
> > -    uint32_t *ptr;
> > +    FeatureWord w;
> it would be better if this refactoring and related changes
> were in a separate patch, something along lines:
>  "x86/cpu: use FeatureWord instead of keeping a pointer to cpuid leaf"

I will do it in v2.

> 
> >      uint32_t mask;
> >  } BitProperty;
> >  
> >  static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
> >                                   void *opaque, Error **errp)
> >  {
> > +    X86CPU *cpu = X86_CPU(obj);
> >      BitProperty *fp = opaque;
> > -    bool value = (*fp->ptr & fp->mask) == fp->mask;
> > +    uint32_t f = cpu->env.features[fp->w];
> > +    bool value = (f & fp->mask) == fp->mask;
> >      visit_type_bool(v, name, &value, errp);
> >  }
> >  
> > @@ -3708,6 +3715,7 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
> >                                   void *opaque, Error **errp)
> >  {
> >      DeviceState *dev = DEVICE(obj);
> > +    X86CPU *cpu = X86_CPU(obj);
> >      BitProperty *fp = opaque;
> >      Error *local_err = NULL;
> >      bool value;
> > @@ -3724,10 +3732,11 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
> >      }
> >  
> >      if (value) {
> > -        *fp->ptr |= fp->mask;
> > +        cpu->env.features[fp->w] |= fp->mask;
> >      } else {
> > -        *fp->ptr &= ~fp->mask;
> > +        cpu->env.features[fp->w] &= ~fp->mask;
> >      }
> > +    cpu->env.user_features[fp->w] |= fp->mask;
> >  }
> >  
> >  static void x86_cpu_release_bit_prop(Object *obj, const char *name,
> > @@ -3745,7 +3754,7 @@ static void x86_cpu_release_bit_prop(Object *obj, const char *name,
> >   */
> >  static void x86_cpu_register_bit_prop(X86CPU *cpu,
> >                                        const char *prop_name,
> > -                                      uint32_t *field,
> > +                                      FeatureWord w,
> >                                        int bitnr)
> >  {
> >      BitProperty *fp;
> > @@ -3755,11 +3764,11 @@ static void x86_cpu_register_bit_prop(X86CPU *cpu,
> >      op = object_property_find(OBJECT(cpu), prop_name, NULL);
> >      if (op) {
> >          fp = op->opaque;
> > -        assert(fp->ptr == field);
> > +        assert(fp->w == w);
> >          fp->mask |= mask;
> >      } else {
> >          fp = g_new0(BitProperty, 1);
> > -        fp->ptr = field;
> > +        fp->w = w;
> >          fp->mask = mask;
> >          object_property_add(OBJECT(cpu), prop_name, "bool",
> >                              x86_cpu_get_bit_prop,
> > @@ -3787,7 +3796,7 @@ static void x86_cpu_register_feature_bit_props(X86CPU *cpu,
> >      /* aliases don't use "|" delimiters anymore, they are registered
> >       * manually using object_property_add_alias() */
> >      assert(!strchr(name, '|'));
> > -    x86_cpu_register_bit_prop(cpu, name, &cpu->env.features[w], bitnr);
> > +    x86_cpu_register_bit_prop(cpu, name, w, bitnr);
> >  }
> >  
> >  static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
> 

-- 
Eduardo
