Received: from eggs.gnu.org ([2001:4830:134:3::10]:46813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exhky-0001u0-FO
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 19:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exhku-0007Mh-0z
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 19:30:28 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exhkt-0007MQ-PQ
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 19:30:23 -0400
Received: by mail-wr0-x243.google.com with SMTP id o8so16848645wra.1
	for <qemu-devel@nongnu.org>; Sun, 18 Mar 2018 16:30:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1521217393-8162-1-git-send-email-frederic.konrad@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1b9b4a96-c415-f96d-132a-82883d14d66c@amsat.org>
Date: Mon, 19 Mar 2018 00:30:21 +0100
MIME-Version: 1.0
In-Reply-To: <1521217393-8162-1-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] gdbstub: send a terminaison packet instead
 of crashing gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com

On 03/16/2018 05:23 PM, KONRAD Frederic wrote:
> Since the commit:
> commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268
> Author: Stefan Hajnoczi <stefanha@redhat.com>
> Date:   Wed Mar 7 14:42:05 2018 +0000
> 
>     vl: introduce vm_shutdown()
> 
> GDB crash when qemu exits (at least on sparc-softmmu):
> Remote communication error.  Target disconnected.: Connection reset by peer.
> Quitting: putpkt: write failed: Broken pipe.
> 
> So send a packet to kill GDB before we exit QEMU:
> [Inferior 1 (Thread 0) exited normally]
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  gdbstub.c              | 7 +++++++
>  include/exec/gdbstub.h | 2 ++
>  vl.c                   | 2 ++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index f1d5148..a76b2fa 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2052,6 +2052,13 @@ int gdbserver_start(const char *device)
>      return 0;
>  }
>  
> +void gdbserver_cleanup(void)
> +{
> +    if (gdbserver_state) {
> +        put_packet(gdbserver_state, "W00");
> +    }
> +}
> +
>  static void register_types(void)
>  {
>      type_register_static(&char_gdb_type_info);
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 9aa7756..2e8a4b8 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -103,6 +103,8 @@ int gdbserver_start(int);
>  int gdbserver_start(const char *port);
>  #endif
>  
> +void gdbserver_cleanup(void);
> +
>  /**
>   * gdb_has_xml:
>   * This is an ugly hack to cope with both new and old gdb.
> diff --git a/vl.c b/vl.c
> index 3ef04ce..0427b15 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4723,6 +4723,8 @@ int main(int argc, char **argv, char **envp)
>  
>      main_loop();
>  
> +    gdbserver_cleanup();
> +
>      /* No more vcpu or device emulation activity beyond this point */
>      vm_shutdown();
>  
> 
