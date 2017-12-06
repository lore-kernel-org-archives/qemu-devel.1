Received: from eggs.gnu.org ([2001:4830:134:3::10]:53988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMdhh-0003Hg-76
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMdhc-0007yc-CT
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:41:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eMdhc-0007xZ-6E
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:41:48 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-9-marcandre.lureau@redhat.com>
Date: Wed, 06 Dec 2017 18:41:42 +0100
In-Reply-To: <20170911110623.24981-9-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 11 Sep 2017 13:05:41 +0200")
Message-ID: <878tefvjmx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 08/50] qapi: mcgen() shouldn't indent #
 lines
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Skip preprocessor lines when adding indentation, since that would
> likely result in invalid code.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index f2b5a7e131..2a8e60e975 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1862,7 +1862,7 @@ def cgen(code, **kwds):
>      if indent_level:
>          indent =3D genindent(indent_level)
>          # re.subn() lacks flags support before Python 2.7, use re.compil=
e()
> -        raw =3D re.subn(re.compile(r'^.', re.MULTILINE),
> +        raw =3D re.subn(re.compile(r'^[^#\n].', re.MULTILINE),
>                        indent + r'\g<0>', raw)
>          raw =3D raw[0]
>      return re.sub(re.escape(eatspace) + r' *', '', raw)

Old: we want to indent all non-empty lines.  Such a line starts with a
character other than newline, matched by '.'.  Replace that character by
indent + the character.

New regexp: we want to indent all non-empty lines not starting with '#'.
Such a line starts with a character other than newline and '#', matched
by '[^#\n]'.  But there's a '.' afterwards, and therefore we don't match
*any* lines consisting of just one character:

    >>> cgen('a\n')
    'a\n'

I think you should drop the '.'.

Alternatively, use a negative lookahead assertion:

        raw =3D re.subn(re.compile(r'^(?!(#|$))', re.MULTILINE),
                      indent, raw)
