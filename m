Received: from eggs.gnu.org ([2001:4830:134:3::10]:46390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIIg1-000603-Mc
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIIg0-0002mF-Os
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:58:29 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180514173044.5025-1-peter.maydell@linaro.org>
	<20180514173044.5025-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5745a274-b05f-97c8-340f-0289c5077368@amsat.org>
Date: Mon, 14 May 2018 15:58:18 -0300
MIME-Version: 1.0
In-Reply-To: <20180514173044.5025-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] gdbstub: Handle errors in gdb_accept()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

On 05/14/2018 02:30 PM, Peter Maydell wrote:
> In gdb_accept(), we both fail to check all errors (notably
> that from socket_set_nodelay(), as Coverity notes in CID 1005666),
> and fail to return an error status back to our caller. Correct
> both of these things, so that errors in accept() result in our
> stopping with a useful error message rather than ignoring it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  gdbstub.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index cc7626c790..7c2bceb040 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1804,7 +1804,7 @@ void gdb_signalled(CPUArchState *env, int sig)
>      put_packet(s, buf);
>  }
>  
> -static void gdb_accept(void)
> +static bool gdb_accept(void)
>  {
>      GDBState *s;
>      struct sockaddr_in sockaddr;
> @@ -1816,7 +1816,7 @@ static void gdb_accept(void)
>          fd = accept(gdbserver_fd, (struct sockaddr *)&sockaddr, &len);
>          if (fd < 0 && errno != EINTR) {
>              perror("accept");
> -            return;
> +            return false;
>          } else if (fd >= 0) {
>              qemu_set_cloexec(fd);
>              break;
> @@ -1824,7 +1824,10 @@ static void gdb_accept(void)
>      }
>  
>      /* set short latency */
> -    socket_set_nodelay(fd);
> +    if (socket_set_nodelay(fd)) {
> +        perror("setsockopt");
> +        return false;
> +    }
>  
>      s = g_malloc0(sizeof(GDBState));
>      s->c_cpu = first_cpu;
> @@ -1833,6 +1836,7 @@ static void gdb_accept(void)
>      gdb_has_xml = false;
>  
>      gdbserver_state = s;
> +    return true;
>  }
>  
>  static int gdbserver_open(int port)
> @@ -1873,7 +1877,11 @@ int gdbserver_start(int port)
>      if (gdbserver_fd < 0)
>          return -1;
>      /* accept connections */
> -    gdb_accept();
> +    if (!gdb_accept()) {
> +        close(gdbserver_fd);
> +        gdbserver_fd = -1;
> +        return -1;
> +    }
>      return 0;
>  }
>  
> 
