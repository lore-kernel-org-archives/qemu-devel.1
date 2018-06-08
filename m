Received: from eggs.gnu.org ([2001:4830:134:3::10]:45925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRLM8-0007do-6e
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRLM3-0005lg-AV
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:39:20 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:60201)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fRLM3-0005l5-3U
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:39:15 -0400
Received: from player796.ha.ovh.net (unknown [10.109.105.93])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id A3CD813C2DB
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 19:39:11 +0200 (CEST)
Date: Fri, 8 Jun 2018 19:39:05 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180608193905.0841f4d5@bahia.lan>
In-Reply-To: <20180531171606.21604-14-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
	<20180531171606.21604-1-pbonzini@redhat.com>
	<20180531171606.21604-14-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 52/53] char: Remove unwanted crlf conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Patryk Olszewski <patryk@fala.ehost.pl>, Markus Armbruster <armbru@redhat.com>

On Thu, 31 May 2018 19:16:05 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> From: Patryk Olszewski <patryk@fala.ehost.pl>
> 
> This patch fixes a bug in serial that made it almost impossible for guest
> to communicate with devices through host's serial.
> 
> OPOST flag in c_oflag enables output processing letting other flags in
> c_oflag take effect. Usually in c_oflag ONLCR flag is also set, which
> causes crlf to be sent in place of lf. This breaks binary transmissions.
> Unsetting OPOST flag turns off any output processing which fixes the bug.
> 

But it damages error reporting...

Without this patch:

$ qemu-system-ppc64 -serial stdio -kernel foo
foo: No such file or directory
qemu-system-ppc64: error loading foo: Failed to load ELF
$

With this patch:

$ .mbuild-ppc-for-3.0/obj/ppc64-softmmu/qemu-system-ppc64 -serial stdio -kernel foo
foo: No such file or directory
                              qemu-system-ppc64: error loading foo: Failed to load ELF
                                                                                      $

It is possible to patch vreport() to append an explicit CR:

     error_vprintf(fmt, ap);
-    error_printf("\n");
+    error_printf("\n\r");
 }

but it only fixes the trailing newline of error_report(). Any other newline,
eg when using error_append_hint(), will lack the CR... Not sure how to fix
this :-\

> Bug reports related:
> https://bugs.launchpad.net/qemu/+bug/1772086
> https://bugs.launchpad.net/qemu/+bug/1407813
> https://bugs.launchpad.net/qemu/+bug/1715296
> also
> https://lists.nongnu.org/archive/html/qemu-devel/2006-06/msg00196.html
> 
> Signed-off-by: Patryk Olszewski <patryk@fala.ehost.pl>
> Message-Id: <1527105041-21013-1-git-send-email-patryk@fala.ehost.pl>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  chardev/char-serial.c | 2 +-
>  chardev/char-stdio.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> index feb52e559d..ae548d28da 100644
> --- a/chardev/char-serial.c
> +++ b/chardev/char-serial.c
> @@ -139,7 +139,7 @@ static void tty_serial_init(int fd, int speed,
>  
>      tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
>                       | INLCR | IGNCR | ICRNL | IXON);
> -    tty.c_oflag |= OPOST;
> +    tty.c_oflag &= ~OPOST;
>      tty.c_lflag &= ~(ECHO | ECHONL | ICANON | IEXTEN | ISIG);
>      tty.c_cflag &= ~(CSIZE | PARENB | PARODD | CRTSCTS | CSTOPB);
>      switch (data_bits) {
> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
> index 96375f2ab8..d83e60e787 100644
> --- a/chardev/char-stdio.c
> +++ b/chardev/char-stdio.c
> @@ -59,7 +59,7 @@ static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo)
>      if (!echo) {
>          tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
>                           | INLCR | IGNCR | ICRNL | IXON);
> -        tty.c_oflag |= OPOST;
> +        tty.c_oflag &= ~OPOST;
>          tty.c_lflag &= ~(ECHO | ECHONL | ICANON | IEXTEN);
>          tty.c_cflag &= ~(CSIZE | PARENB);
>          tty.c_cflag |= CS8;
