Received: from eggs.gnu.org ([2001:4830:134:3::10]:48890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cstTW-00082D-Ju
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cstTV-0001HO-KM
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:56:02 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cstTV-0001H6-B9
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:56:01 -0400
Received: by mail-wm0-x22b.google.com with SMTP id u132so43431429wmg.0
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 08:56:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3d738f84-7708-0578-0e83-5434f43aa928@amsat.org>
References: <1490630670-15818-1-git-send-email-peter.maydell@linaro.org>
	<1490630670-15818-2-git-send-email-peter.maydell@linaro.org>
	<3d738f84-7708-0578-0e83-5434f43aa928@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 16:55:39 +0100
Message-ID: <CAFEAcA-TJOhAuggEdjp0DezGc+H5nq4ftOsrMmq5XLrVMabdQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/2] tcg/sparc: Zero extend data
 argument to store helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 28 March 2017 at 16:52, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> On 03/27/2017 01:04 PM, Peter Maydell wrote:

> it seems to me easier to read masking op:
>
>     switch (op & MO_SIZE) {
>     case MO_8:
>         tcg_out_arithi(s, r, r, 0xff, ARITH_AND);
>         break;
>     case MO_16:
>         tcg_out_arithi(s, r, r, 16, SHIFT_SLL);
>         tcg_out_arithi(s, r, r, 16, SHIFT_SRL);
>         break;
>     case MO_32:
>         if (SPARC64) {
>             tcg_out_arith(s, r, r, 0, SHIFT_SRL);
>         }
>         break;
>     case MO_64:
>         break;
>     }

Yes, agreed.

>> +}
>> +
>>  static void build_trampolines(TCGContext *s)
>>  {
>>      static void * const qemu_ld_helpers[16] =3D {
>> @@ -910,6 +935,7 @@ static void build_trampolines(TCGContext *s)
>>          qemu_st_trampoline[i] =3D s->code_ptr;
>>
>>          if (SPARC64) {
>> +            emit_extend(s, TCG_REG_O2, i);
>
>
> shouldn't be inverting args?

>                emit_extend(s, i, TCG_REG_O2);

emit_extend() takes the TCG reg first and the 'op' second,
so this call is correct...

>>              ra =3D TCG_REG_O4;
>>          } else {
>>              ra =3D TCG_REG_O1;
>> @@ -925,6 +951,7 @@ static void build_trampolines(TCGContext *s)
>>                  tcg_out_arithi(s, ra, ra + 1, 32, SHIFT_SRLX);
>>                  ra +=3D 2;
>>              } else {
>> +                emit_extend(s, i, ra);

...but this one isn't; I don't have 32-bit sparc host to test
with so I missed the error.

>>                  ra +=3D 1;
>>              }
>>              /* Skip the oi argument.  */

thanks
-- PMM
