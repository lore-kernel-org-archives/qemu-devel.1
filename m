Received: from eggs.gnu.org ([2001:4830:134:3::10]:43289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZESG-0006Cb-TC
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZESD-00036e-Mj
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:17:28 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485879287-12548-1-git-send-email-peter.maydell@linaro.org>
	<87wpdbw2ki.fsf@dusky.pond.sub.org>
	<157b55c5-2927-5f4e-0c43-820abd75a6d2@redhat.com>
	<874m0ejth1.fsf@dusky.pond.sub.org>
	<6c841220-8219-69fc-413f-c6ad320fe2ed@redhat.com>
Date: Thu, 02 Feb 2017 11:17:22 +0100
In-Reply-To: <6c841220-8219-69fc-413f-c6ad320fe2ed@redhat.com> (Paolo
	Bonzini's message of "Wed, 1 Feb 2017 17:09:00 -0800")
Message-ID: <87vass7v7x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] Drop QEMU_GNUC_PREREQ() checks for gcc
 older than 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, patches@linaro.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 31/01/2017 22:49, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> On 31/01/2017 12:40, Markus Armbruster wrote:
>>>>>  
>>>>>  #define QEMU_NORETURN __attribute__ ((__noreturn__))
>>>>>  
>>>>> -#if QEMU_GNUC_PREREQ(3, 4)
>>>>>  #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
>>>>> -#else
>>>>> -#define QEMU_WARN_UNUSED_RESULT
>>>>> -#endif
>>>> Should we inline this macro?
>>>>
>>>>>  
>>>>> -#if QEMU_GNUC_PREREQ(4, 0)
>>>>>  #define QEMU_SENTINEL __attribute__((sentinel))
>>>>> -#else
>>>>> -#define QEMU_SENTINEL
>>>>> -#endif
>>>> Likewise.
>>>
>>> Why, since we don't do that for QEMU_NORETURN, QEMU_PACKED, etc.?
>> 
>> Because we do it for aligned, always_inline, constructor, format, mode,
>> noinline, and in places even noreturn and packed:
>> 
>>     $ git-grep __attribute__ | sed '/define/d;s/.*__attribute__ *((\([A-Za-z0-9_]*\).*/\1/' | sort -u
>> 
>
> Uh oh. :)  You have to remove uses in firmware and in imported code
> (which covers mode, format and noreturn), but there's certainly room for
> some BiteSizedTasks.
>
> For sure noinline should be wrapped by a macro so that you also include
> noclone (usually you want to thwart some compiler optimization so both
> are needed).
>
> That leaves aligned, always_inline and constructor.  always_inline has
> three users, constructors has many, aligned has many and there's
> QEMU_ALIGNED too.  The smallest work would be to convert these three to
> QEMU_* rather than convert QEMU_* to __attribute__.

I prefer "direct" expression to hiding behind macros, unless there's a
reason for macros.  A common reason is portability.  Occasionally
abstraction, say when the direct expression doesn't really convey what
you're trying to do, or it's is overly verbose.

Anyway, I'm not particular on how we use attributes.  Since you seem to
have more specific ideas, could you file suitable BiteSizedTasks?
