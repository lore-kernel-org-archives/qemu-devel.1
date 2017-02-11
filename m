Received: from eggs.gnu.org ([2001:4830:134:3::10]:51663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccP6J-0000k8-Aa
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 23:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccP6G-0000uw-7J
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 23:15:55 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccP6G-0000ul-3N
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 23:15:52 -0500
Received: by mail-qk0-x241.google.com with SMTP id e1so7553162qkh.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 20:15:52 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1486249715-5513-1-git-send-email-peter.maydell@linaro.org>
	<1486249715-5513-4-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9d25c855-3604-ae54-aab9-832d722f1882@amsat.org>
Date: Sat, 11 Feb 2017 01:15:47 -0300
MIME-Version: 1.0
In-Reply-To: <1486249715-5513-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] slirp: tcp_listen(): Don't try to
 close() an fd we never opened
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, patches@linaro.org

On 02/04/2017 08:08 PM, Peter Maydell wrote:
> Coverity points out (CID 1005725) that an error-exit path in tcp_listen()
> will try to close(s) even if the reason it got there was that the
> qemu_socket() failed and s was never opened.  Not only that, this isn't even
> the right function to use, because we need closesocket() to do the right
> thing on Windows.  Change to using the right function and only calling it if
> needed.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  slirp/socket.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/slirp/socket.c b/slirp/socket.c
> index 6c18971..8692772 100644
> --- a/slirp/socket.c
> +++ b/slirp/socket.c
> @@ -713,7 +713,9 @@ tcp_listen(Slirp *slirp, uint32_t haddr, u_int hport, uint32_t laddr,
>  	    (listen(s,1) < 0)) {
>  		int tmperrno = errno; /* Don't clobber the real reason we failed */
>
> -		close(s);
> +                if (s >= 0) {
> +                    closesocket(s);
> +                }
>  		sofree(so);
>  		/* Restore the real errno */
>  #ifdef _WIN32
>
