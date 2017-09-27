Received: from eggs.gnu.org ([2001:4830:134:3::10]:49209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxF36-0005aO-57
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxF32-0007ji-5c
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:19:00 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:51274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dxF31-0007iT-V1
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:18:56 -0400
Received: by mail-pg0-x22b.google.com with SMTP id k193so8037968pgc.8
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 09:18:55 -0700 (PDT)
References: <20170916023417.14599-1-richard.henderson@linaro.org>
	<20170916023417.14599-2-richard.henderson@linaro.org>
	<87shf9cl9r.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e1ce7b9e-e8a8-41c8-4851-726377e63f89@linaro.org>
Date: Wed, 27 Sep 2017 09:18:50 -0700
MIME-Version: 1.0
In-Reply-To: <87shf9cl9r.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/6] tcg: Add types and operations for
 host vectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org

On 09/26/2017 12:28 PM, Alex Bennée wrote:
>>      * TCGv_ptr : a host pointer type
>> +    * TCGv_vec : a host vector type; the exact size is not exposed
>> +                 to the CPU front-end code.
> 
> Isn't this a guest vector type (which is pointed to by a host pointer)?

No, it's a host vector, which we have created in response to expanding a guest
vector operation.

> A one line comment wouldn't go amiss here. This looks like we are
> allocating a new temp of the same type as an existing temp?
> 
>> +TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match)

Yes.

>> +All of the vector ops have a final constant argument that specifies the
>> +length of the vector operation LEN as 64 << LEN bits.
> 
> That doesn't scan well. So would a 4 lane operation be encoded as 64 <<
> 4? Is this because we are using the bottom bits for something?

64 << 0 = 64
64 << 1 = 128
64 << 2 = 256.

I've fixed up the wording a bit.

>> +  Copy C across the entire vector.
>> +  At present the only supported values for C are 0 and -1.
> 
> I guess this is why the size in unimportant? This is for clearing or
> setting the whole of the vector? What does len mean in this case?

Yes.  Len still means the length of the whole vector.

Elsewhere there's a comment about maybe using dupi{8,16,32,64}_vec instead.
However I wanted to put that off until we do some more conversions and see
exactly what's going to be needed.


>> +* and_vec     v0, v1, v2, len
>> +* or_vec      v0, v1, v2, len
>> +* xor_vec     v0, v1, v2, len
>> +* andc_vec    v0, v1, v2, len
>> +* orc_vec     v0, v1, v2, len
>> +* not_vec     v0, v1, len
>> +
>> +  Similarly, logical operations.
> 
> Similarly, logical operations with and without compliment?

Sure.


r~
