Received: from eggs.gnu.org ([2001:4830:134:3::10]:36159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIx10-0001ow-VZ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIx0w-0007pV-Cd
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:02:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51310 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIx0w-0007pI-7y
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:02:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A031E40201A3
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 14:02:45 +0000 (UTC)
References: <20180515091356.24106-1-peterx@redhat.com>
	<584bbd99-11dd-8da9-a5b4-de285cebc84d@redhat.com>
	<20180516030750.GC9089@xz-mi>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b5eeb9d8-b5d5-ea06-ae09-3bfacb6036e0@redhat.com>
Date: Wed, 16 May 2018 09:02:42 -0500
MIME-Version: 1.0
In-Reply-To: <20180516030750.GC9089@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] qemu-error: introduce error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 05/15/2018 10:07 PM, Peter Xu wrote:

>>> +        static bool __print_once;               \
>>
>> Double-underscore names are reserved for the compiler's use, not ours.
>> Better would be naming this:
>>
>> static bool print_once_;
>>
>> with a trailing underscore, or at most a single leading underscore.
>>
>>> +        bool __ret_print_once = !__print_once;  \
>>
>> Same comment for this variable.
> 
> Sure!
> 
> (I am wondering why Linux is always using that way to name lots of
>   variables, and I'm surprised that I got 385350 after I run this under
>   the Linux repo: 'git grep "__[a-z][a-z]" | wc -l', even considering
>   some false positives)

git grep "\b_[_A-Z]" might be a more precise grep for use of reserved 
identifiers.  The Linux kernel can get away with some uses that qemu 
does not, because it is a monolithic low-level project that is closely 
tied to rather specific compiler behaviors and does not have to port to 
other systems; rather than a user-space application that aims to be 
portable to multiple operating systems, compilers, and libc 
implementations.  Also, grepping for leading double-underscore will have 
hits even in qemu, where we ARE taking advantage of a compiler feature 
(an obvious example: anywhere we #define a macro wrapper around an 
__attribute__ tag - __attribute__ belongs to the namespace reserved for 
the compiler, so it makes sense that turning on that compiler feature 
requires using the compiler's namespace).  Or put another way, grepping 
for the use of reserved identifiers is easy, but grepping for where we 
are inappropriately declaring something that may collide (rather than 
using something that already exists) is a bit harder.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
