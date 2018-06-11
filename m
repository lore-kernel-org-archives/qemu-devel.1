Received: from eggs.gnu.org ([2001:4830:134:3::10]:34510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSQzJ-0001To-V4
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSQzJ-0003g5-1w
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:52:18 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:33041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSQzI-0003fp-Sm
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:52:16 -0400
Received: by mail-ot0-x243.google.com with SMTP id h6-v6so24830051otj.0
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 10:52:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7e8f8e98-3023-12af-900c-2ad1d97492be@amsat.org>
References: <20180611171007.4165-1-peter.maydell@linaro.org>
	<20180611171007.4165-2-peter.maydell@linaro.org>
	<7e8f8e98-3023-12af-900c-2ad1d97492be@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 18:51:55 +0100
Message-ID: <CAFEAcA941Q72Rz2g-7yKa01e7=xTcnovt9dX3GbMAwmWOm+r0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] bswap: Add new stn_*_p() and ldn_*_p()
 memory access functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 11 June 2018 at 18:43, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Hi Peter,
>
> On 06/11/2018 02:10 PM, Peter Maydell wrote:
>> +/* Store v to p as a sz byte value in host order */
>> +#define DO_STN_LDN_P(END) \
>> +    static inline void stn_## END ## _p(void *ptr, int sz, uint64_t v) =
 \
>> +    {                                                                  =
 \
>> +        switch (sz) {                                                  =
 \
>> +        case 1:                                                        =
 \
>> +            stb_p(ptr, v);                                             =
 \
>> +            break;                                                     =
 \
>> +        case 2:                                                        =
 \
>> +            stw_ ## END ## _p(ptr, v);                                 =
 \
>> +            break;                                                     =
 \
>> +        case 4:                                                        =
 \
>> +            stl_ ## END ## _p(ptr, v);                                 =
 \
>> +            break;                                                     =
 \
>> +        case 8:                                                        =
 \
>> +            stq_ ## END ## _p(ptr, v);                                 =
 \
>> +            break;                                                     =
 \
>> +        default:                                                       =
 \
>> +            g_assert_not_reached();                                    =
 \
>
> As with the recent discussion with Markus about whether using abort() or
> g_assert_not_reached(), I'd prefer to keep abort() here (which is what
> exec.c currently uses).
>
> [http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg01869.html]

I couldn't find anything obvious about the merits of abort() vs
g_assert_not_reached() in that email. g_assert_not_reached() is clear
about what it's doing and we use it in hundreds of places in the
codebase, whereas abort() is used for various things, including
situations where flow-of-execution clearly can get to that location.
So I prefer g_assert_not_reached().

thanks
-- PMM
