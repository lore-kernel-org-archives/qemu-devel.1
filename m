Received: from eggs.gnu.org ([2001:4830:134:3::10]:49980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTuz3-0004cd-6a
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTuz0-00066q-36
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:29:21 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cTuyz-00066I-Tj
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 13:29:18 -0500
Received: by mail-pg0-x241.google.com with SMTP id 204so1983231pge.2
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 10:29:17 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
	<1484644078-21312-2-git-send-email-batuzovk@ispras.ru>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4d351b53-8724-b245-0077-942de1bebd66@twiddle.net>
Date: Wed, 18 Jan 2017 10:29:14 -0800
MIME-Version: 1.0
In-Reply-To: <1484644078-21312-2-git-send-email-batuzovk@ispras.ru>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/18] tcg: add support for 128bit vector
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 01/17/2017 01:07 AM, Kirill Batuzov wrote:
> +static inline TCGv_v128 tcg_global_mem_new_v128(TCGv_ptr reg, intptr_t offset,
> +                                                const char *name)
> +{
> +    int idx = tcg_global_mem_new_internal(TCG_TYPE_V128, reg, offset, name);
> +    return MAKE_TCGV_V128(idx);
> +}

You shouldn't allow a v128 type to be created if the host doesn't support it.

You may want to treat v128 as a pair of v64 if the host supports that. 
Although there's limited applicability there, since only minor hosts (MIPS, 
Sparc, ia64) have 64-bit-only vector extensions.

That said, treating v128 as 2 x v64 scales nicely when we add v256.  Which, if 
we've already gone this far, is clearly how avx2 guest support should be 
implemented.

For hosts that have had no vector support added, you may want to represent v128 
as 2 x i64, for the purpose of intermediate expansion.


r~
