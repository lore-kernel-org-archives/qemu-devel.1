Received: from eggs.gnu.org ([2001:4830:134:3::10]:55275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fM3Xk-00071M-2P
	for qemu-devel@nongnu.org; Thu, 24 May 2018 23:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fM3Xg-0005QR-5Y
	for qemu-devel@nongnu.org; Thu, 24 May 2018 23:37:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53028 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fM3Xg-0005Oo-1V
	for qemu-devel@nongnu.org; Thu, 24 May 2018 23:37:24 -0400
References: <20180524223458.5651-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7163a9ba-3640-68e8-4b4e-ff57189de65e@redhat.com>
Date: Fri, 25 May 2018 05:37:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180524223458.5651-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] gdbstub: Prevent fd leakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

On 25.05.2018 00:34, Philippe Mathieu-Daud=C3=A9 wrote:
> Since 2f652224f7, we now check if socket_set_nodelay() errored,
> but forgot to close the socket before reporting an error.
>=20
> Fixes: Coverity CID 1391290 (RESOURCE_LEAK)
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  gdbstub.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index e4ece2f5bc..9c860cd81c 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1836,6 +1836,7 @@ static bool gdb_accept(void)
>      /* set short latency */
>      if (socket_set_nodelay(fd)) {
>          perror("setsockopt");
> +        close(fd);
>          return false;
>      }

Reviewed-by: Thomas Huth <thuth@redhat.com>
