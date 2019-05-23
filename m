Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9911AC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6614421019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wobxsb4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6614421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40639 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqx8-0003l1-ME
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:52:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hTqvE-0002R3-10
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hTqke-0006al-9W
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:39:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hTqkc-0006Xq-P9; Thu, 23 May 2019 12:39:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NGdKD0130625; Thu, 23 May 2019 16:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : message-id :
	content-type : mime-version : subject : date : in-reply-to : cc : to :
	references; s=corp-2018-07-02;
	bh=cmtRzb3GnCeEy3Gk6rPnVVp6uPabZlx0w4bmD7EjewM=;
	b=wobxsb4vRu35xX6j12oBxCloN2novJEaNOvqclC09jY0b+CBLP+9SMYAjMepXXQQ8qGs
	pJm4jpgR8VW3+HJW2c6386HWpsS1UJj6pzd3EgQ6/N0Ca/+LzbgORJc5W+3EnDn/g30x
	O1c7s6YifuXCsrOlXb4ku8HckGDdJTTpJpZAu6EPGfvtN+KU7TNycLHbGcssOn4WGe3C
	pcicqwXqPKTv31ghDYzSjbwYLKmko+1JkO/zE42jh+g1L5yoYe61mevPGzHFC272dOEo
	9oMRqmUVKI8qrU4uag6gG40Gr336TbuZbRcCrLs9bJ4yXK/VTCf4jaegXBRvfACPuZnD
	Cg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 2smsk5kp30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2019 16:39:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NGbjht191249; Thu, 23 May 2019 16:39:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 2smsgvkr3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2019 16:39:28 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4NGdRvK002113;
	Thu, 23 May 2019 16:39:27 GMT
Received: from [192.168.43.218] (/2.53.191.8)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 23 May 2019 16:39:26 +0000
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-Id: <187CC767-4CB1-42AE-8C9C-6F0EF69F40AF@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Date: Thu, 23 May 2019 19:35:20 +0300
In-Reply-To: <fc179916-0fb5-bb50-da41-14789b020be9@redhat.com>
To: Max Reitz <mreitz@redhat.com>
References: <20190523154444.28783-1-shmuel.eiderman@oracle.com>
	<20190523154444.28783-3-shmuel.eiderman@oracle.com>
	<fc179916-0fb5-bb50-da41-14789b020be9@redhat.com>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905230113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905230113
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4 2/3] qemu-img: rebase: Reduce reads on
 in-chain rebase
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
Cc: kwolf@redhat.com, eyal.moscovici@oracle.com, qemu-block@nongnu.org,
	arbel.moshe@oracle.com, QEMU <qemu-devel@nongnu.org>,
	liran.alon@oracle.com, sagi.amit@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes, my bad, resending as v5.

Sam

> On 23 May 2019, at 19:14, Max Reitz <mreitz@redhat.com> wrote:
>=20
> On 23.05.19 17:44, Sam Eiderman wrote:
>> In the following case:
>>=20
>> (base) A <- B <- C (tip)
>>=20
>> when running:
>>=20
>>    qemu-img rebase -b A C
>>=20
>> QEMU would read all sectors not allocated in the file being rebased =
(C)
>> and compare them to the new base image (A), regardless of whether =
they
>> were changed or even allocated anywhere along the chain between the =
new
>> base and the top image (B). This causes many unneeded reads when
>> rebasing an image which represents a small diff of a large disk, as =
it
>> would read most of the disk's sectors.
>>=20
>> Instead, use bdrv_is_allocated_above() to reduce the number of
>> unnecessary reads.
>>=20
>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
>> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
>> Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
>> ---
>> qemu-img.c | 25 ++++++++++++++++++++++++-
>> 1 file changed, 24 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 9bd0bb1e47..e6fd8e1a98 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>=20
> [...]
>=20
>> @@ -3437,6 +3443,23 @@ static int img_rebase(int argc, char **argv)
>>                 continue;
>>             }
>>=20
>> +            if (prefix_chain_bs) {
>> +                /*
>> +                 * If cluster wasn't changed since prefix_chain, we =
don't need
>> +                 * to take action
>> +                 */
>> +                ret =3D bdrv_is_allocated_above(bs, prefix_chain_bs,
>> +                                              offset, n, &n);
>=20
> I think you forgot to update the patch...?
>=20
> Max
>=20
>> +                if (ret < 0) {
>> +                    error_report("error while reading image =
metadata: %s",
>> +                                 strerror(-ret));
>> +                    goto out;
>> +                }
>> +                if (!ret) {
>> +                    continue;
>> +                }
>> +            }
>> +
>>             /*
>>              * Read old and new backing file and take into =
consideration that
>>              * backing files may be smaller than the COW image.

