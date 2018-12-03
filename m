Received: from eggs.gnu.org ([2001:4830:134:3::10]:54757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTiav-00024Z-AT
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 02:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTiX5-0008Dm-Bu
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 02:20:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gTiX5-0008DO-4j
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 02:20:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1600885A07
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 07:20:42 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
	<20181029125733.14597-4-marcandre.lureau@redhat.com>
Date: Mon, 03 Dec 2018 08:20:34 +0100
In-Reply-To: <20181029125733.14597-4-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 29 Oct 2018 16:57:30 +0400")
Message-ID: <87d0qj84al.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/6] char: add a
 QEMU_CHAR_FEATURE_GCONTEXT flag
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

This one needs review by a chardev guy, with an eye on its use in the
next patch.  Paolo?

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The feature should be set if the chardev is able to switch
> GMainContext. Callers that want to put a chardev in a different thread
> context can/should check this capabilities.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/chardev/char.h |  3 +++
>  chardev/char.c         | 11 +++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 7becd8c80c..014566c3de 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -47,6 +47,9 @@ typedef enum {
>      QEMU_CHAR_FEATURE_FD_PASS,
>      /* Whether replay or record mode is enabled */
>      QEMU_CHAR_FEATURE_REPLAY,
> +    /* Whether the gcontext can be changed after calling
> +     * qemu_chr_be_update_read_handlers() */
> +    QEMU_CHAR_FEATURE_GCONTEXT,
>=20=20
>      QEMU_CHAR_FEATURE_LAST,
>  } ChardevFeature;
> diff --git a/chardev/char.c b/chardev/char.c
> index 7f07a1bfbd..b5ee58b7d2 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -196,6 +196,8 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
>      s->gcontext =3D context;
>      if (cc->chr_update_read_handler) {
>          cc->chr_update_read_handler(s);
> +    } else if (s->gcontext) {
> +        error_report("switching context isn't supported by this chardev"=
);

Code smell: error_report() without returning failure.

If it's truly an error, then the function should fail.  We'd still need
to decide how: error_report() and return -1, or error_setg().

Except if it's a programming error; then we should assert().

If it's not an error, it's probably a warning, and we should use
warn_report().

>      }
>  }
>=20=20
> @@ -240,6 +242,15 @@ static void char_init(Object *obj)
>=20=20
>      chr->logfd =3D -1;
>      qemu_mutex_init(&chr->chr_write_lock);
> +
> +    /*
> +     * Assume if chr_update_read_handler is implemented it will
> +     * take the updated gcontext into account.
> +     */
> +    if (CHARDEV_GET_CLASS(chr)->chr_update_read_handler) {
> +        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT);
> +    }
> +
>  }
>=20=20
>  static int null_chr_write(Chardev *chr, const uint8_t *buf, int len)
