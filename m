Received: from eggs.gnu.org ([2001:4830:134:3::10]:53176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dI9mi-0001Ay-RZ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dI9mi-0006uq-2r
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:24:16 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:33328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dI9mh-0006uk-T6
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:24:16 -0400
Received: by mail-pf0-x22e.google.com with SMTP id 83so37620517pfr.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 01:24:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1496702979-26132-1-git-send-email-cota@braap.org>
	<1496702979-26132-4-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <015d442b-a44e-0ebc-470c-e3289b109ca6@twiddle.net>
Date: Tue, 6 Jun 2017 01:24:11 -0700
MIME-Version: 1.0
In-Reply-To: <1496702979-26132-4-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tcg: allocate TB structs before the
 corresponding translated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>

On 06/05/2017 03:49 PM, Emilio G. Cota wrote:
> +TranslationBlock *tcg_tb_alloc(TCGContext *s)
> +{
> +    void *aligned;
> +
> +    aligned = (void *)ROUND_UP((uintptr_t)s->code_gen_ptr, QEMU_CACHELINE_SIZE);
> +    if (unlikely(aligned + sizeof(TranslationBlock) > s->code_gen_highwater)) {
> +        return NULL;
> +    }
> +    s->code_gen_ptr += aligned - s->code_gen_ptr + sizeof(TranslationBlock);
> +    return aligned;

We don't really need the 2/3 patch.  We don't gain anything by telling the 
compiler that the structure is more aligned than it needs to be.

We can query the line size at runtime, as suggested by Pranith, and use that 
for the alignment here.  Which means that the binary isn't tied to a particular 
cpu implementation, which is clearly preferable for distributions.


r~
