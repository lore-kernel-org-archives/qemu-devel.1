Received: from eggs.gnu.org ([2001:4830:134:3::10]:56032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cov@codeaurora.org>) id 1cMKRV-0002Q8-42
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 15:03:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cov@codeaurora.org>) id 1cMKRS-0006rm-0o
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 15:03:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cov@codeaurora.org>) id 1cMKRR-0006r9-Mp
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 15:03:17 -0500
References: <CAJ+F1CJXGAZa5_+4jD0rP_zX28RCCu3xmF27ZHpgvhnZz686ug@mail.gmail.com>
	<20161228145344.30819-1-cov@codeaurora.org>
	<2a940dc2-05a0-2e91-afc0-eeb560f6ce32@redhat.com>
From: Christopher Covington <cov@codeaurora.org>
Message-ID: <8cab9cb6-3638-09cb-e019-8dcc705a80e1@codeaurora.org>
Date: Wed, 28 Dec 2016 15:03:13 -0500
MIME-Version: 1.0
In-Reply-To: <2a940dc2-05a0-2e91-afc0-eeb560f6ce32@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] build: include sys/sysmacros.h for
 major() and minor()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

Hi Eric,

On 12/28/2016 11:10 AM, Eric Blake wrote:
> On 12/28/2016 08:53 AM, Christopher Covington wrote:
>> The definition of the major() and minor() macros are moving within glibc to
>> <sys/sysmacros.h>. Include this header to avoid the following sorts of
>> build-stopping messages:
>>
> 
>> The additional include allows the build to complete on Fedora 26 (Rawhide)
>> with glibc version 2.24.90.
>>
>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
>> ---
>>  include/sysemu/os-posix.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
>> index b0a6c0695b..772d58f7ed 100644
>> --- a/include/sysemu/os-posix.h
>> +++ b/include/sysemu/os-posix.h
>> @@ -28,6 +28,7 @@
>>  
>>  #include <sys/mman.h>
>>  #include <sys/socket.h>
>> +#include <sys/sysmacros.h>
> 
> I repeat what I said on v1:
> 
> Works for glibc; but <sys/sysmacros.h> is non-standard and not present
> on some other systems, so this may fail to build elsewhere.

I read your response to v1 but got stuck on this "some other systems"
statement which seems too vague for me to act on. I see the following
operating systems checked in configure:

Cygwin, mingw32, GNU/kFreeBSD, FreeBSD, DragonFly, NetBSD, OpenBSD,
Darwin, SunOS, AIX, Haiku, and Linux.

But I'm really not sure what list of C libraries and corresponding mkdev.h
versus sysmacros.h versus types.h usage this translates to.

> You'll probably need a configure probe.

I'm testing that now and will hopefully send it out as v3 shortly.

> Autoconf also says that some platforms have <sys/mkdev.h> instead of
> <sys/sysmacros.h> (per its AC_HEADER_MAJOR macro).

`git grep mkdev` returns no results for me so I conclude that no currently
supported OS/libc requires it.

In case anyone wants to work around these messages, I'd like to highlight
the --disable-werror option to ./configure. If I had known about it this
morning, I probably would be happily authoring other changes right now.

Thanks,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
