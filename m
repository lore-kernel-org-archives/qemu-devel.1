Received: from eggs.gnu.org ([2001:4830:134:3::10]:38921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCOsr-0007S7-8b
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCOsn-0003s9-6s
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:51:05 -0500
Date: Wed, 8 Nov 2017 12:50:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171108125056.159597fd.cohuck@redhat.com>
In-Reply-To: <20171107145546.767-1-richard.henderson@linaro.org>
References: <20171107145546.767-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] target/s390x: Finish
 implementing RISBGN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-s390x@nongnu.org

On Tue,  7 Nov 2017 15:55:46 +0100
Richard Henderson <richard.henderson@linaro.org> wrote:

> We added the entry to insn-data.def, but failed to update op_risbg
> to match.  No need to special-case the imask inversion, since that
> is already ~0 for RISBG (and now RISBGN).
> 
> Fixes: 375ee58bedcda359011fe7fa99e0647f66f9ffa0
> Fixes: https://bugs.launchpad.net/qemu/+bug/1701798 (s390x part)
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/translate.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index dee72a787d..85d0a6c3af 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -3432,6 +3432,7 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
>      /* Adjust the arguments for the specific insn.  */
>      switch (s->fields->op2) {
>      case 0x55: /* risbg */
> +    case 0x59: /* risbgn */
>          i3 &= 63;
>          i4 &= 63;
>          pmask = ~0;
> @@ -3447,7 +3448,7 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
>          pmask = 0x00000000ffffffffull;
>          break;
>      default:
> -        abort();
> +        g_assert_not_reached();
>      }
>  
>      /* MASK is the set of bits to be inserted from R2.
> @@ -3464,11 +3465,7 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
>         insns, we need to keep the other half of the register.  */
>      imask = ~mask | ~pmask;
>      if (do_zero) {
> -        if (s->fields->op2 == 0x55) {
> -            imask = 0;
> -        } else {
> -            imask = ~pmask;
> -        }
> +        imask = ~pmask;
>      }
>  
>      len = i4 - i3 + 1;

I can queue this to s390-fixes (unless there are other takers).
