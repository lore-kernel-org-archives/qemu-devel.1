Received: from eggs.gnu.org ([2001:4830:134:3::10]:47952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1eyywJ-00063c-ID
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 08:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1eyywD-0002bc-UD
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 08:03:27 -0400
Received: from mail-it0-x233.google.com ([2607:f8b0:4001:c0b::233]:54804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1eyywD-0002ap-Nx
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 08:03:21 -0400
Received: by mail-it0-x233.google.com with SMTP id w3-v6so11027806itc.4
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 05:03:21 -0700 (PDT)
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-4-xiaoguangrong@tencent.com>
	<20180321100043.GA30634@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <48da6d2b-f5f4-a077-f282-ed52392c17f9@gmail.com>
Date: Thu, 22 Mar 2018 20:03:53 +0800
MIME-Version: 1.0
In-Reply-To: <20180321100043.GA30634@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/8] migration: support to detect
 compression and decompression errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org



On 03/21/2018 06:00 PM, Peter Xu wrote:
> On Tue, Mar 13, 2018 at 03:57:34PM +0800, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Currently the page being compressed is allowed to be updated by
>> the VM on the source QEMU, correspondingly the destination QEMU
>> just ignores the decompression error. However, we completely miss
>> the chance to catch real errors, then the VM is corrupted silently
>>
>> To make the migration more robuster, we copy the page to a buffer
>> first to avoid it being written by VM, then detect and handle the
>> errors of both compression and decompression errors properly
> 
> Not sure I missed anything important, but I'll just shoot my thoughts
> as questions (again)...
> 
> Actually this is a more general question? Say, even without
> compression, we can be sending a page that is being modified.
> 
> However, IMHO we don't need to worry that, since if that page is
> modified, we'll definitely send that page again, so the new page will
> replace the old.  So on destination side, even if decompress() failed
> on a page it'll be fine IMHO.  Though now we are copying the corrupted
> buffer.  On that point, I fully agree that we should not - maybe we
> can just drop the page entirely?
> 
> For non-compress pages, we can't detect that, so we'll copy the page
> even if corrupted.
> 
> The special part for compression would be: would the deflate() fail if
> there is concurrent update to the buffer being compressed?  And would
> that corrupt the whole compression stream, or it would only fail the
> deflate() call?

It is not the same for normal page and compressed page.

For the normal page, the dirty-log mechanism in QEMU and the infrastructure
of the network (e.g, TCP) can make sure that the modified memory will
be posted to the destination without corruption.

However, nothing can guarantee compression/decompression is BUG-free,
e,g, consider the case, in the last step, vCPUs & dirty-log are paused and
the memory is compressed and posted to destination, if there is any error
in compression/decompression, VM dies silently.
