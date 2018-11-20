Received: from eggs.gnu.org ([2001:4830:134:3::10]:35882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP1k9-0000T2-5l
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP1k6-0003s8-0c
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:49 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gP1k5-0003ru-TT
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:45 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so1564323qkf.13
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 00:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20181115143124.19234-1-pbonzini@redhat.com>
	<20181115143124.19234-3-pbonzini@redhat.com>
In-Reply-To: <20181115143124.19234-3-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Nov 2018 12:50:34 +0400
Message-ID: <CAMxuvazUitJ7kVoyt6MJ_W3H+EANfbE8rabpZt7_MGpzL4whAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/10] vhost-user-test: signal data_cond
 when s->rings changes
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
> This speeds up wait_for_rings_started, which currently is just waiting fo=
r
> the timeout before checking s->rings.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/vhost-user-test.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 656e51938b..6a805e67be 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -384,6 +384,7 @@ static void chr_read(void *opaque, const uint8_t *buf=
, int size)
>
>          assert(msg.payload.state.index < s->queues * 2);
>          s->rings &=3D ~(0x1ULL << msg.payload.state.index);
> +        g_cond_broadcast(&s->data_cond);
>          break;
>
>      case VHOST_USER_SET_MEM_TABLE:
> @@ -425,6 +426,7 @@ static void chr_read(void *opaque, const uint8_t *buf=
, int size)
>      case VHOST_USER_SET_VRING_BASE:
>          assert(msg.payload.state.index < s->queues * 2);
>          s->rings |=3D 0x1ULL << msg.payload.state.index;
> +        g_cond_broadcast(&s->data_cond);
>          break;
>
>      case VHOST_USER_GET_QUEUE_NUM:
> --
> 2.19.1
>
>
