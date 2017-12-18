Received: from eggs.gnu.org ([2001:4830:134:3::10]:35609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1eQnRw-0006ZS-1f
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1eQnRs-0003uf-W7
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:54:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1eQnRs-0003sM-NQ
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:54:44 -0500
References: <1513370232-25515-1-git-send-email-wei@redhat.com>
	<CAFEAcA8FXhrOzN=9Thiv_aGy8n=kU+E1R5R93DL3XStwQQ2MfQ@mail.gmail.com>
From: Wei Huang <wei@redhat.com>
Message-ID: <ac2b3b8e-851e-3264-5da2-c214304dfc8e@redhat.com>
Date: Sun, 17 Dec 2017 22:54:39 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8FXhrOzN=9Thiv_aGy8n=kU+E1R5R93DL3XStwQQ2MfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 12/16/2017 07:49 AM, Peter Maydell wrote:
> On 15 December 2017 at 20:37, Wei Huang <wei@redhat.com> wrote:
>> This patch adds the migration test support for aarch64. The test code,
>> which implements the same functionality as x86, is compiled into a binary
>> and booted as a kernel to qemu. Here are the design ideas:
>>
>> * We choose this -kernel design because aarch64 QEMU doesn't provide a
>>   built-in fw like x86 does. So instead of relying on a boot loader, we
>>   use -kernel approach for aarch64.
>> * The serial output is sent to PL011 directly.
>> * The physical memory base for mach-virt machine is 0x40000000. We have
>>   to change the start_address and end_address for aarch64.
>> * The downtime is changed from 0.001 to 0.1. Without this change, we saw
>>   migration stalled. This problem is still under analysis and needs to be
>>   resolved before removing RFC for this patch.
>>
>> The test code is as the following:
>>
>> .section .text
> 
> 
>>  #if defined(__linux__)
>> @@ -125,6 +125,18 @@ unsigned char bootsect[] = {
>>    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa
>>  };
>>
>> +unsigned char aarch64_kernel[] = {
>> +    0x00, 0x10, 0x38, 0xd5, 0x00, 0xf8, 0x7f, 0x92, 0x00, 0x10, 0x18, 0xd5,
>> +    0xdf, 0x3f, 0x03, 0xd5, 0x24, 0x08, 0x80, 0x52, 0x05, 0x20, 0xa1, 0xd2,
>> +    0xa4, 0x00, 0x00, 0x39, 0x06, 0x00, 0x80, 0x52, 0x03, 0xc8, 0xa8, 0xd2,
>> +    0x02, 0x02, 0xa8, 0xd2, 0x41, 0x00, 0x40, 0x39, 0x21, 0x04, 0x00, 0x11,
>> +    0x41, 0x00, 0x00, 0x39, 0x42, 0x04, 0x40, 0x91, 0x5f, 0x00, 0x03, 0xeb,
>> +    0x6b, 0xff, 0xff, 0x54, 0xc6, 0x04, 0x00, 0x11, 0xc6, 0x1c, 0x00, 0x12,
>> +    0xdf, 0x00, 0x00, 0x71, 0xc1, 0xfe, 0xff, 0x54, 0x44, 0x08, 0x80, 0x52,
>> +    0x05, 0x20, 0xa1, 0xd2, 0xa4, 0x00, 0x00, 0x39, 0xf2, 0xff, 0xff, 0x97
>> +};
>> +unsigned int aarch64_kernel_len = 96;
> 
> I'm not really a fan of this steadily increasing number of hex-encoded
> target binary blobs in the tests directory, but if we must, I
> think this would be easier to read as an array of uint32_t,
> so that each entry is one instruction word.

This make sense given that ARM has fixed-length instructions.

> 
> (If your claim is that nobody cares about the hex because
> they'll just rebuild from the source code in the commit
> message, I would suggest that that makes the source code
> the 'preferred form for modification' under the GPL...)
> 

Overall I agree with your comments. For this specific migration-test,
PPC's approach is my preferred one. But unfortunately, ARM doesn't have
a built-in firmware in QEMU to run a scripting test. So either we have
to use a per-compiled binary blob, or find a way to build this blob from
source inside QEMU. The second one might take a while to complete though.

> But I think at some point we really need to stop doing
> this and instead figure out a mechanism for building
> target code as part of the QEMU build-and-test.
> It is coming up increasingly often:
>  * code to run on the guest in tests
>  * the bios blobs (at the moment we special case
>    the x86 bios blobs and assume we can compile them
>    with the host C compiler, which is not great)
>  * for linux-user on several architectures we would like
>    to properly implement a guest VDSO
> 
> thanks
> -- PMM
> 
