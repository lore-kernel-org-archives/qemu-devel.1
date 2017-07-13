Received: from eggs.gnu.org ([2001:4830:134:3::10]:41332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVdMz-0005f4-Sf
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVdMz-0001lG-1O
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:37:25 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVdMy-0001db-Rs
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:37:24 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 77so52550419wrb.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 05:37:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170713123225.GE4139@noname.redhat.com>
References: <20170709210717.984-1-peter.maydell@linaro.org>
	<20170713123225.GE4139@noname.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 13:36:40 +0100
Message-ID: <CAFEAcA_mAF23axLZ8tMcyQxjkv3pgu6PUtHyBTTVJLSMd5BTaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] block/vpc.c: Handle write failures in
 get_image_offset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 13 July 2017 at 13:32, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 09.07.2017 um 23:07 hat Peter Maydell geschrieben:
>> Coverity (CID 1355236) points out that get_image_offset() doesn't check that
>> it actually succeeded in writing the updated block bitmap to the file.
>> Check the error return from bdrv_pwrite_sync() and propagate an error
>> response back up to the function which calls get_image_offset() for
>> a write so that it can return the error to its caller.
>>
>> get_sector_offset() is only used for reads, but we move it to the
>> same API for consistency.

> get_sector_offset() has two useless parameters now instead of one, but
> I'll just send a patch on top to remove them.

I thought about doing that, but I decided it was better to
keep it as it is. A get_sector_offset() that silently only
works for reads and causes disk corruption if you use it for
a write seemed like a bit of a bear trap to leave lying around.

thanks
-- PMM
