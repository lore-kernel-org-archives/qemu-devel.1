Received: from eggs.gnu.org ([2001:4830:134:3::10]:52626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYYMb-0008LR-0Y
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYYMW-0004sP-4b
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:57:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42560 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fYYMV-0004qQ-Vf
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:57:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
	<20180627163551.31610-2-marcandre.lureau@redhat.com>
Date: Thu, 28 Jun 2018 16:57:26 +0200
In-Reply-To: <20180627163551.31610-2-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 27 Jun 2018 18:35:37 +0200")
Message-ID: <871scrgdrd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/15] qapi: add 'if' to top-level
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
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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

This paragraph looks obsolete now, because...

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/common.py                   | 35 ++++++++++++++++++++----
>  tests/test-qmp-cmds.c                    |  6 ++++
>  docs/devel/qapi-code-gen.txt             | 22 +++++++++++++++

... you update documentation right in this patch (I like that).

[...]
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 88a70e4d45..7af60b48f3 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -739,6 +739,28 @@ Example: Red Hat, Inc. controls redhat.com, and may =
therefore add a
>  downstream command __com.redhat_drive-mirror.
>=20=20
>=20=20
> +=3D=3D=3D Configuring the schema =3D=3D=3D
> +
> +Top-level QAPI expressions.

This sentence no verb :)  I suspect an editing accident ate "can take an
'if' key".

>                               The value must be a string or a list of
> +string.

s/string/strings/

>           The corresponding generated code will then guard the inclusion
> +of that member in the larger struct or function with #if IFCOND
> +(or several #if lines for a list), where IFCOND is the value of the
> +'if' key.

"that member" makes little sense; top-level expressions aren't members.

> +
> +'struct', 'enum', 'union', 'alternate', 'command' and 'event'
> +top-level QAPI expressions can take an 'if' keyword like:
> +
> +{ 'struct': 'IfStruct', 'data': { 'foo': 'int' },
> +  'if': 'defined(IFCOND)' }

Repetitive.

Moreover, I'd like to see the example spell out how conditions affect
generated code.

Here's my try:

=3D=3D=3D Configuring the schema =3D=3D=3D

The 'struct', 'enum', 'union', 'alternate', 'command' and 'event'
top-level expressions can take an 'if' key.  Its value must be a string
or a list of strings.  A string is shorthand for a list containing just
that string.  The code generated for the top-level expression will then
be guarded by #if COND for each COND in the list.

Example: a conditional struct

 { 'struct': 'IfStruct', 'data': { 'foo': 'int' },
   'if': ['defined(CONFIG_FOO)', 'defined(HAVE_BAR)'] }

gets its generated code guarded like this:

 #if defined(CONFIG_FOO)
 #if defined(HAVE_BAR)
 ... generated code ...
 #endif /* defined(HAVE_BAR) */
 #endif /* defined(CONFIG_FOO) */

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
[...]

I'm happy to apply these proposals without a respin, if you like them.
