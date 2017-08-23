Received: from eggs.gnu.org ([2001:4830:134:3::10]:52619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkXFa-0008RA-Qn
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkXFV-0001x4-Sj
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:07:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dkXFV-0001wX-N3
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:07:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAA447E42E
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 15:07:15 +0000 (UTC)
Message-ID: <1503500832.16071.32.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 23 Aug 2017 17:07:12 +0200
In-Reply-To: <87mv6yk1x3.fsf@dusky.pond.sub.org>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-17-marcandre.lureau@redhat.com>
	<87d17ur7y1.fsf@dusky.pond.sub.org> <87mv6yk1x3.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 16/26] qapi: add conditions to VNC
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Habkost, Eduardo" <ehabkost@redhat.com>

On Thu, 2017-08-17 at 10:56 +0200, Markus Armbruster wrote:
> Gerd, can we delete the vnc_init_func() stub?=C2=A0=C2=A0Things still c=
ompile
> for
> me when I do.
>=20
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 7262bef..2c3b2cd 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -484,11 +484,6 @@ static inline QemuOpts *vnc_parse(const char
> *str, Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg(errp, "VNC support is disabled=
");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> =C2=A0}
> -static inline int vnc_init_func(void *opaque, QemuOpts *opts, Error
> **errp)
> -{
> -=C2=A0=C2=A0=C2=A0=C2=A0error_setg(errp, "VNC support is disabled");
> -=C2=A0=C2=A0=C2=A0=C2=A0return -1;
> -}
> =C2=A0#endif

Looking at a663fbd9e2f65fae81018d81f231ad79510cf9fb.  Guess we want fix
qemu_opts_foreach to not barf on NULL, then revert that commit, so
f8c75b2486 (adding Eduardo to Cc) works as intended.

Beside that:  The inline for vnc_init_func looks pointless (it's used
via function pointer).  Also it can be empty as it will never be
actually called.  Which is fine, vnc_parse will throw an error if
someone tries to use vnc with a binary without vnc support.

cheers,
  Gerd
