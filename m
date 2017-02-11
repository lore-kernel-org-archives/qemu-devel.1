Received: from eggs.gnu.org ([2001:4830:134:3::10]:51567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccP5u-0000X2-HZ
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 23:15:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccP5r-0000rT-CN
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 23:15:30 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccP5r-0000rP-6l
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 23:15:27 -0500
Received: by mail-qk0-x241.google.com with SMTP id i34so7526387qkh.3
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 20:15:27 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1486249715-5513-1-git-send-email-peter.maydell@linaro.org>
	<1486249715-5513-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cac53afa-c1b1-e219-628f-76239ca22fff@amsat.org>
Date: Sat, 11 Feb 2017 01:15:21 -0300
MIME-Version: 1.0
In-Reply-To: <1486249715-5513-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] slirp: Check qemu_socket() return
 value in udp_listen()
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
> Check the return value from qemu_socket() rather than trying to
> pass it to bind() as an fd argument even if it's negative.
> This wouldn't have caused any negative consequences, because
> it won't be a valid fd number and the bind call will fail;
> but Coverity complains (CID 1005723).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  slirp/udp.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/slirp/udp.c b/slirp/udp.c
> index 93d7224..227d779 100644
> --- a/slirp/udp.c
> +++ b/slirp/udp.c
> @@ -335,6 +335,10 @@ udp_listen(Slirp *slirp, uint32_t haddr, u_int hport, uint32_t laddr,
>  	    return NULL;
>  	}
>  	so->s = qemu_socket(AF_INET,SOCK_DGRAM,0);
> +        if (so->s < 0) {
> +            sofree(so);
> +            return NULL;
> +        }
>  	so->so_expire = curtime + SO_EXPIRE;
>  	insque(so, &slirp->udb);
>
>
