Received: from eggs.gnu.org ([2001:4830:134:3::10]:32970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTXSh-0003Sj-Go
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTXSg-0000sT-A0
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:54:39 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170707161822.29659-1-alex.bennee@linaro.org>
	<87inj49mr1.fsf@linaro.org>
	<CAFEAcA_YvS8OQVTPnvRtWyVuAKO2bccyNALOs1Oq7snTO1WwkA@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a391e7e5-0be9-0863-bfb7-88d9168484f3@twiddle.net>
Date: Fri, 7 Jul 2017 07:54:22 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_YvS8OQVTPnvRtWyVuAKO2bccyNALOs1Oq7snTO1WwkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] target/arm: ensure eret exits the
 run-loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Etienne Carriere <etienne.carriere@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, "Emilio G . Cota" <cota@braap.org>

On 07/07/2017 07:36 AM, Peter Maydell wrote:
> On 7 July 2017 at 18:32, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Given the wording of:
>>
>> /* is_jmp field values */
>> #define DISAS_NEXT    0 /* next instruction can be analyzed */
>> #define DISAS_JUMP    1 /* only pc was modified dynamically */
>> #define DISAS_UPDATE  2 /* cpu state was modified dynamically */
>> #define DISAS_TB_JUMP 3 /* only pc was modified statically */
>>
>> I'm thinking that really these DISAS_JUMP's should be DISAS_UPDATEs and
>> we need to disable the TB chaining optimisations for this. I'll prepare
>> a more comprehensive series next week. However testing this patch for
>> known failure modes will be useful.
> 
> The problem I think is that a lot of our current code assumes
> that DISAS_UPDATE means "go back to the top loop".
> 
> In any case I think you are right that DISAS_UPDATE should not
> allow chaining to the next TB, because it implies that perhaps
> a TB flags bit got changed, so you need to look in the hash
> table again.

Changes to TB flags are not a problem; helper_lookup_tb does examine them, and 
indeed go back to the hash table.  The only thing it doesn't do is re-evaluate 
the interrupt state.

Naming all of these different exit conditions is certainly non-trivial.


r~
