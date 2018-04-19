Received: from eggs.gnu.org ([2001:4830:134:3::10]:52531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9GDn-00084u-KA
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9GDk-0003OO-Kd
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:31:59 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:45422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9GDk-0003MY-FF
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:31:56 -0400
Received: by mail-qt0-x243.google.com with SMTP id b13-v6so7252564qtp.12
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 13:31:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-16-git-send-email-ian.jackson@eu.citrix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b8d20908-c76c-1dc2-2c14-31c185abbbfc@amsat.org>
Date: Thu, 19 Apr 2018 17:31:50 -0300
MIME-Version: 1.0
In-Reply-To: <1524156319-11465-16-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 15/16] os-posix: cleanup: Replace perror
 with error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

On 04/19/2018 01:45 PM, Ian Jackson wrote:
> perror() is defined to fprintf(stderr,...).  HACKING says
> fprintf(stderr,...) is wrong.  So perror() is too.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Daniel P. Berrange <berrange@redhat.com>
> CC: Michael Tokarev <mjt@tls.msk.ru>
> CC: Alistair Francis <alistair.francis@xilinx.com>
> ---
> v7: New patch
> ---
>  os-posix.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/os-posix.c b/os-posix.c
> index d4cf466..0108028 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -125,7 +125,7 @@ void os_set_proc_name(const char *s)
>      /* Could rewrite argv[0] too, but that's a bit more complicated.
>         This simple way is enough for `top'. */
>      if (prctl(PR_SET_NAME, name)) {
> -        perror("unable to change process name");
> +        error_report("unable to change process name: %s", strerror(errno));
>          exit(1);
>      }
>  #else
> @@ -247,7 +247,7 @@ static void change_root(void)
>              exit(1);
>          }
>          if (chdir("/")) {
> -            perror("not able to chdir to /");
> +            error_report("not able to chdir to /: %s", strerror(errno));
>              exit(1);
>          }
>      }
> @@ -309,7 +309,7 @@ void os_setup_post(void)
>  
>      if (daemonize) {
>          if (chdir("/")) {
> -            perror("not able to chdir to /");
> +            error_report("not able to chdir to /: %s", strerror(errno));
>              exit(1);
>          }
>          TFR(fd = qemu_open("/dev/null", O_RDWR));
> @@ -383,7 +383,7 @@ int os_mlock(void)
>  
>      ret = mlockall(MCL_CURRENT | MCL_FUTURE);
>      if (ret < 0) {
> -        perror("mlockall");
> +        error_report("mlockall: %s", strerror(errno));
>      }
>  
>      return ret;

Thinking loudly, maybe we can refactor as error_report_errno(const char
*desc)...

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
