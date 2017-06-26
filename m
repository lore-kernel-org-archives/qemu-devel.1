Received: from eggs.gnu.org ([2001:4830:134:3::10]:49992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPVQV-00058v-RX
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPVQS-0003ja-Rv
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:55:43 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:32908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPVQS-0003jC-NL
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:55:40 -0400
Received: by mail-qt0-x22f.google.com with SMTP id r30so3297306qtc.0
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 07:55:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170621024831.26019-1-rth@twiddle.net>
	<20170621024831.26019-2-rth@twiddle.net> <878tkeyfjp.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d0e45622-b256-2e5a-2600-768b0b9559cb@twiddle.net>
Date: Mon, 26 Jun 2017 07:55:36 -0700
MIME-Version: 1.0
In-Reply-To: <878tkeyfjp.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/16] tcg: Merge opcode arguments into
 TCGOp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net

On 06/26/2017 07:44 AM, Alex Bennée wrote:
>> -/* The layout here is designed to avoid crossing of a 32-bit boundary.
>> -   If we do so, gcc adds padding, expanding the size to 12.  */
>> +/* The layout here is designed to avoid crossing of a 32-bit
>> boundary.  */
> 
> This isn't correct now? Do we mean we now aim to be cache line aligned?

I still avoid having a bitfield cross a 32-bit boundary.  Perhaps I should not 
have trimmed quite so much from the comment.

>>   /* Make sure operands fit in the bitfields above.  */
>>   QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
>> -QEMU_BUILD_BUG_ON(OPC_BUF_SIZE > (1 << 10));
>> -QEMU_BUILD_BUG_ON(OPPARAM_BUF_SIZE > (1 << 14));
>> -
>> -/* Make sure that we don't overflow 64 bits without noticing.  */
>> -QEMU_BUILD_BUG_ON(sizeof(TCGOp) > 8);
>> +QEMU_BUILD_BUG_ON(OPC_BUF_SIZE > (1 << 16));
> 
> OPC_BUF_SIZE is statically assigned, we don't seem to be taking notice
> of sizeof(TCGOp) anymore here. In fact OPC_BUF_SIZE is really
> MAX_TCG_OPS right?

Yes, I dropped the sizeof(TCGOp) check.  I could perhaps adjust it, but the 
expression would be a bit unwieldy, since it'll vary by host now.

I suppose you could think of OPC_BUF_SIZE as MAX_TCG_OPS, yes.  I suppose that 
might be a decent renaming as well.

> I see TCGArg is currently target_ulong. Is this because we never leak
> the host size details into generated code safe for the statically
> assigned env_ptr?

You mis-read.  TCGArg is tcg_target_ulong, which is a host specific value.

> I mention this because in looking at modelling SIMD registers I'm going
> to need to carry a host ptr around in TCG registers that can be passed
> to helpers and the like.

You'll always be able to do that.


r~
