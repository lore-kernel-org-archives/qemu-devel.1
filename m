Received: from eggs.gnu.org ([2001:4830:134:3::10]:59121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAVzL-0002Zg-Kq
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAVzI-0002jN-Es
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:06:31 -0400
References: <20181003193931.18096-1-richard.henderson@linaro.org>
	<20181003193931.18096-9-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <12df0e47-0105-a200-5ed8-0b0311d1b09f@redhat.com>
Date: Thu, 11 Oct 2018 10:06:24 +0200
MIME-Version: 1.0
In-Reply-To: <20181003193931.18096-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 8/9] target/s390x: Skip
 wout, cout helpers if op helper does not return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org

On 03/10/2018 21:39, Richard Henderson wrote:
> When op raises an exception, it may not have initialized the output
> temps that would be written back by wout or cout.
> 
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/translate.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 7363aabf3a..7fad3ad8e9 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -6164,11 +6164,13 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
>      if (insn->help_op) {
>          ret = insn->help_op(s, &o);
>      }
> -    if (insn->help_wout) {
> -        insn->help_wout(s, &f, &o);
> -    }
> -    if (insn->help_cout) {
> -        insn->help_cout(s, &o);
> +    if (ret != DISAS_NORETURN) {
> +        if (insn->help_wout) {
> +            insn->help_wout(s, &f, &o);
> +        }
> +        if (insn->help_cout) {
> +            insn->help_cout(s, &o);
> +        }
>      }
>  
>      /* Free any temporaries created by the helpers.  */
> 

What about things like LPSW/LPWSE ? They certainly don't imply that we
had an exception.

(these two don't use wout/cout, so it is still fine, but I would prefer
a comment somewhere because otherwise it is really easy to miss that
DISAS_NORETURN makes us skip these handlers)

Apart from that

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
