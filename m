Received: from eggs.gnu.org ([2001:4830:134:3::10]:52655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih6H-0001XT-8k
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih6C-0004Au-M5
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:46:25 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:36313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eih6C-0004A6-Fg
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:46:20 -0500
Received: by mail-qt0-f182.google.com with SMTP id t25so6006659qtg.3
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:46:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-10-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-10-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 14:46:19 +0100
Message-ID: <CAMxuvawB2EaYOCrnO-m7JpSbc=ZVCb6XwMyQs5sXmNb0JZF0aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 09/21] qapi: Don't absolutize include
 file name in error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>, mdroth@linux.vnet.ibm.com

On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Error messages print absolute filenames of included files even gave a
> relative one on the command line:
>
>      PYTHONPATH=3Dscripts python -B tests/qapi-schema/test-qapi.py tests/=
qapi-schema/include-cycle.json
>     In file included from tests/qapi-schema/include-cycle.json:1:
>     In file included from /work/armbru/qemu/tests/qapi-schema/include-cyc=
le-b.json:1:
>     /work/armbru/qemu/tests/qapi-schema/include-cycle-c.json:1: Inclusion=
 loop for include-cycle.json
>
> Improve this to
>
>     In file included from tests/qapi-schema/include-cycle.json:1:
>     In file included from tests/qapi-schema/include-cycle-b.json:1:
>     tests/qapi-schema/include-cycle-c.json:1: Inclusion loop for include-=
cycle.json
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

most of the necessary refactoring/split is done in previous patch,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi/common.py                | 12 ++++++------
>  tests/qapi-schema/include-no-file.err |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index be0fcc548a..6c6962a364 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -255,9 +255,8 @@ class QAPIDoc(object):
>  class QAPISchemaParser(object):
>
>      def __init__(self, fp, previously_included=3D[], incl_info=3DNone):
> -        abs_fname =3D os.path.abspath(fp.name)
>          self.fname =3D fp.name
> -        previously_included.append(abs_fname)
> +        previously_included.append(os.path.abspath(fp.name))
>          self.incl_info =3D incl_info
>          self.src =3D fp.read()
>          if self.src =3D=3D '' or self.src[-1] !=3D '\n':
> @@ -288,7 +287,7 @@ class QAPISchemaParser(object):
>                  if not isinstance(include, str):
>                      raise QAPISemError(info,
>                                         "Value of 'include' must be a str=
ing")
> -                self._include(include, info, os.path.dirname(abs_fname),
> +                self._include(include, info, os.path.dirname(self.fname)=
,
>                                previously_included)
>              elif "pragma" in expr:
>                  self.reject_expr_doc(cur_doc)
> @@ -321,7 +320,8 @@ class QAPISchemaParser(object):
>                  % doc.symbol)
>
>      def _include(self, include, info, base_dir, previously_included):
> -        incl_abs_fname =3D os.path.join(base_dir, include)
> +        incl_fname =3D os.path.join(base_dir, include)
> +        incl_abs_fname =3D os.path.abspath(incl_fname)
>          # catch inclusion cycle
>          inf =3D info
>          while inf:
> @@ -333,9 +333,9 @@ class QAPISchemaParser(object):
>          if incl_abs_fname in previously_included:
>              return
>          try:
> -            fobj =3D open(incl_abs_fname, 'r')
> +            fobj =3D open(incl_fname, 'r')
>          except IOError as e:
> -            raise QAPISemError(info, '%s: %s' % (e.strerror, include))
> +            raise QAPISemError(info, '%s: %s' % (e.strerror, incl_fname)=
)
>          exprs_include =3D QAPISchemaParser(fobj, previously_included, in=
fo)
>          self.exprs.extend(exprs_include.exprs)
>          self.docs.extend(exprs_include.docs)
> diff --git a/tests/qapi-schema/include-no-file.err b/tests/qapi-schema/in=
clude-no-file.err
> index d5b9b22d85..e42bcf4bc1 100644
> --- a/tests/qapi-schema/include-no-file.err
> +++ b/tests/qapi-schema/include-no-file.err
> @@ -1 +1 @@
> -tests/qapi-schema/include-no-file.json:1: No such file or directory: inc=
lude-no-file-sub.json
> +tests/qapi-schema/include-no-file.json:1: No such file or directory: tes=
ts/qapi-schema/include-no-file-sub.json
> --
> 2.13.6
>
