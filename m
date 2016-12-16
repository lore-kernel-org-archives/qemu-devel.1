Received: from eggs.gnu.org ([2001:4830:134:3::10]:46938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHtlF-0002BQ-50
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHtlE-00055A-9z
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:45:25 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:35272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHtlE-000550-4k
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:45:24 -0500
Received: by mail-ua0-x236.google.com with SMTP id 12so39935529uas.2
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 06:45:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1480003738-8754-5-git-send-email-Lena.Djokic@rt-rk.com>
References: <1480003738-8754-1-git-send-email-Lena.Djokic@rt-rk.com>
	<1480003738-8754-5-git-send-email-Lena.Djokic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 14:45:02 +0000
Message-ID: <CAFEAcA_D6efAX_Hcy4LeTsVvhA1dMAks14v5zptyw-5wvmFarA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 4/7] linux-user: Fix fcnt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lena Djokic <Lena.Djokic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 24 November 2016 at 16:08, Lena Djokic <Lena.Djokic@rt-rk.com> wrote:

Making the subject line "linux-user: fix F_GETSIG and F_SETSIG fcntls"
would be a bit more precise about what we're fixing here and I think
that will be helpful for people looking back in the git log later.

> F_GETSIG and F_SETSIG were implemented with default behaviour which
> simply passes given arguments to fcntl syscall, but since those
> arguments are signals used for communication between taget and

typo: "target"

> host we need conversion which is done by using host_to_target signal
> and taget_to_host_signal functions.

"target"

>
> Signed-off-by: Lena Djokic <Lena.Djokic@rt-rk.com>
> ---
>  linux-user/syscall.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 41873ca..1b59a71 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6544,14 +6544,18 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
>
>      case TARGET_F_SETOWN:
>      case TARGET_F_GETOWN:
> -    case TARGET_F_SETSIG:
> -    case TARGET_F_GETSIG:
>      case TARGET_F_SETLEASE:
>      case TARGET_F_GETLEASE:
>      case TARGET_F_SETPIPE_SZ:
>      case TARGET_F_GETPIPE_SZ:
>          ret = get_errno(safe_fcntl(fd, host_cmd, arg));
>          break;
> +    case TARGET_F_GETSIG:
> +        ret = host_to_target_signal(get_errno(fcntl(fd, host_cmd, arg)));
> +        break;
> +    case TARGET_F_SETSIG:
> +        ret = get_errno(fcntl(fd, host_cmd, target_to_host_signal(arg)));
> +        break;

This is basically right, but I suggest some minor changes:
 * put these special cases above the long list of 'just call fcntl'
   cases, not below it
 * these should both call safe_fcntl(), not fcntl()
 * don't call host_to_target_signal() unless we know the call
   succeeded (compare the code used for TARGET_F_GETLK, TARGET_F_GETFL, etc)

>
>      default:
>          ret = get_errno(safe_fcntl(fd, cmd, arg));

thanks
-- PMM
