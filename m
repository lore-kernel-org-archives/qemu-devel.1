Received: from eggs.gnu.org ([2001:4830:134:3::10]:57600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSqYg-0006i6-CS
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 17:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSqYc-0007fy-DD
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 17:10:30 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:41605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSqYb-0007f1-UT
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 17:10:26 -0400
Received: by mail-pl0-x244.google.com with SMTP id az12-v6so188014plb.8
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 14:10:25 -0700 (PDT)
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-12-f4bug@amsat.org>
	<15d222dd-d2e9-4855-62c6-f89f2ee59c52@linaro.org>
	<76aa5170-1d18-8799-6ff1-a7c0dba0b489@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8537ca07-2645-6c2c-5945-a91da035b474@linaro.org>
Date: Tue, 12 Jun 2018 11:10:19 -1000
MIME-Version: 1.0
In-Reply-To: <76aa5170-1d18-8799-6ff1-a7c0dba0b489@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 11/40] hw/xen: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>

On 06/12/2018 11:04 AM, Eric Blake wrote:
> On 06/12/2018 03:51 PM, Richard Henderson wrote:
>> On 06/10/2018 03:14 PM, Philippe Mathieu-Daudé wrote:
>>>       xen_pv_printf(xendev, 1, "type \"%s\", fileproto \"%s\", filename
>>> \"%s\","
>>> -                  " size %" PRId64 " (%" PRId64 " MB)\n",
>>> +                  " size %" PRId64 " (%llu MB)\n",
>>>                     blkdev->type, blkdev->fileproto, blkdev->filename,
>>> -                  blkdev->file_size, blkdev->file_size >> 20);
>>> +                  blkdev->file_size, blkdev->file_size / MiB);
>>
>> Having to change printf markup is exactly why you shouldn't use ULL in MiB.
> 
> Conversely, M_BYTE was already ULL, so if you don't use it in MiB, you'll have
> to change other printf markup where you were changing those uses.
> 
> One benefit of using the widest possible type: we avoid risk of silent
> truncation.  Potential downsides: wasted processing time (when 32 bits was
> sufficient), and compilers might start warning when we narrow a 64-bit value
> into a 32-bit variable (but I think we already ignore that).
> 
> One benefit of using the natural type that holds the value: use of 64-bit math
> is explicit based on the type of what else is being multiplied by the macro. 
> Potential downside: 32*32 assigned to a 64-bit result may be botched (but
> hopefully Coverity will flag it).
> 
> So there's tradeoffs either way, and you at least need to document in your
> commit messages what auditing you have done that any type changes introduced by
> your changes are safe.

I'm more concerned about unnecessary or unintended signed vs unsigned changes
than I am about width.  But if we're going to force a 64-bit type, use
(int64_t)1 not 1LL.  That way the type will match the existing PRId64 printf
markup.


r~
