Received: from eggs.gnu.org ([209.51.188.92]:38362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1grmac-0000zl-Sg
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1grmab-0007mO-Us
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:31:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1grmab-0007iv-Ok
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:31:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id r2so470987wrv.10
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 08:31:39 -0800 (PST)
References: <20181126105125.30973-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7c5bc3fe-116e-f29c-977d-cac890bdfa93@redhat.com>
Date: Thu, 7 Feb 2019 17:31:37 +0100
MIME-Version: 1.0
In-Reply-To: <20181126105125.30973-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] doc: fix the configuration path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

On 11/26/18 11:51 AM, Marc-André Lureau wrote:
> Use a CONFDIR variable to show the configured sysconf path in the
> generated documentations (html, man pages etc).
> 
> Related to:
> https://bugzilla.redhat.com/show_bug.cgi?id=1644985
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  Makefile     | 9 ++++++---
>  qemu-ga.texi | 4 ++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 9cc4dae1a6..a39c231d1c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -932,11 +932,14 @@ ui/shader.o: $(SRC_PATH)/ui/shader.c \
>  MAKEINFO=makeinfo
>  MAKEINFOINCLUDES= -I docs -I $(<D) -I $(@D)
>  MAKEINFOFLAGS=--no-split --number-sections $(MAKEINFOINCLUDES)
> -TEXI2PODFLAGS=$(MAKEINFOINCLUDES) "-DVERSION=$(VERSION)"
> +TEXI2PODFLAGS=$(MAKEINFOINCLUDES) -DVERSION="$(VERSION)" -DCONFDIR="$(qemu_confdir)"
>  TEXI2PDFFLAGS=$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
>  
> -docs/version.texi: $(SRC_PATH)/VERSION
> -	$(call quiet-command,echo "@set VERSION $(VERSION)" > $@,"GEN","$@")
> +docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
> +	$(call quiet-command,(\
> +		echo "@set VERSION $(VERSION)" && \
> +		echo "@set CONFDIR $(qemu_confdir)" \
> +	)> $@,"GEN","$@")
>  
>  %.html: %.texi docs/version.texi
>  	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
> diff --git a/qemu-ga.texi b/qemu-ga.texi
> index 4c7a8fd163..f00ad830f2 100644
> --- a/qemu-ga.texi
> +++ b/qemu-ga.texi
> @@ -30,7 +30,7 @@ set user's password
>  @end itemize
>  
>  qemu-ga will read a system configuration file on startup (located at
> -@file{/etc/qemu/qemu-ga.conf} by default), then parse remaining
> +@file{@value{CONFDIR}/qemu-ga.conf} by default), then parse remaining
>  configuration options on the command line. For the same key, the last
>  option wins, but the lists accumulate (see below for configuration
>  file format).
> @@ -58,7 +58,7 @@ file format).
>    Enable fsfreeze hook. Accepts an optional argument that specifies
>    script to run on freeze/thaw. Script will be called with
>    'freeze'/'thaw' arguments accordingly (default is
> -  @samp{/etc/qemu/fsfreeze-hook}). If using -F with an argument, do
> +  @samp{@value{CONFDIR}/fsfreeze-hook}). If using -F with an argument, do
>    not follow -F with a space (for example:
>    @samp{-F/var/run/fsfreezehook.sh}).
>  
> 
