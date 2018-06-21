Received: from eggs.gnu.org ([2001:4830:134:3::10]:35239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVtfs-0007x2-3p
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVtfn-000647-57
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:06:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVtfn-00062q-0d
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:06:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2C68400E9BA
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 07:06:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-9-marcandre.lureau@redhat.com>
Date: Thu, 21 Jun 2018 09:06:24 +0200
In-Reply-To: <20180321115211.17937-9-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 21 Mar 2018 12:51:30 +0100")
Message-ID: <87a7ropqj3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 08/49] qapi: add #if/#endif helpers
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

> Add helpers to wrap generated code with #if/#endif lines.
>
> Add QAPIGenCSnippet class to write C snippet code, make QAPIGenC
> inherit from it, for full C files with copyright headers etc.
>
> Add a 'with' statement context manager that will be used to wrap
> generator visitor methods.  The manager will check if code was
> generated before adding #if/#endif lines on QAPIGenCSnippet
> objects. Used in the following patches.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py | 82 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 78 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 47efe79758..60c1d0a783 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
[...]
> @@ -2061,6 +2097,23 @@ class QAPIGen(object):
>      def add(self, text):
>          self._body +=3D text
>=20=20
> +    def start_if(self, ifcond):
> +        self._ifcond =3D ifcond
> +        self._start_if_body =3D self._body
> +        self._start_if_preamble =3D self._preamble

pylint gripes:

+W:2102, 8: Attribute '_start_if_body' defined outside __init__ (attribute-=
defined-outside-init)
+W:2103, 8: Attribute '_start_if_preamble' defined outside __init__ (attrib=
ute-defined-outside-init)

We generally define in .__init__(), except when we want to catch
premature use, such as in PATCH 05.  Let's define these two in
.__init__().

[...]
