Received: from eggs.gnu.org ([2001:4830:134:3::10]:54081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1df3M7-00067u-S5
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1df3M6-0007vV-Oo
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:11:27 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1df3M6-0007uk-GT
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:11:26 -0400
Received: by mail-wm0-x22e.google.com with SMTP id m85so5432017wma.1
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 05:11:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170808120421.GK16801@stefanha-x1.localdomain>
References: <878tize8k1.fsf@dusky.pond.sub.org>
	<20170808120421.GK16801@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Aug 2017 13:11:04 +0100
Message-ID: <CAFEAcA_kdcGxbY7oF+R0BDiB1c42KKrh+YPuKJGTweD=k0DwxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] Unchecked blk_getlength() in device
 models and board code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@web.de>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>

On 8 August 2017 at 13:04, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Fri, Aug 04, 2017 at 04:01:18PM +0200, Markus Armbruster wrote:
>> blk_getlength() can fail.  I figure the following need fixing:
>>
>> hw/arm/musicpal.c: musicpal_init()
>
> Seems okay:
>
> flash_size = blk_getlength(blk);
> if (flash_size != 8*1024*1024 && flash_size != 16*1024*1024 &&
>     flash_size != 32*1024*1024) {
>     fprintf(stderr, "Invalid flash image size\n");
>     exit(1);
> }

A lot of the time for flash devices it's not possible to
get an error code out of blk_getlength() anyway, because
AFAIK it only happens for cases like "cdrom with CD
ejected" and "sd card emulating the card-ejected state".
Still better to handle the error value than not, though.

thanks
-- PMM
