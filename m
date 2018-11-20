Received: from eggs.gnu.org ([2001:4830:134:3::10]:35819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP1k2-0000PX-SG
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gP1k1-0003pp-VZ
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:42 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gP1k1-0003pc-Pl
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:50:41 -0500
Received: by mail-qk1-f194.google.com with SMTP id d19so1619737qkg.5
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 00:50:41 -0800 (PST)
MIME-Version: 1.0
References: <20181115143124.19234-1-pbonzini@redhat.com>
	<20181115143124.19234-6-pbonzini@redhat.com>
In-Reply-To: <20181115143124.19234-6-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Nov 2018 12:50:29 +0400
Message-ID: <CAMxuvaw3gPXJkAC6ac9p6LVPB4TYMuSAQ763FoRiK+VwZ4ZBDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/10] vhost-user-test: support
 VHOST_USER_PROTOCOL_F_CROSS_ENDIAN
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

Hi

On Thu, Nov 15, 2018 at 6:31 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> This will be useful to run the qtest for ppc64 targets on (for example)
> x86_64 hosts.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/vhost-user-test.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 6a805e67be..82fc6c581b 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -51,6 +51,7 @@
>  #define VHOST_USER_F_PROTOCOL_FEATURES 30
>  #define VHOST_USER_PROTOCOL_F_MQ 0
>  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD 1
> +#define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
>
>  #define VHOST_LOG_PAGE 0x1000
>
> @@ -251,7 +252,7 @@ static void wait_for_fds(TestServer *s)
>
>  static void read_guest_mem_server(TestServer *s)
>  {
> -    uint32_t *guest_mem;
> +    uint8_t *guest_mem;
>      int i, j;
>      size_t size;
>
> @@ -278,8 +279,8 @@ static void read_guest_mem_server(TestServer *s)
>          g_assert(guest_mem !=3D MAP_FAILED);
>          guest_mem +=3D (s->memory.regions[i].mmap_offset / sizeof(*guest=
_mem));
>
> -        for (j =3D 0; j < 256; j++) {
> -            uint32_t a =3D readl(s->memory.regions[i].guest_phys_addr + =
j*4);
> +        for (j =3D 0; j < 1024; j++) {
> +            uint32_t a =3D readb(s->memory.regions[i].guest_phys_addr + =
j);
>              uint32_t b =3D guest_mem[j];
>
>              g_assert_cmpint(a, =3D=3D, b);
> @@ -367,6 +368,7 @@ static void chr_read(void *opaque, const uint8_t *buf=
, int size)
>          msg.flags |=3D VHOST_USER_REPLY_MASK;
>          msg.size =3D sizeof(m.payload.u64);
>          msg.payload.u64 =3D 1 << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
> +        msg.payload.u64 |=3D 1 << VHOST_USER_PROTOCOL_F_CROSS_ENDIAN;
>          if (s->queues > 1) {
>              msg.payload.u64 |=3D 1 << VHOST_USER_PROTOCOL_F_MQ;
>          }
> --
> 2.19.1
>
>
