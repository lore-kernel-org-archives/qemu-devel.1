Received: from eggs.gnu.org ([2001:4830:134:3::10]:36872)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cgqFq-0001cR-JP
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cgqFl-0001ZO-C4
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:04:06 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:36749 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cgqFl-0001ZG-3g
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:04:01 -0500
References: <1487680191-13096-1-git-send-email-pl@kamp.de>
	<20170222153111.GF10201@stefanha-x1.localdomain>
From: Peter Lieven <pl@kamp.de>
Message-ID: <2fdeb862-0362-f5d2-a5a5-37f1254262ca@kamp.de>
Date: Thu, 23 Feb 2017 11:03:56 +0100
MIME-Version: 1.0
In-Reply-To: <20170222153111.GF10201@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, ct@flyingcircus.io, mreitz@redhat.com, famz@redhat.com, eblake@redhat.com

Am 22.02.2017 um 16:31 schrieb Stefan Hajnoczi:
> On Tue, Feb 21, 2017 at 01:29:51PM +0100, Peter Lieven wrote:
>> the convert process is currently completely implemented with sync operations.
>> That means it reads one buffer and then writes it. No parallelism and each sync
>> request takes as long as it takes until it is completed.
>>
>> This can be a big performance hit when the convert process reads and writes
>> to devices which do not benefit from kernel readahead or pagecache.
>> In our environment we heavily have the following two use cases when using
>> qemu-img convert.
>>
>> a) reading from NFS and writing to iSCSI for deploying templates
>> b) reading from iSCSI and writing to NFS for backups
>>
>> In both processes we use libiscsi and libnfs so we have no kernel cache.
>>
>> This patch changes the convert process to work with parallel running coroutines
>> which can significantly improve performance for network storage devices:
>>
>> qemu-img (master)
>>   nfs -> iscsi 22.8 secs
>>   nfs -> ram   11.7 secs
>>   ram -> iscsi 12.3 secs
>>
>> qemu-img-async (8 coroutines, in-order write disabled)
>>   nfs -> iscsi 11.0 secs
>>   nfs -> ram   10.4 secs
>>   ram -> iscsi  9.0 secs
>>
>> This patches introduces 2 new cmdline parameters. The -m parameter to specify
>> the number of coroutines running in parallel (defaults to 8). And the -W paremeter to
>> allow qemu-img to write to the target out of order rather than sequential. This improves
>> performance as the writes do not have to wait for each other to complete.
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>     RFC->V1: - add documentation
>>              - add missing coroutine_fn annotation [Stefan]
>>              - add a comment why it is safe to call coroutine_enter [Stefan]
>>              - check -m paramater for values < 1 [Stefan]
>>              - disallow -W parameter with compression [Stefan]
>>
>> RFC V3->V4: - avoid to prepare a request queue upfront [Kevin]
>>              - do not ignore the BLK_BACKING_FILE status [Kevin]
>>              - redesign the interface to the read and write routines [Kevin]
>>      
>> RFC V2->V3: - updated stats in the commit msg from a host with a better network card
>>              - only wake up the coroutine that is acutally waiting for a write to complete.
>>                this was not only overhead, but also breaking at least linux AIO.
>>              - fix coding style complaints
>>              - rename some variables and structs
>>      
>> RFC V1->V2: - using coroutine as worker "threads". [Max]
>>              - keeping the request queue as otherwise it happens
>>                that we wait on BLK_ZERO chunks while keeping the write order.
>>                it also avoids redundant calls to get_block_status and helps
>>                to skip some conditions for fully allocated imaged (!s->min_sparse)
>>
>>   qemu-img-cmds.hx |   4 +-
>>   qemu-img.c       | 276 ++++++++++++++++++++++++++++++++++++++++---------------
>>   qemu-img.texi    |  16 +++-
>>   3 files changed, 220 insertions(+), 76 deletions(-)
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>
>> @@ -326,6 +332,14 @@ skipped. This is useful for formats such as @code{rbd} if the target
>>   volume has already been created with site specific options that cannot
>>   be supplied through qemu-img.
>>   
>> +With option @code{-W} specified, it is allowed to write out of order to the target.
>> +This is option improves performance, but is only recommened for preallocated devices
> Minor nit.  Suggested rewording:
>
> Out of order writes can be enabled with @code{-W} to improve
> performance.  This is only recommended for preallocated devices

Can whoever picks this up change this please?
If I need to send a V2 I will change that paragraph.

Thank you,
Peter
