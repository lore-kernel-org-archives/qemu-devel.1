Received: from eggs.gnu.org ([2001:4830:134:3::10]:54806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cakgF-0004HQ-Pf
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cakgF-0003dg-3I
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:54:11 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cakgE-0003dN-S0
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:54:11 -0500
Received: by mail-wr0-x22a.google.com with SMTP id i10so23552815wrb.0
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 06:54:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170204143132.GP9606@toto>
References: <1486144135-4894-1-git-send-email-peter.maydell@linaro.org>
	<1486144135-4894-3-git-send-email-peter.maydell@linaro.org>
	<20170204143132.GP9606@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Feb 2017 14:53:49 +0000
Message-ID: <CAFEAcA9ybZzMPKMUUyrALGq4ufwBbWPFAtZEctHmA1CKnnpLgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 2/2] target/arm: A32,
 T32: Create Instruction Syndromes for Data Aborts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 4 February 2017 at 14:31, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> On Fri, Feb 03, 2017 at 05:48:55PM +0000, Peter Maydell wrote:
>> Add support for generating the ISS (Instruction Specific Syndrome)
>> for Data Abort exceptions taken from AArch32. These syndromes are
>> used by hypervisors for example to trap and emulate memory accesses.
>>
>> This is the equivalent for AArch32 guests of the work done for AArch64
>> guests in commit aaa1f954d4cab243.

>> +static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
>> +{
>> +    /* We don't need to save all of the syndrome so we mask and shift
>> +     * out uneeded bits to help the sleb128 encoder do a better job.
>> +     */
>> +    syn &= ARM_INSN_START_WORD2_MASK;
>> +    syn >>= ARM_INSN_START_WORD2_SHIFT;
>> +
>> +    /* We check and clear insn_start_idx to catch multiple updates.  */
>> +    assert(s->insn_start_idx != 0);
>> +    tcg_set_insn_param(s->insn_start_idx, 2, syn);
>> +    s->insn_start_idx = 0;
>> +}
>
> Could we move this into translate.h and share it with translate-a64.c?

Sure; I'll just squash that change into this patch and put the
results into the target-arm queue, rather than burdening the
list with a v3 respin, if that's OK.

thanks
-- PMM
