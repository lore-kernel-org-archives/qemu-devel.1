Received: from eggs.gnu.org ([2001:4830:134:3::10]:56592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJ4tW-0008EF-5Q
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 17:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJ4tT-00028j-1d
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 17:23:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dJ4tS-00027S-Pd
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 17:23:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEBC44E4D4
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 21:23:01 +0000 (UTC)
References: <20170608133906.12737-1-ehabkost@redhat.com>
	<20170608133906.12737-6-ehabkost@redhat.com>
	<b27cc65d-1a07-c320-0bbc-8bb11dc22e63@redhat.com>
	<20170608160516.GL5016@thinpad.lan.raisama.net>
	<20170608174451.GJ22043@thinpad.lan.raisama.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f01fb514-c6be-6380-f893-4a20f516b578@redhat.com>
Date: Thu, 8 Jun 2017 16:22:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170608174451.GJ22043@thinpad.lan.raisama.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hi3lT6u58gAxcPDm9DPw4eJaoLvAwR5eK"
Subject: Re: [Qemu-devel] [PATCH 5/5] vnc: No need for Error** parameter at
 vnc_client_io_error()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hi3lT6u58gAxcPDm9DPw4eJaoLvAwR5eK
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <f01fb514-c6be-6380-f893-4a20f516b578@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] vnc: No need for Error** parameter at
 vnc_client_io_error()
References: <20170608133906.12737-1-ehabkost@redhat.com>
 <20170608133906.12737-6-ehabkost@redhat.com>
 <b27cc65d-1a07-c320-0bbc-8bb11dc22e63@redhat.com>
 <20170608160516.GL5016@thinpad.lan.raisama.net>
 <20170608174451.GJ22043@thinpad.lan.raisama.net>
In-Reply-To: <20170608174451.GJ22043@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/08/2017 12:44 PM, Eduardo Habkost wrote:

>>>> -ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp=
)
>>>> +ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
>>>>  {
>>>
>>> This is unusual.
>>
>> Why?  I would say that using Error** for input (and not output)
>> is the unusual pattern.

Yes, and when you frame it that way, it makes sense. But with no comment
framing it that way, ...

>> Isn't this one of the purposes of this function?
>>
>> The difference here is that now the function function is just
>> taking ownership of err, making the interface and the
>> implementation simpler.  If I document this more clearly at
>> vnc_client_io_error()'s declaration, would it make this change
>> acceptable?

=2E.. why yes, you've hit on why I felt uneasy - we are missing good
documentation!

>=20
> What about the following?
>=20

Yes, that makes it MUCH easier to understand what's going on.

With this squashed in,
Reviewed-by: Eric Blake <eblake@redhat.com>

> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  ui/vnc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 51f13f0c29..cb55554210 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1180,6 +1180,15 @@ void vnc_disconnect_finish(VncState *vs)
>      g_free(vs);
>  }
> =20
> +
> +/*
> + * Handle I/O error (@ret < 0) or EOF (@ret =3D=3D 0) from I/O
> + * channel.  In case of errors or EOF, @err is freed using
> + * error_free().
> + *
> + * Returns 0 in case @ret <=3D 0 and the error was properly
> + * handled, otherwise returns @ret.
> + */
>  ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
>  {
>      if (ret <=3D 0) {
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hi3lT6u58gAxcPDm9DPw4eJaoLvAwR5eK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOcAyAAoJEKeha0olJ0NqCZIH/2AO12+Jx/nXgbIMjlnTfN8w
tAMvfT5LR3ALLjc7wvKcPslZVFY6YJGIgoAJQGm30sxa5wbP2YghnGTS4EQ3Tcul
uJM819x49Osk4hh/wATuZi1zcIHh0EXDSmjC22O7GMq9w8pgiHlPKfz8/wA/VvcE
ObCAeC78CT+DFPkLKykR4xCYjqsRu6d2rPr8O8IWBlKx+0o9estGnSJBd+YjRw0z
qZLTy8rJDQyEOGeAatlNoaGv8Ppa/gJdSLWaHowyqo/5Sg220iAnaYs7BRMtCe/L
sXW45/1ErSfA875PhruIV/TJhmNenpLB9gWEOJqvsfnL9V0liVEeiplciOCwQIg=
=gHgj
-----END PGP SIGNATURE-----

--hi3lT6u58gAxcPDm9DPw4eJaoLvAwR5eK--
