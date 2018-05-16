Received: from eggs.gnu.org ([2001:4830:134:3::10]:38567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fIvRN-0003Zj-DK
	for qemu-devel@nongnu.org; Wed, 16 May 2018 08:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fIvRK-0005xh-Od
	for qemu-devel@nongnu.org; Wed, 16 May 2018 08:21:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51454 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fIvRK-0005x9-JF
	for qemu-devel@nongnu.org; Wed, 16 May 2018 08:21:54 -0400
References: <20180514165424.12884-1-zhangckid@gmail.com>
	<20180516111828.GD2531@work-vm>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2ce43efb-9fb3-c091-a444-3b004d888ada@redhat.com>
Date: Wed, 16 May 2018 20:21:47 +0800
MIME-Version: 1.0
In-Reply-To: <20180516111828.GD2531@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V7 RESEND 00/17] COLO: integrate colo frame
 with block replication and COLO proxy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>



On 2018=E5=B9=B405=E6=9C=8816=E6=97=A5 19:18, Dr. David Alan Gilbert wrot=
e:
> Hi Jason,
>    Patches 1,2,3,14,15 seem mostly networky to me; can you have a look?
>
> Dave

Sure, will review.

Thanks

>
> * Zhang Chen (zhangckid@gmail.com) wrote:
>> The RESEND version just fix code style in patch 11/17.
>>
>> Hi~ All~
>>
>> COLO Frame, block replication and COLO proxy(colo-compare,filter-mirro=
r,
>> filter-redirector,filter-rewriter) have been exist in qemu
>> for long time, it's time to integrate these three parts to make COLO r=
eally works.
>>
>> In this series, we have some optimizations for COLO frame, including s=
eparating the
>> process of saving ram and device state, using an COLO_EXIT event to no=
tify users that
>> VM exits COLO, for these parts, most of them have been reviewed long t=
ime ago in old version,
>> but since this series have just rebased on upstream which had merged a=
 new series of migration,
>> parts of pathes in this series deserve review again.
>>
>> We use notifier/callback method for COLO compare to notify COLO frame =
about
>> net packets inconsistent event, and add a handle_event method for NetF=
ilterClass to
>> help COLO frame to notify filters and colo-compare about checkpoint/fa=
ilover event,
>> it is flexible.
>>
>> For the neweset version, please refer to:
>> https://github.com/zhangckid/qemu/tree/qemu-colo-18may1-rebase
>>
>> Please review, thanks.
>>
>> V7:
>>   - Addressed Markus's comments in 11/17.
>>   - Rebased on upstream.
>>
>> V6:
>>   - Addressed Eric Blake's comments, use the enum to feedback in patch=
 11/17.
>>   - Fixed QAPI command separator problem in patch 11/17.
>>
>>
>> Zhang Chen (12):
>>    filter-rewriter: fix memory leak for connection in
>>      connection_track_table
>>    colo-compare: implement the process of checkpoint
>>    colo-compare: use notifier to notify packets comparing result
>>    COLO: integrate colo compare with colo frame
>>    COLO: Add block replication into colo process
>>    COLO: Remove colo_state migration struct
>>    COLO: Load dirty pages into SVM's RAM cache firstly
>>    ram/COLO: Record the dirty pages that SVM received
>>    COLO: Flush memory data from ram cache
>>    qapi: Add new command to query colo status
>>    filter: Add handle_event method for NetFilterClass
>>    filter-rewriter: handle checkpoint and failover event
>>
>> zhanghailiang (5):
>>    qmp event: Add COLO_EXIT event to notify users while exited COLO
>>    savevm: split the process of different stages for loadvm/savevm
>>    COLO: flush host dirty ram from cache
>>    COLO: notify net filters about checkpoint/failover event
>>    COLO: quick failover process by kick COLO thread
>>
>>   include/exec/ram_addr.h  |   1 +
>>   include/migration/colo.h |  11 +-
>>   include/net/filter.h     |   5 +
>>   migration/Makefile.objs  |   2 +-
>>   migration/colo-comm.c    |  76 --------------
>>   migration/colo.c         | 219 +++++++++++++++++++++++++++++++++++++=
--
>>   migration/migration.c    |  38 ++++++-
>>   migration/ram.c          | 183 +++++++++++++++++++++++++++++++-
>>   migration/ram.h          |   4 +
>>   migration/savevm.c       |  55 ++++++++--
>>   migration/savevm.h       |   5 +
>>   migration/trace-events   |   3 +
>>   net/colo-compare.c       | 108 +++++++++++++++++--
>>   net/colo-compare.h       |  24 +++++
>>   net/colo.h               |   4 +
>>   net/filter-rewriter.c    | 109 +++++++++++++++++--
>>   net/filter.c             |  17 +++
>>   net/net.c                |  28 +++++
>>   qapi/migration.json      |  70 +++++++++++++
>>   vl.c                     |   2 -
>>   20 files changed, 846 insertions(+), 118 deletions(-)
>>   delete mode 100644 migration/colo-comm.c
>>   create mode 100644 net/colo-compare.h
>>
>> --=20
>> 2.17.0
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
