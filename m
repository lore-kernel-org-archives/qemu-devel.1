Received: from eggs.gnu.org ([2001:4830:134:3::10]:35705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1duNX4-00064w-Ne
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1duNX0-0003ke-PM
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:46:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1duNX0-0003ju-IR
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:46:02 -0400
References: <20170918104624.14743-1-laurent@vivier.eu>
	<a79537e9-1053-128e-e63b-8ce969beb12d@linaro.org>
	<e67746f6-6855-c761-f4ff-dd6b19391eda@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9234d486-d4cb-c10e-da8c-48ca800e31a3@redhat.com>
Date: Tue, 19 Sep 2017 20:45:56 +0200
MIME-Version: 1.0
In-Reply-To: <e67746f6-6855-c761-f4ff-dd6b19391eda@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Eric Blake <eblake@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Markus Armbruster <armbru@redhat.com>

On 09/19/17 19:39, Eric Blake wrote:
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
> though :(  Here's another thread where we had a similar discussion, but
> there, the solution was to just make the macro behave as an initializer
> (which is C99 compliant, but loses some type safety) instead of relying
> on a gcc extension:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06566.html
> 
> I suspect you're running into the same issues that Laszlo already helped
> us understand regarding QLit.
> 

Thanks for the CC! I don't have much context, but the patch looks quite
isolated.

I think I agree with Richard here -- I don't think there's any reason to
change the replacement text of make_floatx80.

The patch names make_float64() as an earlier example (already using
__extension__), but I don't understand why make_float64() was written
that way. ... It seems to go back to ancient commit f090c9d4ad58 ("Add
strict checking mode for softfp code.", 2007-11-18). Was C99 support
(esp. compound literals) spotty in gcc back then?

Not having much background, I'd suggest the opposite change -- replace
the statement-expression in make_float64() with a compound literal.

Thanks
Laszlo
