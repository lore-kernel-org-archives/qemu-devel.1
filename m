Received: from eggs.gnu.org ([2001:4830:134:3::10]:38349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eP4Tk-0007hR-Re
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eP4Tg-0004CS-TT
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:41:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eP4Tg-0004BG-LP
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:41:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE936883AE
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 10:41:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-32-marcandre.lureau@redhat.com>
Date: Wed, 13 Dec 2017 11:41:23 +0100
In-Reply-To: <20170911110623.24981-32-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 11 Sep 2017
	13:06:04 +0200")
Message-ID: <87lgi6gbak.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 31/50] docs: document schema
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
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Cc: Eric for an additional pair of eyeballs.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/devel/qapi-code-gen.txt | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 0a90f2278a..24fc6f74ee 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -682,6 +682,43 @@ Example: Red Hat, Inc. controls redhat.com, and may =
therefore add a
>  downstream command __com.redhat_drive-mirror.
>=20=20
>=20=20
> +=3D=3D=3D Configuring the schema =3D=3D=3D
> +
> +'struct', 'enum', 'union', 'alternate', 'command' and 'event'
> +top-level QAPI expressions can take a 'if' keyword like:

an 'if' key

> +
> +{ 'struct': 'IfStruct', 'data': { 'foo': 'int' },
> +  'if': 'defined(IF_STRUCT) && defined(FOO)' }

Perhaps we should add something like

    Code generated for such conditional definitions will be guarded with
    #if IFCOND, where IFCOND is the value of the 'if' key.

> +
> +Members can be exploded as dictionnary with 'type' & 'if' keys:

dictionary

I get what you mean by "can be exploded", but can we phrase this more
clearly?

In section "Struct types", we have

    A struct is a dictionary containing a single 'data' key whose value is
    a dictionary; the dictionary may be empty.  This corresponds to a
    struct in C or an Object in JSON. Each value of the 'data' dictionary
    must be the name of a type, or a one-element array containing a type
    name.

The part "must be the name of a type, or a one-element array containing
a type" name is now wrong.

Likewise, in section "Enumeration types"

    An enumeration type is a dictionary containing a single 'data' key
    whose value is a list of strings.

> +
> +{ 'struct': 'IfStruct', 'data':
> +  { 'foo': 'int',
> +    'bar': { 'type': 'int', 'if': 'defined(IF_STRUCT_BAR)'} } }

Perhaps add something like

    Code generated for such conditional members will be guarded with #if
    IFCOND, where IFCOND is the value of the 'if' key.

> +
> +Enum values can be exploded as dictionnary with 'name' & 'if' keys:

dictionnary and exploded again.

> +
> +{ 'enum': 'IfEnum', 'data':
> +  [ 'foo',
> +    { 'name' : 'bar', 'if': 'defined(IF_ENUM_BAR)' } ] }
> +
> +The C code generators will wrap the corresponding lines with #if / #endif
> +pre-processor conditions for a given 'if' value.
> +
> +Example for enum values:
> +
> +enum IfEnum {
> +     IF_ENUM_FOO,
> +#if defined(IF_ENUM_BAR)
> +     IF_ENUM_BAR,
> +#endif /* defined(IF_ENUM_BAR) */
> +     IF_ENUM__MAX
> +}

Hmm.  If enumeration documentation profits from an example, it stands to
reason that the previous two would, too.

Should we (additionally?) add examples of 'if' in section "Code
generation"?

> +
> +Please note that you are responsbile to ensure that the C code will
> +compile with an arbitrary combination of conditions, since the
> +generators are unable to check it at this point.
> +
>  =3D=3D Client JSON Protocol introspection =3D=3D
>=20=20
>  Clients of a Client JSON Protocol commonly need to figure out what

Do we need to update section "Client JSON Protocol introspection"?
