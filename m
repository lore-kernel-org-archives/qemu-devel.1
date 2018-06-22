Received: from eggs.gnu.org ([2001:4830:134:3::10]:55557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWJxu-0004v9-0J
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWJxq-0000na-Sc
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:10:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fWJxq-0000nS-NS
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:10:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECBCA406C74B
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 11:10:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-31-marcandre.lureau@redhat.com>
Date: Fri, 22 Jun 2018 13:10:48 +0200
In-Reply-To: <20180321115211.17937-31-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 21 Mar 2018
	12:51:52 +0100")
Message-ID: <87bmc3dqkn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 30/49] docs: document schema
 configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/devel/qapi-code-gen.txt | 38 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index a569d24745..eec52e63e5 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -728,6 +728,44 @@ Example: Red Hat, Inc. controls redhat.com, and may =
therefore add a
>  downstream command __com.redhat_drive-mirror.
>=20=20
>=20=20
> +=3D=3D=3D Configuring the schema =3D=3D=3D
> +
> +Top-level QAPI expressions and various type expressions listed below

Not sure about "and various type expressions listed below".  Perhaps
it's better to start with explaining just top-level conditionals, then
explain member conditionals separately.

> +can take an 'if' key.  The value must be a string or a list of
> +string.  The corresponding generated code will then guard the inclusion

s/string/strings/

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
> +Where a member can normally be defined with a single string value as its
> +type, it is also possible to supply a dictionary with both 'type' and
> +'if' keys.
> +
> +{ 'struct': 'IfStruct', 'data':
> +  { 'foo': 'int',
> +    'bar': { 'type': 'int', 'if': 'defined(IFCOND)'} } }
> +
> +An enum value can be replaced by a dictionary with a 'name' and a 'if'
> +key:
> +
> +{ 'enum': 'IfEnum', 'data':
> +  [ 'foo',
> +    { 'name' : 'bar', 'if': 'defined(IFCOND)' } ] }
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

Missing: how 'if' affects generated code.

Want me to try my hand at a fixup?
