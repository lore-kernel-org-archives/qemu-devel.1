Received: from eggs.gnu.org ([2001:4830:134:3::10]:45219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1egPNj-00061E-Kw
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 01:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1egPNg-00084V-Hn
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 01:26:59 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1egPNg-000845-Aq
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 01:26:56 -0500
Received: by mail-wm0-f68.google.com with SMTP id f71so18743658wmf.0
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 22:26:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180129154902.GJ6141@localhost.localdomain>
References: <20180124044216.12461-1-famz@redhat.com>
	<20180129154902.GJ6141@localhost.localdomain>
From: Fam Zheng <famz@redhat.com>
Date: Tue, 30 Jan 2018 14:26:24 +0800
Message-ID: <CAK1Eb9=_D+ctx4akutaY16hSfSX9j=KRzRKDfK+wKUN2tz7DCA@mail.gmail.com>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon, Jan 29, 2018 at 11:49 PM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 24.01.2018 um 05:42 hat Fam Zheng geschrieben:
>> The descriptor block in the image, which includes the CID to verify, has been
>> invalid since the reference image was added. Since commit 9877860e7bd we report
>> this error earlier than the "file too large", so 059.out mismatches.
>>
>> Instead of fixing the output, we fix the image descriptor, because the code
>> path we want to exercise is actually the invalid image size.
>>
>> The binary change is generated along the operations of:
>>
>>   $ bunzip2 afl9.vmdk.bz2
>>   $ qemu-img create -f qcow2 fix.vmdk 1G
>
> Sure about -f qcow2? :-)

Typo when writing up the commit message, will fix.

>
>>   $ dd if=afl9.vmdk.bz2 of=fix.vmdk bs=512 count=1 conv=notrunc
>>   $ mv fix.vmdk afl9.vmdk
>>   $ bzip2 afl9.vmdk
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>>  tests/qemu-iotests/sample_images/afl9.vmdk.bz2 | Bin 178 -> 618 bytes
>>  1 file changed, 0 insertions(+), 0 deletions(-)
>
> I think you also want to revert 76bf133c in this patch, otherwise 059
> fails after applying it.

Yeah, sending another version with that.

Fam
