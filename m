Received: from eggs.gnu.org ([2001:4830:134:3::10]:34348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnNs1-0004Vb-3x
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 07:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnNs0-0007Bw-Ah
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 07:10:33 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnNs0-0007Ba-49
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 07:10:32 -0400
Received: by mail-wm0-x233.google.com with SMTP id t189so36987261wmt.1
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 04:10:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489084718-15294-3-git-send-email-joserz@linux.vnet.ibm.com>
References: <1489084718-15294-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1489084718-15294-3-git-send-email-joserz@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Mar 2017 12:10:10 +0100
Message-ID: <CAFEAcA8GPTVg-kUXfTJk17KPaPFAHJ-mGOEXPZLxQ0q9CNRckw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH Risu v2 2/3] configure: Add initial support
 to PPC64 (big endian)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 9 March 2017 at 19:38, Jose Ricardo Ziviani
<joserz@linux.vnet.ibm.com> wrote:
> This commit set Makefile to point to ppc64le source for both archs
> (ppc64 and ppc64le) because they do the exact same thing. The
> difference is in risugen and how the binary is build.

If we're going to share a single set of source files for ppc64le
and ppc64 (which makes sense) then I think we should use ARCH=ppc64
for that, and rename the 'ppc64le' source files to 'ppc64'.

The rest of these patches look OK.

> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  configure | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/configure b/configure
> index 055e6d6..dd64d8b 100755
> --- a/configure
> +++ b/configure
> @@ -51,11 +51,7 @@ guess_arch() {
>      elif check_define __aarch64__ ; then
>          ARCH="aarch64"
>      elif check_define __powerpc64__ ; then
> -        if check_define __BIG_ENDIAN__; then
> -            ARCH="ppc64"
> -        else
> -            ARCH="ppc64le"
> -        fi
> +        ARCH="ppc64le"
>      else
>          echo "This cpu is not supported by risu. Try -h. " >&2
>          exit 1
> @@ -127,6 +123,9 @@ OBJDUMP="${OBJDUMP-${CROSS_PREFIX}objdump}"
>
>  if test "x${ARCH}" = "x"; then
>      guess_arch
> +elif test "x${ARCH}" = "xppc64"; then
> +    # ppc64 and ppc64le uses the same C source code
> +    ARCH="ppc64le"
>  fi
>
>  generate_makefilein
> --
> 2.7.4
>

Incidentally, maybe we should just drop support for
specifying ARCH= manually to configure. I can't really
see a use case where the auto-detection won't do the
right thing.

thanks
-- PMM
