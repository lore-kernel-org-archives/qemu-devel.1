Received: from eggs.gnu.org ([2001:4830:134:3::10]:46058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIIex-0005N1-Hh
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIIew-0000tu-PC
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:57:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180514173044.5025-1-peter.maydell@linaro.org>
	<20180514173044.5025-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <77995743-27bb-9cb9-5455-a2383d3be7b5@amsat.org>
Date: Mon, 14 May 2018 15:57:09 -0300
MIME-Version: 1.0
In-Reply-To: <20180514173044.5025-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 1/2] gdbstub: Use
 qemu_set_cloexec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, patches@linaro.org

On 05/14/2018 02:30 PM, Peter Maydell wrote:
> Use the utility routine qemu_set_cloexec() rather than
> manually calling fcntl(). This lets us drop the #ifndef _WIN32
> guards and also means Coverity doesn't complain that we're
> ignoring the fcntl error return (CID 1005665, CID 1005667).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  gdbstub.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 3c3807358c..cc7626c790 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1818,9 +1818,7 @@ static void gdb_accept(void)
>              perror("accept");
>              return;
>          } else if (fd >= 0) {
> -#ifndef _WIN32
> -            fcntl(fd, F_SETFD, FD_CLOEXEC);
> -#endif
> +            qemu_set_cloexec(fd);
>              break;
>          }
>      }
> @@ -1847,9 +1845,7 @@ static int gdbserver_open(int port)
>          perror("socket");
>          return -1;
>      }
> -#ifndef _WIN32
> -    fcntl(fd, F_SETFD, FD_CLOEXEC);
> -#endif
> +    qemu_set_cloexec(fd);
>  
>      socket_set_fast_reuse(fd);
>  
> 
