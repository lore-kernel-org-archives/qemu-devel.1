Received: from eggs.gnu.org ([2001:4830:134:3::10]:51781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cjpia-0007Oz-HM
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cjpiW-0000s1-Ix
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:06:08 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1cjpiW-0000rl-Bj
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:06:04 -0500
Received: by mail-lf0-x244.google.com with SMTP id y193so7101088lfd.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:06:04 -0800 (PST)
Date: Fri, 3 Mar 2017 17:06:01 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170303160601.GA9606@toto>
References: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
	<1488556233-31246-5-git-send-email-peter.maydell@linaro.org>
	<20170303155847.GY9606@toto>
	<CAFEAcA9fm4XmY1LhssvkeAV4eBDC3ooQ7Tep=saRB7XYu10OZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9fm4XmY1LhssvkeAV4eBDC3ooQ7Tep=saRB7XYu10OZQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>

On Fri, Mar 03, 2017 at 04:02:07PM +0000, Peter Maydell wrote:
> On 3 March 2017 at 15:58, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> > On Fri, Mar 03, 2017 at 03:50:31PM +0000, Peter Maydell wrote:
> >> In read_insn_microblaze() we assemble 4 bytes into an 'unsigned
> >> long'.  If 'unsigned long' is 64 bits and the high byte has its top
> >> bit set, then C's implicit conversion from 'unsigned char' to 'int'
> >> for the shift will result in an unintended sign extension which sets
> >> the top 32 bits in 'inst'.  Add casts to prevent this.  (Spotted by
> >> Coverity, CID 1005401.)
> >
> > I'm OK with this but perhaps it would have been more readable to
> > change inst to uint32_t ? (All microblaze insns are 32bit).
> 
> I thought about that, but it was more invasive a change than
> I was happy with: you'd want to change not just 'inst' but
> also the return type of read_insn_microblaze, the opcode_mask
> field of struct op_code_struct, 'inst' and 'prev_inst' in
> print_insn_microblaze, the type of the instr arguments to
> get_field, get_field_imm, etc...

Ah, I see, didn't think about that...

Cheers,
Edgar
