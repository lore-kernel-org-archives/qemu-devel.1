Received: from eggs.gnu.org ([2001:4830:134:3::10]:35906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP1kB-0000Ul-8S
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP1kA-0003um-Fd
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:51 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gP1kA-0003ue-CC
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:50 -0500
Received: by mail-qk1-f193.google.com with SMTP id m5so1593393qka.9
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 00:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20181115143124.19234-1-pbonzini@redhat.com>
	<20181115143124.19234-2-pbonzini@redhat.com>
In-Reply-To: <20181115143124.19234-2-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Nov 2018 12:50:38 +0400
Message-ID: <CAMxuvaxYyGz6Kq3kk7j9jAFicSQFzE8uyeXNAMQ0AUE1uGbwuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/10] vhost-user-test: use g_cond_broadcast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Bonzini, Paolo" <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>

On Thu, Nov 15, 2018 at 6:31 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> g_cond_signal is rarely the right thing to do, it works now because
> vhost-user-test only has two threads but it is not correct in general.
> Fix it before adding more calls.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/vhost-user-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 45d58d8ea2..656e51938b 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -393,7 +393,7 @@ static void chr_read(void *opaque, const uint8_t *buf=
, int size)
>                                              G_N_ELEMENTS(s->fds));
>
>          /* signal the test that it can continue */
> -        g_cond_signal(&s->data_cond);
> +        g_cond_broadcast(&s->data_cond);
>          break;
>
>      case VHOST_USER_SET_VRING_KICK:
> @@ -419,7 +419,7 @@ static void chr_read(void *opaque, const uint8_t *buf=
, int size)
>          p =3D (uint8_t *) &msg;
>          qemu_chr_fe_write_all(chr, p, VHOST_USER_HDR_SIZE);
>
> -        g_cond_signal(&s->data_cond);
> +        g_cond_broadcast(&s->data_cond);
>          break;
>
>      case VHOST_USER_SET_VRING_BASE:
> --
> 2.19.1
>
>
