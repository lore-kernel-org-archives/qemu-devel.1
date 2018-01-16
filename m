Received: from eggs.gnu.org ([2001:4830:134:3::10]:60545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebXVZ-0008Ie-Ds
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebXVW-00084E-8B
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:06:57 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:40321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebXVW-000843-1p
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:06:54 -0500
Received: by mail-pl0-x242.google.com with SMTP id g18so1390189plo.7
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 12:06:53 -0800 (PST)
References: <20180113004338.16867-1-laurent@vivier.eu>
	<20180113004338.16867-6-laurent@vivier.eu>
	<ca9dca07-3551-3e7b-cd1c-f1b41e1e3fc4@linaro.org>
	<8051fca4-c074-89c5-6f07-2d7e1520e625@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <627e6120-eb14-2f05-62d4-cdc66388757c@linaro.org>
Date: Tue, 16 Jan 2018 12:06:48 -0800
MIME-Version: 1.0
In-Reply-To: <8051fca4-c074-89c5-6f07-2d7e1520e625@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 5/7] target/m68k: add moves
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/16/2018 09:48 AM, Laurent Vivier wrote:
> Le 15/01/2018 à 19:37, Richard Henderson a écrit :
>> On 01/12/2018 04:43 PM, Laurent Vivier wrote:
> ...
>>> -    dc->user = (env->sr & SR_S) == 0;
>>> +#if defined(CONFIG_SOFTMMU)
>>> +    dc->user = (env->sr & SR_S) == 0 ? M68K_USER_FROM_MSR : 0;
>>> +    dc->user |= (env->sfc & 4) == 0 ? M68K_USER_FROM_SFC : 0;
>>> +    dc->user |= (env->dfc & 4) == 0 ? M68K_USER_FROM_DFC : 0;
>>> +#endif
>>
>> Really you should be extracting these from tb->flags.
> 
> Do I need to keep the dc->user variable?

Not necessarily.  Depends on whether it's more convenient to access.

>> You also need to end the TB when assigning to SFC and DFC.  Otherwise the
>> generated code is not in sync with the register contents.
> 
> I checked that and SFC and DFC are assigned by movec, and movec ends
> with gen_lookup_tb() that set s->is_jmp to DISAS_UPDATE, and this forces
> an exit from the loop and tcg_gen_exit_tb() (like move_to_sr()).

Ok, thanks.  I should have double-checked that myself.


r~
