Received: from eggs.gnu.org ([209.51.188.92]:52456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gizby-0000ES-Or
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gizbx-0002yQ-NK
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:36:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gizbx-0002wa-HF
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:36:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so22168008wrs.8
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:36:53 -0800 (PST)
References: <20190111191401.18317-1-armbru@redhat.com>
	<20190111191401.18317-2-armbru@redhat.com>
	<38d3856b-b763-3253-a6a8-10ea489ac0fa@janustech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <435c327e-52d6-325c-0272-81378b93b935@redhat.com>
Date: Mon, 14 Jan 2019 11:36:51 +0100
MIME-Version: 1.0
In-Reply-To: <38d3856b-b763-3253-a6a8-10ea489ac0fa@janustech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/1] block: Eliminate the S_1KiB, S_2KiB,
 ... macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

On 1/13/19 10:41 AM, Leonid Bloch wrote:
> On 1/11/19 9:14 PM, Markus Armbruster wrote:
>> We define 54 macros for the powers of two >= 1024.  We use six, in six
>> macro definitions.  Four of them could just as well use the common MiB
>> macro, so do that.  The remaining two can't, because they get passed
>> to stringify.  Replace the macro by the literal number there.
>> Slightly harder to read in one instance (1048576 vs. S_1MiB), so add a
>> comment there.  The other instance is a wash: 65536 vs S_64KiB.  65536
>> has been good enough for more than seven years there.
>>
>> This effectively reverts commit 540b8492618 and 1240ac558d3.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   block/qcow2.h        | 10 +++---
>>   block/vdi.c          |  3 +-
>>   include/qemu/units.h | 73 --------------------------------------------
>>   3 files changed, 7 insertions(+), 79 deletions(-)
>>
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index a98d24500b..2380cbfb41 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -50,11 +50,11 @@
>>   
>>   /* 8 MB refcount table is enough for 2 PB images at 64k cluster size
>>    * (128 GB for 512 byte clusters, 2 EB for 2 MB clusters) */
>> -#define QCOW_MAX_REFTABLE_SIZE S_8MiB
>> +#define QCOW_MAX_REFTABLE_SIZE (8 * MiB)
>>   
>>   /* 32 MB L1 table is enough for 2 PB images at 64k cluster size
>>    * (128 GB for 512 byte clusters, 2 EB for 2 MB clusters) */
>> -#define QCOW_MAX_L1_SIZE S_32MiB
>> +#define QCOW_MAX_L1_SIZE (32 * MiB)
>>   
>>   /* Allow for an average of 1k per snapshot table entry, should be plenty of
>>    * space for snapshot names and IDs */
>> @@ -81,15 +81,15 @@
>>   #define MIN_REFCOUNT_CACHE_SIZE 4 /* clusters */
>>   
>>   #ifdef CONFIG_LINUX
>> -#define DEFAULT_L2_CACHE_MAX_SIZE S_32MiB
>> +#define DEFAULT_L2_CACHE_MAX_SIZE (32 * MiB)
>>   #define DEFAULT_CACHE_CLEAN_INTERVAL 600  /* seconds */
>>   #else
>> -#define DEFAULT_L2_CACHE_MAX_SIZE S_8MiB
>> +#define DEFAULT_L2_CACHE_MAX_SIZE (8 * MiB)
>>   /* Cache clean interval is currently available only on Linux, so must be 0 */
>>   #define DEFAULT_CACHE_CLEAN_INTERVAL 0
>>   #endif
>>   
>> -#define DEFAULT_CLUSTER_SIZE S_64KiB
>> +#define DEFAULT_CLUSTER_SIZE 65536
> 
> /* Note: can't use 64 * KiB here, because it's passed to stringify() */

Good idea.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Otherwise fine with me. The other solutions (including mine) indeed seem 
> overengineered compared to this.
> 
> Leonid.
> 
>>   
>>   #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
>>   #define QCOW2_OPT_DISCARD_REQUEST "pass-discard-request"
>> diff --git a/block/vdi.c b/block/vdi.c
>> index 2380daa583..bf1d19dd68 100644
>> --- a/block/vdi.c
>> +++ b/block/vdi.c
>> @@ -85,7 +85,8 @@
>>   #define BLOCK_OPT_STATIC "static"
>>   
>>   #define SECTOR_SIZE 512
>> -#define DEFAULT_CLUSTER_SIZE S_1MiB
>> +#define DEFAULT_CLUSTER_SIZE 1048576
>> +/* Note: can't use 1 * MiB, because it's passed to stringify() */
>>   
>>   #if defined(CONFIG_VDI_DEBUG)
>>   #define VDI_DEBUG 1
>> diff --git a/include/qemu/units.h b/include/qemu/units.h
>> index 1c959d182e..692db3fbb2 100644
>> --- a/include/qemu/units.h
>> +++ b/include/qemu/units.h
>> @@ -17,77 +17,4 @@
>>   #define PiB     (INT64_C(1) << 50)
>>   #define EiB     (INT64_C(1) << 60)
>>   
>> -/*
>> - * The following lookup table is intended to be used when a literal string of
>> - * the number of bytes is required (for example if it needs to be stringified).
>> - * It can also be used for generic shortcuts of power-of-two sizes.
>> - * This table is generated using the AWK script below:
>> - *
>> - *  BEGIN {
>> - *      suffix="KMGTPE";
>> - *      for(i=10; i<64; i++) {
>> - *          val=2**i;
>> - *          s=substr(suffix, int(i/10), 1);
>> - *          n=2**(i%10);
>> - *          pad=21-int(log(n)/log(10));
>> - *          printf("#define S_%d%siB %*d\n", n, s, pad, val);
>> - *      }
>> - *  }
>> - */
>> -
>> -#define S_1KiB                  1024
>> -#define S_2KiB                  2048
>> -#define S_4KiB                  4096
>> -#define S_8KiB                  8192
>> -#define S_16KiB                16384
>> -#define S_32KiB                32768
>> -#define S_64KiB                65536
>> -#define S_128KiB              131072
>> -#define S_256KiB              262144
>> -#define S_512KiB              524288
>> -#define S_1MiB               1048576
>> -#define S_2MiB               2097152
>> -#define S_4MiB               4194304
>> -#define S_8MiB               8388608
>> -#define S_16MiB             16777216
>> -#define S_32MiB             33554432
>> -#define S_64MiB             67108864
>> -#define S_128MiB           134217728
>> -#define S_256MiB           268435456
>> -#define S_512MiB           536870912
>> -#define S_1GiB            1073741824
>> -#define S_2GiB            2147483648
>> -#define S_4GiB            4294967296
>> -#define S_8GiB            8589934592
>> -#define S_16GiB          17179869184
>> -#define S_32GiB          34359738368
>> -#define S_64GiB          68719476736
>> -#define S_128GiB        137438953472
>> -#define S_256GiB        274877906944
>> -#define S_512GiB        549755813888
>> -#define S_1TiB         1099511627776
>> -#define S_2TiB         2199023255552
>> -#define S_4TiB         4398046511104
>> -#define S_8TiB         8796093022208
>> -#define S_16TiB       17592186044416
>> -#define S_32TiB       35184372088832
>> -#define S_64TiB       70368744177664
>> -#define S_128TiB     140737488355328
>> -#define S_256TiB     281474976710656
>> -#define S_512TiB     562949953421312
>> -#define S_1PiB      1125899906842624
>> -#define S_2PiB      2251799813685248
>> -#define S_4PiB      4503599627370496
>> -#define S_8PiB      9007199254740992
>> -#define S_16PiB    18014398509481984
>> -#define S_32PiB    36028797018963968
>> -#define S_64PiB    72057594037927936
>> -#define S_128PiB  144115188075855872
>> -#define S_256PiB  288230376151711744
>> -#define S_512PiB  576460752303423488
>> -#define S_1EiB   1152921504606846976
>> -#define S_2EiB   2305843009213693952
>> -#define S_4EiB   4611686018427387904
>> -#define S_8EiB   9223372036854775808
>> -
>>   #endif
>>

Thanks Markus, Eric and Leonid for this cleanup!

I'm sorry all of you wasted so many ressources here.

Phil.
