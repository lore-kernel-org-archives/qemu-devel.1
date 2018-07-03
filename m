Received: from eggs.gnu.org ([2001:4830:134:3::10]:45753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faO3g-0005vw-3T
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faO3e-0006Nu-Tz
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:21:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51950 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faO3e-0006NA-OU
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:21:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2547A81ACF3A
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 16:21:38 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180703155648.11933-1-marcandre.lureau@redhat.com>
	<20180703155648.11933-2-marcandre.lureau@redhat.com>
Date: Tue, 03 Jul 2018 18:21:34 +0200
In-Reply-To: <20180703155648.11933-2-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 3 Jul 2018 17:56:35 +0200")
Message-ID: <87601we1dd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 01/14] qapi: add 'if' to top-level
 expressions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Accept 'if' key in top-level elements, accepted as string or list of
> string type. The following patches will modify the test visitor to
> check the value is correctly saved, and generate #if/#endif code (as a
> single #if/endif line or a series for a list).
>
> Example of 'if' key:
> { 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
>   'if': 'defined(TEST_IF_STRUCT)' }
>
> The generated code is for now *unconditional*. Later patches generate
> the conditionals.
>
> A following patch for qapi-code-gen.txt will provide more complete
> documentation for 'if' usage.

Dropping this paragraph as per review of v6.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
[...]
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 94a7e8f4d0..beca020575 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -744,6 +744,28 @@ Example: Red Hat, Inc. controls redhat.com, and may =
therefore add a
>  downstream command __com.redhat_drive-mirror.
>=20=20
>=20=20
> +=3D=3D=3D Configuring the schema =3D=3D=3D
> +
> +Top-level QAPI expressions.  The value must be a string or a list of
> +string.  The corresponding generated code will then guard the inclusion
> +of that member in the larger struct or function with #if IFCOND
> +(or several #if lines for a list), where IFCOND is the value of the
> +'if' key.
> +
> +'struct', 'enum', 'union', 'alternate', 'command' and 'event'
> +top-level QAPI expressions can take an 'if' keyword like:
> +
> +{ 'struct': 'IfStruct', 'data': { 'foo': 'int' },
> +  'if': 'defined(IFCOND)' }
> +
> +Please note that you are responsible to ensure that the C code will
> +compile with an arbitrary combination of conditions, since the
> +generators are unable to check it at this point.
> +
> +The presence of 'if' keys in the schema is reflected through to the
> +introspection output depending on the build configuration.
> +
> +
>  =3D=3D Client JSON Protocol introspection =3D=3D
>=20=20
>  Clients of a Client JSON Protocol commonly need to figure out what

Replacing this hunk by

  +=3D=3D=3D Configuring the schema =3D=3D=3D
  +
  +The 'struct', 'enum', 'union', 'alternate', 'command' and 'event'
  +top-level expressions can take an 'if' key.  Its value must be a string
  +or a list of strings.  A string is shorthand for a list containing just
  +that string.  The code generated for the top-level expression will then
  +be guarded by #if COND for each COND in the list.
  +
  +Example: a conditional struct
  +
  + { 'struct': 'IfStruct', 'data': { 'foo': 'int' },
  +   'if': ['defined(CONFIG_FOO)', 'defined(HAVE_BAR)'] }
  +
  +gets its generated code guarded like this:
  +
  + #if defined(CONFIG_FOO)
  + #if defined(HAVE_BAR)
  + ... generated code ...
  + #endif /* defined(HAVE_BAR) */
  + #endif /* defined(CONFIG_FOO) */
  +
  +Please note that you are responsible to ensure that the C code will
  +compile with an arbitrary combination of conditions, since the
  +generators are unable to check it at this point.
  +
  +The presence of 'if' keys in the schema is reflected through to the
  +introspection output depending on the build configuration.
  +
  +

as per review of v6.

[...]
