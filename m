Received: from eggs.gnu.org ([2001:4830:134:3::10]:55351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fB5L1-00043y-Mp
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fB5L0-0005NK-AN
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:18:59 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:40893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fB5L0-0005Mw-2Z
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:18:58 -0400
Received: by mail-lf0-x243.google.com with SMTP id j16-v6so5180317lfb.7
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 14:18:57 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <1524592709-6553-16-git-send-email-ian.jackson@eu.citrix.com>
References: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524592709-6553-16-git-send-email-ian.jackson@eu.citrix.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 24 Apr 2018 14:18:25 -0700
Message-ID: <CAKmqyKOur_B1T-Bh613yukBWbPZ3VbZkNPy-MOCNw=4-BWiJGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 15/16] os-posix: cleanup:
 Replace perror with error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, "Daniel P. Berrange" <berrange@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

On Tue, Apr 24, 2018 at 10:58 AM, Ian Jackson <ian.jackson@eu.citrix.com> w=
rote:
> perror() is defined to fprintf(stderr,...).  HACKING says
> fprintf(stderr,...) is wrong.  So perror() is too.
>
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Daniel P. Berrange <berrange@redhat.com>
> CC: Michael Tokarev <mjt@tls.msk.ru>
> CC: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v7: New patch
> ---
>  os-posix.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/os-posix.c b/os-posix.c
> index a2ba50d..24eb700 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -125,7 +125,7 @@ void os_set_proc_name(const char *s)
>      /* Could rewrite argv[0] too, but that's a bit more complicated.
>         This simple way is enough for `top'. */
>      if (prctl(PR_SET_NAME, name)) {
> -        perror("unable to change process name");
> +        error_report("unable to change process name: %s", strerror(errno=
));
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
>          TFR(fd =3D qemu_open("/dev/null", O_RDWR));
> @@ -383,7 +383,7 @@ int os_mlock(void)
>
>      ret =3D mlockall(MCL_CURRENT | MCL_FUTURE);
>      if (ret < 0) {
> -        perror("mlockall");
> +        error_report("mlockall: %s", strerror(errno));
>      }
>
>      return ret;
> --
> 2.1.4
>
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
