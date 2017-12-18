Received: from eggs.gnu.org ([2001:4830:134:3::10]:38027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3Nh-0005uy-To
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3Ng-0007WX-Li
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:55:29 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR3Ng-0007Vh-Cp
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:55:28 -0500
Received: by mail-pg0-x244.google.com with SMTP id g7so9708499pgs.0
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:55:28 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-6-alex.bennee@linaro.org>
	<8b36b09f-eb89-46bf-561b-2536cc93c489@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4c8e62d1-50bd-e429-153d-3b6d8733bb88@linaro.org>
Date: Mon, 18 Dec 2017 13:50:52 -0800
MIME-Version: 1.0
In-Reply-To: <8b36b09f-eb89-46bf-561b-2536cc93c489@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 05/19] include/fpu/softfloat: add some
 float16 contants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 12/15/2017 05:37 AM, Philippe Mathieu-Daudé wrote:
> Hi Alex,
> 
> On 12/11/2017 09:56 AM, Alex Bennée wrote:
>> This defines the same set of common constants for float 16 as defined
>> for 32 and 64 bit floats. These are often used by target helper
>> functions.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  include/fpu/softfloat.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
>> index 17dfe60dbd..5a9258c57c 100644
>> --- a/include/fpu/softfloat.h
>> +++ b/include/fpu/softfloat.h
>> @@ -395,6 +395,13 @@ static inline float16 float16_set_sign(float16 a, int sign)
>>      return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
>>  }
>>  
>> +#define float16_zero make_float16(0)
> 
> ok
> 
>> +#define float16_one make_float16(0x3a00)
> 
> I'm a bit confused...
> 
>>>> [np.fromstring(struct.pack("<H", x), dtype=np.float16)[0] for x in
> [0, 0x3a00, 0x34d1, 0x4448, 0x3800, 0x7a00]]
> [0.0, 0.75, 0.30103, 4.2812, 0.5, 49152.0]
> 
> However:
> 
>>>> ['0x' + binascii.hexlify(np.array([x], '>f2').tostring()) for x in
> [0, 1, math.log(2), np.pi, 0.5, np.inf]]
> ['0x0000', '0x3c00', '0x398c', '0x4248', '0x3800', '0x7c00']
> 
> It seems the MSB bit of the mantissa got shifted as the LSB of the
> biased exponent...
> 
>> +#define float16_ln2 make_float16(0x34d1)
> 
> incorrect? 0x398c
> 
>> +#define float16_pi make_float16(0x4448)
> 
> incorrect? 0x4248
> 
>> +#define float16_half make_float16(0x3800)
> 
> ok
> 
>> +#define float16_infinity make_float16(0x7a00)
> 
> incorrect? 0x7c00

All of Phil's numbers are correct -- I double-checked with gcc.

Other than 0, 1 and +inf, I doubt any of the others will actually be used.
Perhaps we should just leave them out?


r~
