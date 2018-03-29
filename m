Received: from eggs.gnu.org ([2001:4830:134:3::10]:55594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f1OSc-0007C9-H0
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 23:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1f1OSY-0001Fl-Hy
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 23:42:46 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:38988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1f1OSY-0001FN-BD
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 23:42:42 -0400
Received: by mail-pf0-x235.google.com with SMTP id c78so2336531pfj.6
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 20:42:42 -0700 (PDT)
References: <20180327091043.30220-1-xiaoguangrong@tencent.com>
	<20180327091043.30220-4-xiaoguangrong@tencent.com>
	<20180328094239.GF29554@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <ac8c2b63-90b8-11bb-f221-15fe190a89a1@gmail.com>
Date: Thu, 29 Mar 2018 11:43:07 +0800
MIME-Version: 1.0
In-Reply-To: <20180328094239.GF29554@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/10] migration: stop decompression to
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



On 03/28/2018 05:42 PM, Peter Xu wrote:
> On Tue, Mar 27, 2018 at 05:10:36PM +0800, guangrong.xiao@gmail.com wrote:
> 
> [...]
> 
>> +static int compress_threads_load_setup(void)
>> +{
>> +    int i, thread_count;
>> +
>> +    if (!migrate_use_compression()) {
>> +        return 0;
>> +    }
>> +
>> +    thread_count = migrate_decompress_threads();
>> +    decompress_threads = g_new0(QemuThread, thread_count);
>> +    decomp_param = g_new0(DecompressParam, thread_count);
>> +    qemu_mutex_init(&decomp_done_lock);
>> +    qemu_cond_init(&decomp_done_cond);
>> +    for (i = 0; i < thread_count; i++) {
>> +        if (inflateInit(&decomp_param[i].stream) != Z_OK) {
>> +            goto exit;
>> +        }
>> +        decomp_param[i].stream.opaque = &decomp_param[i];
> 
> Same question as the encoding patch here, otherwise looks good to me.

Thanks for you pointed out, will fix.

Hmm, can i treat it as your Reviewed-by for the next version?
