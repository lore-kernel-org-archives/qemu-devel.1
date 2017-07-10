Received: from eggs.gnu.org ([2001:4830:134:3::10]:46223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dURWN-0007DS-Ul
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 01:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dURWJ-0004r1-2D
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 01:46:11 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dURWI-0004qn-SA
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 01:46:06 -0400
Received: by mail-pf0-f195.google.com with SMTP id z6so13041564pfk.3
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 22:46:06 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <201707101115005493498@zte.com.cn>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f0290c7b-ff80-6e4d-1ff4-4cd1121aadef@twiddle.net>
Date: Sun, 9 Jul 2017 19:44:49 -1000
MIME-Version: 1.0
In-Reply-To: <201707101115005493498@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/mips: Bugfix for crash
 whenrunningprogram with qemu-i386.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jiang.biao2@zte.com.cn
Cc: qemu-devel@nongnu.org, james.hogan@imgtec.com, zhong.weidong@zte.com.cn, wang.liang82@zte.com.cn, shi.zhongbing@zte.com.cn, jinguojie@loongson.cn, jiang.yong5@zte.com.cn

On 07/09/2017 05:15 PM, jiang.biao2@zte.com.cn wrote:
> It lies in the following code,
> 
>  >     if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
>  >         tcg_out_ext32u(s, base, addr_regl);
>  >        addr_regl = base; //problem is here.
>  >    }
> 
> this section of code is to extend the addr_regl to 64bit, and use *base* as temp
> intermedia. The real intention could be to extend addr_regl into base, and then
> move base back to addr_regl for later use, but it wrongly assigning  base to
> addr_regl directly, which will cause crash for every use of tcg_out_qemu_st.

The intent is to zero-extend addr_regl into a temporary; base = A0, and at this 
point is known to be unused.  Afterward, whenever we talk about the low part of 
the address, we want to use the temporary and not the original input.

For example, if addr_regl = S0, and guest_base = S1, then we want

	dext	a0, s0, 31, 0
	dadd	a0, s1, a0

instead of

	dext	a0, s0, 31, 0
	mov	s0, a0
	dadd	a0, s1, s0

> My intention is to fix this bug, and intend to use TCG_TMP0 for temporary use
> for addr_regl.

That is also fine; there's nothing magic about using base = A0 for the temporary.


r~
