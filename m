Received: from eggs.gnu.org ([2001:4830:134:3::10]:53576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPtl9-00084h-QB
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPtBX-000754-5x
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:17:54 -0400
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:36594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPtBX-00074u-11
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:17:51 -0400
Received: by mail-qk0-x22e.google.com with SMTP id p21so29376101qke.3
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 09:17:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170621024831.26019-1-rth@twiddle.net>
	<20170621024831.26019-7-rth@twiddle.net> <87y3sdx1rr.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5554273c-7858-9048-5c2c-4677884baff5@twiddle.net>
Date: Tue, 27 Jun 2017 09:17:46 -0700
MIME-Version: 1.0
In-Reply-To: <87y3sdx1rr.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/16] tcg: Add temp_global bit to TCGTemp
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

On 06/27/2017 01:39 AM, Alex Bennée wrote:
>> +    /* If true, the temp is saved across both basic blocks and
>> +       translation blocks.  */
>> +    unsigned int temp_global:1;
>> +    /* If true, the temp is saved across basic blocks but dead
>> +       at the end of translation blocks.  If false, the temp is
>> +       dead at the end of basic blocks.  */
>> +    unsigned int temp_local:1;
>> +    unsigned int temp_allocated:1;
> 
> This is where my knowledge of the TCG internals gets slightly confused.
> As far as I'm aware all our TranslationBlocks are Basic Blocks - they
> don't have any branches until the end of the block. What is the
> distinction here?
> 
> Is a temp_global truly global? I thought the guest state was fully
> rectified by the time we leave the basic block.

TranslationBlocks are not basic blocks.  They normally stop at branches in the 
target instruction stream, but they certainly may have many branches in the tcg 
opcode stream (brcond and the like).  Consider, for instance, our 
implementation of arm32's conditional instructions.

Beyond that, I agree the language is confusing.

A temp_global is created by tcg_global_mem_new_*, generally represents a cpu 
register, and is synced back to a slot in ENV.

A temp_local is created by tcg_temp_local_new_*, and is synced to a slot in the 
local stack frame.

Something without either is simply declared dead at the end of a basic block, 
and is a source of confusion to those writing new front-ends.

Anyway, we already have all of these concepts.  The change is that before the 
patch the only way to tell a temp_global is to compare the index against 
tcg_ctx.nb_global.


r~
