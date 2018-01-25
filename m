Received: from eggs.gnu.org ([2001:4830:134:3::10]:45904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eeiL0-0004Q0-7L
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eeiKw-0003zJ-7N
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:17:10 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:46584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1eeiKw-0003sU-0U
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:17:06 -0500
Received: by mail-wm0-f68.google.com with SMTP id 143so14864048wma.5
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 06:17:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8zie8oB57b9chAXvL_5s3eJ6SBbVpadfbd7w1+zdJMOw@mail.gmail.com>
References: <20180125054648.18747-1-famz@redhat.com>
	<CAFEAcA8zie8oB57b9chAXvL_5s3eJ6SBbVpadfbd7w1+zdJMOw@mail.gmail.com>
From: Fam Zheng <famz@redhat.com>
Date: Thu, 25 Jan 2018 22:16:28 +0800
Message-ID: <CAK1Eb9nX3o3DpcmsQeAr2w1+XTJUWn5U=4aud6WDvUk0hrSJZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] Block and docker patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jan 25, 2018 at 9:51 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 25 January 2018 at 05:46, Fam Zheng <famz@redhat.com> wrote:
>> The following changes since commit 834a336eb911db8a8ca00e760ee6a85faca19414:
>>
>>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-01-24 19:24:26 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/famz/qemu.git tags/staging-pull-request
>>
>> for you to fetch changes up to 6b4c4a84a1c7386df30edb4cb3b846b7ded9c707:
>>
>>   qapi: Add NVMe driver options to the schema (2018-01-25 13:26:54 +0800)
>>
>> ----------------------------------------------------------------
>>
>> Hi Peter, this includes:
>>
>> - Paolo's docker fix for fedora image.
>> - Paolo's coroutine lock API improvements.
>> - My userspace NVMe driver.
>>
>> ----------------------------------------------------------------
>
> Hi -- there are a couple of build failures here:
>
> NetBSD/OpenBSD/OSX don't like the change to the .texi file:
>
> /root/qemu//docs/qemu-block-drivers.texi:788: `disk_images_nvme' has
> no Up field (perhaps incorrect sectioning?).
> /root/qemu//docs/qemu-block-drivers.texi:788: warning: unreferenced
> node `disk_images_nvme'.
>
> and some of the other hosts produce this slightly different error
> for what is probably the same issue:
>
> /home/pm215/qemu/qemu-doc.texi:603: node `disk_images' lacks menu item
> for `disk_images_nvme' despite being its Up target
>
>
> There are some format string problems on 32-bit hosts:
>
> /home/peter.maydell/qemu/util/vfio-helpers.c: In function
> 'qemu_vfio_init_ramblock':
> /home/peter.maydell/qemu/util/vfio-helpers.c:406:25: error: format
> '%ld' expects argument of type 'long int', but argument 4 has type
> 'ram_addr_t {aka unsigned int}' [-Werror=format=]
>          fprintf(stderr, "qemu_vfio_init_ramblock: failed %p %ld\n",
>                          ^
> /home/peter.maydell/qemu/util/vfio-helpers.c: In function
> 'qemu_vfio_dump_mapping':
> /home/peter.maydell/qemu/util/vfio-helpers.c:443:16: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 3 has
> type 'size_t {aka unsigned int}' [-Werror=format=]
>          printf("  vfio mapping %p %lx to %lx\n", m->host, m->size, m->iova);
>                 ^
> /home/peter.maydell/qemu/util/vfio-helpers.c:443:16: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 4 has
> type 'uint64_t {aka long long unsigned int}' [-Werror=format=]
>
>
> Finally, the clang build spots what looks like a typo:
>
> /home/petmay01/linaro/qemu-for-merges/util/vfio-helpers.c:514:55:
> error: explicitly assigning value of variable of type 'uint64_t' (aka
> 'unsigned long') to itself [-Werror,-Wself-assign]
>     IOVAMapping m = {.host = host, .size = size, iova = iova};
>                                                  ~~~~ ^ ~~~~
>
> ...should be ".iova", I imagine.

All good catches. Will fix them all. Thanks!

Fam
