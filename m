Received: from eggs.gnu.org ([2001:4830:134:3::10]:35421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHQdq-0007ND-5b
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHQdm-0003WN-UK
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:44:22 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eHQdm-0003Vz-Lu
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:44:18 -0500
Received: by mail-wm0-x232.google.com with SMTP id r68so8497724wmr.1
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 00:44:18 -0800 (PST)
References: <20171109144155.17076-1-batuzovk@ispras.ru>
	<20171109144155.17076-3-batuzovk@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1236eb3c-7612-4b96-3925-a0375e0c9888@linaro.org>
Date: Wed, 22 Nov 2017 09:44:14 +0100
MIME-Version: 1.0
In-Reply-To: <20171109144155.17076-3-batuzovk@ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 2/3] tcg/optimize: do copy propagation
 for memory locations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 11/09/2017 03:41 PM, Kirill Batuzov wrote:
> +typedef struct TCGMemLocation {
> +    /* Offset is relative to ENV. Only fields of CPUState are accounted.  */
> +    tcg_target_ulong offset;
> +    tcg_target_ulong size;
> +    TCGType type;
> +    /* Pointer to a temp containing a valid copy of this memory location.  */
> +    TCGTemp *copy;
> +    /* Pointer to the next memory location containing copy of the same
> +       content.  */
> +    struct TCGMemLocation *next_copy;

Did you ever find copies of memories that weren't also copies within temps?
I.e. you could have found this through copy->next_copy?

> +    /* Double-linked list of all memory locations.  */
> +    struct TCGMemLocation *next;
> +    struct TCGMemLocation **prev_ptr;

Use QTAILQ_* for common double-linked-list manipulation.

> +struct TCGMemLocation *mem_locations;
> +struct TCGMemLocation *free_mls;

These can't be globals anymore -- we're do multi-threaded code generation now.

> @@ -77,12 +125,27 @@ static void reset_ts(TCGTemp *ts)
>      struct tcg_temp_info *pi = ts_info(ti->prev_copy);
>      struct tcg_temp_info *ni = ts_info(ti->next_copy);
>  
> +    if (ti->mem_loc && ts_is_copy(ts) && 0) {
> +        TCGMemLocation *ml, *nml;
> +        for (ml = ti->mem_loc; ml; ml = nml) {
> +            nml = ml->next_copy;
> +            ml->copy = ti->next_copy;
> +            ml->next_copy = ni->mem_loc;
> +            ni->mem_loc = ml;
> +        }
> +    } else {
> +        while (ti->mem_loc) {
> +            reset_ml(ti->mem_loc);
> +        }

Why would a single temp be associated with more than one memory?

> +static TCGOpcode ld_to_mov(TCGOpcode op)
> +{
> +#define LD_TO_EXT(sz, w)                                 \
> +    case glue(glue(INDEX_op_ld, sz), glue(_i, w)):       \
> +        return glue(glue(INDEX_op_ext, sz), glue(_i, w))
> +
> +    switch (op) {
> +    LD_TO_EXT(8s, 32);
> +    LD_TO_EXT(8u, 32);
> +    LD_TO_EXT(16s, 32);
> +    LD_TO_EXT(16u, 32);
> +    LD_TO_EXT(8s, 64);
> +    LD_TO_EXT(8u, 64);
> +    LD_TO_EXT(16s, 64);
> +    LD_TO_EXT(16u, 64);
> +    LD_TO_EXT(32s, 64);
> +    LD_TO_EXT(32u, 64);

How many extensions did you find?  Or is this Just In Case?

Otherwise this looks quite reasonable.


r~
