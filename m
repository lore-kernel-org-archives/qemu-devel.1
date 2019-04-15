Received: from eggs.gnu.org ([209.51.188.92]:51797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG03n-0000vV-Fx
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG03l-0008S6-PK
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:46:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hG03k-0008IE-RO
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:46:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id r186so6018147wmf.1
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 04:45:41 -0700 (PDT)
References: <20190415113431.12060-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7d253776-5410-aded-fb58-aa53d6f55d5d@redhat.com>
Date: Mon, 15 Apr 2019 13:45:35 +0200
MIME-Version: 1.0
In-Reply-To: <20190415113431.12060-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vl: set LC_MESSAGES and LC_CTYPE in main
 for all code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On 4/15/19 1:34 PM, Daniel P. Berrangé wrote:
> Localization is not a feature whose impact is limited to the UI
> frontends. Other parts of QEMU rely in localization. In particular the
> USB MTP driver needs to be able to convert filenames from the locale
> specified character set into UTF-16 / UCS-2 encoded wide characters.
> setlocale() is only set from two of the UI frontends though, and worse,
> there is inconsistent behaviour with GTK setting LC_CTYPE to C.UTF-8,
> while ncurses honours whatever is set in the user's environment.
> 
> This causes the USP MTP driver to behave differently depending on why
> UI frontend is activated.
> 
> Furthermore, the curses settings are dangerous because LC_CTYPE will affect
> the is{upper,lower,alnum} functions which much QEMU code assumes to have
> C locale sorting behaviour. This also breaks QMP if the env requests a
> non-UTF-8 locale, since QMP is defined to use UTF-8 encoding for JSON.
> This problematic curses code was introduced in:
> 
>   commit 2f8b7cd587558944532f587abb5203ce54badba9
>   Author: Samuel Thibault <samuel.thibault@ens-lyon.org>
>   Date:   Mon Mar 11 14:51:27 2019 +0100
> 
>     curses: add option to specify VGA font encoding
> 
> This patch moves the GTK frontend setlocale() handling into the main()
> method. This ensures QMP and other QEMU code has a predictable C.UTF-8.
> 
> Eventually QEMU should set LC_ALL, honouring the full user environment,
> but this needs various cleanups in QEMU code first. Hardcoding LC_CTYPE
> to C.UTF-8 is a partial regression vs the above curses commit, since it
> will break the curses wide character handling for non-UTF-8 locales but
> this is unavoidable until QEMU is cleaned up to cope with non-UTF-8
> locales fully.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  ui/curses.c |  2 --
>  ui/gtk.c    | 29 ++++++-----------------------
>  vl.c        | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 25 deletions(-)
> 
> diff --git a/ui/curses.c b/ui/curses.c
> index cc6d6da684..403cd57913 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -27,7 +27,6 @@
>  #include <sys/ioctl.h>
>  #include <termios.h>
>  #endif
> -#include <locale.h>
>  #include <wchar.h>
>  #include <langinfo.h>
>  #include <iconv.h>
> @@ -716,7 +715,6 @@ static void curses_display_init(DisplayState *ds, DisplayOptions *opts)
>      }
>  #endif
>  
> -    setlocale(LC_CTYPE, "");
>      if (opts->u.curses.charset) {
>          font_charset = opts->u.curses.charset;
>      }
> diff --git a/ui/gtk.c b/ui/gtk.c
> index e96e15435a..e490a88d3f 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -40,7 +40,6 @@
>  #include "ui/gtk.h"
>  
>  #include <glib/gi18n.h>
> -#include <locale.h>
>  #if defined(CONFIG_VTE)
>  #include <vte/vte.h>
>  #endif
> @@ -2208,12 +2207,6 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
>  
>      s->free_scale = FALSE;
>  
> -    /* Mostly LC_MESSAGES only. See early_gtk_display_init() for details. For
> -     * LC_CTYPE, we need to make sure that non-ASCII characters are considered
> -     * printable, but without changing any of the character classes to make
> -     * sure that we don't accidentally break implicit assumptions.  */
> -    setlocale(LC_MESSAGES, "");
> -    setlocale(LC_CTYPE, "C.UTF-8");
>      bindtextdomain("qemu", CONFIG_QEMU_LOCALEDIR);
>      textdomain("qemu");
>  
> @@ -2262,22 +2255,12 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
>  
>  static void early_gtk_display_init(DisplayOptions *opts)
>  {
> -    /* The QEMU code relies on the assumption that it's always run in
> -     * the C locale. Therefore it is not prepared to deal with
> -     * operations that produce different results depending on the
> -     * locale, such as printf's formatting of decimal numbers, and
> -     * possibly others.
> -     *
> -     * Since GTK+ calls setlocale() by default -importing the locale
> -     * settings from the environment- we must prevent it from doing so
> -     * using gtk_disable_setlocale().
> -     *
> -     * QEMU's GTK+ UI, however, _does_ have translations for some of
> -     * the menu items. As a trade-off between a functionally correct
> -     * QEMU and a fully internationalized UI we support importing
> -     * LC_MESSAGES from the environment (see the setlocale() call
> -     * earlier in this file). This allows us to display translated
> -     * messages leaving everything else untouched.
> +    /*
> +     * GTK calls setlocale() by default, importing the locale
> +     * settings from the environment. QEMU's main() method will
> +     * have set LC_MESSAGES and LC_CTYPE to allow GTK to display
> +     * translated messages, including use of wide characters. We
> +     * must not allow GTK to change other aspects of the locale.
>       */
>      gtk_disable_setlocale();
>      gtkinit = gtk_init_check(NULL, NULL);
> diff --git a/vl.c b/vl.c
> index c696ad2a13..e37e1c9d55 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -49,6 +49,7 @@ int main(int argc, char **argv)
>  #define main qemu_main
>  #endif /* CONFIG_COCOA */
>  
> +#include <locale.h>
>  
>  #include "qemu/error-report.h"
>  #include "qemu/sockets.h"
> @@ -3022,6 +3023,41 @@ int main(int argc, char **argv, char **envp)
>      char *dir, **dirs;
>      BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
>  
> +    /*
> +     * Ideally we would set LC_ALL, but QEMU currently isn't able to cope
> +     * with arbitrary localization settings. In particular there are two
> +     * known problems
> +     *
> +     *   - The QMP monitor needs to use the C locale rules for numeric
> +     *     formatting. This would need a double/int -> string formatter
> +     *     that is locale independant.
> +     *
> +     *   - The QMP monitor needs to encode all data as UTF-8. This needs
> +     *     to be updated to use iconv(3) to explicitly convert the current
> +     *     locale's charset into utf-8
> +     *
> +     *   - Lots of codes uses is{upper,lower,alnum,...} functions, expecting
> +     *     C locale sorting behaviour. Most QEMU usage should likely be
> +     *     changed to g_ascii_is{upper,lower,alnum...} to match code
> +     *     assumptions, without being broken by locale settnigs.
> +     *
> +     * We do still have two requirements
> +     *
> +     *   - Ability to correct display translated text according to the
> +     *     user's locale
> +     *
> +     *   - Ability to handle multibyte characters, ideally according to
> +     *     user's locale specified character set. This affects ability
> +     *     of usb-mtp to correctly convert filenames to UCS16 and curses
> +     *     & GTK frontends wide character display.
> +     *
> +     * The second requirement would need LC_CTYPE to be honoured, but
> +     * this conflicts with the 2nd & 3rd problems listed earlier. For
> +     * now we make a tradeoff, trying to set an explicit UTF-8 locale
> +     */
> +    setlocale(LC_MESSAGES, "");
> +    setlocale(LC_CTYPE, "C.UTF-8");

Looks saner.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
>      module_call_init(MODULE_INIT_TRACE);
>  
>      qemu_init_cpu_list();
> 
