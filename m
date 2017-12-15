Received: from eggs.gnu.org ([2001:4830:134:3::10]:41297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePupz-0003TF-6u
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:36:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePupw-0006cc-0N
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:35:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ePupv-0006ab-OC
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:35:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAAD46551
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 18:35:54 +0000 (UTC)
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-11-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4e623c8d-fc60-df02-6039-8ff249bf2376@redhat.com>
Date: Fri, 15 Dec 2017 12:35:51 -0600
MIME-Version: 1.0
In-Reply-To: <20171215150659.1811-11-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5bXkQF5R9xB8vOUWi7Dtglwsn6Xmx2unS"
Subject: Re: [Qemu-devel] [PATCH v2 10/13] qemu-config: fix leak in
 query-command-line-options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5bXkQF5R9xB8vOUWi7Dtglwsn6Xmx2unS
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <4e623c8d-fc60-df02-6039-8ff249bf2376@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/13] qemu-config: fix leak in
 query-command-line-options
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
 <20171215150659.1811-11-marcandre.lureau@redhat.com>
In-Reply-To: <20171215150659.1811-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 09:06 AM, Marc-Andr=C3=A9 Lureau wrote:
> Direct leak of 160 byte(s) in 4 object(s) allocated from:
>     #0 0x55ed7678cda8 in calloc (/home/elmarco/src/qq/build/x86_64-soft=
mmu/qemu-system-x86_64+0x797da8)
>     #1 0x7f3f5e725f75 in g_malloc0 /home/elmarco/src/gnome/glib/builddi=
r/../glib/gmem.c:124
>     #2 0x55ed778aa3a7 in query_option_descs /home/elmarco/src/qq/util/q=
emu-config.c:60:16
>     #3 0x55ed778aa307 in get_drive_infolist /home/elmarco/src/qq/util/q=
emu-config.c:140:19
>     #4 0x55ed778a9f40 in qmp_query_command_line_options /home/elmarco/s=
rc/qq/util/qemu-config.c:254:36

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  util/qemu-config.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/util/qemu-config.c b/util/qemu-config.c
> index 99b0e46fa3..029fec53a9 100644
> --- a/util/qemu-config.c
> +++ b/util/qemu-config.c
> @@ -105,7 +105,8 @@ static void cleanup_infolist(CommandLineParameterIn=
foList *head)
>              if (!strcmp(pre_entry->value->name, cur->next->value->name=
)) {
>                  del_entry =3D cur->next;
>                  cur->next =3D cur->next->next;
> -                g_free(del_entry);
> +                del_entry->next =3D NULL;
> +                qapi_free_CommandLineParameterInfoList(del_entry);

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5bXkQF5R9xB8vOUWi7Dtglwsn6Xmx2unS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlo0FgcACgkQp6FrSiUn
Q2pwZwf+JdRtUm2jUOegN2MD0mthDYRFw6PFfX3NC0hU9p1jBslJCMDWNVva06qL
7BRVmi4zlMix66HxxO6d3kDLMR+PvRiIM7LJ3I+vud9fn/G5UagF77iOpX2NnJWj
Z+MrP3tuiVH9GGIr/3+EGC/h0+NZkxPBW0CTLR3du0ixaULmdptTubs/RN7J5KDr
I2rHF3Sw9qRedKMtqcRouf3blBTk/7d5cNvLxbu13fvDN152T9g9rO4KMGyPh0YF
vkw+v4yXcimmQJlkajerRVVcGVmnCRglwui8YNwmbl/6b5t3+IdiX3xksLyLLqsd
lEZp2wyEja0nlE78bkX4RsxSemJXuA==
=ZGFs
-----END PGP SIGNATURE-----

--5bXkQF5R9xB8vOUWi7Dtglwsn6Xmx2unS--
