Received: from eggs.gnu.org ([2001:4830:134:3::10]:57820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dI4n5-0007VT-C9
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 23:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dI4n0-0008MJ-EP
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 23:04:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58219
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dI4n0-0008Le-87
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 23:04:14 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5633dwb010367
	for <qemu-devel@nongnu.org>; Mon, 5 Jun 2017 23:04:13 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2awm22g8bm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 23:04:13 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Mon, 5 Jun 2017 23:04:12 -0400
References: <20170605104851.61818-1-haoqf@linux.vnet.ibm.com>
	<20170605104851.61818-2-haoqf@linux.vnet.ibm.com>
	<20170605110809.GA2666@work-vm>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Tue, 6 Jun 2017 11:03:55 +0800
MIME-Version: 1.0
In-Reply-To: <20170605110809.GA2666@work-vm>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <91250a70-04ac-dfbc-4ab3-092cb499e502@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] qemu/migration: fix the double free
 problem on from_src_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, liujbjl@linux.vnet.ibm.com, peterx@redhat.com, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com



=D4=DA 2017/6/5 19:08, Dr. David Alan Gilbert =D0=B4=B5=C0:
> * QingFeng Hao (haoqf@linux.vnet.ibm.com) wrote:
>> In load_vmstate, mis->from_src_file is freed twice, the first free is =
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
>> ---
>>   migration/savevm.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
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
> Thanks!
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Thanks David!
>
>>  =20
>>       migration_incoming_state_destroy();
>> --=20
>> 2.11.2
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>

--=20
Regards
QingFeng Hao
