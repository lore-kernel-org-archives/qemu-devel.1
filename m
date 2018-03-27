Received: from eggs.gnu.org ([2001:4830:134:3::10]:58816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f0oVp-0002Wb-SI
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f0oVk-0006l9-8T
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:19:41 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:42009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f0oVk-0006kb-0o
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:19:36 -0400
Received: by mail-pg0-x229.google.com with SMTP id f10so8370878pgs.9
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 06:19:35 -0700 (PDT)
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-4-xiaoguangrong@tencent.com>
	<20180321100043.GA30634@xz-mi>
	<48da6d2b-f5f4-a077-f282-ed52392c17f9@gmail.com>
	<20180327072204.GJ17789@xz-mi>
	<51b59c4c-b153-e711-d78a-8611780b2874@gmail.com>
	<20180327111717.GN17789@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <19870756-df8d-a2ef-6518-cf7791594824@gmail.com>
Date: Tue, 27 Mar 2018 09:20:01 +0800
MIME-Version: 1.0
In-Reply-To: <20180327111717.GN17789@xz-mi>
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



On 03/27/2018 07:17 PM, Peter Xu wrote:
> On Tue, Mar 27, 2018 at 03:42:32AM +0800, Xiao Guangrong wrote:
> 
> [...]
> 
>>> It'll be understandable to me if the problem is that the compress()
>>> API does not allow the input buffer to be changed during the whole
>>> period of the call.  If that is a must, this patch for sure helps.
>>
>> Yes, that is exactly what i want to say. :)
> 
> So I think now I know what this patch is for. :) And yeah, it makes
> sense.
> 
> Though another question would be: if the buffer is updated during
> compress() and compress() returned error, would that pollute the whole
> z_stream or it only fails the compress() call?
> 

I guess deflateReset() can recover everything, i.e, keep z_stream as
it is init'ed by deflate_init().

> (Same question applies to decompress().)
> 
> If it's only a compress() error and it won't pollute z_stream (or say,
> it can be recovered after a deflateReset() and then we can continue to
> call deflate() without problem), then we'll actually have two
> alternatives to solve this "buffer update" issue:
> 
> 1. Use the approach of current patch: we copy the page every time, so
>     deflate() never fails because update never happens.  But it's slow
>     since we copy the pages every time.
> 
> 2. Use the old approach, and when compress() fail, we just ignore that
>     page (since now we know that error _must_ be caused by page update,
>     then we are 100% sure that we'll send that page again so it'll be
>     perfectly fine).
> 

No, we can't make the assumption that "error _must_ be caused by page update".
No document/ABI about compress/decompress promised it. :)

Thanks!
