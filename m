Received: from eggs.gnu.org ([209.51.188.92]:53461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hC8Bc-0007Gg-Kk
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 15:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hC7yQ-0004zg-Vu
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 15:24:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hC7yQ-0004yB-Ag
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 15:24:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so4330652wmf.1
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 12:24:29 -0700 (PDT)
References: <20190404185730.GA22512@ls3530.dellerweb.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e0959fcc-df89-1d64-e512-924c25106dc0@redhat.com>
Date: Thu, 4 Apr 2019 21:24:27 +0200
MIME-Version: 1.0
In-Reply-To: <20190404185730.GA22512@ls3530.dellerweb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org

Hi Helge,

On 4/4/19 8:57 PM, Helge Deller wrote:
> If a non-release architecture is found, and it's known that there is no
> native TCG support for that CPU, automatically fall back to the TCI
> implementation instead of requesting the user to run configure again
> with the --enable-tcg-interpreter option.
> 
> This change simplifies building qemu in automatic build environments
> (like in my case the debian buildds) because one does not need to
> special case on the architectures.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/configure b/configure
> index 1c563a7027..8fe4fc84d8 100755
> --- a/configure
> +++ b/configure
> @@ -769,8 +769,10 @@ case "$cpu" in
>      cross_cc_sparc=$host_cc
>    ;;
>    *)
> -    # This will result in either an error or falling back to TCI later
> +    # Fall back to TCI on unsupported CPUs
>      ARCH=unknown
> +    echo "Unsupported '$cpu' CPU found. Will use TCG with TCI (experimental)."
> +    tcg_interpreter="yes"

I'm not comfortable with this change... I'd prefer to keep the explicit
flag. Is your debian buildd targetting mainstream QEMU or the Debian
package? Can't you manage this as a Debian specific patch?

Else, why not add a "hppa" case selecting TCI in the switch? This would
be less invasive.

>    ;;
>  esac
>  if test -z "$ARCH"; then
> @@ -1855,16 +1857,6 @@ if ! compile_prog ; then
>      error_exit "\"$cc\" cannot build an executable (is your linker broken?)"
>  fi
> 
> -# Now we have handled --enable-tcg-interpreter and know we're not just
> -# printing the help message, bail out if the host CPU isn't supported.
> -if test "$ARCH" = "unknown"; then
> -    if test "$tcg_interpreter" = "yes" ; then
> -        echo "Unsupported CPU = $cpu, will use TCG with TCI (experimental)"
> -    else
> -        error_exit "Unsupported CPU = $cpu, try --enable-tcg-interpreter"
> -    fi
> -fi
> -
>  # Consult white-list to determine whether to enable werror
>  # by default.  Only enable by default for git builds
>  if test -z "$werror" ; then
> 
