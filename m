Received: from eggs.gnu.org ([2001:4830:134:3::10]:37229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dIRUU-0002ew-GR
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dIRUR-0001M1-BO
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:18:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dIRUR-0001LI-2Q
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:18:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v573E1X7046815
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 23:18:33 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ax4wv0bnm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 23:18:33 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Tue, 6 Jun 2017 23:18:32 -0400
References: <20170606052438.35405-1-haoqf@linux.vnet.ibm.com>
	<20170606052438.35405-2-haoqf@linux.vnet.ibm.com>
	<20170606124953.GD5448@noname.redhat.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Wed, 7 Jun 2017 11:18:11 +0800
MIME-Version: 1.0
In-Reply-To: <20170606124953.GD5448@noname.redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <a908cc58-3001-0d8a-0415-887b5cbae4e7@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qemu/migration: fix the double free
 problem on from_src_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, liujbjl@linux.vnet.ibm.com, famz@redhat.com



=D4=DA 2017/6/6 20:49, Kevin Wolf =D0=B4=B5=C0:
> Am 06.06.2017 um 07:24 hat QingFeng Hao geschrieben:
>> In load_snapshot, mis->from_src_file is freed twice, the first free is=
 by
>> qemu_fclose, the second is by migration_incoming_state_destroy and
>> it causes Illegal instruction exception. The fix is just to remove the
>> first free.
>>
>> This problem is found by qemu-iotests case 068 since commit
>> "660819b migration: shut src return path unconditionally". The error i=
s:
>> 068 1s ... - output mismatch (see 068.out.bad)
>>      --- tests/qemu-iotests/068.out	2017-05-06 01:00:26.417270437 +020=
0
>>      +++ 068.out.bad	2017-06-03 13:59:55.360274640 +0200
>>      @@ -6,6 +6,8 @@
>>       QEMU X.Y.Z monitor - type 'help' for more information
>>       (qemu) savevm 0
>>       (qemu) quit
>>      +./common.config: line 107: 242472 Illegal instruction     (core =
dumped) ( if [ -n "${QEMU_NEED_PID}" ]; then
>>      +    echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid";
>>      +fi; exec "$QEMU_PROG" $QEMU_OPTIONS "$@" )
>>       QEMU X.Y.Z monitor - type 'help' for more information
>>      -(qemu) quit
>>      -*** done
>>      +(qemu) *** done
>>
>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
> Dave, as you only gave R-b rather than merging the patch, should this b=
e
> merged through the block tree?
>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 9c320f59d0..853e14e34e 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2290,7 +2290,6 @@ int load_snapshot(const char *name, Error **errp=
)
>>  =20
>>       aio_context_acquire(aio_context);
>>       ret =3D qemu_loadvm_state(f);
>> -    qemu_fclose(f);
>>       aio_context_release(aio_context);
>>  =20
>>       migration_incoming_state_destroy();
> Did we check other callers of migration_incoming_state_destroy()?
>
> For example, qmp_xen_load_devices_state() looks suspicious, too.
Good reminder! Yes, I checked it and there is no assignment of=20
from_src_file there and f
is opened locally, so I think that qemu_fclose doesn't impact=20
migration_incoming_state_destroy.
migration_incoming_state_destroy is called in 4 places:
process_incoming_migration_bh, postcopy_ram_listen_thread,=20
qmp_xen_load_devices_state
and load_snapshot. process_incoming_migration_bh is launched by=20
process_incoming_migration_co
whose qemu_fclose is removed by commit 660819b.
For postcopy_ram_listen_thread, I didn't see where it calls qemu_fclose.
Actually to simplify the check for the problem, I just searched where=20
from_src_file
is assigned to and got 2 places: process_incoming_migration_co and=20
load_snapshot.
qemu_fclose in the first function is removed by commit 660819b, and=20
qemu_fclose in the
second is removed by this one. I think a potential risk might be opaque=20
is closed
by anywhere else than process_incoming_migration_co, but there is legacy=20
qemu_close
before commit 660819b, so the risk might be low? thanks :)
>
> I can't tell for postcopy_ram_listen_thread() - commit 660819b didn't
> seem to remove a qemu_fclose() call there, but I can't see one left
> behind either. Was the file leaked before commit 660819b or am I
> missing something?
I don't think so because loadvm_postcopy_handle_listen creates thread=20
postcopy_ram_listen_thread
and passes mis->from_src_file as its arg, which will be closed by=20
migration_incoming_state_destroy.
What confuses me is in the series function calls of=20
qemu_loadvm_state_main etc, argument f looks
to be redundant as mis already contains from_src_file which equals to f.=20
Furthermore, mis may be
also redundant as it can be got via migration_incoming_get_current. Thank=
s!
>
> Kevin
>

--=20
Regards
QingFeng Hao
