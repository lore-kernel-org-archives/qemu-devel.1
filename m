Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07737C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A500F206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="An1dkQHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A500F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56175 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMu26-0001iu-0s
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 08:44:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMu1F-0001HW-6p
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMu1D-0007iv-HZ
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:43:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hMu19-0007fl-OE; Sat, 04 May 2019 08:43:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x44Cdggc114027; Sat, 4 May 2019 12:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : message-id :
	content-type : mime-version : subject : date : in-reply-to : cc : to :
	references; s=corp-2018-07-02;
	bh=HJU3qN/4rVkNUU1OdoAZ3swjyIeKTmvmTeE5Z/A6aYs=;
	b=An1dkQHRy8pYM6RTMawI9HLWqSXZzawe+YeH+rPBfzSeU88buoZEAG5s7Iddx6l4QUdI
	yPACzF0yjM229fFAHi/Yup64gV0NZYnm+HJIC6CEjulYVoxmG/iwC+Bmnrza+mDTkkwV
	NQFRZFbuSrSRB34xJDdUVkIuIIT4GXC+Nec7d8VJwyokNl6zhGIDmI65oDOiZVxDMl0J
	X4ORthGVA3wCidwuBFxYgQh0Hp2U9hqJH1geBARIQbUhJo6NSQJdj+ZsNk+KU7W7ponh
	gQJDwPJhsBVX1ydpiaoi979PK8AZrNW4Un6HWyODgRMcHK4/cReCdSqZSHdIAiEdSHP3
	wA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 2s94bfgqw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 May 2019 12:43:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x44ChEWs153426; Sat, 4 May 2019 12:43:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3030.oracle.com with ESMTP id 2s94aqk2ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 May 2019 12:43:33 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x44ChWXF009829;
	Sat, 4 May 2019 12:43:32 GMT
Received: from [10.0.0.12] (/79.182.71.37)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sat, 04 May 2019 05:43:31 -0700
From: Sam <shmuel.eiderman@oracle.com>
Message-Id: <75AB1BD6-546D-4103-8A44-BEEC2FD3FF63@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Date: Sat, 4 May 2019 15:43:25 +0300
In-Reply-To: <a44ffb98-4cc2-47b9-2c9e-eeeda445a0a0@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <af928e13-bde2-a9ae-de74-853d9bfc5e65@redhat.com>
	<20190502130822.46858-1-shmuel.eiderman@oracle.com>
	<20190502130822.46858-2-shmuel.eiderman@oracle.com>
	<8d201096-ab9d-82e0-93cb-74bd23d93dbe@redhat.com>
	<a44ffb98-4cc2-47b9-2c9e-eeeda445a0a0@redhat.com>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9246
	signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905040082
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9246
	signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905040082
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2] vmdk: Set vmdk parent backing_format to
 vmdk
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
	Arbel Moshe <arbel.moshe@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504124325._tWNvH5zLkiozFgqWCcF7Yu3UBSZo_jTsou1I8Zyy4A@z>

Thanks Thomas, Thanks Max

So how do you want to proceed?

Apply Max=E2=80=99s RFC from here =
(http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00442.html =
<http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00442.html>) =
and add the commit id which is stable now?
Or should I resubmit my fix (which is very similar to what Max did) =
without the original change?

Sam

> On 3 May 2019, at 17:32, Max Reitz <mreitz@redhat.com> wrote:
>=20
> On 03.05.19 13:34, Thomas Huth wrote:
>> Hi Sam,
>>=20
>> On 02/05/2019 15.08, Sam Eiderman wrote:
>>> Commit b69864e ("vmdk: Support version=3D3 in VMDK descriptor =
files")
>>> fixed the probe function to correctly guess vmdk descriptors with
>>> version=3D3.
>>>=20
>>> This solves the issue where vmdk snapshot with parent vmdk =
descriptor
>>> containing "version=3D3" would be treated as raw instead vmdk.
>>>=20
>>> In the future case where a new vmdk version is introduced, we will =
again
>>> experience this issue, even if the user will provide "-f vmdk" it =
will
>>> only apply to the tip image and not to the underlying "misprobed" =
parent
>>> image.
>>>=20
>>> The code in vmdk.c already assumes that the backing file of vmdk =
must be
>>> vmdk (see vmdk_is_cid_valid which returns 0 if backing file is not
>>> vmdk).
>>>=20
>>> So let's make it official by supplying the backing_format as vmdk.
>>>=20
>>> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
>>> Reviewed-By: Liran Alon <liran.alon@oracle.com>
>>> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
>>> Signed-off-by: Shmuel Eiderman <shmuel.eiderman@oracle.com>
>>> ---
>>> block/vmdk.c           | 2 ++
>>> tests/qemu-iotests/110 | 6 +++---
>>> tests/qemu-iotests/126 | 4 ++--
>>> 3 files changed, 7 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/block/vmdk.c b/block/vmdk.c
>>> index 8dec6ef767..de8cb859f8 100644
>>> --- a/block/vmdk.c
>>> +++ b/block/vmdk.c
>>> @@ -397,6 +397,8 @@ static int vmdk_parent_open(BlockDriverState =
*bs)
>>>         pstrcpy(bs->auto_backing_file, end_name - p_name + 1, =
p_name);
>>>         pstrcpy(bs->backing_file, sizeof(bs->backing_file),
>>>                 bs->auto_backing_file);
>>> +        pstrcpy(bs->backing_format, sizeof(bs->backing_format),
>>> +                "vmdk");
>>>     }
>>=20
>> Your patch with this change has already been merged into the QEMU =
master
>> branch...
>>=20
>>> diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
>>> index fad672c1ae..982569dbc5 100755
>>> --- a/tests/qemu-iotests/110
>>> +++ b/tests/qemu-iotests/110
>>> @@ -54,7 +54,7 @@ _make_test_img -b "$TEST_IMG_REL.base" 64M
>>> # qemu should be able to reconstruct the filename, so relative =
backing names
>>> # should work
>>> =
TEST_IMG=3D"json:{'driver':'$IMGFMT','file':{'driver':'file','filename':'$=
TEST_IMG'}}" \
>>> -    _img_info | _filter_img_info
>>> +    _img_info | _filter_img_info | grep -v "backing file format"
>>>=20
>>> echo
>>> echo '=3D=3D=3D Non-reconstructable filename =3D=3D=3D'
>>> @@ -78,7 +78,7 @@ TEST_IMG=3D"json:{
>>>             }
>>>         ]
>>>     }
>>> -}" _img_info | _filter_img_info
>>> +}" _img_info | _filter_img_info | grep -v "backing file format"
>>>=20
>>> echo
>>> echo '=3D=3D=3D Backing name is always relative to the backed image =
=3D=3D=3D'
>>> @@ -110,7 +110,7 @@ TEST_IMG=3D"json:{
>>>             }
>>>         ]
>>>     }
>>> -}" _img_info | _filter_img_info
>>> +}" _img_info | _filter_img_info | grep -v "backing file format"
>>>=20
>>>=20
>>> # success, all done
>>> diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
>>> index 96dc048d59..1f7618c8a5 100755
>>> --- a/tests/qemu-iotests/126
>>> +++ b/tests/qemu-iotests/126
>>> @@ -63,7 +63,7 @@ TEST_IMG=3D$BASE_IMG _make_test_img 64M
>>> TEST_IMG=3D$TOP_IMG _make_test_img -b ./image:base.$IMGFMT
>>>=20
>>> # The default cluster size depends on the image format
>>> -TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size'
>>> +TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size\|backing file =
format'
>>>=20
>>> _rm_test_img "$BASE_IMG"
>>> _rm_test_img "$TOP_IMG"
>>> @@ -79,7 +79,7 @@ TOP_IMG=3D"file:image:top.$IMGFMT"
>>> TEST_IMG=3D$BASE_IMG _make_test_img 64M
>>> TEST_IMG=3D$TOP_IMG _make_test_img -b "$BASE_IMG"
>>>=20
>>> -TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size'
>>> +TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size\|backing file =
format'
>>>=20
>>> _rm_test_img "$BASE_IMG"
>>> _rm_test_img "image:top.$IMGFMT"
>>>=20
>>=20
>> ... so please just send a patch with these fixes!
>=20
> I already did, it's here:
>=20
> http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00442.html =
<http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00442.html>
>=20
> Max

