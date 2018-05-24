Received: from eggs.gnu.org ([2001:4830:134:3::10]:46491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLxt8-00081q-Ar
	for qemu-devel@nongnu.org; Thu, 24 May 2018 17:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLxt3-0002Mf-HW
	for qemu-devel@nongnu.org; Thu, 24 May 2018 17:35:10 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fLxt3-0002LQ-CF
	for qemu-devel@nongnu.org; Thu, 24 May 2018 17:35:05 -0400
Received: by mail-pg0-f51.google.com with SMTP id u7-v6so1347277pgp.3
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 14:35:05 -0700 (PDT)
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
	<2f652224f76c115f6c991766b7acac1e22580954.1526796813.git.mjt@msgid.tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d3acfa93-ee93-fce8-36bb-f481637b0140@redhat.com>
Date: Thu, 24 May 2018 23:35:02 +0200
MIME-Version: 1.0
In-Reply-To: <2f652224f76c115f6c991766b7acac1e22580954.1526796813.git.mjt@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 20/22] gdbstub: Handle errors in gdb_accept()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 20/05/2018 08:15, Michael Tokarev wrote:
> From: Peter Maydell <peter.maydell@linaro.org>
> 
> In gdb_accept(), we both fail to check all errors (notably
> that from socket_set_nodelay(), as Coverity notes in CID 1005666),
> and fail to return an error status back to our caller. Correct
> both of these things, so that errors in accept() result in our
> stopping with a useful error message rather than ignoring it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  gdbstub.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index b99980d2e2..e4ece2f5bc 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1814,7 +1814,7 @@ void gdb_signalled(CPUArchState *env, int sig)
>      put_packet(s, buf);
>  }
>  
> -static void gdb_accept(void)
> +static bool gdb_accept(void)
>  {
>      GDBState *s;
>      struct sockaddr_in sockaddr;
> @@ -1826,7 +1826,7 @@ static void gdb_accept(void)
>          fd = accept(gdbserver_fd, (struct sockaddr *)&sockaddr, &len);
>          if (fd < 0 && errno != EINTR) {
>              perror("accept");
> -            return;
> +            return false;
>          } else if (fd >= 0) {
>              qemu_set_cloexec(fd);
>              break;
> @@ -1834,7 +1834,10 @@ static void gdb_accept(void)
>      }
>  
>      /* set short latency */
> -    socket_set_nodelay(fd);
> +    if (socket_set_nodelay(fd)) {
> +        perror("setsockopt");
> +        return false;

Coverity notes that this leaks fd.

Paolo

> +    }
>  
>      s = g_malloc0(sizeof(GDBState));
>      s->c_cpu = first_cpu;
> @@ -1843,6 +1846,7 @@ static void gdb_accept(void)
>      gdb_has_xml = false;
>  
>      gdbserver_state = s;
> +    return true;
>  }
>  
>  static int gdbserver_open(int port)
> @@ -1883,7 +1887,11 @@ int gdbserver_start(int port)
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
