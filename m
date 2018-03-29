Received: from eggs.gnu.org ([2001:4830:134:3::10]:55420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f1ORV-0006X8-K7
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 23:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f1ORR-0008Uj-N5
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 23:41:37 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:46701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f1ORR-0008TP-GE
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 23:41:33 -0400
Received: by mail-pg0-x243.google.com with SMTP id t12so2217756pgp.13
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 20:41:33 -0700 (PDT)
References: <20180327091043.30220-1-xiaoguangrong@tencent.com>
	<20180327091043.30220-3-xiaoguangrong@tencent.com>
	<20180328092544.GE29554@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <5ce3a930-dc29-5aeb-58d4-b4b47bd2b14e@gmail.com>
Date: Thu, 29 Mar 2018 11:41:58 +0800
MIME-Version: 1.0
In-Reply-To: <20180328092544.GE29554@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/10] migration: stop compression to
 allocate and free memory frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 03/28/2018 05:25 PM, Peter Xu wrote:
> On Tue, Mar 27, 2018 at 05:10:35PM +0800, guangrong.xiao@gmail.com wrote:
> 
> [...]
> 
>> @@ -357,10 +358,20 @@ static void compress_threads_save_cleanup(void)
>>       terminate_compression_threads();
>>       thread_count = migrate_compress_threads();
>>       for (i = 0; i < thread_count; i++) {
>> +        /*
>> +         * stream.opaque can be used to store private data, we use it
>> +         * as a indicator which shows if the thread is properly init'd
>> +         * or not
>> +         */
>> +        if (!comp_param[i].stream.opaque) {
>> +            break;
>> +        }
> 
> How about using comp_param[i].file?  The opaque seems to be hiding
> deeper, and...
> 

Yes, indeed, good suggestion.

>>           qemu_thread_join(compress_threads + i);
>>           qemu_fclose(comp_param[i].file);
>>           qemu_mutex_destroy(&comp_param[i].mutex);
>>           qemu_cond_destroy(&comp_param[i].cond);
>> +        deflateEnd(&comp_param[i].stream);
>> +        comp_param[i].stream.opaque = NULL;
>>       }
>>       qemu_mutex_destroy(&comp_done_lock);
>>       qemu_cond_destroy(&comp_done_cond);
>> @@ -370,12 +381,12 @@ static void compress_threads_save_cleanup(void)
>>       comp_param = NULL;
>>   }
>>   
>> -static void compress_threads_save_setup(void)
>> +static int compress_threads_save_setup(void)
>>   {
>>       int i, thread_count;
>>   
>>       if (!migrate_use_compression()) {
>> -        return;
>> +        return 0;
>>       }
>>       thread_count = migrate_compress_threads();
>>       compress_threads = g_new0(QemuThread, thread_count);
>> @@ -383,6 +394,12 @@ static void compress_threads_save_setup(void)
>>       qemu_cond_init(&comp_done_cond);
>>       qemu_mutex_init(&comp_done_lock);
>>       for (i = 0; i < thread_count; i++) {
>> +        if (deflateInit(&comp_param[i].stream,
>> +                           migrate_compress_level()) != Z_OK) {
> 
> (indent issue)
> 

Will fix.

>> +            goto exit;
>> +        }
>> +        comp_param[i].stream.opaque = &comp_param[i];
> 
> ...here from document:
> 
>          ZEXTERN int ZEXPORT deflateInit OF((z_streamp strm, int level));
> 
>          Initializes the internal stream state for compression. The
>          fields zalloc, zfree and opaque must be initialized before by
>          the caller. If zalloc and zfree are set to Z_NULL, deflateInit
>          updates them to use default allocation functions.
> 
> So shall we init opaque first?  Otherwise looks good to me.

No, opaque need to be init-ed only if zalloc and zfree are specified, it
is not the case in this patch.
