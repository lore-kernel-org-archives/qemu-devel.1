Received: from eggs.gnu.org ([2001:4830:134:3::10]:52619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eXWsv-0007x4-VE
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 13:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eXWsu-0007YF-OV
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 13:38:29 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:32976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eXWsu-0007XW-Ct
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 13:38:28 -0500
Received: by mail-ot0-x236.google.com with SMTP id x15so4650756ote.0
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 10:38:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a979d8c1-2b2a-9ccd-5e51-bfef8292e571@cadami.net>
References: <a979d8c1-2b2a-9ccd-5e51-bfef8292e571@cadami.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jan 2018 18:38:06 +0000
Message-ID: <CAFEAcA9Hg4-ZABXZXi8Rxs+nvVpMh+95nY-VLNsxzCRrj1srzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] linux-user/mmap: Should not return NULL on guest
 call mmap(NULL, ...), causes crash inside glibc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maximilian Riemensberger <riemensberger@cadami.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 January 2018 at 18:13, Maximilian Riemensberger
<riemensberger@cadami.net> wrote:
> Hi,
>
> yesterday I hit the following problem when running an arm linux executable on
> qemu-2.10 (qemu-arm-static through binfmt_misc)
>
> 1879 mmap2(NULL,8388608,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|0x20000,-1,0) = 0x00000000
> 1879 write(2,0xf6fd39d0,79) stx_test: allocatestack.c:514: allocate_stack: Assertion `mem != NULL' failed.
>
> The issue comes up when the executable creates and joins lots of
> threads in a loop (it's a unit test).  Eventually, glibc allocatestack
> hits the mmap(NULL, ...) == NULL.  Judging from the posix and linux
> manuals mmap(NULL, ...) never returns NULL.  Either it fails with MAP_FAILED
> or it succeeds and returns non-NULL address.

Given the heavy use of threading, can you retest with QEMU 2.11,
please? We fixed a couple of threading issues in linux-user there.

thanks
-- PMM
