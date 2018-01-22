Received: from eggs.gnu.org ([2001:4830:134:3::10]:57939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edhYg-0004c6-Hx
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:15:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edhYd-00032u-Ee
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:15:06 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:43103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1edhYd-00032k-7e
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:15:03 -0500
Received: by mail-wm0-x242.google.com with SMTP id g1so18325404wmg.2
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 11:15:03 -0800 (PST)
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-2-richard.henderson@linaro.org>
	<CAFEAcA-TfkUUP8C1u_WiPhQj+seMBER-MkcHXBOai4Yt27pCsw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-TfkUUP8C1u_WiPhQj+seMBER-MkcHXBOai4Yt27pCsw@mail.gmail.com>
Date: Mon, 22 Jan 2018 19:15:00 +0000
Message-ID: <87fu6xk8nf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10.5 01/20] tcg: Allow multiple word
 entries into the constant pool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 17 January 2018 at 16:14, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> This will be required for storing vector constants.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  tcg/tcg-pool.inc.c | 115 +++++++++++++++++++++++++++++++++++++++++++---=
-------
>>  1 file changed, 93 insertions(+), 22 deletions(-)
>>
>> diff --git a/tcg/tcg-pool.inc.c b/tcg/tcg-pool.inc.c
>> index 8a85131405..0f76e7bee3 100644
>> --- a/tcg/tcg-pool.inc.c
>> +++ b/tcg/tcg-pool.inc.c
>> @@ -22,39 +22,110 @@
>>
>>  typedef struct TCGLabelPoolData {
>>      struct TCGLabelPoolData *next;
>> -    tcg_target_ulong data;
>>      tcg_insn_unit *label;
>> -    intptr_t addend;
>> -    int type;
>> +    int addend  : 32;
>> +    int rtype   : 16;
>> +    int nlong   : 16;
>> +    tcg_target_ulong data[];
>>  } TCGLabelPoolData;
>>
>
> Seems a bit odd to use bitfields for 32 and 16 bit values, but whatever.
> (My default reaction to bitfields is "be suspicious" :-))

I'm guessing this is the same reason as the softfloat re-factor. By
manually forcing stuff into a bitfield the compiler does a better job of
passing multiple structure elements in a single register?

It would be nice if the compiler could spot this itself though.

>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
