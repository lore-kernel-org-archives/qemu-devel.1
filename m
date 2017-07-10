Received: from eggs.gnu.org ([2001:4830:134:3::10]:53541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUacu-0002z9-QM
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUact-0007tL-Tw
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:29:32 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865776960.17063.4875279139522061160.stgit@frigg.lan>
	<2bfdb883-f19b-7fcf-c28b-7ce39115937e@twiddle.net>
	<87podcebyi.fsf@frigg.lan>
	<3745ae02-3fb0-1503-9c99-98dce369f697@twiddle.net>
	<87lgo0cgij.fsf@frigg.lan>
	<260addd5-45fe-ad10-5208-35906fd3f197@twiddle.net>
	<87k23gl7yd.fsf@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a464e904-4080-319b-62e2-e3090ac9af9d@twiddle.net>
Date: Mon, 10 Jul 2017 05:28:16 -1000
MIME-Version: 1.0
In-Reply-To: <87k23gl7yd.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 23/29] target/arm: [tcg] Port to
 translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/10/2017 03:47 AM, Lluís Vilanova wrote:
> Richard Henderson writes:
> 
>> On 07/07/2017 07:18 AM, Lluís Vilanova wrote:
>>> There was no code being generated after this specific case, but I haven't
>>> checked if DISAS_EXC is set in any other place that is not immediately followed
>>> by a "goto done_generating".
> 
>> Typically we haven't actually done a goto, but simply exit the loop and emit
>> nothing within the final cleanup (tb_stop?).
> 
> The case handled by DISAS_SKIP ignores tb_stop() (the target code can simply
> return when DISAS_EXC is found instead of DISAS_SKIP) *and* gen_io_end(); this
> last one is never omitted when DISAS_EXC is found now, and theoretically
> DISAS_EXC can be set by any target-specific hook. Thus my question if the
> generic call to gen_io_end() should check for DISAS_EXC too (I have no idea if
> it would be an error to call it with DISAS_EXC set, or whether it makes sense to
> for a target to set it so that gen_io_start() is called but gen_io_end() is then
> skipped by a DISAS_EXC set in ops->translate_insn()).

It is not an error to call gen_io_start when gen_io_end isn't called (or isn't 
reached).  There are many ways that can happen.

The reason that arm does the goto after the gen_exception for single-stepping 
was simply convenience.  Nothing would have gone wrong if it had used

	dc->is_jmp = DISAS_EXC;
	break;

instead.


r~
