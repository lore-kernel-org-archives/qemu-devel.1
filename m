Received: from eggs.gnu.org ([2001:4830:134:3::10]:49029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNrT-0006th-6d
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duNrQ-0001GQ-2d
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:07:11 -0400
Received: from mail-io0-x229.google.com ([2607:f8b0:4001:c06::229]:53833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duNrP-0001Fq-Tt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:07:08 -0400
Received: by mail-io0-x229.google.com with SMTP id q11so1420383ioe.10
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 12:07:07 -0700 (PDT)
References: <20170918104624.14743-1-laurent@vivier.eu>
	<a79537e9-1053-128e-e63b-8ce969beb12d@linaro.org>
	<e67746f6-6855-c761-f4ff-dd6b19391eda@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <10c85d62-6cd3-c555-529b-59b8de2c6ac7@linaro.org>
Date: Tue, 19 Sep 2017 14:06:58 -0500
MIME-Version: 1.0
In-Reply-To: <e67746f6-6855-c761-f4ff-dd6b19391eda@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] softfloat: rename make_float[x80|128]_init
 to const_float[x80|128]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 09/19/2017 12:39 PM, Eric Blake wrote:
> On 09/19/2017 11:30 AM, Richard Henderson wrote:
>> On 09/18/2017 05:46 AM, Laurent Vivier wrote:
>>> Redefine make_floatx80() and make_float128() as make_float16(),
>>> make_float32() and make_float64() using a variable and not only
>>> a cast.
> 
>>> -#define make_floatx80(exp, mant) ((floatx80) { mant, exp })
>>> -#define make_floatx80_init(exp, mant) { .low = mant, .high = exp }
>>> +#define make_floatx80(exp, mant) __extension__ \
>>> +    ({ floatx80 f80_val = { .low = mant, .high = exp }; f80_val; })
>>> +#define const_floatx80(exp, mant) { .low = mant, .high = exp }
> 
>>
>> I don't like this part -- (type){ init } is a standard C99 compound literal.
>> There's no point using a gcc extension instead.
> 
> The C99 compound literal is not a const initializer in all situations,
> though :( 

A compound literal not officially a const initializer in any situation.  That
it is accepted by gcc as a const initializer is an extension.

I don't dispute const_floatx80, but the change to make_floatx80.


r~
