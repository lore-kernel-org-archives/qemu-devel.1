Received: from eggs.gnu.org ([208.118.235.92]:37482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gecSF-0003N1-56
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 04:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gecSA-0007Bm-Bb
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 04:04:47 -0500
References: <20181223111525.581-1-mark.cave-ayland@ilande.co.uk>
	<20181223111525.581-9-mark.cave-ayland@ilande.co.uk>
	<20190102063516.GS27457@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3cdeef04-6317-e690-e17b-398f1155a524@ilande.co.uk>
Date: Wed, 2 Jan 2019 09:04:21 +0000
MIME-Version: 1.0
In-Reply-To: <20190102063516.GS27457@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 8/9] target/ppc: move FP and VMX
 registers into aligned vsr register array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 02/01/2019 06:35, David Gibson wrote:

> On Sun, Dec 23, 2018 at 11:15:24AM +0000, Mark Cave-Ayland wrote:
>> The VSX register array is a block of 64 128-bit registers where the first 32
>> registers consist of the existing 64-bit FP registers extended to 128-bit
>> using new VSR registers, and the last 32 registers are the VMX 128-bit
>> registers as show below:
>>
>>             64-bit               64-bit
>>     +--------------------+--------------------+
>>     |        FP0         |                    |  VSR0
>>     +--------------------+--------------------+
>>     |        FP1         |                    |  VSR1
>>     +--------------------+--------------------+
>>     |        ...         |        ...         |  ...
>>     +--------------------+--------------------+
>>     |        FP30        |                    |  VSR30
>>     +--------------------+--------------------+
>>     |        FP31        |                    |  VSR31
>>     +--------------------+--------------------+
>>     |                  VMX0                   |  VSR32
>>     +-----------------------------------------+
>>     |                  VMX1                   |  VSR33
>>     +-----------------------------------------+
>>     |                  ...                    |  ...
>>     +-----------------------------------------+
>>     |                  VMX30                  |  VSR62
>>     +-----------------------------------------+
>>     |                  VMX31                  |  VSR63
>>     +-----------------------------------------+
>>
>> In order to allow for future conversion of VSX instructions to use TCG vector
>> operations, recreate the same layout using an aligned version of the existing
>> vsr register array.
>>
>> Since the old fpr and avr register arrays are removed, the existing callers
>> must also be updated to use the correct offset in the vsr register array. This
>> also includes switching the relevant VMState fields over to using subarrays
>> to make sure that migration is preserved.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Sorry, I had to pull this out of ppc-for-4.0 again (and I pulled all
> the later patches in the series out for safety as well).  It breaks
> build on a ppc host - looks like you haven't updated the code to push
> pull the VSX state to KVM.

Apologies for that. I've now fixed up and compile tested target/ppc/kvm.c on a PPC
host, and will post an updated v5 shortly.


ATB,

Mark.
