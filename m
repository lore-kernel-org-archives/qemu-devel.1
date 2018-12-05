Received: from eggs.gnu.org ([2001:4830:134:3::10]:53439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUSgX-0005Rd-K6
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:37:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUSgS-0004xz-MC
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:37:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUSgS-0004xl-EQ
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:37:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A94789AC5
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 08:37:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181204131802.16885-1-marcandre.lureau@redhat.com>
	<20181204131802.16885-4-marcandre.lureau@redhat.com>
Date: Wed, 05 Dec 2018 09:37:21 +0100
In-Reply-To: <20181204131802.16885-4-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 4 Dec 2018 17:17:59 +0400")
Message-ID: <87d0qg1i9q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/6] char: add a
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The feature should be set if the chardev is able to switch
> GMainContext. Callers that want to put a chardev in a different thread
> context can/should check this capability. Otherwise, print an
> error (arguably, it may assert instead).

Really?  I think you do assert instead.  Hmm, misunderstanding; this
isn't about what the patch does, it's about what callers should do.
Perhaps:

  QEMU_CHAR_FEATURE_GCONTEXT declares the character device can switch
  GMainContext.

  Assert we don't switch context when the character device doesn't
  provide this feature.  Character device users must not violate this
  restriction.  In particular, user configurations that violate them
  must be rejected.

This leads me to my next question: is it currently possible to violate
this restriction and trip the new assertion?

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
> index 152dde5327..123b566cba 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -196,6 +196,8 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
>      s->gcontext =3D context;
>      if (cc->chr_update_read_handler) {
>          cc->chr_update_read_handler(s);
> +    } else if (s->gcontext) {
> +        g_assert_not_reached();
>      }

Hmm.

cc->chr_update_read_handler is true iff QEMU_CHAR_FEATURE_GCONTEXT.
Therefore, the assertion really asserts "context may be non-null only
when we have QEMU_CHAR_FEATURE_GCONTEXT".  Let's make that clearer:

       assert(qemu_chr_has_feature(s, QEMU_CHAR_FEATURE_GCONTEXT)
              || !context);
       s->gcontext =3D context;
       if (cc->chr_update_read_handler) {
           cc->chr_update_read_handler(s);
       }

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
