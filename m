Received: from eggs.gnu.org ([2001:4830:134:3::10]:38565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1f0fMz-0007sH-Dj
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1f0fMw-0001c1-AN
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:33:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1f0fMw-0001ba-1U
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:33:54 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2R3XjBW019806
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 23:33:53 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gycbabjne-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 23:33:52 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Mon, 26 Mar 2018 23:33:51 -0400
References: <20180323034356.72130-1-haoqf@linux.vnet.ibm.com>
	<20180323034356.72130-2-haoqf@linux.vnet.ibm.com>
	<20180326102919.GB5267@localhost.localdomain>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 11:33:33 +0800
MIME-Version: 1.0
In-Reply-To: <20180326102919.GB5267@localhost.localdomain>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <94a4e9f3-e4af-4060-b2b5-bb0be25f46b6@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] iotests: fix test case 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: famz@redhat.com, qemu-block@nongnu.org, jcody@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, stefanha@redhat.com



=D4=DA 2018/3/26 18:29, Kevin Wolf =D0=B4=B5=C0:
> Am 23.03.2018 um 04:43 hat QingFeng Hao geschrieben:
>> Test case 185 failed since commit 4486e89c219 --- "vl: introduce vm_sh=
utdown()".
>> It's because of the newly introduced function vm_shutdown calls bdrv_d=
rain_all,
>> which is called later by bdrv_close_all. bdrv_drain_all resumes the jo=
bs
>> that doubles the speed and offset is doubled.
>> Some jobs' status are changed as well.
>>
>> The fix is to not resume the jobs that are already yielded and also ch=
ange
>> 185.out accordingly.
>>
>> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>=20
> Stefan already commented on the fix itself, but I want to add two more
> points:
>=20
> Please change your subject line. "iotests: fix test case 185" means tha=
t
> you are fixing the test case, not qemu code that makes the test case
> fail. The subject line should describe the actual change. In all
> likelihood it will start with "blockjob:" rather than "iotests:".
Sure! thanks for pointing that.
>=20
>> diff --git a/include/block/blockjob.h b/include/block/blockjob.h
>> index fc645dac68..f8f208bbcf 100644
>> --- a/include/block/blockjob.h
>> +++ b/include/block/blockjob.h
>> @@ -99,6 +99,11 @@ typedef struct BlockJob {
>>       bool ready;
>>  =20
>>       /**
>> +     * Set to true when the job is yielded.
>> +     */
>> +    bool yielded;
>=20
> This is the same as !busy, so we don't need a new field for this.
>=20
Mostly yes, but the trick is that busy is set to be true in=20
block_job_do_yield.
> Kevin
>=20

--=20
Regards
QingFeng Hao
