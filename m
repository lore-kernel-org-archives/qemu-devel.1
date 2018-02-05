Received: from eggs.gnu.org ([2001:4830:134:3::10]:35844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eij4e-0003jV-OF
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:52:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eij4b-0003T7-Kw
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:52:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eij4b-0003RN-Bw
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:52:49 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-7-armbru@redhat.com>
	<05068311-b8db-69b0-9c86-50839994f630@redhat.com>
	<87lgga4f7s.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0e3ea662-418e-0574-3817-434b35e85887@redhat.com>
Date: Mon, 5 Feb 2018 09:52:41 -0600
MIME-Version: 1.0
In-Reply-To: <87lgga4f7s.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n4ZJx3XvCWIfjqDZpHdIyY5p8tTGo6OnZ"
Subject: Re: [Qemu-devel] [PATCH RFC 06/21] qapi-gen: New common driver for
 code and doc generators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n4ZJx3XvCWIfjqDZpHdIyY5p8tTGo6OnZ
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 mdroth@linux.vnet.ibm.com
Message-ID: <0e3ea662-418e-0574-3817-434b35e85887@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 06/21] qapi-gen: New common driver for
 code and doc generators
References: <20180202130336.24719-1-armbru@redhat.com>
 <20180202130336.24719-7-armbru@redhat.com>
 <05068311-b8db-69b0-9c86-50839994f630@redhat.com>
 <87lgga4f7s.fsf@dusky.pond.sub.org>
In-Reply-To: <87lgga4f7s.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2018 03:03 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 02/02/2018 07:03 AM, Markus Armbruster wrote:
>>> Whenever qapi-schema.json changes, we run six programs eleven times t=
o
>>> update eleven files.  This is silly.  Replace the six programs by a
>>> single program that spits out all eleven files.
>>
>> Yay, about time!
>>
>> One program, but still invoked multiple times:
>>

>>>  rename scripts/{qapi2texi.py =3D> qapi/doc.py} (92%)
>>>  mode change 100755 =3D> 100644
>>
>> Unintinentional?  We're inconsistent on which of our *.py files are
>> executable in git.  Does it matter whether a file that is designed for=

>> use as a module is marked executable (if so, perhaps 5/21 should be
>> adding the x attribute on other files, rather than this patch removing=

>> it on the doc generator).
>=20
> qapi2texi.py is no longer runnable as a standalone program after this
> patch.
>=20
> So are qapi-{commands,events,introspect,types,visit}.py, but they never=

> had the executable bit set.

Okay, so dropping the bit consistently makes sense; still, a mention in
the commit message wouldn't hurt.

>=20
>>> +++ b/Makefile
>>
>>> +qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-type=
s.h \
>>> +qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visi=
t.h \
>>> +qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-mar=
shal.c \
>>> +qga/qapi-generated/qga-qapi.texi: \
>>> +qga/qapi-generated/qapi-gen-timestamp ;
>>> +qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.j=
son $(qapi-py)
>>> +	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
>>> +		-o qga/qapi-generated -p "qga-" $<, \
>>> +		"GEN","$(@:%-timestamp=3D%)")
>>> +	@>$@
>>
>> once for qga,
>=20
> That's the QAPI/QGA schema.  The commit message talks about the QAPI/QM=
P
> schema.  I wish the two weren't named the same.

7 files here,...

>=20
> Modularization might make fusing them possible.  Whether that's a good
> idea I don't know.
>=20
>>> +qapi-types.c qapi-types.h \
>>> +qapi-visit.c qapi-visit.h \
>>> +qmp-commands.h qmp-marshal.c \
>>> +qapi-event.c qapi-event.h \
>>> +qmp-introspect.h qmp-introspect.c \
>>> +qapi.texi: \
>>> +qapi-gen-timestamp ;
>>> +qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
>>> +	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
>>> +		-o "." -b $<, \
>>> +		"GEN","$(@:%-timestamp=3D%)")
>>> +	@>$@
>>
>> and again for the main level.  Still, a definite improvement!

11 files here,...

>=20
> Perhaps I can find a way to clarify the commit message.
>=20

[1]


>>> -def main(argv):
>>> -    (input_file, output_dir, do_c, do_h, prefix, opts) =3D parse_com=
mand_line()
>>> -
>>> -    blurb =3D '''
>>> - * Schema-defined QAPI/QMP commands
>>> -'''
>>> -
>>> +def gen_commands(schema, output_dir, prefix):
>>> +    blurb =3D ' * Schema-defined QAPI/QMP commands'
>>
>> Some churn on the definition of blurb; worth tidying this in the
>> introduction earlier in the series?
>=20
> Doesn't seem worth a separate patch, but I can try to reshuffle things
> to reduce churn.

Yeah, my question was more about the conversion between multiline
'''...''' to single-line '...'; why not just use the single-line
construct earlier in the series when introducing the blurb variable.
You are right that creating blurb didn't need a separate patch, just
less churn over the series.

>>> =20
>>> -qapi-py =3D $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/orderedd=
ict.py
>>> +# TODO don't duplicate $(SRC_PATH)/Makefile's qapi-py here
>>> +qapi-py =3D $(SRC_PATH)/scripts/qapi/commands.py \
>>> +$(SRC_PATH)/scripts/qapi/events.py \
>>> +$(SRC_PATH)/scripts/qapi/introspect.py \
>>> +$(SRC_PATH)/scripts/qapi/types.py \
>>> +$(SRC_PATH)/scripts/qapi/visit.py \
>>> +$(SRC_PATH)/scripts/qapi/common.py \
>>> +$(SRC_PATH)/scripts/qapi/doc.py \
>>> +$(SRC_PATH)/scripts/ordereddict.py \
>>> +$(SRC_PATH)/scripts/qapi-gen.py
>>
>> So, were you counting these in the 11 generated files mentioned in the=

>> commit message? :)
>=20
> I'm not sure I understand what you mean here...

[1] and 9 more files.  So, the commit message only mentioned the 11 QMP
files, rather than all 27 (if I counted right) QAPI generated files.  My
comments were trying to point out that you simplified more than just the
QMP code generation into fewer script invocations, and the counts looked
off since out of the three spots converted, only one of the spots had 11
files.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--n4ZJx3XvCWIfjqDZpHdIyY5p8tTGo6OnZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp4fckACgkQp6FrSiUn
Q2qNvgf/b8oX3rteQ7CY/9tM5uimWgrK/aZvkkK+elhpIQP5gWa3Eb6FvD7FQba+
Xgbanrep+Y6HowUC4kjpczScTGAB1GNuho7Ex+kvEsqdAbn3x+f/qFJFYA90Zw8B
dE/1elDM7ivJnVnlFEtkSbN4TwIwwlx7fpBnOFtDrVx0U2mI0xRHBjB2V9sC3J//
uWNEQzZmmnOORNuI0WnugBxVuB9EUcPPtco1JNlaTa55ijEvCUOgKjNUKf0jFiPL
IIpFXKPMuy1ES4UpelmF0lCfNBIkPn7HNPRnTedrDz2KJ+5voyZmNlBz57zQQjQB
QJuRUUq14Amke/ErHoOZ9kwInsIf4w==
=Z3k6
-----END PGP SIGNATURE-----

--n4ZJx3XvCWIfjqDZpHdIyY5p8tTGo6OnZ--
