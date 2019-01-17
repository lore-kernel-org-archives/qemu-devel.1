Received: from eggs.gnu.org ([209.51.188.92]:33187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkB0F-0000Ly-2Z
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkB0C-0000FY-My
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:58:51 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-18-eblake@redhat.com>
	<2124d8aa-7081-ccdd-7e13-aca823b40020@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <071f88a7-a1a8-0dcc-8153-99034790168b@redhat.com>
Date: Thu, 17 Jan 2019 10:58:00 -0600
MIME-Version: 1.0
In-Reply-To: <2124d8aa-7081-ccdd-7e13-aca823b40020@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QH76GhdsNOrTMdFOFWUDBhTWF9dav61pU"
Subject: Re: [Qemu-devel] [PATCH v3 17/19] qemu-nbd: Add --list option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QH76GhdsNOrTMdFOFWUDBhTWF9dav61pU
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <071f88a7-a1a8-0dcc-8153-99034790168b@redhat.com>
Subject: Re: [PATCH v3 17/19] qemu-nbd: Add --list option
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-18-eblake@redhat.com>
 <2124d8aa-7081-ccdd-7e13-aca823b40020@virtuozzo.com>
In-Reply-To: <2124d8aa-7081-ccdd-7e13-aca823b40020@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/17/19 4:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.01.2019 20:58, Eric Blake wrote:
>> We want to be able to detect whether a given qemu NBD server is
>> exposing the right export(s) and dirty bitmaps, at least for
>> regression testing.  We could use 'nbd-client -l' from the upstream
>> NBD project to list exports, but it's annoying to rely on
>> out-of-tree binaries; furthermore, nbd-client doesn't necessarily
>> know about all of the qemu NBD extensions.  Thus, it is time to add
>> a new mode to qemu-nbd that merely sniffs all possible information
>> from the server during handshake phase, then disconnects and dumps
>> the information.
>>
>> This patch actually implements --list/-L, while reusing other
>> options such as --tls-creds for now designating how to connect
>> as the client (rather than their non-list usage of how to operate
>> as the server).
>>

>>
>> Not done here, but maybe worth future experiments: capture
>> the meat of NBDExportInfo into a QAPI struct, and use the
>> generated QAPI pretty-printers instead of hand-rolling our
>> output loop.  It would also permit us to add a JSON output
>> mode for machine parsing.

A start of that experiment has now been posted:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg04196.html


>>   @item --tls-creds=3DID
>>   Enable mandatory TLS encryption for the server by setting the ID
>>   of the TLS credentials object previously created with the --object
>> -option.
>> +option; or provide the credentials needed for connecting as a client
>> +in list mode.
>=20
> may be "list mode (--list)", as "list mode" is not directly defined. On=
 the other hand,
> list option is extremely close to tls-creds, so it is obvious anyway.

I'm thinking of adding this (and see conversation below that mentions [1]=
):

diff --git i/qemu-nbd.texi w/qemu-nbd.texi
index 65caeb7874a..0d297eed6db 100644
--- i/qemu-nbd.texi
+++ w/qemu-nbd.texi
@@ -105,7 +105,9 @@ Set the NBD volume export description, as a
human-readable
 string.
 @item -L, --list
 Connect as a client and list all details about the exports exposed by
-a remote NBD server.
+a remote NBD server.  This enables list mode, and is incompatible
+with options that change behavior related to a specific export (such as
+@option{--export-name}, @option{--offset}, ...).
 @item --tls-creds=3DID
 Enable mandatory TLS encryption for the server by setting the ID
 of the TLS credentials object previously created with the --object


>> +static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds=
 *tls,
>> +                                const char *hostname)
>> +{
>> +    int ret =3D EXIT_FAILURE;
>> +    int rc;
>> +    Error *err =3D NULL;
>> +    QIOChannelSocket *sioc;
>> +    NBDExportInfo *list;
>> +    int i, j;
>> +
>> +    sioc =3D qio_channel_socket_new();
>> +    if (qio_channel_socket_connect_sync(sioc, saddr, &err) < 0) {
>> +        error_report_err(err);
>> +        goto out;
>=20
> May be just return EXIT_FAUILURE here;
> remove out label;
> s/out_socket/out

Will do. Probably leftovers from earlier attempts as I changed my
approach over time.


>> +    printf("exports available: %d\n", rc);
>> +    for (i =3D 0; i < rc; i++) {
>> +        printf(" export: '%s'\n", list[i].name);
>> +        if (list[i].description && *list[i].description) {
>> +            printf("  description: %s\n", list[i].description);
>> +        }
>> +        if (list[i].flags & NBD_FLAG_HAS_FLAGS) {
>=20
> actually this is
>=20
> if (server not have a bug of not setting NBD_FLAG_HAS_FLAGS) {

Which, as the commit message mentions, is for servers so old and rare
that it really doesn't matter.

>   ...
> }
>=20
> Why not to print @size for example, if @flags field has a bug?
>=20
> Or, then, why to print flags, if @size has a bug?

Because we don't have to worry about those servers being mainstream.

>>
>> -    if ((argc - optind) !=3D 1) {
>> +    if (list) {
>> +        if (argc !=3D optind) {
>> +            error_report("List mode is incompatible with a file name"=
);
>> +            exit(EXIT_FAILURE);
>> +        }
>> +        if (export_name || export_description || dev_offset || partit=
ion ||
>> +            device || disconnect || fmt || sn_id_or_name || bitmap) {=

>> +            error_report("List mode is incompatible with per-device s=
ettings");
>> +            exit(EXIT_FAILURE);
>=20
> and what about aio, discard, etc?

I don't mind adding in any more options that you think are useful to
flag the user on.  Looks like I missed seen_aio, seen_cache,
seen_discard.  Catching '-s' is harder, as it merely sets a bit within
flags rather than a witness variable.

> Also, I think, it would be good to specify in Usage
> (or in man), which options are available for list mode.

I worry that keeping an exact list may be a maintenance nightmare (the
two are likely to get out of sync); does my proposed wording above at
[1] satisfy the problem by at least making the user aware that not all
combinations will work?

Another alternative would be to just silently ignore all per-export
options, instead of warning the user that they are incompatible.  I
don't know if that's any friendlier, but it is less code.

>=20
> Hm, note, --help has grouping of options and man don't.

That could be a separate patch, if it is desired (or squashed into 2/19)

>=20
>=20
> I don't have good understanding of tls related things, the rest looks O=
K,
> my suggestions are optional, so, if you don't want to improve docs and
> option conflict checking now:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--QH76GhdsNOrTMdFOFWUDBhTWF9dav61pU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxAtBgACgkQp6FrSiUn
Q2r6kAf8CjQb87rNbxOk6/3fqy4UzB8lKVHNvSZ3DJKAm+H4xQ4Xa37gjh//1F5p
wSmKvWD47NDVWyHfb3xWnxY44lt/+KBa4tW4PZjvsucl62XGW3Lnm1RFrbs+w3De
YV+sNXxxYKz1f1gRe8ld6mR+UqGipBtmuZNj8XPGPLp8xjPhXyXh/+dnVOGahzZk
m8EC0joUt8bcQFKsUe/4ZMEXybQOj+y0n2Hytuz4GCZa5b4ywubk2nD0W/b1FL7D
dEvvHKnemUj4qbJS6fVhUQ6s6qdw8MppD9j+MAp1h5IjJvDibTuVzurnDagTGvhC
6kiKYe5igFTaogWiZVZsvR5cyzXcvw==
=7Tll
-----END PGP SIGNATURE-----

--QH76GhdsNOrTMdFOFWUDBhTWF9dav61pU--
