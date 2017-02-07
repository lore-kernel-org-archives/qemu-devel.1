Received: from eggs.gnu.org ([2001:4830:134:3::10]:58609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cb8jb-00077h-2A
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cb8jX-0000x3-SE
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:35:15 -0500
Received: from 7.mo179.mail-out.ovh.net ([46.105.61.94]:37196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cb8jX-0000uq-Md
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:35:11 -0500
Received: from player732.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id ED56214AFB
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 17:35:07 +0100 (CET)
Date: Tue, 7 Feb 2017 17:35:04 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170207173504.46aa7258@bahia.lan>
In-Reply-To: <20170207135211.15870-5-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
	<20170207135211.15870-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/28] timer: use an inline function for
 free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue,  7 Feb 2017 17:51:47 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Similarly to allocation, do it from an inline function. This allows
> tests to only use the headers for allocation/free of timer.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/qemu/timer.h | 5 ++++-
>  qemu-timer.c         | 5 -----
>  2 files changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index 9abed51ae8..26e628584c 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -610,7 +610,10 @@ void timer_deinit(QEMUTimer *ts);
>   *
>   * Free a timer (it must not be on the active list)
>   */
> -void timer_free(QEMUTimer *ts);
> +static inline void timer_free(QEMUTimer *ts)
> +{
> +    g_free(ts);
> +}
> =20
>  /**
>   * timer_del:
> diff --git a/qemu-timer.c b/qemu-timer.c
> index ff620ecff7..6cf70b96f6 100644
> --- a/qemu-timer.c
> +++ b/qemu-timer.c
> @@ -355,11 +355,6 @@ void timer_deinit(QEMUTimer *ts)
>      ts->timer_list =3D NULL;
>  }
> =20
> -void timer_free(QEMUTimer *ts)
> -{
> -    g_free(ts);
> -}
> -
>  static void timer_del_locked(QEMUTimerList *timer_list, QEMUTimer *ts)
>  {
>      QEMUTimer **pt, *t;
