Received: from eggs.gnu.org ([2001:4830:134:3::10]:35802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1duOF1-00081K-6K
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1duOEw-0001OG-9J
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:31:31 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:59647)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1duOEv-0001Mx-U9
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:31:26 -0400
References: <20170918104624.14743-1-laurent@vivier.eu>
	<a79537e9-1053-128e-e63b-8ce969beb12d@linaro.org>
	<e67746f6-6855-c761-f4ff-dd6b19391eda@redhat.com>
	<9234d486-d4cb-c10e-da8c-48ca800e31a3@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ab998bd2-ba92-0a9e-ce0f-25d19cdb860a@vivier.eu>
Date: Tue, 19 Sep 2017 21:31:06 +0200
MIME-Version: 1.0
In-Reply-To: <9234d486-d4cb-c10e-da8c-48ca800e31a3@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Markus Armbruster <armbru@redhat.com>

Le 19/09/2017 à 20:45, Laszlo Ersek a écrit :
> On 09/19/17 19:39, Eric Blake wrote:
>> On 09/19/2017 11:30 AM, Richard Henderson wrote:
>>> On 09/18/2017 05:46 AM, Laurent Vivier wrote:
>>>> Redefine make_floatx80() and make_float128() as make_float16(),
>>>> make_float32() and make_float64() using a variable and not only
>>>> a cast.
>>
>>>> -#define make_floatx80(exp, mant) ((floatx80) { mant, exp })
>>>> -#define make_floatx80_init(exp, mant) { .low = mant, .high = exp }
>>>> +#define make_floatx80(exp, mant) __extension__ \
>>>> +    ({ floatx80 f80_val = { .low = mant, .high = exp }; f80_val; })
>>>> +#define const_floatx80(exp, mant) { .low = mant, .high = exp }
>>
>>>
>>> I don't like this part -- (type){ init } is a standard C99 compound literal.
>>> There's no point using a gcc extension instead.
>>
>> The C99 compound literal is not a const initializer in all situations,
>> though :(  Here's another thread where we had a similar discussion, but
>> there, the solution was to just make the macro behave as an initializer
>> (which is C99 compliant, but loses some type safety) instead of relying
>> on a gcc extension:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06566.html
>>
>> I suspect you're running into the same issues that Laszlo already helped
>> us understand regarding QLit.
>>
> 
> Thanks for the CC! I don't have much context, but the patch looks quite
> isolated.
> 
> I think I agree with Richard here -- I don't think there's any reason to
> change the replacement text of make_floatx80.
> 
> The patch names make_float64() as an earlier example (already using
> __extension__), but I don't understand why make_float64() was written
> that way. ... It seems to go back to ancient commit f090c9d4ad58 ("Add
> strict checking mode for softfp code.", 2007-11-18). Was C99 support
> (esp. compound literals) spotty in gcc back then?
> 
> Not having much background, I'd suggest the opposite change -- replace
> the statement-expression in make_float64() with a compound literal.


Okay, I'll do this way.

Thank you all for your comments.

Laurent
