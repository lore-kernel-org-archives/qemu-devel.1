Received: from eggs.gnu.org ([2001:4830:134:3::10]:46229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQgWb-0005Vl-30
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQgWW-0005zH-6w
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:26:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cQgWV-0005z5-Uv
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:26:32 -0500
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
	<1483371890-289981-4-git-send-email-imammedo@redhat.com>
	<bd7470b8-42e1-c681-f5c5-0d3808e0a9b6@redhat.com>
	<20170109151733.34510569@nial.brq.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76f63302-2cb2-199e-317f-7d44212188b9@redhat.com>
Date: Mon, 9 Jan 2017 14:26:28 -0600
MIME-Version: 1.0
In-Reply-To: <20170109151733.34510569@nial.brq.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Stx02inntB2tWRv6Jnct71SSsIrL5Tklh"
Subject: Re: [Qemu-devel] [PATCH 3/3] fix qmp/hmp query-memdev not
 repporting IDs of memory backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, afaerber@suse.de, ehabkost@redhat.com, dgilbert@redhat.com, armbru@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Stx02inntB2tWRv6Jnct71SSsIrL5Tklh
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, afaerber@suse.de, ehabkost@redhat.com,
 dgilbert@redhat.com, armbru@redhat.com, pbonzini@redhat.com
Message-ID: <76f63302-2cb2-199e-317f-7d44212188b9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] fix qmp/hmp query-memdev not repporting
 IDs of memory backends
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
 <1483371890-289981-4-git-send-email-imammedo@redhat.com>
 <bd7470b8-42e1-c681-f5c5-0d3808e0a9b6@redhat.com>
 <20170109151733.34510569@nial.brq.redhat.com>
In-Reply-To: <20170109151733.34510569@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2017 08:17 AM, Igor Mammedov wrote:

>> Wait. Isn't this going to inject an 'id' dict member to every use of
>> user_creatable_add_type()?  But not all QAPI structs contain an id
>> member.  Which means that you are now explicitly relying on the visito=
r
>> to silently ignore garbage in the dictionary, rather than our desired
>> goal of only validating if the dictionary exactly matches what the QAP=
I
>> says it will match.
>>
>> I'm not sure if I like this hack, or if there is a better way to do
>> things when using a strict (rather than relaxed) input visitor.
> a bit less ugly variant but with the same basic idea would look like:
> --------------
> Subject: [PATCH] fix qmp/hmp query-memdev not reporting IDs of memory b=
ackends  =20
>                                                                        =
         =20
> Considering 'id' is mandatory for user_creatable objects/backends      =
         =20
> and user_creatable_add_type() always has it as an argument             =
         =20
> regardless of where from it is called CLI/monitor or QMP,              =
         =20
> Fix issue by adding 'id' property to hostmem backends and              =
         =20
> set it in user_creatable_add_type() for every object that              =
         =20
> implements 'id' property. Then later at query-memdev time              =
         =20
> get 'id' from object directly.                    =20

Yes, that seems like an improved message.

>                                                                        =
         =20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>=20
>=20
> [...]
>=20
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index 9b4155a..03a95c3 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -62,6 +62,12 @@ Object *user_creatable_add_type(const char *type, co=
nst char *id,
> =20
>      assert(qdict);
>      obj =3D object_new(type);
> +    if (object_property_find(obj, "id", NULL)) {
> +        object_property_set_str(obj, id, "id", &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +    }

Works for me.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Stx02inntB2tWRv6Jnct71SSsIrL5Tklh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYc/H0AAoJEKeha0olJ0NqUqsH/j3rbJDvy8zUoDBzl8ZM2iyC
StTwpfsG6nZPoLS6y7WIJhm93qeEyfAs/seXuR0HXHVyaODIbZ5v58pWv98H32xW
mbVftt4YF7Ord+KqXJmoiDTAhbWFP57/bsXxVDMOpFB8XI+GK2XHBPOsmHDdMuJm
9tHGNa+/jIE6kmiWRSoW5BX0c8iyRazNA3jzYGurtKaPdbH2Y4Iwm1/m7B398jm+
vgeq9RY9UIyZT5etxgZFgzHT2VK6+OB760GdqJtUPZWbk393jgFDs2ftqTItC1ff
zTyyDgPGY9ambGNOz1BTl6R78Sg+1rJoapnjAwWZ+biKr5LCXVAVGSlFdiLr7Do=
=qYP0
-----END PGP SIGNATURE-----

--Stx02inntB2tWRv6Jnct71SSsIrL5Tklh--
