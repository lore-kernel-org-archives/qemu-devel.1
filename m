Received: from eggs.gnu.org ([2001:4830:134:3::10]:54091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiangyiwen@huawei.com>) id 1eGzzg-0003Em-K0
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 23:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiangyiwen@huawei.com>) id 1eGzzd-00073S-Fb
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 23:17:08 -0500
Received: from [45.249.212.32] (port=38298 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiangyiwen@huawei.com>)
	id 1eGzzd-0006xg-3f
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 23:17:05 -0500
References: <5A126CCB.3010602@huawei.com>
	<20171120111303.2db7cdd0@bahia.lab.toulouse-stg.fr.ibm.com>
From: jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5A139D5D.9050907@huawei.com>
Date: Tue, 21 Nov 2017 11:28:29 +0800
MIME-Version: 1.0
In-Reply-To: <20171120111303.2db7cdd0@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: don't ignore O_DIRECT flag in the
 9pfs server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, qemu-devel@nongnu.org, sochin.jiang@huawei.com

On 2017/11/20 18:13, Greg Kurz wrote:
> On Mon, 20 Nov 2017 13:48:59 +0800
> jiangyiwen <jiangyiwen@huawei.com> wrote:
> 
>> Now v9fs in linux has already supported O_DIRECT(v9fs_direct_IO),
>> when guest user open file with O_DIRECT flag and return success,
>> so user hopes data doesn't pass through page cache, but 9pfs in
>> qemu ignore direct disk access and use host page cache, it is not
>> match to DIRECT_IO semantic, so we should not ignore O_DIRECT in
>> 9pfs unless v9fs in linux don't support DIRECT_IO.
>>
>> And if server fs don't support O_DIRECT, user will receive -EINVAL
>> and know the filesystem don't support O_DIRECT.
>>
>> So in order to ensure semantic consistency, don't ignore direct
>> disk access in 9pfs.
>>
> 
> There are good reasons for us to ignore O_DIRECT. AFAIK, O_DIRECT requires
> the application to take care of the alignment of the buffers with either the
> logical block size of the filesystem (linux <= 2.4) or the logical block size
> of the underlying storage... I don't really see how you can achieve that since
> the linux 9p client only cares to break up requests into msize-chunks, and
> ignores alignment. ie, you're likely to not ensure semantic consistency on the
> host side anyway and linux will fallback to cached I/O.
> 
> Also, this change would silently break existing users of O_DIRECT, which isn't
> acceptable... it would require some fsdev property to enable this new behavior.
> 

Thank you very much, I understand what your mean, v9fs in linux doesn't take care
of the alignment, only split as the msize. Then there is another problem,
should v9fs support DIRECT_IO? or delete DIRECT_IO ops in v9fs?

Thanks,
Yiwen.
>> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
>> ---
>>  hw/9pfs/9p.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
>> index 52d4663..5ea01c4 100644
>> --- a/hw/9pfs/9p.c
>> +++ b/hw/9pfs/9p.c
>> @@ -155,10 +155,6 @@ static int get_dotl_openflags(V9fsState *s, int oflags)
>>       */
>>      flags = dotl_to_open_flags(oflags);
>>      flags &= ~(O_NOCTTY | O_ASYNC | O_CREAT);
>> -    /*
>> -     * Ignore direct disk access hint until the server supports it.
>> -     */
>> -    flags &= ~O_DIRECT;
>>      return flags;
>>  }
>>
> 
> 
> .
> 
