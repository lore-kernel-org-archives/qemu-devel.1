Received: from eggs.gnu.org ([209.51.188.92]:53935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hG2Xq-0008Ga-IA
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hG2Xp-0000DW-A4
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:25:14 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hG2Xo-0000By-Qu
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:25:13 -0400
Received: by mail-oi1-x244.google.com with SMTP id j132so13944343oib.2
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 07:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190415141547.15444-1-berrange@redhat.com>
In-Reply-To: <20190415141547.15444-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Apr 2019 15:25:00 +0100
Message-ID: <CAFEAcA9353Sar3Uny0Qvx0Ex6jP-dzE2w4AjsA4O8gCEF3RdKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vl: set LC_CTYPE early in main() for
 all code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On Mon, 15 Apr 2019 at 15:17, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Localization is not a feature whose impact is limited to the UI
> frontends. Other parts of QEMU rely in localization. In particular the
> USB MTP driver needs to be able to convert filenames from the locale
> specified character set into UTF-16 / UCS-2 encoded wide characters.
> setlocale() is only set from two of the UI frontends though, and worse,
> there is inconsistent behaviour with GTK setting LC_CTYPE to C.UTF-8,
> while ncurses honours whatever is set in the user's environment.
>
> This causes the USP MTP driver to behave differently depending on which
> UI frontend is activated.
>
> Furthermore, the curses settings are dangerous because LC_CTYPE will affe=
ct
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
> Setting of LC_MESSAGES is left in the GTK code since only the GTK
> frontend is using translation of strings. This lets us avoid the
> platform portability problem where LC_MESSAGES is not provided by
> locale.h on MinGW. GTK pulls it in indirectly from libintl.h via
> gi18n.h header, but we don't want to pull that into the global
> QEMU namespace.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

A few typo nits below...

>
> +    /*
> +     * Ideally we would set LC_ALL, but QEMU currently isn't able to cop=
e
> +     * with arbitrary localization settings. In particular there are two
> +     * known problems
> +     *
> +     *   - The QMP monitor needs to use the C locale rules for numeric
> +     *     formatting. This would need a double/int -> string formatter
> +     *     that is locale independant.

"independent"

> +     *
> +     *   - The QMP monitor needs to encode all data as UTF-8. This needs
> +     *     to be updated to use iconv(3) to explicitly convert the curre=
nt
> +     *     locale's charset into utf-8
> +     *
> +     *   - Lots of codes uses is{upper,lower,alnum,...} functions, expec=
ting

"code"

> +     *     C locale sorting behaviour. Most QEMU usage should likely be
> +     *     changed to g_ascii_is{upper,lower,alnum...} to match code
> +     *     assumptions, without being broken by locale settnigs.

"settings"

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
> +     * now we make a tradeoff, trying to set an explicit UTF-8 localee

"locale"

> +     *
> +     * Note we can't set LC_MESSAGES here, since mingw doesn't define
> +     * this constant in locale.h Fortunately we only need it for the
> +     * GTK frontend and that uses gi18n.h which pulls in a definition
> +     * of LC_MESSAGES.
> +     */

thanks
-- PMM
