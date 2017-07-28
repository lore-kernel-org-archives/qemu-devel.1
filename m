Received: from eggs.gnu.org ([2001:4830:134:3::10]:45690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1db8wb-0004L1-IU
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1db8wY-0004pE-8U
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:20:57 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:37305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1db8wY-0004p3-4I
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 13:20:54 -0400
Received: by mail-ua0-x244.google.com with SMTP id 80so20215203uas.4
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 10:20:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
	<CAKmqyKPZ3+ohCvpzbw=MyLpgB5cFKQosBJNsaWcoT=yWp1c9Mw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cf854184-8bc0-4a9c-b97f-8274abf538bc@amsat.org>
Date: Fri, 28 Jul 2017 14:20:49 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPZ3+ohCvpzbw=MyLpgB5cFKQosBJNsaWcoT=yWp1c9Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: include <linux/limits.h> for
 XATTR_SIZE_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>, Patrick Steinhardt <ps@pks.im>, Kamil Rytarowski <kamil@netbsd.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

> On Mon, Jun 26, 2017 at 12:20 PM, Patrick Steinhardt <ps@pks.im> wrote:
>> The function `v9fs_xattrcreate` makes use of the define `XATTR_SIZE_MAX`
>> to reject attempts of creating xattrs with an invalid size, which is
>> defined in <linux/limits.h>. On glibc-based systems, this header is
>> indirectly included via <limits.h>, <bits/posix1_lim.h>,
>> <bitts/local_lim.h>, but on other platforms this is not guaranteed due
>> to not being part of the POSIX standard. One examples are systems based
>> on musl libc, which do not include the <linux/limits.h> indirectly,
>> which leads to `XATTR_SIZE_MAX` being undefined.
>>
>> Fix this error by directly include <linux/limits.h>. As the 9P fs code
>> is being Linux-based either way, we can simply do so without breaking
>> other platforms. This enables building 9pfs on musl-based systems.
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>   hw/9pfs/9p.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
>> index 96d2683348..48cd558e96 100644
>> --- a/hw/9pfs/9p.c
>> +++ b/hw/9pfs/9p.c
>> @@ -13,6 +13,7 @@
>>
>>   #include "qemu/osdep.h"
>>   #include <glib/gprintf.h>

This is likely to break on BSD, but now than patchew has a NetBSD job 
you can trigger a build RESENDing this patch.

This should probably work:

#ifdef __linux__

>> +#include <linux/limits.h>

#endif

>>   #include "hw/virtio/virtio.h"
>>   #include "qapi/error.h"
>>   #include "qemu/error-report.h"
>> --
>> 2.13.2

Regards,

Phil.
