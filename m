Received: from eggs.gnu.org ([2001:4830:134:3::10]:38851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d0aG0-0004ab-6h
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 17:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d0aFw-00061C-80
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 17:01:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33901
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d0aFw-000616-2E
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 17:01:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3IKrjkg006653
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 17:01:46 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29wqq0epyv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 17:01:46 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 18 Apr 2017 17:01:46 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170413173625.GG27126@thinpad.lan.raisama.net>
References: <1490700426-222115-1-git-send-email-agraf@suse.de>
	<20170413173625.GG27126@thinpad.lan.raisama.net>
Date: Tue, 18 Apr 2017 16:01:20 -0500
Message-Id: <149254928069.7320.7406236070784019013@loki>
Subject: Re: [Qemu-devel] [PATCH v2] i386: Allow cpuid bit override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>

Quoting Eduardo Habkost (2017-04-13 12:36:25)
> On Tue, Mar 28, 2017 at 01:27:06PM +0200, Alexander Graf wrote:
> > KVM has a feature bitmap of CPUID bits that it knows works for guests.
> > QEMU removes bits that are not part of that bitmap automatically on VM
> > start.
> > =

> > However, some times we just don't list features in that list because
> > they don't make sense for normal scenarios, but may be useful in specif=
ic,
> > targeted workloads.
> > =

> > For that purpose, add a new =3Dforce option to all CPUID feature flags =
in
> > the CPU property. With that we can override the accel filtering and give
> > users full control over the CPUID feature bits exposed into guests.
> > =

> > Signed-off-by: Alexander Graf <agraf@suse.de>
> > =

> > ---
> > =

> > v1 -> v2:
> > =

> >   - Base on "i386: Replace uint32_t* with FeatureWord on feature getter=
/setter"
> > ---
> >  target/i386/cpu.c | 25 ++++++++++++++++++++++---
> >  target/i386/cpu.h |  3 +++
> >  2 files changed, 25 insertions(+), 3 deletions(-)
> > =

> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 13c0985..6105fc5 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -2229,7 +2229,7 @@ void x86_cpu_list(FILE *f, fprintf_function cpu_f=
printf)
> >      g_slist_foreach(list, x86_cpu_list_entry, &s);
> >      g_slist_free(list);
> >  =

> > -    (*cpu_fprintf)(f, "\nRecognized CPUID flags:\n");
> > +    (*cpu_fprintf)(f, "\nRecognized CPUID flags (=3Don|=3Doff|=3Dforce=
):\n");
> >      for (i =3D 0; i < ARRAY_SIZE(feature_word_info); i++) {
> >          FeatureWordInfo *fw =3D &feature_word_info[i];
> >  =

> > @@ -3464,6 +3464,7 @@ static int x86_cpu_filter_features(X86CPU *cpu)
> >              x86_cpu_get_supported_feature_word(w, false);
> >          uint32_t requested_features =3D env->features[w];
> >          env->features[w] &=3D host_feat;
> > +        env->features[w] |=3D cpu->forced_features[w];
> >          cpu->filtered_features[w] =3D requested_features & ~env->featu=
res[w];
> >          if (cpu->filtered_features[w]) {
> >              rv =3D 1;
> > @@ -3706,8 +3707,17 @@ static void x86_cpu_get_bit_prop(Object *obj, Vi=
sitor *v, const char *name,
> >      X86CPU *cpu =3D X86_CPU(obj);
> >      BitProperty *fp =3D opaque;
> >      uint32_t f =3D cpu->env.features[fp->w];
> > +    uint32_t ff =3D cpu->forced_features[fp->w];
> >      bool value =3D (f & fp->mask) =3D=3D fp->mask;
> > -    visit_type_bool(v, name, &value, errp);
> > +    bool forced =3D (ff & fp->mask) =3D=3D fp->mask;
> > +    char str[] =3D "force";
> > +    char *strval =3D str;
> > +
> > +    if (forced) {
> > +        visit_type_str(v, name, &strval, errp);
> > +    } else {
> > +        visit_type_bool(v, name, &value, errp);
> =

> Interesting approach. This means we keep returning a boolean
> value on the property getter (which is important to not break
> compatibility), but return a string in case the feature was set
> to "force".
> =

> We probably should update the 'type' field of the property, as it
> won't be a real "bool" property anymore.
> =

> I won't say I love that solution, but it seems to work. I'm CCing
> the QAPI maintainers to see what they think about it.
> =

> (For reference: in the v1 thread I have suggested introducing a
> new enum type in the QAPI schema, but this would break
> compatibility with existing management code that expects the
> property to return a boolean value [like the users of
> query-cpu-model-expansion]).
> =

> > +    }
> >  }
> >  =

> >  static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *=
name,
> > @@ -3717,6 +3727,7 @@ static void x86_cpu_set_bit_prop(Object *obj, Vis=
itor *v, const char *name,
> >      X86CPU *cpu =3D X86_CPU(obj);
> >      BitProperty *fp =3D opaque;
> >      Error *local_err =3D NULL;
> > +    char *strval =3D NULL;
> >      bool value;
> >  =

> >      if (dev->realized) {
> > @@ -3724,7 +3735,15 @@ static void x86_cpu_set_bit_prop(Object *obj, Vi=
sitor *v, const char *name,
> >          return;
> >      }
> >  =

> > -    visit_type_bool(v, name, &value, &local_err);
> > +    visit_type_str(v, name, &strval, &local_err);
> > +    if (!local_err && !strcmp(strval, "force")) {
> > +        value =3D true;
> > +        cpu->forced_features[fp->w] |=3D fp->mask;
> > +    } else {
> > +        local_err =3D NULL;
> > +        visit_type_bool(v, name, &value, &local_err);
> > +    }
> =

> I'm not sure this is valid usage of the visitor API. If the
> visit_type_str() call succeeds, isn't the visitor allowed to
> consume the original value, and return something completely
> different when visit_type_bool() is called?

That was indeed one of the design goals, to the extent that
you could even take a stream of data types and actually build
up a dictionary based on the ordering visited (e.g. the
once-proposed BER visitor for migration and why QAPI uses
OrderedDict when generating visitors).

I'm not sure how important that is anymore, but even setting
that aside that we still have the issue of not handling the
data type as declared, and relying on error-handling to probe
it, which doesn't necessarily leave the visitor in a recoverable
state where we can continue visiting. I think it might be possible
to rely on the "alternate" QAPI type to handle this case. Maybe
something like this?

    GenericAlternate *alt =3D NULL;
    visit_start_alternate(v, name, &alt, sizeof(*alt), false, &local_err);
    if (local_err) {
        goto out;
    }
    if (!alt) {
        goto out_obj;
    }
    switch (alt->type) {
    case QTYPE_QBOOL:
        visit_type_bool(v, name, &value, &local_err);
        break;
    case QTYPE_QSTRING:
        visit_type_str(v, name, &strval, &local_err);
        if (!local_err && !strcmp(strval, "force")) {
            value =3D true;
            cpu->forced_features[fp->w] |=3D fp->mask;
        }
        break;
    default:
        error_setg(&local_err, "invalid type");
    }

out_obj:
    visit_end_alternate(v, (void **)obj);
out:
    ...

This would only work for setters/qobject-input-visitor ATM though since
qobject-output-visitor doesn't support the visit_start_alternate()
interface. I'm not sure why it wasn't enabled on the output side, maybe
Eric knows if doing so would be feasible for this situation?

> =

> > +
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >          return;
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index c4602ca..69efe6c 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -1230,6 +1230,9 @@ struct X86CPU {
> >      /* Features that were filtered out because of missing host capabil=
ities */
> >      uint32_t filtered_features[FEATURE_WORDS];
> >  =

> > +    /* Features that are force enabled despite incompatible accel */
> > +    uint32_t forced_features[FEATURE_WORDS];
> > +
> >      /* Enable PMU CPUID bits. This can't be enabled by default yet bec=
ause
> >       * it doesn't have ABI stability guarantees, as it passes all PMU =
CPUID
> >       * bits returned by GET_SUPPORTED_CPUID (that depend on host CPU a=
nd kernel
> > -- =

> > 1.8.5.6
> > =

> > =

> =

> -- =

> Eduardo
>=20
