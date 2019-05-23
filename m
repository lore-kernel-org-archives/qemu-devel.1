Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D020EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891CA20851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t56s7uO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891CA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37487 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTohd-00061s-N5
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:28:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hToQG-0005oW-Gl
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hToQB-0003vW-CX
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:10:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hToQ4-0003kQ-Ch; Thu, 23 May 2019 10:10:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NE3x0L186615; Thu, 23 May 2019 14:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : message-id :
	content-type : mime-version : subject : date : in-reply-to : cc : to :
	references; s=corp-2018-07-02;
	bh=fpZkLL/g0zAQZ/JImH0ODu6mVKnwWCQNTFMnu7rlM/k=;
	b=t56s7uO+lQByObxnq0gzvgcwZPiUwzqX1OrzBD0Fgbfz0N2kxF+jD6u6g4a70qPCDI/z
	qpck4NEjipdylXmykklGCqGyacnb9xrIMjTkWBRXDc8RLneVmqUhLwCnGofqFoyD6Xn8
	y3s+okbx78zUkVqiJ80ELJVyOkWDwYIw932HV7TjdaH6C4B/AoRziPiX1fVSL/NjHkBI
	nIPQz+rUPZKef9DvdhqQgBqbnSWpAuXwJv2+UWqOat29vB/pDUiMd++Up1oAI9K+oSod
	jzd/u3V69IvB4DGzSTWW5LzLzJzSuC+2MvweP1Dn4yVoSuGWVXTvq+FPY/2RB+OjMp5L
	3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2120.oracle.com with ESMTP id 2smsk5akf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2019 14:10:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NE9767067375; Thu, 23 May 2019 14:10:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3030.oracle.com with ESMTP id 2smshf8sve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2019 14:10:06 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4NEA5nN031450;
	Thu, 23 May 2019 14:10:05 GMT
Received: from [10.0.5.157] (/213.57.127.10)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 23 May 2019 14:10:04 +0000
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-Id: <B8380028-641C-4355-AF16-2F881E25CF8D@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Date: Thu, 23 May 2019 17:09:58 +0300
In-Reply-To: <c117d2e2-eef2-df4f-ef3d-37a33426dd51@redhat.com>
To: Max Reitz <mreitz@redhat.com>
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-3-shmuel.eiderman@oracle.com>
	<c117d2e2-eef2-df4f-ef3d-37a33426dd51@redhat.com>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905230098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905230098
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qemu-img: rebase: Reduce reads on
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
	arbel.moshe@oracle.com, qemu-devel@nongnu.org,
	liran.alon@oracle.com, sagi.amit@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 23 May 2019, at 17:01, Max Reitz <mreitz@redhat.com> wrote:
>=20
> On 02.05.19 15:58, Sam Eiderman wrote:
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
>> index d9b609b3f0..7f20858cb9 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>=20
> [...]
>=20
>> @@ -3422,6 +3428,23 @@ static int img_rebase(int argc, char **argv)
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
> This will always return true because it definitely is allocated in =
@bs,
> or we wouldn=E2=80=99t be here.  (We just checked that with
> bdrv_is_allocated().)  I think @top should be backing_bs(bs).
>=20
> Max

I don=E2=80=99t think that=E2=80=99s true:

Examine the case where we have the following chain:

A <- B <- C

When we rebase C directly over A: qemu-img rebase -b A C

We must check for every offset (sector): bdrv_is_allocated_above(C, A, =
offset, n, &n);

If a sector from C is allocated above A - it may have been changed - so =
we need to do a read from A and a read from C and compare.
If the sector is not allocated above, it was not changed - we don=E2=80=99=
t need to read from A or C.

Sam


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

