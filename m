Received: from eggs.gnu.org ([2001:4830:134:3::10]:34958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dgFtB-00051y-M6
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 15:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dgFt7-0004k8-QS
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 15:46:33 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:38305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dgFt7-0004jK-Ll
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 15:46:29 -0400
Received: by mail-pg0-x22a.google.com with SMTP id l64so19076000pge.5
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 12:46:29 -0700 (PDT)
References: <cover.1502474835.git.alistair.francis@xilinx.com>
	<2fbcf76e4ff63d8527edd3662342948276e2cd37.1502474835.git.alistair.francis@xilinx.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <de3609ba-241a-6df8-b5c3-30eb4535735e@linaro.org>
Date: Fri, 11 Aug 2017 12:46:24 -0700
MIME-Version: 1.0
In-Reply-To: <2fbcf76e4ff63d8527edd3662342948276e2cd37.1502474835.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 3/3] target/arm: Correct exclusive store
 return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: edgar.iglesias@xilinx.com, alistair23@gmail.com, qemu-arm@nongnu.org, edgar.iglesias@gmail.com

On 08/11/2017 11:19 AM, Alistair Francis wrote:
> The exclusive store operation should return 0 if the operation updates
> memory and 1 if it doesn't. This means that storing tmp in the rd
> register is incorrect.

I'm confused as to what you believe is wrong.

>              tcg_gen_atomic_cmpxchg_i64(tmp, addr, val, tmp,
>                                         get_mem_index(s),
> -                                       size | MO_ALIGN | s->be_data);
> -            tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, val);

Yes, we load the result of the cmpxchg into tmp, but then we immediately
overwrite tmp with 0/1 depending on whether the operation succeeded.

> 
> This patch updates the succesful opertion to store 0 into the rd
> register instead of tmp. It also adds a branch to fail if the memory
> isn't updated.

Since we use setcond, a branch is not required.

> +            tcg_gen_ext_i64(val, val, memop);

What is this addition intended to accomplish?  Because of the position within
the code, you know that memop contains MO_64, so that this is a no-op.


r~
