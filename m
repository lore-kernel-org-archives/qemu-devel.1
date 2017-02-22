Received: from eggs.gnu.org ([2001:4830:134:3::10]:54661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgVBF-0000Li-IY
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgVBE-0000Sr-N4
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:33:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cgVBE-0000Sm-Hd
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:33:56 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B29772625
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 11:33:56 +0000 (UTC)
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-5-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ba6b1df-2afc-abe7-200d-fdd60f734052@redhat.com>
Date: Wed, 22 Feb 2017 12:33:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170221141451.28305-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/30] timer: use an inline function for
 free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 21/02/2017 15:14, Marc-Andr=C3=A9 Lureau wrote:
> Similarly to allocation, do it from an inline function. This allows
> tests to only use the headers for allocation/free of timer.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
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
>=20

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
