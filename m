Received: from eggs.gnu.org ([2001:4830:134:3::10]:51437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVD4h-0004pB-6v
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVD4d-0006Rd-TO
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:09:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gVD4d-0006RL-Lm
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:09:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so3751259wmi.3
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:09:31 -0800 (PST)
References: <20181116190211.17622-1-remy.noel@blade-group.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e4aa171f-4112-f249-4ecf-3a27f0a0c459@redhat.com>
Date: Fri, 7 Dec 2018 11:09:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181116190211.17622-1-remy.noel@blade-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] aio_poll race condition.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: remy.noel@blade-group.com, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi Remy,
On 11/16/18 8:02 PM, remy.noel@blade-group.com wrote:
> From: Remy Noel <remy.noel@blade-group.com>
> 
> It is possible for an io_poll callback to be concurrently executed along
> with an aio_set_fd_handlers. This can cause all sorts of problems, like
> a NULL callback or a bad opaque pointer.
> We fixes that by using an remove/insert RCU scheme.

You forgot to Cc the relevant maintainers, that's probably why your
series went unnoticed.

>From the wiki:
https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer

$ ./scripts/get_maintainer.pl -f include/block/aio.h util/aio-posix.c
util/aio-win32.c util/async.c
Stefan Hajnoczi <stefanha@redhat.com> (supporter:Block I/O path)
Fam Zheng <famz@redhat.com> (supporter:Block I/O path)
Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
Stefan Weil <sw@weilnetz.de> (maintainer:W32, W64)
qemu-block@nongnu.org (open list:Block I/O path)
qemu-devel@nongnu.org (open list:All patches CC here)

Please Cc them in your v2.

(Note Fam has a new email: Fam Zheng <fam@euphon.net>)

Regards,

Phil.

> 
> Please note that i did not test the win32 version.
> 
> Remy Noel (3):
>   aio-posix: Fix concurrent aio_poll/set_fd_handler.
>   util/aio-posix: Use RCU for handler insertion.
>   aio: Do not use list_lock as a sync mechanism for aio_handlers
>     anymore.
> 
>  include/block/aio.h |   4 +-
>  util/aio-posix.c    | 148 ++++++++++++++++++++------------------------
>  util/aio-win32.c    |  82 +++++++++---------------
>  util/async.c        |   7 ++-
>  4 files changed, 103 insertions(+), 138 deletions(-)
> 
