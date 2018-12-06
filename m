Received: from eggs.gnu.org ([2001:4830:134:3::10]:36942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUwJX-0004rY-Nn
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUwJU-0007Ix-DL
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:15:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUwJU-0007Ie-3I
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:15:44 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-10-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <765f17e9-ce4d-1015-f76d-5aa168e567b2@redhat.com>
Date: Thu, 6 Dec 2018 17:15:41 +0100
MIME-Version: 1.0
In-Reply-To: <1543851204-41186-10-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/71] vhost-user-test: support
 VHOST_USER_PROTOCOL_F_CROSS_ENDIAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 2018-12-03 16:32, Paolo Bonzini wrote:
> This will be useful to run the qtest for ppc64 targets on (for example)
> x86_64 hosts.
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/vhost-user-test.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 6a805e6..82fc6c5 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -51,6 +51,7 @@
>  #define VHOST_USER_F_PROTOCOL_FEATURES 30
>  #define VHOST_USER_PROTOCOL_F_MQ 0
>  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD 1
> +#define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
> =20
>  #define VHOST_LOG_PAGE 0x1000
> =20
> @@ -251,7 +252,7 @@ static void wait_for_fds(TestServer *s)
> =20
>  static void read_guest_mem_server(TestServer *s)
>  {
> -    uint32_t *guest_mem;
> +    uint8_t *guest_mem;
>      int i, j;
>      size_t size;
> =20
> @@ -278,8 +279,8 @@ static void read_guest_mem_server(TestServer *s)
>          g_assert(guest_mem !=3D MAP_FAILED);
>          guest_mem +=3D (s->memory.regions[i].mmap_offset / sizeof(*gue=
st_mem));
> =20
> -        for (j =3D 0; j < 256; j++) {
> -            uint32_t a =3D readl(s->memory.regions[i].guest_phys_addr =
+ j*4);
> +        for (j =3D 0; j < 1024; j++) {
> +            uint32_t a =3D readb(s->memory.regions[i].guest_phys_addr =
+ j);

Can't you simply use memread() intead?

 Thomas
