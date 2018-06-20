Received: from eggs.gnu.org ([2001:4830:134:3::10]:50571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVb3u-0006Oh-2j
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVb3p-00041l-4F
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:14:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVb3o-00041S-U2
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:14:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A5D177154
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 11:14:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-25-marcandre.lureau@redhat.com>
Date: Wed, 20 Jun 2018 13:13:57 +0200
In-Reply-To: <20180321115211.17937-25-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 21 Mar 2018
	12:51:46 +0100")
Message-ID: <87vaadww0a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 24/49] qapi: add a dictionary form with
 'type' key for members
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

No review, just a short note.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Wherever a struct/union/alternate/command/event member with NAME: TYPE
> form is accepted, desugar it to a NAME: { 'type': TYPE } form.
>
> This will allow to add new member details, such as 'if' in the
> following patch to introduce conditionals, or 'default' for default
> values etc.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
[...]
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 9eb2b0cc37..3f46ed5530 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
[...]
> @@ -952,6 +967,10 @@ def check_exprs(exprs):
>          info =3D expr_elem['info']
>          if 'enum' in expr:
>              normalize_enum(expr, info)
> +        elif 'union' in expr:
> +            normalize_members(expr, 'base')
> +        if {'union', 'alternate', 'struct', 'command', 'event'} & set(ex=
pr):
> +            normalize_members(expr, 'data')

You've since changed this to

  +        if set(['union', 'alternate', 'struct', 'command', 'event']) & s=
et(expr):
  +            normalize_members(expr, 'data')

in your git branch.

>=20=20
>      # Learn the types and check for valid expression keys
>      for expr_elem in exprs:
[...]
