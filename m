Received: from eggs.gnu.org ([2001:4830:134:3::10]:37883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUYBZ-00024P-15
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUYBX-0002e8-Va
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:20:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUYBX-0002dl-QQ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:20:51 -0500
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
	<1484859998-25074-5-git-send-email-mst@redhat.com>
	<aa9a259a-a649-d399-5895-837a5a23f56c@redhat.com>
	<20170120000636-mutt-send-email-mst@kernel.org>
	<459939cd-4f0e-bc08-7de8-5788e6f2e2aa@redhat.com>
	<877f5q421q.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50f7a120-c0eb-9832-2ac1-d906b7884b42@redhat.com>
Date: Fri, 20 Jan 2017 13:20:47 +0100
MIME-Version: 1.0
In-Reply-To: <877f5q421q.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/4] ARRAY_SIZE: check that argument is
 an array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Sergey Fedorov <serge.fdrv@gmail.com>, qemu-devel@nongnu.org



On 20/01/2017 08:34, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 01/19/2017 04:11 PM, Michael S. Tsirkin wrote:
>>
>>>>> +#define QEMU_IS_ARRAY(x) (!__builtin_types_compatible_p(typeof(x), \
>>>>> +                                                        typeof(&(x)[0])))
>>>>>  #ifndef ARRAY_SIZE
>>>>> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>>>>> +#define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
>>>>> +                       QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
>>>>
>>>> We've got some double-negation going on here ("cause a build bug if the
>>>> negation of QEMU_IS_ARRAY() is not 0") which takes some mental
>>>> gymnastics, but it is the correct result.  [I kind of like that gnulib
>>>> uses positive logic in its 'verify(x)' meaning "verify that x is true,
>>>> or cause a build error"; compared to the negative logic in the kernal
>>>> 'BUILD_BUG_ON[_ZERO](x)' meaning "cause a build bug if x is non-zero" -
>>>> but that's personal preference and not something for qemu to change]
>>>
>>> I can rename QEMU_IS_ARRAY to QEMU_IS_PTR and reverse the logic - would
>>> this be preferable?
>>
>> No, that's worse. As written, "cause a build bug if x is not an array"
>> is easier than "cause a build bug if x is a pointer", because now you
>> are missing an implicit "(instead of the intended array)".  Keep it the
>> way you have it.  I guess it's the _ZERO as a suffix that's throwing me;
>> a better name might have been QEMU_ZERO_OR_BUILD_BUG_ON(x) ("give me a
>> zero expression, or a build bug if x is non-zero") rather than
>> QEMU_BUILD_BUG_ON_ZERO (my first read was "give me a build bug if x is
>> zero", but a better read is "give me a build bug if x is not zero, else
>> give me x because it is zero") - but our choice of naming in patch 3/4
>> mirrors the kernel naming, so it's not worth changing.
> 
> Two ways to skin the assertion cat:
> 
>     assert must_be_true
>     bug_on must_be_false
> 
> The C language picks the first one, both with assert() and with C11's
> _Static_assert().  I'd prefer we stick to that, but I'm not asking you
> to change your series.

We should probably change it to QEMU_STATIC_ASSERT and
QEMU_STATIC_ASSERT_VALUE, but that shouldn't be in this series.

Paolo
