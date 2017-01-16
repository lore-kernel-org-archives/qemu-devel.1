Received: from eggs.gnu.org ([2001:4830:134:3::10]:39954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cT7OH-0002jc-Hf
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cT7OD-0001cW-Fc
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:32:05 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cT7OD-0001cK-7G
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:32:01 -0500
Received: by mail-lf0-x241.google.com with SMTP id v186so12647037lfa.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 05:32:01 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-11-pbonzini@redhat.com>
	<20170116130702.GG14226@lemon.Home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <609935a2-9a35-ac2f-f484-a0936d0fd642@redhat.com>
Date: Mon, 16 Jan 2017 14:32:00 +0100
MIME-Version: 1.0
In-Reply-To: <20170116130702.GG14226@lemon.Home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/16] block: explicitly acquire aiocontext
 in timers that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com



On 16/01/2017 14:07, Fam Zheng wrote:
> On Fri, 01/13 14:17, Paolo Bonzini wrote:
>> diff --git a/block/qed.c b/block/qed.c
>> index 7f1c508..a21d025 100644
>> --- a/block/qed.c
>> +++ b/block/qed.c
>> @@ -345,10 +345,22 @@ static void qed_need_check_timer_cb(void *opaque)
>>  
>>      trace_qed_need_check_timer_cb(s);
>>  
>> +    qed_acquire(s);
>>      qed_plug_allocating_write_reqs(s);
>>  
>>      /* Ensure writes are on disk before clearing flag */
>>      bdrv_aio_flush(s->bs->file->bs, qed_clear_need_check, s);
>> +    qed_release(s);
>> +}
>> +
>> +void qed_acquire(BDRVQEDState *s)
>> +{
>> +    aio_context_acquire(bdrv_get_aio_context(s->bs));
>> +}
>> +
>> +void qed_release(BDRVQEDState *s)
>> +{
>> +    aio_context_release(bdrv_get_aio_context(s->bs));
>>  }
>>  
>>  static void qed_start_need_check_timer(BDRVQEDState *s)
>> diff --git a/block/qed.h b/block/qed.h
>> index 9676ab9..ce8c314 100644
>> --- a/block/qed.h
>> +++ b/block/qed.h
>> @@ -198,6 +198,9 @@ enum {
>>   */
>>  typedef void QEDFindClusterFunc(void *opaque, int ret, uint64_t offset, size_t len);
>>  
>> +void qed_acquire(BDRVQEDState *s);
>> +void qed_release(BDRVQEDState *s);
>> +
> 
> Why cannot these be local (static) functions, in block/qed.c?

Patch 13 uses them elsewhere.  Should I put them in a separate patch?

Paolo

>>  /**
>>   * Generic callback for chaining async callbacks
>>   */
> 
> Fam
> 
> 
