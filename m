Received: from eggs.gnu.org ([2001:4830:134:3::10]:50474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cni6X-0004Ux-4U
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cni6V-00013G-Pd
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:46:53 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cni6V-000135-Cz
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:46:51 -0400
Received: by mail-lf0-x243.google.com with SMTP id g70so13536650lfh.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 01:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-12-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Mar 2017 08:46:39 +0000
Message-ID: <CAJ+F1CKbJWGsZzD=kJh8aN2E3fi1atgLV4A+FmhOO9F=t-z0+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 11/47] qapi: Avoid unwanted blank
 lines in QAPIDoc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

Hi

On Mon, Mar 13, 2017 at 10:25 AM Markus Armbruster <armbru@redhat.com>
wrote:

> We silently fix missing #optional tags for QAPIDoc by appending a line
> "#optional" to the section's .content.  However, this interferes with
> .__repr__ stripping trailing blank lines from .content.
>
> Use new ArgSection instance variable .optional instead, and leave
> .content alone.
>
> To permit testing .optional in texi_body(), clean up texi_enum()'s
> hack to add empty documentation for undocumented enum values: add an
> ArgSection instead of ''.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi.py      | 5 +++--
>  scripts/qapi2texi.py | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index eec7bfb..e6d023f 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -107,6 +107,7 @@ class QAPIDoc(object):
>              self.name =3D name
>              # the list of lines for this section
>              self.content =3D []
> +            self.optional =3D False
>
>          def append(self, line):
>              self.content.append(line)
> @@ -978,15 +979,15 @@ def check_definition_doc(doc, expr, info):
>              desc =3D doc.args.get(arg)
>          if not desc:
>              continue
> +        desc.optional =3D opt
>          desc_opt =3D "#optional" in str(desc)
>          if desc_opt and not opt:
>              raise QAPISemError(info, "Description has #optional, "
>                                 "but the declaration doesn't")
>          if not desc_opt and opt:
> -            # silently fix the doc
>              # TODO either fix the schema and make this an error,
>              # or drop #optional entirely
> -            desc.append("#optional")
> +            pass
>
>      doc_args =3D set(doc.args.keys())
>      args =3D set([name.strip('*') for name in args])
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index 0f3e573..0aaf45c 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -136,7 +136,7 @@ def texi_body(doc):
>          for arg, section in doc.args.iteritems():
>              desc =3D str(section)
>              opt =3D ''
> -            if "#optional" in desc:
> +            if section.optional:
>                  desc =3D re.sub(r'^ *#optional *\n?|\n? *#optional
> *$|#optional',
>                                '', desc)
>                  opt =3D ' (optional)'
> @@ -185,7 +185,7 @@ def texi_enum(expr, doc):
>      """Format an enum to texi"""
>      for i in expr['data']:
>          if i not in doc.args:
> -            doc.args[i] =3D ''
> +            doc.args[i] =3D qapi.QAPIDoc.ArgSection(i)

     body =3D texi_body(doc)
>      return TYPE_FMT(type=3D"Enum",
>                      name=3Ddoc.symbol,
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
