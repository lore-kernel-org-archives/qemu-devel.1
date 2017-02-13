Received: from eggs.gnu.org ([2001:4830:134:3::10]:41515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cdClW-0004iO-Cj
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cdClT-0003Ab-8h
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:17:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1cdClS-0003AK-VN
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:17:43 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1D9DkuZ004253
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 04:17:40 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28k7ja5kwc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 04:17:40 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Mon, 13 Feb 2017 02:17:39 -0700
References: <20161216052040.53067-1-haoqf@linux.vnet.ibm.com>
	<20161216052040.53067-2-haoqf@linux.vnet.ibm.com>
	<be77cb51-c3ad-d7a0-9c85-cb7aeaed31b0@redhat.com>
From: Hao QingFeng <haoqf@linux.vnet.ibm.com>
Date: Mon, 13 Feb 2017 17:17:32 +0800
MIME-Version: 1.0
In-Reply-To: <be77cb51-c3ad-d7a0-9c85-cb7aeaed31b0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <54271058-3366-fbe0-d314-3b6d1b0030ad@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 1/1] block/vmdk: Fix the
 endian problem of buf_len and lba
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-stable@nongnu.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com



=E5=9C=A8 2017-01-26 0:25, Max Reitz =E5=86=99=E9=81=93:
> On 16.12.2016 06:20, QingFeng Hao wrote:
>> The problem was triggered by qemu-iotests case 055. It failed when it
>> was comparing the compressed vmdk image with original test.img.
>>
>> The cause is that buf_len in vmdk_write_extent wasn't converted to
>> little-endian before it was stored to disk. But later vmdk_read_extent
>> read it and converted it from little-endian to cpu endian.
>> If the cpu is big-endian like s390, the problem will happen and
>> the data length read by vmdk_read_extent will become invalid!
>> The fix is to add the conversion in vmdk_write_extent, meanwhile,
>> repair the endianness problem of lba field which shall also be convert=
ed
>> to little-endian before storing to disk.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>> Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> ---
>>   block/vmdk.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> Thanks, I've applied the patch to my block tree:
>
> https://github.com/XanClic/qemu/commits/block
Thanks Max!
>
> Max
>

--=20
QingFeng Hao(Robin)
