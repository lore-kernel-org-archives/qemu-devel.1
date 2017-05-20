Received: from eggs.gnu.org ([2001:4830:134:3::10]:54131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCDup-0007Bq-NN
	for qemu-devel@nongnu.org; Sat, 20 May 2017 19:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dCDuo-0002wg-UG
	for qemu-devel@nongnu.org; Sat, 20 May 2017 19:36:07 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170426105027.10666-1-n54@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b8a1e411-c87e-525f-667a-710b7bcadff9@amsat.org>
Date: Sat, 20 May 2017 20:35:59 -0300
MIME-Version: 1.0
In-Reply-To: <20170426105027.10666-1-n54@gmx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: Detect native NetBSD curses(3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: peter.maydell@linaro.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Hi Kamil,

On 04/26/2017 07:50 AM, Kamil Rytarowski wrote:
> NetBSD ships with traditional BSD curses with compatibility with ncurses.
> qemu works nicely with the basesystem version of curses(3) from NetBSD.
>
> The only mismatch between curses(3) and ncurses is the lack of
> curses_version() in the NetBSD version. This function is used solely in
> the configure script, therefore eliminate it from the curses(3) detection.
>
> With this change applied, configure detects correctly curses frontend.
>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  configure | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/configure b/configure
> index c35acf1192..17dc7224f7 100755
> --- a/configure
> +++ b/configure
> @@ -3034,14 +3034,13 @@ if test "$curses" != "no" ; then
>  #include <curses.h>

This checks if the <curses.h> include in present,

>  #include <wchar.h>
>  int main(void) {
> -  const char *s = curses_version();

This however checks if the library is present, trying to link it.

>    wchar_t wch = L'w';
>    setlocale(LC_ALL, "");
>    resize_term(0, 0);
>    addwstr(L"wide chars\n");
>    addnwstr(&wch, 1);
>    add_wch(WACS_DEGREE);

Those 3 functions also belong to the libcurse, so the link is still 
checked, and this patch looks good to me.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> -  return s != 0;
> +  return 0;
>  }
>  EOF
>    IFS=:
>
