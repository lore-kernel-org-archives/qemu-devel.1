Received: from eggs.gnu.org ([2001:4830:134:3::10]:57739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cSeRg-0005OW-Tb
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 01:37:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cSeRd-0006tu-Ry
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 01:37:40 -0500
Received: from [59.151.112.132] (port=62419 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cSeRd-0006tW-2z
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 01:37:37 -0500
References: <1483513091-30661-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<878tqfxmn4.fsf@dusky.pond.sub.org>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <cd6f5c64-79cc-085f-9065-7bc512b6f120@cn.fujitsu.com>
Date: Sun, 15 Jan 2017 14:37:31 +0800
MIME-Version: 1.0
In-Reply-To: <878tqfxmn4.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v3 0/2] block/qapi: refactor and
 optimize the qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, famz@redhat.com, danpb@redhat.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, qemu-devel@nongnu.org

Hi, Markus

At 01/13/2017 06:46 PM, Markus Armbruster wrote:
> Dou Liyang <douly.fnst@cn.fujitsu.com> writes:
>
>> Change log v2 -> v3:
>>  1. Remove the unnecessary code for the bdrv_next_node().
>>  2. Remove the change of the locking rules.
>>     Even if this change can improve the performance, but it may
>>     effect the consistency.
>>
>> For the multi-disks guest, we can use the dataplane feature to
>> hold performance does not drop, if we execute some slow monitor
>> commands, such as "info blockstats". But, without this feature,
>> How to reduce the decline in performance?
>>
>> These patches aim to refactor the qmp_query_blockstats() and
>> improve the performance by reducing the running time of it.
>>
>> There are the two jobs:
>>
>> 1 For the performance:
>>
>> 1.1 the time it takes(ns) in each time:
>> the disk numbers     | 10    | 500
>> -------------------------------------
>> before these patches | 19429 | 667722
>> after these patches  | 18536 | 627945
>>
>> 1.2 the I/O performance is degraded(%) during the monitor:
>>
>> the disk numbers     | 10    | 500
>> -------------------------------------
>> before these patches | 1.3   | 14.2
>> after these patches  | 1.0   | 11.3
>>
>> used the dd command likes this to test:
>> dd if=date_1.dat of=date_2.dat conv=fsync oflag=direct bs=1k count=100k.
>>
>> 2 refactor qmp_query_blockstats():
>>
>> From:
>>
>> +--------------+      +---------------------+
>>  | 1            |      | 4.                  |
>>  |next_query_bds|      |bdrv_query_bds_stats +---+
>>  |              |      |                     |   |
>>  +--------^-----+      +-------------^-------+   |
>>           |                          |           |
>> +---------+----------+      +--------+-------+   |
>> | 0.                 |      | 2.             |   |
>> |qmp_query_blockstats+------>bdrv_query_stats<----
>> |                    |      |                |
>> +--------------------+      +--------+-------+
>>                                      |
>>                        +-------------v-------+
>>                        | 3.                  |
>>                        |bdrv_query_blk_stats |
>>                        |                     |
>>                        +---------------------+
>>
>> To:
>>
>>                                     +--------------+
>>                                     |              |
>>                            +--------v-----------+  |
>>                        +--->  3.                |  |
>> +-------------------+  |   |bdrv_query_bds_stats+--+
>> | 1.                +--+   |                    |
>> |                   +      +--------------------+
>> |qmp_query_blockstats--+
>> |                   |  |
>> +-------------------+  |   +--------------------+
>>                        |   | 2.                 |
>>                        +--->                    |
>>                            |bdrv_query_blk_stats|
>>                            |                    |
>>                            +--------------------+
>
> Thanks for the picture, it helps.
>
> Your patches make the code easier to follow, and shorter, too.  The
> performance impact is unexpected.  But the code cleanup is worthwhile
> even without it.  Please develop this into a non-RFC patch submission.
>

OK, I understood.

Thanks,
	Liyang.
>
>
