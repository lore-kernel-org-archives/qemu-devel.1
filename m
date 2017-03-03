Received: from eggs.gnu.org ([2001:4830:134:3::10]:50494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjpf3-0004Yv-KI
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjpf2-00087k-SQ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:02:29 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjpf2-00087K-Im
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:02:28 -0500
Received: by mail-wm0-x230.google.com with SMTP id v186so18789525wmd.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:02:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170303155847.GY9606@toto>
References: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
	<1488556233-31246-5-git-send-email-peter.maydell@linaro.org>
	<20170303155847.GY9606@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 16:02:07 +0000
Message-ID: <CAFEAcA9fm4XmY1LhssvkeAV4eBDC3ooQ7Tep=saRB7XYu10OZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/6] disas/microblaze: Avoid
 unintended sign extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>

On 3 March 2017 at 15:58, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> On Fri, Mar 03, 2017 at 03:50:31PM +0000, Peter Maydell wrote:
>> In read_insn_microblaze() we assemble 4 bytes into an 'unsigned
>> long'.  If 'unsigned long' is 64 bits and the high byte has its top
>> bit set, then C's implicit conversion from 'unsigned char' to 'int'
>> for the shift will result in an unintended sign extension which sets
>> the top 32 bits in 'inst'.  Add casts to prevent this.  (Spotted by
>> Coverity, CID 1005401.)
>
> I'm OK with this but perhaps it would have been more readable to
> change inst to uint32_t ? (All microblaze insns are 32bit).

I thought about that, but it was more invasive a change than
I was happy with: you'd want to change not just 'inst' but
also the return type of read_insn_microblaze, the opcode_mask
field of struct op_code_struct, 'inst' and 'prev_inst' in
print_insn_microblaze, the type of the instr arguments to
get_field, get_field_imm, etc...

thanks
-- PMM
