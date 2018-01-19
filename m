Received: from eggs.gnu.org ([2001:4830:134:3::10]:40207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecUxd-0002TY-P3
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 06:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecUxY-0000MO-Pq
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 06:35:53 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ecUxY-0000Lz-Jz
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 06:35:48 -0500
Received: by mail-wr0-f194.google.com with SMTP id 36so1308854wrh.1
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 03:35:48 -0800 (PST)
References: <20170709170614.24967-1-peter.maydell@linaro.org>
	<20170728125446.GE3983@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f6911ff-bc2e-d32d-6516-ec737ebf4703@redhat.com>
Date: Fri, 19 Jan 2018 12:35:43 +0100
MIME-Version: 1.0
In-Reply-To: <20170728125446.GE3983@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/vmdk: Report failures
 in vmdk_read_cid()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, patches@linaro.org

On 28/07/2017 14:54, Kevin Wolf wrote:
> Am 09.07.2017 um 19:06 hat Peter Maydell geschrieben:
>> The function vmdk_read_cid() can fail if the read on the underlying
>> block device fails, or if there's a format error in the VMDK file.
>> However its API doesn't provide a mechanism to report these errors,
>> and in some cases we were returning a CID of 0 and in some cases a
>> CID of 0xffffffff, either of which might potentially be valid values.
>>
>> Change the function to return 0 on success or a negative errno, and
>> return the CID via a uint32_t* argument. Update the callsites to
>> handle and propagate the error appropriately.
>>
>> This fixes in passing a Coverity-spotted issue (CID 1350038) where
>> we weren't checking the return value from sscanf().
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Fam, this is the commit that introduced the qemu-iotests 059 failure for
> vmdk. I think what's happening is that we use an image produced by a
> fuzzer, and with the additional checks introduced in this patch, we now
> fail earlier and don't test the condition any more that we wanted to
> test.
> 
> So do we need a new version of sample_images/afl9.vmdk.bz2 that has a
> valid CID?

This has never been fixed, has it?  I still see the failure.

Paolo
