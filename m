Received: from eggs.gnu.org ([2001:4830:134:3::10]:41296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTjWH-0005XG-Q8
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTjWC-0002dB-Mr
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:23:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gTjWC-0002c1-Fr
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:23:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E48B3097074
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 08:23:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
	<20181029125733.14597-5-marcandre.lureau@redhat.com>
Date: Mon, 03 Dec 2018 09:23:45 +0100
In-Reply-To: <20181029125733.14597-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 29 Oct 2018 16:57:31 +0400")
Message-ID: <871s6z81da.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/6] monitor: check if chardev can
 switch gcontext for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Not all backends are able to switch gcontext. Those backends cannot
> drive a OOB monitor (the monitor would then be blocking on main
> thread).
>
> For example, ringbuf, spice, or more esoteric input chardevs like
> braille or MUX.
>
> We currently forbid MUX because not all frontends are ready to run
> outside main loop. Extend to add a context-switching feature check.

Double-checking: the reason for forbidding MUX and the reason for
requiring QEMU_CHAR_FEATURE_GCONTEXT are orthogonal, right?

> Note: this patch will conflict with Peter "[PATCH v9 3/6] monitor:
> remove "x-oob", turn oob on by default", but can be trivially updated.

I intend to merge this series first, and drop this sentence.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 511dd11d1c..fffeb27ef9 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4560,9 +4560,11 @@ void monitor_init(Chardev *chr, int flags)
>      bool use_oob =3D flags & MONITOR_USE_OOB;
>=20=20
>      if (use_oob) {
> -        if (CHARDEV_IS_MUX(chr)) {
> +        if (CHARDEV_IS_MUX(chr) ||
> +            !qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
>              error_report("Monitor out-of-band is not supported with "
> -                         "MUX typed chardev backend");
> +                         "%s typed chardev backend",
> +                         object_get_typename(OBJECT(chr)));
>              exit(1);
>          }
>          if (use_readline) {
