Received: from eggs.gnu.org ([2001:4830:134:3::10]:44317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOWne-0007x5-Ju
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOWnb-0004lL-Ec
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:16:06 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:40547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOWnb-0004ki-97
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:16:03 -0400
Received: by mail-qt0-x242.google.com with SMTP id h2-v6so29984014qtp.7
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 16:16:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b5e492dc-da36-dbb4-5cc4-32d2d78050cd@amsat.org>
Date: Thu, 31 May 2018 20:15:58 -0300
MIME-Version: 1.0
In-Reply-To: <20180531224911.23725-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] gdbstub: Return the fd from
 gdbserver_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, evgreen@chromium.org

Hi Richard,

On 05/31/2018 07:49 PM, Richard Henderson wrote:
> This will allow us to protect gdbserver_fd from the guest.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  gdbstub.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 6081e719c5..057d0d65c5 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1890,15 +1890,16 @@ static int gdbserver_open(int port)
>  int gdbserver_start(int port)
>  {
>      gdbserver_fd = gdbserver_open(port);
> -    if (gdbserver_fd < 0)
> +    if (gdbserver_fd < 0) {
>          return -1;
> +    }
>      /* accept connections */
>      if (!gdb_accept()) {
>          close(gdbserver_fd);
>          gdbserver_fd = -1;
>          return -1;
>      }
> -    return 0;
> +    return gdbserver_fd;

I agree with your change, but what about !CONFIG_USER_ONLY?

It should be safe enough documenting the different behaviors in
include/exec/gdbstub.h.

>  }
>  
>  /* Disable gdb stub for child processes.  */
> 
