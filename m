Received: from eggs.gnu.org ([2001:4830:134:3::10]:40737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8n1m-0000RG-0v
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8n1k-0007kF-Hh
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:21:37 -0400
References: <20180405170619.20480-1-kwolf@redhat.com>
	<20180406080406.GA4850@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <25584b6b-b822-f4f8-2e94-47cf288f2b94@redhat.com>
Date: Wed, 18 Apr 2018 08:21:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180406080406.GA4850@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w1r0amXDNsnNrmR0F1LMYQO47cXCp1anG"
Subject: Re: [Qemu-devel] [RFC][BROKEN] rbd: Allow configuration of
 authentication scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jdurgin@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w1r0amXDNsnNrmR0F1LMYQO47cXCp1anG
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jdurgin@redhat.com, jcody@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <25584b6b-b822-f4f8-2e94-47cf288f2b94@redhat.com>
Subject: Re: [RFC][BROKEN] rbd: Allow configuration of authentication scheme
References: <20180405170619.20480-1-kwolf@redhat.com>
 <20180406080406.GA4850@localhost.localdomain>
In-Reply-To: <20180406080406.GA4850@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2018 03:04 AM, Kevin Wolf wrote:
> Am 05.04.2018 um 19:06 hat Kevin Wolf geschrieben:
>> The legacy command line syntax supports a "password-secret" option tha=
t
>> allows to pass an authentication key to Ceph. This was not supported i=
n
>> QMP so far.
>>
>> This patch introduces authentication options in the QAPI schema, makes=

>> them do the corresponding rados_conf_set() calls and adds compatibilit=
y
>> code that translates the old "password-secret" option both for opening=

>> and creating images to the new set of options.
>>
>> Note that the old option didn't allow to explicitly specify the set of=

>> allowed authentication schemes. The compatibility code assumes that if=

>> "password-secret" is given, only the cephx scheme is allowed. If it's
>> missing, both none and cephx are allowed because the configuration fil=
e
>> could still provide a key.
>=20
> There is another problem here that suggests that maybe this is not the
> right QAPI schema after all: The defaults needed for command line
> compatibility and those promised in the QAPI schema are conflicting.
>=20
> The required command line behaviour is as described above:
>=20
> * password-secret given: only cephx
> * no options given: cephx, none
>=20
> The desired QMP default behaviour is:
>=20
> * auth-cephx given: allow cephx
> * auth-none given: allow none
> * both given: allow both
> * no options given: error
>=20
> In .bdrv_open() there is no way to distinguish the "no options given" o=
f
> the command line from that of QMP. The current implementation allows
> everything if no options are given, i.e. it keeps existing command line=
s
> working, but it doesn't correctly implement the behaviour described in
> the QAPI schema.

Can we use a QAPI alternate with an explicit JSON null for the command
line 'no options given' case?

>=20
> I don't think changing the description of the QAPI schema would be a
> good idea, it would be a rather surprising interface.
>=20
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>
>> This doesn't actually work correctly yet because the way that options
>> are passed through the block layer (QAPI -> QemuOpts -> QDict). Before=

>> we fix or hack around this, let's make sure this is the schema that we=

>> want.

Can we skip the intermediate QemuOpts?  If we can go straight from
command line to QDict using just QAPI, won't that give us what we really
need?

>>
>> The two known problems are:
>>
>> 1. QDict *options in qemu_rbd_open() may contain options either in the=
ir
>>    proper QObject types (if passed from blockdev-add) or as strings
>>    (-drive). Both forms can be mixed in the same options QDict.
>>
>>    rbd uses the keyval visitor to convert the options into a QAPI
>>    object. This means that it requires all options to be strings. This=

>>    patch, however, introduces a bool property, so the visitor breaks
>>    when it gets its input from blockdev-add.
>>
>>    Options to hack around the problem:
>>
>>    a. Do an extra conversion step or two and go through QemuOpts like
>>       some other block drivers. When I offered something like this to
>>       Markus a while ago in a similar case, he rejected the idea.
>>
>>    b. Introduce a qdict_stringify_entries() that just does what its na=
me
>>       says. It would be called before the running keyval visitor so th=
at
>>       only strings will be present in the QDict.
>>
>>    c. Do a local one-off hack that checks if the entry with the key
>>       "auth-none" is a QBool, and if so, overwrite it with a string. T=
he
>>       problem will reappear with the next non-string option.
>>
>>    (d. Get rid of the QDict detour and work only with QAPI objects
>>        everywhere. Support rbd authentication only in QEMU 4.0.)

Oh, even one step further than just avoiding QemuOpts, but using REAL
types everywhere in the block layer!  It might be a nice cleanup, but it
would probably take a lot of effort in the meantime to get to that point?=


>>
>> 2. The proposed schema allows 'auth-cephx': {} as a valid option with
>>    the meaning that the cephx authentication scheme is enabled, but no=

>>    key is given (e.g. it is taken from the config file).
>>
>>    However, an empty dict cannot currently be represented by flattened=

>>    QDicts. We need to find a way to enable this. I think this will be
>>    externally visible because it directly translates into the dotted
>>    syntax of -blockdev, so we may want to be careful.

Can we just require users to give -blockdev with the JSON format (rather
than dotted format) when they need to use that particular feature on the
command line?

>>
>> Any thoughts on the proposed QAPI schema or the two implementation
>> problems are welcome.
>=20
> Kevin
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--w1r0amXDNsnNrmR0F1LMYQO47cXCp1anG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrXRk4ACgkQp6FrSiUn
Q2pm6Qf8CONrg9YxQ9ih2YWUaWs/Aa98AerZU4ZRpjmgvWqhDJ2aEMVIk00Mu9hM
nhfTeWEt78XGc/LDfxPZ+1Nkz18UL3nSEJnO52aMeYgomsb35qsQ5tX/CL/pDp3j
uqirWbjK68Q2vN7FQiEwaIYixlzATqeFVHb/gELKSPirn2+6zWypxTCS2gNDXI4S
HVSUCOEeAkJrNRjDAMIZf4XXAQ2mZzE36bwykr1xQTFcM6i+vc0QpVpg9SCxxCB8
3XCs203zlvlkYVFgOmIBTRuD2vTYgCoLgofmUzPT4Ao1UNz6f7HX2eieZuQNe6Fj
fMBQABuK82+/057D4Q2qgXv5rUMPOw==
=raTn
-----END PGP SIGNATURE-----

--w1r0amXDNsnNrmR0F1LMYQO47cXCp1anG--
