Received: from eggs.gnu.org ([2001:4830:134:3::10]:45767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ch1zu-0004ej-9u
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:36:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ch1zr-00060x-5F
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:36:26 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170223032118.GD12577@umbus.fritz.box>
	<8760k1tmnf.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3044e2e4-3911-2031-9a59-dc223fdbf7ea@twiddle.net>
Date: Fri, 24 Feb 2017 09:36:16 +1100
MIME-Version: 1.0
In-Reply-To: <8760k1tmnf.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/10] target/ppc: support for 32-bit
 carry and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 02/23/2017 06:02 PM, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>
>> -static void gen_read_xer(TCGv dst)
>>> +static void gen_read_xer(DisasContext *ctx, TCGv dst)
>>>  {
>>>      TCGv t0 = tcg_temp_new();
>>>      TCGv t1 = tcg_temp_new();
>>> @@ -3715,15 +3719,30 @@ static void gen_read_xer(TCGv dst)
>>>      tcg_gen_or_tl(t0, t0, t1);
>>>      tcg_gen_or_tl(dst, dst, t2);
>>>      tcg_gen_or_tl(dst, dst, t0);
>>> +    if (is_isa300(ctx)) {
>>> +        tcg_gen_shli_tl(t0, cpu_ov32, XER_OV32);
>>> +        tcg_gen_or_tl(dst, dst, t0);
>>> +        tcg_gen_shli_tl(t0, cpu_ca32, XER_CA32);
>>> +        tcg_gen_or_tl(dst, dst, t0);
>>
>> Could you use 2 deposits here, instead of 2 shifts and 2 ors?
>
> I checked the implementation of tcg_gen_deposit_i64, resultant will have much
> more than 2 shifts + 2 ors.

Well, that depends on the host.  For a host that implements deposit, like 
aarch64 or ppc64, it will be one instruction.


r~
