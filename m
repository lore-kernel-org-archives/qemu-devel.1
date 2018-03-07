Received: from eggs.gnu.org ([2001:4830:134:3::10]:35708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etVXF-00030z-JH
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etVXC-0000Le-73
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:38:57 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etVWt-0000JR-4n
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:38:54 -0500
Received: by mail-wr0-x243.google.com with SMTP id v65so1428328wrc.11
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 01:38:34 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <23118.27370.136663.284087@guava.gson.org>
	<143c7064-8a4d-6f78-6d50-ed10096ddd3b@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5b3a1a64-2960-d120-08f4-e32227df2712@amsat.org>
Date: Wed, 7 Mar 2018 06:38:30 -0300
MIME-Version: 1.0
In-Reply-To: <143c7064-8a4d-6f78-6d50-ed10096ddd3b@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="DqJbeMMpkROEB0rQ6nkTHLeZMTpOoBkur"
Subject: Re: [Qemu-devel] [PATCH] slirp: disable Nagle in outgoing
 connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, Andreas Gustafsson <gson@gson.org>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DqJbeMMpkROEB0rQ6nkTHLeZMTpOoBkur
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Kamil Rytarowski <n54@gmx.com>, Andreas Gustafsson <gson@gson.org>,
 qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5b3a1a64-2960-d120-08f4-e32227df2712@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] slirp: disable Nagle in outgoing connections
References: <23118.27370.136663.284087@guava.gson.org>
 <143c7064-8a4d-6f78-6d50-ed10096ddd3b@gmx.com>
In-Reply-To: <143c7064-8a4d-6f78-6d50-ed10096ddd3b@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/07/2018 06:13 AM, Kamil Rytarowski wrote:
> This patch is correct. LLDB expects 1sec for reply, GDB by default 2.
>=20
> Debuggers use this option to disable Nagle algorithm in order to quickl=
y
> transfer messages between gdb-server and gdb-client. It's also fairy
> portable across systems.
>=20
> On 04.01.2018 18:56, Andreas Gustafsson wrote:
>> slirp: disable Nagle in outgoing connections
>>
>> When setting up an outgoing user mode networking TCP connection,
>> disable the Nagle algorithm in the host-side connection.  Either the
>> guest is already doing Nagle, in which case there is no point in doing=

>> it twice, or it has chosen to disable it, in which case we should
>> respect that choice.
>>
>> This change speeds up GDB remote debugging over TCP over user mode
>> networking (with GDB runing on the guest) by multiple orders of
>> magnitude, and has been part of the local patches applied by pkgsrc
>> since 2012 with no reported ill effects.
>>
>> Signed-off-by: Andreas Gustafsson <gson@gson.org>
>=20
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>

I suppose you meant "Reviewed-by: Kamil Rytarowski <n54@gmx.com>"

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

>=20
>> ---
>>  slirp/tcp_subr.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
>> index da0d53743f..8d0f94b75f 100644
>> --- a/slirp/tcp_subr.c
>> +++ b/slirp/tcp_subr.c
>> @@ -416,6 +416,8 @@ int tcp_fconnect(struct socket *so, unsigned short=
 af)
>>      socket_set_fast_reuse(s);
>>      opt =3D 1;
>>      qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(opt));
>> +    opt =3D 1;
>> +    qemu_setsockopt(s, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
>> =20
>>      addr =3D so->fhost.ss;
>>      DEBUG_CALL(" connect()ing")
>>
>=20
>=20


--DqJbeMMpkROEB0rQ6nkTHLeZMTpOoBkur
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlqfsxcACgkQ4+MsLN6t
wN7R5BAA0xO7VEtXn6J3PRv1B3sov18kgGcu+qUkcQB189KqCHLm4FYy2D48GEO1
4ngqOIbq9FYtuvYIL862RMhfMN3/tMehwWMquqA60eFrZxQLhCI7nCgGRk4hMeNz
rESiQG6/xia7hzw93bOBRLniguhDit2Zb4nn1LzwzRQ0ybjYpm+lr5jxweCWVM+R
ohjjnxm5+tisgPEDl4xgk5rpIZ53PXkpmQ2kn5pU+1c3W6781kXiNMY/QewrGpTu
CDgYbjdGEUXuuU/VEnimqmCAUA4OYtffSrX87pE0AaWAqfJLgvdEJiIuDe/oEZ5k
dkTSPoGmQt3gEPqPWxu+n+cWRjwNvHtQNwzNeIUWE3q6KNKMFs+g+QhR5Fn7utYl
SAMlgjSmsvR6kItqX1iEeMLLYLASmR1bcAaMtFkB9VKZToMAcBmnaUB+A0sGIpV3
Gp76J7ezl6I86bRDZjMy+fUdFmh5OXt/N4Il5/HZMQaguN2qVPObcoryUNwEBYBe
Nbz7Vhunk6CtDUsNmttFOBlnl1Smx41BZefe+BhUg1CpNvaTdAnMqujKxEDdwlEl
+6hT90inZO9sVBn+fIoUFUsaLucWjEc7O2iDZ7KyLX+GxD38kdG4+bNZahPToUej
yUY6PyIC6ebyLfSbNA+oh9Bcyf2EO34YrICfKYCdNCkF9pawpbA=
=7xS7
-----END PGP SIGNATURE-----

--DqJbeMMpkROEB0rQ6nkTHLeZMTpOoBkur--
