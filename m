Received: from eggs.gnu.org ([2001:4830:134:3::10]:39852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eh3AT-0007yn-5N
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eh3AQ-0000q7-4t
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:55:57 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1eh3AP-0000pW-UE
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:55:54 -0500
Received: by mail-wm0-f65.google.com with SMTP id x4so487687wmc.0
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 16:55:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7d94ad09-9c3e-da10-3f15-2c15147fb837@redhat.com>
References: <20180130062503.32596-1-famz@redhat.com>
	<7d94ad09-9c3e-da10-3f15-2c15147fb837@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Thu, 1 Feb 2018 08:55:22 +0800
Message-ID: <CAK1Eb9k_x9guD5L2EPBEx1ipjuUmFAA0FbLsAHkgp==z+=r7dA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix CID for VMDK afl image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Thu, Feb 1, 2018 at 2:58 AM, Max Reitz <mreitz@redhat.com> wrote:
> On 2018-01-30 07:25, Fam Zheng wrote:
>> This reverts commit 76bf133c4 which updated the reference output, and
>> fixed the reference image, because the code path we want to exercise is
>> actually the invalid image size.
>>
>> The descriptor block in the image, which includes the CID to verify, has been
>> invalid since the reference image was added. Since commit 9877860e7bd we report
>> this error earlier than the "file too large", so 059.out mismatches.
>>
>> The binary change is generated along the operations of:
>>
>>   $ bunzip2 afl9.vmdk.bz2
>>   $ qemu-img create -f vmdk fix.vmdk 1G
>>   $ dd if=afl9.vmdk.bz2 of=fix.vmdk bs=512 count=1 conv=notrunc
>>   $ mv fix.vmdk afl9.vmdk
>>   $ bzip2 afl9.vmdk
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>
>> ---
>>
>> v2: Fix commit message "qcow2 -> vmdk". [Kevin]
>>     Revert 76bf133c4.
>
> Hmmmm, now this fails again on my 32 bit build. :-(
>
> The issue there is that you get a "Cannot allocate memory" when trying
> to open the file.  My current fix was 2291712c39111a732 which simply
> converted that to "Invalid argument", but now it's getting a bit more
> complicated...  Should I just continue to play the game and check the
> output for "Cannot allocate memory" and print exactly what the reference
> output is expecting...?

Ahhh. OK, then, with a big comment.

I'd say let's just _notrun on 32 bit.

Fam
