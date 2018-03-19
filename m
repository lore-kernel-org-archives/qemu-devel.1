Received: from eggs.gnu.org ([2001:4830:134:3::10]:40257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1extdj-00021K-4h
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 08:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1extdf-0002JU-Lz
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 08:11:46 -0400
Received: from mail-pl0-x22b.google.com ([2607:f8b0:400e:c01::22b]:36574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1extdf-0002Ij-Fd
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 08:11:43 -0400
Received: by mail-pl0-x22b.google.com with SMTP id 61-v6so10086848plf.3
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 05:11:43 -0700 (PDT)
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-3-xiaoguangrong@tencent.com>
	<20180315110350.GB3062@work-vm>
	<41a1b36c-2bb6-bc11-f59e-973e730d8c28@gmail.com>
	<20180319105405.GB3206@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <52d3a6a1-69ec-4b6d-5760-8f60b24a0ba1@gmail.com>
Date: Mon, 19 Mar 2018 20:11:30 +0800
MIME-Version: 1.0
In-Reply-To: <20180319105405.GB3206@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/8] migration: stop allocating and freeing
 memory frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: quintela@redhat.com, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org



On 03/19/2018 06:54 PM, Dr. David Alan Gilbert wrote:

>>>> +    return 0;
>>>> +exit:
>>>> +    compress_threads_load_cleanup();
>>>
>>> I don't think this is safe; if inflateInit(..) fails in not-the-last
>>> thread, compress_threads_load_cleanup() will try and destroy all the
>>> mutex's and condition variables, even though they've not yet all been
>>> _init'd.
>>>
>>
>> That is exactly why we used 'opaque', please see more below...
>>
>>> However, other than that I think the patch is OK; a chat with Dan
>>> Berrange has convinced me this probably doesn't affect the stream
>>> format, so that's OK.
>>>
>>> One thing I would like is a comment as to how the 'opaque' field is
>>> being used; I don't think I quite understand what you're doing there.
>>
>> The zlib.h file says that:
>> "     The opaque value provided by the application will be passed as the first
>>     parameter for calls of zalloc and zfree.  This can be useful for custom
>>     memory management.  The compression library attaches no meaning to the
>>     opaque value."
>> So we can use it to store our private data.
>>
>> Here, we use it as a indicator which shows if the thread is properly init'd
>> or not. If inflateInit() is successful we will set it to non-NULL, otherwise
>> it is NULL, so that the cleanup path can figure out the first thread failed
>> to do inflateInit().
> 
> OK, so I think you just need to add a comment to explain that. Put it
> above the 'if (!decomp_param[i].stream.opaque) {' in
> compress_threads_load_cleanup  so it'll be easy to understand.

Yes, indeed, i will do.

Thanks!
