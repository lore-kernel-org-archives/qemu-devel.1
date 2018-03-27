Received: from eggs.gnu.org ([2001:4830:134:3::10]:58280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f14oO-0003Dy-FZ
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 02:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f14oK-0002oj-75
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 02:43:56 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:37538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f14oK-0002ob-2E
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 02:43:52 -0400
Received: by mail-io0-x243.google.com with SMTP id y128so2200994iod.4
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 23:43:51 -0700 (PDT)
References: <20180328030351.GU17789@xz-mi> <201803281208196040484@zte.com.cn>
	<20180328042003.GB29554@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <acb5360c-75ac-2ae3-0e66-ff2adcbfb244@gmail.com>
Date: Wed, 28 Mar 2018 02:44:21 +0800
MIME-Version: 1.0
In-Reply-To: <20180328042003.GB29554@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/8] migration: support todetectcompression
 and decompression errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, jiang.biao2@zte.com.cn
Cc: kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com, xiaoguangrong@tencent.com, qemu-devel@nongnu.org, pbonzini@redhat.com



On 03/28/2018 12:20 PM, Peter Xu wrote:
> On Wed, Mar 28, 2018 at 12:08:19PM +0800, jiang.biao2@zte.com.cn wrote:
>>>
>>> On Tue, Mar 27, 2018 at 10:35:29PM +0800, Xiao Guangrong wrote:
>>>
>>>>>> No, we can't make the assumption that "error _must_ be caused by page update".
>>>>>> No document/ABI about compress/decompress promised it. :)
>>>
>>> Indeed, I found no good documents about below errors that jiang.biao
>>> pointed out.
>> Hi, Peter
>> The description about the errors comes from here,
>> http://www.zlib.net/manual.html
>> And about the error codes returned by inflate(), they are described as，
>> ** inflate() returns
>> Z_OK if some progress has been made (more input processed or more output produced),
>> Z_STREAM_END if the end of the compressed data has been reached and all uncompressed output has been produced,
>> Z_NEED_DICT if a preset dictionary is needed at this point,
>> Z_DATA_ERROR if the input data was corrupted (input stream not conforming to the zlib format or incorrect check value, in which case strm->msg points to a string with a more specific error),
>> Z_STREAM_ERROR if the stream structure was inconsistent (for example next_in or next_out was Z_NULL, or the state was inadvertently written over by the application),
>> Z_MEM_ERROR if there was not enough memory,
>> Z_BUF_ERROR if no progress was possible or if there was not enough room in the output buffer when Z_FINISH is used. ...
>> **
> 
> Ah yes.  My bad to be so uncareful. :)
> 
>> According to the above description, the error caused by page update looks
>> more like tend to return Z_DATA_ERROR, but I do not have env to verify that. :)

No, still lack info to confirm the case of compressing the data being
updated is the only one to return Z_DATA_ERROR. And nothing provided
that no other error condition causes data corrupted will be squeezed
into this error code.

>> As I understand it, the real compress/decompress error cases other than that
>> caused by page update should be rare, maybe the error code is enough to
>> distinguish those if we can verify the the error codes returned by page update
>> and other silent failures by test. If so, we can cut the cost of memcpy.

Please note, compare with other operations, e.g, compression, detect zero page,
etc., memcpy() is not a hot function at all.

>> If not, I agree with Guangrong's idea too. I never read the zlib code and all my
>> information comes from the manual, so if anything inaccurate, pls ignore my
>> option. :)
> 
> So I suppose all of us know that alternative now, we just need a solid
> way to confirm the uncertainty.  I'll leave this to Guangrong.

Yes, i still prefer to memcpy() to make it safe enough to protect our production
unless we get enough certainty to figure out the error conditions.

Thanks!
