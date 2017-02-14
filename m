Received: from eggs.gnu.org ([2001:4830:134:3::10]:51176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdajc-0006Ry-3X
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:53:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdajb-0001S3-3x
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:53:24 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cdaja-0001Re-Sa
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:53:23 -0500
Received: by mail-wr0-x22e.google.com with SMTP id k90so166832549wrc.3
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 02:53:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-9-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-9-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Feb 2017 10:53:01 +0000
Message-ID: <CAFEAcA_utp4m28Lk20vZ4u1UT7zPdkgywxJp2GS8WNFsNh_AOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 08/24] util/cutils: Clean up control flow
 around qemu_strtol() a bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 February 2017 at 10:25, Markus Armbruster <armbru@redhat.com> wrote:
> Reorder check_strtox_error() to make it obvious that we always store
> through a non-null @endptr.
>
> Transform
>
>     if (some error) {
>         error case ...
>         err = value for error case;
>     } else {
>         normal case ...
>         err = value for normal case;
>     }
>     return err;
>
> to
>
>     if (some error) {
>         error case ...
>         return value for error case;
>     }
>     normal case ...
>     return value for normal case;
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/cutils.c | 89 ++++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 45 insertions(+), 44 deletions(-)
>
> diff --git a/util/cutils.c b/util/cutils.c
> index 7d165bc..7442d46 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -265,15 +265,20 @@ int64_t qemu_strtosz(const char *nptr, char **end)
>  static int check_strtox_error(const char *nptr, char *ep,
>                                const char **endptr, int eno)
>  {
> -    if (eno == 0 && ep == nptr) {
> -        eno = EINVAL;
> -    }
> -    if (!endptr && *ep) {
> -        return -EINVAL;
> -    }
>      if (endptr) {
>          *endptr = ep;
>      }
> +
> +    /* Turn "no conversion" into an error */
> +    if (eno == 0 && ep == nptr) {
> +        return -EINVAL;
> +    }
> +
> +    /* Fail when we're expected to consume the string, but didn't */
> +    if (!endptr && *ep) {
> +        return -EINVAL;
> +    }
> +
>      return -eno;
>  }

Doesn't this change the semantics? Previously, for the
case of (eno == 0 && ep == nptr) we would both set
*endptr to ep and return -EINVAL. Now we only return -EINVAL
and leave *endptr alone. The comment describing the
qemu_strtol() API is a bit vague about what exactly we keep
from the strtol() semantics for "no convertable characters"
but I would assume that retaining "*endptr is written with
the original value of nptr" is intentional.

thanks
-- PMM
