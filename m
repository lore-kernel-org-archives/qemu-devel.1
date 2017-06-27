Received: from eggs.gnu.org ([2001:4830:134:3::10]:52542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dPutq-000701-OU
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dPutp-0000fp-N6
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:07:42 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:32955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dPutp-0000eU-Eo
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:07:41 -0400
Received: by mail-lf0-x241.google.com with SMTP id t72so3395448lff.0
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 11:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <1498584769-12439-1-git-send-email-peter.maydell@linaro.org>
	<1498584769-12439-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1498584769-12439-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 27 Jun 2017 18:07:25 +0000
Message-ID: <CAJ+F1CJt0S3HCwLQoK7YC+oFiiHxuy2pL9YKC+SziEopG1wJiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/2] tests/test-char.c: Don't use
 main_loop_wait()'s return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, patches@linaro.org

On Tue, Jun 27, 2017 at 7:57 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> In QEMU's main_loop() we used to check whether we should do
> a nonblocking call to main_loop(); this was deleted in commit e330c118f2a=
5,
> because now that vCPUs always drop the I/O thread lock it is an unnecessa=
ry
> optimization.
>
> The loop in test-char.c copied the old QEMU main_loop() code, but
> here the nonblocking check has never been necessary because this
> standalone test case doesn't hold the I/O lock anyway. Remove it,
> so we can drop the main_loop_wait() return value.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  tests/test-char.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/tests/test-char.c b/tests/test-char.c
> index 9e361c8..94ef708 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -20,13 +20,9 @@ typedef struct FeHandler {
>
>  static void main_loop(void)
>  {
> -    bool nonblocking;
> -    int last_io =3D 0;
> -
>      quit =3D false;
>      do {
> -        nonblocking =3D last_io > 0;
> -        last_io =3D main_loop_wait(nonblocking);
> +        main_loop_wait(false);
>      } while (!quit);
>  }
>
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
