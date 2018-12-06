Received: from eggs.gnu.org ([2001:4830:134:3::10]:51876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUyAr-0001T9-Qd
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUyAl-0005jf-Np
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:14:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUyAl-0005hh-FD
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:14:51 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2C8DC049592
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 18:14:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-23-marcandre.lureau@redhat.com>
Date: Thu, 06 Dec 2018 19:14:46 +0100
In-Reply-To: <20180706105753.26700-23-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 6 Jul 2018
	12:57:48 +0200")
Message-ID: <877egm8quh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 22/27] docs: document schema
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
>  docs/devel/qapi-code-gen.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index c2e11465f0..799aef7728 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -752,6 +752,25 @@ gets its generated code guarded like this:
>   #endif /* defined(HAVE_BAR) */
>   #endif /* defined(CONFIG_FOO) */
>=20=20
> +Where a member can be defined with a single string value for its type,
> +it is also possible to supply a dictionary instead with both 'type'
> +and 'if' keys.
> +
> +Example: a conditional 'bar' member
> +
> +{ 'struct': 'IfStruct', 'data':
> +  { 'foo': 'int',
> +    'bar': { 'type': 'int', 'if': 'defined(IFCOND)'} } }
> +
> +An enum value can be replaced by a dictionary with a 'name' and a 'if'
> +key.
> +
> +Example: a conditional 'bar' enum member.
> +
> +{ 'enum': 'IfEnum', 'data':
> +  [ 'foo',
> +    { 'name' : 'bar', 'if': 'defined(IFCOND)' } ] }
> +
>  Please note that you are responsible to ensure that the C code will
>  compile with an arbitrary combination of conditions, since the
>  generators are unable to check it at this point.

I'd prefer to update qapi-code-gen.txt right when we extend the schema
language, like you did in part 1 (commit 967c885108f qapi: add 'if' to
top-level expressions).  I understand it's a bit more churn, since you
need four steps (enum, struct, union, alternate members).  I think the
following would be the least work for you that still satisfies me:

* Add the part about enum values in PATCH 13.

* Add the rest in PATCH 17 (the first patch that implements a part of
  it), with a TODO implement <list of things that get done in later
  patches>.  Then just update the TODO as you go.

Okay?
