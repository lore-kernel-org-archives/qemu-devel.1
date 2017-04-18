Received: from eggs.gnu.org ([2001:4830:134:3::10]:42522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0aWr-0007iR-TO
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 17:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0aWo-0004fx-NR
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 17:19:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d0aWo-0004f2-DH
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 17:19:14 -0400
References: <1490700426-222115-1-git-send-email-agraf@suse.de>
	<20170413173625.GG27126@thinpad.lan.raisama.net>
	<149254928069.7320.7406236070784019013@loki>
From: Eric Blake <eblake@redhat.com>
Message-ID: <75cd49eb-7a78-ef86-9df4-8962228c8285@redhat.com>
Date: Tue, 18 Apr 2017 16:19:10 -0500
MIME-Version: 1.0
In-Reply-To: <149254928069.7320.7406236070784019013@loki>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CguwRoUIJqAQFlaRVSG0UXvJL352Gblas"
Subject: Re: [Qemu-devel] [PATCH v2] i386: Allow cpuid bit override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CguwRoUIJqAQFlaRVSG0UXvJL352Gblas
From: Eric Blake <eblake@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Message-ID: <75cd49eb-7a78-ef86-9df4-8962228c8285@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] i386: Allow cpuid bit override
References: <1490700426-222115-1-git-send-email-agraf@suse.de>
 <20170413173625.GG27126@thinpad.lan.raisama.net>
 <149254928069.7320.7406236070784019013@loki>
In-Reply-To: <149254928069.7320.7406236070784019013@loki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/18/2017 04:01 PM, Michael Roth wrote:

>>> @@ -3706,8 +3707,17 @@ static void x86_cpu_get_bit_prop(Object *obj, =
Visitor *v, const char *name,
>>>      X86CPU *cpu =3D X86_CPU(obj);
>>>      BitProperty *fp =3D opaque;
>>>      uint32_t f =3D cpu->env.features[fp->w];
>>> +    uint32_t ff =3D cpu->forced_features[fp->w];
>>>      bool value =3D (f & fp->mask) =3D=3D fp->mask;
>>> -    visit_type_bool(v, name, &value, errp);
>>> +    bool forced =3D (ff & fp->mask) =3D=3D fp->mask;
>>> +    char str[] =3D "force";
>>> +    char *strval =3D str;
>>> +
>>> +    if (forced) {
>>> +        visit_type_str(v, name, &strval, errp);
>>> +    } else {
>>> +        visit_type_bool(v, name, &value, errp);
>>
>> Interesting approach. This means we keep returning a boolean
>> value on the property getter (which is important to not break
>> compatibility), but return a string in case the feature was set
>> to "force".
>>
>> We probably should update the 'type' field of the property, as it
>> won't be a real "bool" property anymore.
>>
>> I won't say I love that solution, but it seems to work. I'm CCing
>> the QAPI maintainers to see what they think about it.

Use of a formal QAPI alternate type seems reasonable here.

>>
>> (For reference: in the v1 thread I have suggested introducing a
>> new enum type in the QAPI schema, but this would break
>> compatibility with existing management code that expects the
>> property to return a boolean value [like the users of
>> query-cpu-model-expansion]).

>>> @@ -3724,7 +3735,15 @@ static void x86_cpu_set_bit_prop(Object *obj, =
Visitor *v, const char *name,
>>>          return;
>>>      }
>>> =20
>>> -    visit_type_bool(v, name, &value, &local_err);
>>> +    visit_type_str(v, name, &strval, &local_err);
>>> +    if (!local_err && !strcmp(strval, "force")) {
>>> +        value =3D true;
>>> +        cpu->forced_features[fp->w] |=3D fp->mask;
>>> +    } else {
>>> +        local_err =3D NULL;
>>> +        visit_type_bool(v, name, &value, &local_err);
>>> +    }
>>
>> I'm not sure this is valid usage of the visitor API. If the
>> visit_type_str() call succeeds, isn't the visitor allowed to
>> consume the original value, and return something completely
>> different when visit_type_bool() is called?
>=20

Better would be defining the QAPI alternate type:

{ 'enum': 'Force', 'data': ['force']}
{ 'alternate': 'BoolOrForce',
  'data': { 'b': 'bool', 's': 'Force' } }

then given a BoolOrForce *state; declaration, you do either:

state->type =3D QTYPE_QBOOL;
state->u.b =3D true;

or

state->type =3D QTYPE_QSTRING;
state->u.s =3D FORCE_FORCE;

and then call visit_type_BoolOrForce(..., &state ...)

Qcow2OverlapChecks is an example of an alternate in use, if that helps.

> That was indeed one of the design goals, to the extent that
> you could even take a stream of data types and actually build
> up a dictionary based on the ordering visited (e.g. the
> once-proposed BER visitor for migration and why QAPI uses
> OrderedDict when generating visitors).

We document that QMP is order-insensitive, but you are right that
QAPI-generated code still respects ordering. Some of our testsuite at
least relies on the stability you get by always visiting things in
declaration order, even though other dictionary orders should still be
valid.

>=20
> I'm not sure how important that is anymore, but even setting
> that aside that we still have the issue of not handling the
> data type as declared, and relying on error-handling to probe
> it, which doesn't necessarily leave the visitor in a recoverable
> state where we can continue visiting. I think it might be possible
> to rely on the "alternate" QAPI type to handle this case. Maybe
> something like this?

Yes, that was the proposal I outlined above.  Note that your rough-idea
code:

>=20
>     GenericAlternate *alt =3D NULL;
>     visit_start_alternate(v, name, &alt, sizeof(*alt), false, &local_er=
r);
>     if (local_err) {
>         goto out;
>     }
>     if (!alt) {
>         goto out_obj;
>     }
>     switch (alt->type) {
>     case QTYPE_QBOOL:
>         visit_type_bool(v, name, &value, &local_err);
>         break;
>     case QTYPE_QSTRING:
>         visit_type_str(v, name, &strval, &local_err);

=2E..
is a duplicate of what is already generated for
visit_type_BoolOrForce(), so you don't need to open-code it.

>=20
> This would only work for setters/qobject-input-visitor ATM though since=

> qobject-output-visitor doesn't support the visit_start_alternate()
> interface. I'm not sure why it wasn't enabled on the output side, maybe=

> Eric knows if doing so would be feasible for this situation?

qobject-output-visitor DOES support alternates.  It doesn't need a
=2Estart_alternate callback, because the generic visitor-core.c code
handles things just fine for output visitors (only input visitors _have_
to have a callback).  The comments in visitor-impl.h confirm that.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CguwRoUIJqAQFlaRVSG0UXvJL352Gblas
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9oLOAAoJEKeha0olJ0NqSrQH/ir8m3JESlPt/Z+a3LCOwWvU
bmXrczSL2B7esN14/lkzMW8Bt2V91yZr21DL7+QDkp3iGz9w2mWXqVV5JtElyb/L
Qz/fqPrvc9mxZpmhISw6TOLjJa5knhTKI9LmBcl9wnxYk071LbDauJSZGcm90EYz
U20x+BU5z2I17Fn5/a6eAoneQ6OHf5SxXpy9CpfnU3MgDjiNQc80cMXtoMYhZZvi
ZfZj3/axfHKbW+ASIOIVkaktIVaSx8RaQb7qFIyRcXr3Fb+QAP9cnZlxxmrI4g6q
gbpkFU4ur+7mA8pIzGe03+51u6o5RHEDkOjKWYaH6igw+vkBoUnf+j2uShpI5BM=
=lJYZ
-----END PGP SIGNATURE-----

--CguwRoUIJqAQFlaRVSG0UXvJL352Gblas--
