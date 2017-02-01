Received: from eggs.gnu.org ([2001:4830:134:3::10]:39606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYojq-0001jd-SY
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 01:49:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYojm-0005yB-2E
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 01:49:54 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485879287-12548-1-git-send-email-peter.maydell@linaro.org>
	<87wpdbw2ki.fsf@dusky.pond.sub.org>
	<157b55c5-2927-5f4e-0c43-820abd75a6d2@redhat.com>
Date: Wed, 01 Feb 2017 07:49:46 +0100
In-Reply-To: <157b55c5-2927-5f4e-0c43-820abd75a6d2@redhat.com> (Paolo
	Bonzini's message of "Tue, 31 Jan 2017 18:27:10 -0500")
Message-ID: <874m0ejth1.fsf@dusky.pond.sub.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 31/01/2017 12:40, Markus Armbruster wrote:
>>>  
>>>  #define QEMU_NORETURN __attribute__ ((__noreturn__))
>>>  
>>> -#if QEMU_GNUC_PREREQ(3, 4)
>>>  #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
>>> -#else
>>> -#define QEMU_WARN_UNUSED_RESULT
>>> -#endif
>> Should we inline this macro?
>> 
>>>  
>>> -#if QEMU_GNUC_PREREQ(4, 0)
>>>  #define QEMU_SENTINEL __attribute__((sentinel))
>>> -#else
>>> -#define QEMU_SENTINEL
>>> -#endif
>> Likewise.
>
> Why, since we don't do that for QEMU_NORETURN, QEMU_PACKED, etc.?

Because we do it for aligned, always_inline, constructor, format, mode,
noinline, and in places even noreturn and packed:

    $ git-grep __attribute__ | sed '/define/d;s/.*__attribute__ *((\([A-Za-z0-9_]*\).*/\1/' | sort -u
