Received: from eggs.gnu.org ([2001:4830:134:3::10]:43257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMcUB-0007NB-R4
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMcU9-0002Ob-4u
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:23:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eMcU8-0002Nh-Rg
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:23:49 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-5-marcandre.lureau@redhat.com>
Date: Wed, 06 Dec 2017 17:23:43 +0100
In-Reply-To: <20170911110623.24981-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 11 Sep 2017 13:05:37 +0200")
Message-ID: <87mv2vx1tc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/50] qapi: add 'if' to top-level
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
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Second thoughts...

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
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py                         | 35 +++++++++++++++++++++++++++=
------
>  tests/test-qmp-commands.c               |  6 ++++++
>  tests/qapi-schema/qapi-schema-test.json | 20 +++++++++++++++++++
>  tests/qapi-schema/qapi-schema-test.out  | 22 +++++++++++++++++++++
>  4 files changed, 77 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 62dc52ed6e..20c1abf915 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -639,6 +639,26 @@ def add_name(name, info, meta, implicit=3DFalse):
>      all_names[name] =3D meta
>=20=20
>=20=20
> +def check_if(expr, info):
> +
> +    def check_if_str(ifcond, info):
> +        if ifcond =3D=3D '':
> +            raise QAPISemError(info, "'if' condition '' makes no sense")
> +
> +    ifcond =3D expr['if']
> +    if isinstance(ifcond, str):
> +        check_if_str(ifcond, info)
> +    elif (isinstance(ifcond, list)
> +          and all(isinstance(elt, str) for elt in ifcond)):
> +        if ifcond =3D=3D []:
> +            raise QAPISemError(info, "'if' condition [] is useless")
> +        for elt in ifcond:
> +            check_if_str(elt, info)
> +    else:
> +        raise QAPISemError(
> +            info, "'if' condition must be a string or a list of strings")
> +
> +

Slightly terser:

   def check_if(expr, info):

       def check_if_str(ifcond, info):
           if not isinstance(ifcond, str):
               raise QAPISemError(
                   info, "'if' condition must be a string or a list of stri=
ngs")
           if ifcond =3D=3D '':
               raise QAPISemError(info, "'if' condition '' makes no sense")

       ifcond =3D expr['if']
       if isinstance(ifcond, list):
           if ifcond =3D=3D []:
               raise QAPISemError(info, "'if' condition [] is useless")
           for elt in ifcond:
               check_if_str(elt, info)
       else:
           check_if_str(ifcond, info)

Can slot this in on commit.

>  def check_type(info, source, value, allow_array=3DFalse,
>                 allow_dict=3DFalse, allow_optional=3DFalse,
>                 allow_metas=3D[]):
[...]
