Received: from eggs.gnu.org ([2001:4830:134:3::10]:41900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej0FL-0001IL-44
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:13:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ej0FG-0001wP-Va
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:13:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ej0FG-0001ui-Pg
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:12:58 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-7-marcandre.lureau@redhat.com>
Date: Tue, 06 Feb 2018 11:12:54 +0100
In-Reply-To: <20180111213250.16511-7-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 11 Jan 2018 22:32:05 +0100")
Message-ID: <874lmue89l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 06/51] qapi: pass 'if' condition into
 QAPISchemaEntity objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Built-in objects remain unconditional.  Explicitly defined objects
> use the condition specified in the schema.  Implicitly defined
> objects inherit their condition from their users.  For most of them,
> there is exactly one user, so the condition to use is obvious.  The
> exception is the wrapped type's generated for simple union variants,
> which can be shared by any number of simple unions.  The tight
> condition would be the disjunction of the conditions of these simple
> unions.  For now, use wrapped type's condition instead.  Much
> simpler and good enough for now.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py | 98 ++++++++++++++++++++++++++++++++++++++-------------=
------
>  1 file changed, 66 insertions(+), 32 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 27df0fcf48..8f54dead8d 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -991,8 +991,17 @@ def check_exprs(exprs):
>  # Schema compiler frontend
>  #
>=20=20
> +def listify_cond(ifcond):
> +    if not ifcond:
> +        return []
> +    elif not isinstance(ifcond, list):
> +        return [ifcond]
> +    else:
> +        return ifcond

pylint complains:

    R:995, 4: Unnecessary "else" after "return" (no-else-return)

Matter of taste.  Mine happens to agree with pylint's.  Suggest:

   def listify_cond(ifcond):
       if not ifcond:
           return []
       if not isinstance(ifcond, list):
           return [ifcond]
       return ifcond

> +
> +
>  class QAPISchemaEntity(object):
> -    def __init__(self, name, info, doc):
> +    def __init__(self, name, info, doc, ifcond=3DNone):
>          assert isinstance(name, str)
>          self.name =3D name
>          # For explicitly defined entities, info points to the (explicit)
[...]
