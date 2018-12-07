Received: from eggs.gnu.org ([2001:4830:134:3::10]:51510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gVG7v-0004DT-KJ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gVG7r-0007v4-SS
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:25:07 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1gVG7r-0007ru-IN
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:25:03 -0500
Received: by mail-wr1-x42f.google.com with SMTP id x10so3785033wrs.8
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 05:25:03 -0800 (PST)
References: <20181116190211.17622-1-remy.noel@blade-group.com>
	<e4aa171f-4112-f249-4ecf-3a27f0a0c459@redhat.com>
From: Remy NOEL <remy.noel@blade-group.com>
Message-ID: <3474d518-cd98-deb6-757e-a5ed47887b98@blade-group.com>
Date: Fri, 7 Dec 2018 14:25:20 +0100
MIME-Version: 1.0
In-Reply-To: <e4aa171f-4112-f249-4ecf-3a27f0a0c459@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH] aio_poll race condition.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Indeed, i did not add those for the cover letter (i used the wiki's 
commit hook though)

Anyway, I sent a V2 after discovering the rcu usage hada significant 
performance impact.

It was not sent to the New email fo Fam Zheng though. i'll forward it to 
its new address, thanks.

Regards.

Remy

On 12/7/18 11:09 AM, Philippe Mathieu-Daudé wrote:
> Hi Remy,
> On 11/16/18 8:02 PM, remy.noel@blade-group.com wrote:
>> From: Remy Noel <remy.noel@blade-group.com>
>>
>> It is possible for an io_poll callback to be concurrently executed along
>> with an aio_set_fd_handlers. This can cause all sorts of problems, like
>> a NULL callback or a bad opaque pointer.
>> We fixes that by using an remove/insert RCU scheme.
> You forgot to Cc the relevant maintainers, that's probably why your
> series went unnoticed.
>
>  From the wiki:
> https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer
>
> $ ./scripts/get_maintainer.pl -f include/block/aio.h util/aio-posix.c
> util/aio-win32.c util/async.c
> Stefan Hajnoczi <stefanha@redhat.com> (supporter:Block I/O path)
> Fam Zheng <famz@redhat.com> (supporter:Block I/O path)
> Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
> Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
> Stefan Weil <sw@weilnetz.de> (maintainer:W32, W64)
> qemu-block@nongnu.org (open list:Block I/O path)
> qemu-devel@nongnu.org (open list:All patches CC here)
>
> Please Cc them in your v2.
>
> (Note Fam has a new email: Fam Zheng <fam@euphon.net>)
>
> Regards,
>
> Phil.
>
>> Please note that i did not test the win32 version.
>>
>> Remy Noel (3):
>>    aio-posix: Fix concurrent aio_poll/set_fd_handler.
>>    util/aio-posix: Use RCU for handler insertion.
>>    aio: Do not use list_lock as a sync mechanism for aio_handlers
>>      anymore.
>>
>>   include/block/aio.h |   4 +-
>>   util/aio-posix.c    | 148 ++++++++++++++++++++------------------------
>>   util/aio-win32.c    |  82 +++++++++---------------
>>   util/async.c        |   7 ++-
>>   4 files changed, 103 insertions(+), 138 deletions(-)
>>
