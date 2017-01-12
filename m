Received: from eggs.gnu.org ([2001:4830:134:3::10]:58369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRdZw-0003Qh-Ql
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:30:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRdZs-00009G-Sm
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:30:00 -0500
References: <20161215110459.27985-1-ncopa@alpinelinux.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <ef305d55-5579-661b-e895-f91bd800dc55@msgid.tls.msk.ru>
Date: Thu, 12 Jan 2017 14:29:54 +0300
MIME-Version: 1.0
In-Reply-To: <20161215110459.27985-1-ncopa@alpinelinux.org>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix build with musl on aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Natanael Copa <ncopa@alpinelinux.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

15.12.2016 14:04, Natanael Copa wrote:
> Use the standard uint64_t instead of internal __u64.
> 
> This fixes compiler error with musl libc on aarch64:
> .../qemu-2.7.0/linux-user/host/aarch64/hostdep.h:28:5:
> error: unknown type name '__u64'
>      __u64 *pcreg = &uc->uc_mcontext.pc;
>      ^~~~~
> 
> Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
> ---
>  linux-user/host/aarch64/hostdep.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/host/aarch64/hostdep.h b/linux-user/host/aarch64/hostdep.h
> index 64f75cef49..6fd6e36b2a 100644
> --- a/linux-user/host/aarch64/hostdep.h
> +++ b/linux-user/host/aarch64/hostdep.h
> @@ -25,7 +25,7 @@ extern char safe_syscall_end[];
>  static inline void rewind_if_in_safe_syscall(void *puc)
>  {
>      struct ucontext *uc = puc;
> -    __u64 *pcreg = &uc->uc_mcontext.pc;
> +    uint64_t *pcreg = &uc->uc_mcontext.pc;

Is this type available in all places where this header is
being included (apparently these are linux-user/qemu.h and
linux-user/safe-syscall.S, with the latter not being
interesting. But in linux-user/qemu.h, this is the first
file which is included..

Why do we have a mix of __u64 and uint64_t ? :)

Hmm.

/mjt

>      if (*pcreg > (uintptr_t)safe_syscall_start
>          && *pcreg < (uintptr_t)safe_syscall_end) {
> 
