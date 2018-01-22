Received: from eggs.gnu.org ([2001:4830:134:3::10]:44045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edgww-000054-Hr
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:36:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edgws-00050G-FR
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:36:06 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:37550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1edgws-0004zr-9I
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:36:02 -0500
Received: by mail-wr0-x244.google.com with SMTP id f11so9763582wre.4
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 10:36:02 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-10-richard.henderson@linaro.org>
	<87vafuje0q.fsf@linaro.org>
	<502ebfa1-7fd9-b953-2681-f73304b1b4ce@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <502ebfa1-7fd9-b953-2681-f73304b1b4ce@linaro.org>
Date: Mon, 22 Jan 2018 18:35:59 +0000
Message-ID: <87inbtkagg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/16] target/arm: Add predicate
 registers for SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 01/22/2018 04:04 AM, Alex Benn=C3=A9e wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  target/arm/cpu.h | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>> index 57d805b5d8..132da359b5 100644
>>> --- a/target/arm/cpu.h
>>> +++ b/target/arm/cpu.h
>>> @@ -186,6 +186,15 @@ typedef struct ARMVectorReg {
>>>      uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
>>>  } ARMVectorReg;
>>>
>>> +/* In AArch32 mode, predicate registers do not exist at all.  */
>>> +typedef struct ARMPredicateReg {
>>> +#ifdef TARGET_AARCH64
>>> +    uint64_t p[2 * ARM_MAX_VQ / 8] QEMU_ALIGNED(16);
>>> +#else
>>> +    uint64_t p[0];
>>> +#endif
>>> +} ARMPredicateReg;
>>> +
>>>
>>>  typedef struct CPUARMState {
>>>      /* Regs for current mode.  */
>>> @@ -513,6 +522,9 @@ typedef struct CPUARMState {
>>>      struct {
>>>          ARMVectorReg zregs[32];
>>>
>>> +        /* Store FFR as pregs[16] to make it easier to treat as any ot=
her.  */
>>> +        ARMPredicateReg pregs[17];
>>> +
>>
>> What happens if code tries to accidentally access this on the 32 bit bui=
ld?
>
> *shrug* About what you'd expect.  What do you suggest?  Ifdeffery?

I think so. I'd prefer a straight compile failure to some subtle
run-time corruption. That is of course assuming the #ifdef magic doesn't
make the aarch32 support for aarch64-softmmu harder. I wouldn't say it
is a hill I want to die on ;-)

--
Alex Benn=C3=A9e
