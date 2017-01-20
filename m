Received: from eggs.gnu.org ([2001:4830:134:3::10]:51617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUchM-00007E-M3
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUchH-0002NU-N0
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:10:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUchH-0002NC-Gx
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:09:55 -0500
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
	<1484859998-25074-3-git-send-email-mst@redhat.com>
	<87wpdq2n4e.fsf@dusky.pond.sub.org>
	<20170120185551-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <024df752-27f3-88f3-99a3-a7f5e18069b4@redhat.com>
Date: Fri, 20 Jan 2017 18:09:52 +0100
MIME-Version: 1.0
In-Reply-To: <20170120185551-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/4] compiler: rework BUG_ON using a
 struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>



On 20/01/2017 17:57, Michael S. Tsirkin wrote:
> On Fri, Jan 20, 2017 at 08:42:41AM +0100, Markus Armbruster wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>
>>> There are theoretical concerns that some compilers might not trigger
>>> build failures on attempts to define an array of size -1 and make it a
>>> variable sized array instead. Let rewrite using a struct with a negative
>>> bit field size instead as there are no dynamic bit field sizes.  This is
>>> similar to what Linux does.
>>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>  include/qemu/compiler.h | 9 ++++++---
>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>>> index 7512082..c6f673e 100644
>>> --- a/include/qemu/compiler.h
>>> +++ b/include/qemu/compiler.h
>>> @@ -85,9 +85,12 @@
>>>  #define typeof_field(type, field) typeof(((type *)0)->field)
>>>  #define type_check(t1,t2) ((t1*)0 - (t2*)0)
>>>  
>>> -#define QEMU_BUILD_BUG_ON(x) \
>>> -    typedef char glue(qemu_build_bug_on__, __LINE__)[(x) ? -1 : 1] \
>>> -        __attribute__((unused))
>>> +#define QEMU_BUILD_BUG_ON_STRUCT(x) \
>>> +    struct { \
>>> +        int qemu_build_bug_on : (x) ? -1 : 1; \
>>> +    }
>>
>> The qemu_build_bug_on name space pollution is harmless, but quite
>> unnecessary: the name can be simply omitted (unnamed bit-field).
> 
> I have concerns about it's portability though. I remember
> we had to get rid of unnamed fields in some structs at some point
> for the sake of some old compiler.

Unnamed bitfields are in C89 and we definitely use unnamed unions.
Maybe that was an unnamed struct or scalar.

Paolo

>>> +#define QEMU_BUILD_BUG_ON(x) typedef QEMU_BUILD_BUG_ON_STRUCT(x) \
>>> +    glue(qemu_build_bug_on__, __LINE__) __attribute__((unused))
>>>  
>>>  #if defined __GNUC__
>>>  # if !QEMU_GNUC_PREREQ(4, 4)
