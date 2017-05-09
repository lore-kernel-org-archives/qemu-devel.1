Received: from eggs.gnu.org ([2001:4830:134:3::10]:42900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d85vy-0001Ea-OM
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d85vx-0003NR-Ta
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:16:14 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d85vx-0003NK-P6
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:16:13 -0400
Received: by mail-qk0-x244.google.com with SMTP id u75so278930qka.1
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 07:16:13 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170509082800.10756-1-aurelien@aurel32.net>
	<20170509082800.10756-4-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <566a2bee-0ead-215a-fdf6-77b96e218411@twiddle.net>
Date: Tue, 9 May 2017 07:16:10 -0700
MIME-Version: 1.0
In-Reply-To: <20170509082800.10756-4-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] target/s390x: implement serialization
 in BRANCH CONDITION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 05/09/2017 01:28 AM, Aurelien Jarno wrote:
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>   target/s390x/translate.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index c58c27f8e9..2f07ce2be9 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -1517,6 +1517,21 @@ static ExitStatus op_bc(DisasContext *s, DisasOps *o)
>       int imm = is_imm ? get_field(s->fields, i2) : 0;
>       DisasCompare c;
>   
> +    /* BCR with R2 = 0 causes no branching */
> +    if (have_field(s->fields, r2) && get_field(s->fields, r2) == 0) {
> +        if (m1 == 14) {
> +            /* Perform serialization */
> +            /* FIXME: check for fast-BCR-serialization facility */
> +            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +        }
> +        if (m1 == 15) {
> +            /* Perform serialization */
> +            /* FIXME: perform checkpoint-synchronisation */

I don't know if we'll ever need to do anything with this side effect, but I 
guess it's good to document.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
