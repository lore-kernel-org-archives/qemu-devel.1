Received: from eggs.gnu.org ([2001:4830:134:3::10]:51746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUeqU-0003l7-NV
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUeqT-0008Id-TM
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:59:50 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170710192128.9048-1-alex.bennee@linaro.org>
	<20170710192128.9048-6-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9d34052b-57db-9a71-b8a9-e1bbe1a9fae1@twiddle.net>
Date: Mon, 10 Jul 2017 09:58:31 -1000
MIME-Version: 1.0
In-Reply-To: <20170710192128.9048-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] target/arm: use DISAS_EXIT for eret
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org
Cc: qemu-devel@nongnu.org, Etienne Carriere <etienne.carriere@linaro.org>, Joakim Bech <joakim.bech@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 07/10/2017 09:21 AM, Alex Bennée wrote:
> Previously DISAS_JUMP did ensure this but with the optimisation of
> 8a6b28c7 (optimize indirect branches) we might not leave the loop.
> This means if any pending interrupts are cleared by changing IRQ flags
> we might never get around to servicing them. You usually notice this
> by seeing the lookup_tb_ptr() helper gainfully chaining TBs together
> while cpu->interrupt_request remains high and the exit_request has not
> been set.
> 
> This breaks amongst other things the OPTEE test suite which executes
> an eret from the secure world after a non-secure world IRQ has gone
> pending which then never gets serviced.
> 
> Instead of using the previously implied semantics of DISAS_JUMP we use
> DISAS_EXIT which will always exit the run-loop.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> CC: Etienne Carriere<etienne.carriere@linaro.org>
> CC: Joakim Bech<joakim.bech@linaro.org>
> CC: Peter Maydell<peter.maydell@linaro.org>
> CC: Emilio G. Cota<cota@braap.org>
> CC: Richard Henderson<rth@twiddle.net>
> ---
>   target/arm/translate-a64.c | 3 ++-
>   target/arm/translate.c     | 6 ++++--
>   2 files changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>

As an aside, I presume we don't have support for armv7ve?  I was expecting 
there to be an eret insn in the aa32 translator and had to dig up previous 
manuals to see when that insn was introduced.


r~
