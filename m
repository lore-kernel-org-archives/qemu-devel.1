Received: from eggs.gnu.org ([2001:4830:134:3::10]:54548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cMHi5-0004aW-0r
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 12:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cMHi4-0001ie-2j
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 12:08:16 -0500
Received: from mail-vk0-x232.google.com ([2607:f8b0:400c:c05::232]:35683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cMHi3-0001iW-Uy
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 12:08:16 -0500
Received: by mail-vk0-x232.google.com with SMTP id y197so74372254vky.2
	for <qemu-devel@nongnu.org>; Wed, 28 Dec 2016 09:08:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2a940dc2-05a0-2e91-afc0-eeb560f6ce32@redhat.com>
References: <CAJ+F1CJXGAZa5_+4jD0rP_zX28RCCu3xmF27ZHpgvhnZz686ug@mail.gmail.com>
	<20161228145344.30819-1-cov@codeaurora.org>
	<2a940dc2-05a0-2e91-afc0-eeb560f6ce32@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Dec 2016 17:07:55 +0000
Message-ID: <CAFEAcA_g5Ru2cg-D5JEhpzuUTx7=SwNg=TW3uxs-z_pp2yvqHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Eric Blake <eblake@redhat.com>
Cc: Christopher Covington <cov@codeaurora.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

On 28 December 2016 at 16:10, Eric Blake <eblake@redhat.com> wrote:
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
> on some other systems, so this may fail to build elsewhere.  You'll
> probably need a configure probe.  Autoconf also says that some platforms
> have <sys/mkdev.h> instead of <sys/sysmacros.h> (per its AC_HEADER_MAJOR
> macro).

Also this seems straightforwardly like a bug in glibc: it shouldn't
be making this kind of breaking change. makedev(3) on my Linux box
says nothing about needing sysmacros.h for these.

thanks
-- PMM
