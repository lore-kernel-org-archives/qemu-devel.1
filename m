Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01672C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC002133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ttqzISK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC002133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39039 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpna-0004Wd-14
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:38:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hTpme-00044P-Ep
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hTpmd-0008Vb-AQ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:37:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hTpma-0008RD-HZ; Thu, 23 May 2019 11:37:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NFYA5V078760; Thu, 23 May 2019 15:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=content-type :
	mime-version : subject : from : in-reply-to : date : cc :
	content-transfer-encoding : message-id : references : to;
	s=corp-2018-07-02; bh=wIwm0tx6igGNyP9tCC++3mP2y9OhPsB9sQVWYkyz8ZQ=;
	b=ttqzISK1z979Nd9rSHDjlEyRcRfP2Lqc1nFNGzFXR1UPUAHAc8jrXcGcyMn9AgRuiVpp
	3uyO1o8mV+5cjwFvpY7FUKK6CdSkB4lQVgcFccsxiWVwZ79lUf16YRVaWzbF+kA1gDiJ
	PLzWP2a/BaSFsYhvEMZHiUP5bevytEv1AzjpHqQ42WekFke0n2RbNw6ldFsplR7mbRCY
	dhPQ+WI+Qh8OTCN4T5kQj8WWs4ybAS2Qstqk83mfiDGK7LWSgjfNdEDCEEWuY8t5X0lh
	t5ga16EbksET5hbwmPijCu3ejKHHPRZpYN3BrkLPiQ9k049Hzn39EFHl+blcq8s+Dh2M
	/A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2smsk5b834-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2019 15:37:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NFa8Wi022164; Thu, 23 May 2019 15:37:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 2smsh2atdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2019 15:37:25 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4NFbOwg030322;
	Thu, 23 May 2019 15:37:24 GMT
Received: from [10.0.5.157] (/213.57.127.10)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 23 May 2019 15:37:24 +0000
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
From: Sam Eiderman <shmuel.eiderman@oracle.com>
In-Reply-To: <f8b7c7b3-fe64-59cc-6b11-1a87270caf00@redhat.com>
Date: Thu, 23 May 2019 18:37:18 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <B57B5689-1ABB-4770-9776-4F06E1F19E95@oracle.com>
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-3-shmuel.eiderman@oracle.com>
	<c117d2e2-eef2-df4f-ef3d-37a33426dd51@redhat.com>
	<B8380028-641C-4355-AF16-2F881E25CF8D@oracle.com>
	<f8b7c7b3-fe64-59cc-6b11-1a87270caf00@redhat.com>
To: Max Reitz <mreitz@redhat.com>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=802
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905230106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9265
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=841
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905230106
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
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



> On 23 May 2019, at 17:26, Max Reitz <mreitz@redhat.com> wrote:
>=20
> On 23.05.19 16:09, Sam Eiderman wrote:
>>=20
>>=20
>>> On 23 May 2019, at 17:01, Max Reitz <mreitz@redhat.com
>>> <mailto:mreitz@redhat.com>> wrote:
>>>=20
>>> On 02.05.19 15:58, Sam Eiderman wrote:
>>>> In the following case:
>>>>=20
>>>> (base) A <- B <- C (tip)
>>>>=20
>>>> when running:
>>>>=20
>>>>    qemu-img rebase -b A C
>>>>=20
>>>> QEMU would read all sectors not allocated in the file being rebased =
(C)
>>>> and compare them to the new base image (A), regardless of whether =
they
>>>> were changed or even allocated anywhere along the chain between the =
new
>>>> base and the top image (B). This causes many unneeded reads when
>>>> rebasing an image which represents a small diff of a large disk, as =
it
>>>> would read most of the disk's sectors.
>>>>=20
>>>> Instead, use bdrv_is_allocated_above() to reduce the number of
>>>> unnecessary reads.
>>>>=20
>>>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com
>>>> <mailto:karl.heubaum@oracle.com>>
>>>> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com
>>>> <mailto:shmuel.eiderman@oracle.com>>
>>>> Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com
>>>> <mailto:eyal.moscovici@oracle.com>>
>>>> ---
>>>> qemu-img.c | 25 ++++++++++++++++++++++++-
>>>> 1 file changed, 24 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/qemu-img.c b/qemu-img.c
>>>> index d9b609b3f0..7f20858cb9 100644
>>>> --- a/qemu-img.c
>>>> +++ b/qemu-img.c
>>>=20
>>> [...]
>>>=20
>>>> @@ -3422,6 +3428,23 @@ static int img_rebase(int argc, char **argv)
>>>>                 continue;
>>>>             }
>>>>=20
>>>> +            if (prefix_chain_bs) {
>>>> +                /*
>>>> +                 * If cluster wasn't changed since prefix_chain, =
we
>>>> don't need
>>>> +                 * to take action
>>>> +                 */
>>>> +                ret =3D bdrv_is_allocated_above(bs, =
prefix_chain_bs,
>>>> +                                              offset, n, &n);
>>>=20
>>> This will always return true because it definitely is allocated in =
@bs,
>>> or we wouldn=E2=80=99t be here.  (We just checked that with
>>> bdrv_is_allocated().)  I think @top should be backing_bs(bs).
>>>=20
>>> Max
>>=20
>> I don=E2=80=99t think that=E2=80=99s true:
>>=20
>> Examine the case where we have the following chain:
>>=20
>> A <- B <- C
>>=20
>> When we rebase C directly over A: qemu-img rebase -b A C
>>=20
>> We must check for every offset (sector): bdrv_is_allocated_above(C, =
A,
>> offset, n, &n);
>>=20
>> If a sector from C is allocated above A - it may have been changed - =
so
>> we need to do a read from A and a read from C and compare.
>> If the sector is not allocated above, it was not changed - we don=E2=80=
=99t need
>> to read from A or C.
>=20
> First: Oops, somehow I inverted the bdrv_is_allocated() check in my
> head.  (For context: I mean this part above this hunk here:
>=20
>    /* If the cluster is allocated, we don't need to take action */
>    ret =3D bdrv_is_allocated(bs, offset, n, &n);
>    if (ret < 0) {
>        error_report("error while reading image metadata: %s",
>                     strerror(-ret));
>        goto out;
>    }
>=20
>=20
>=20
>    if (ret) {
>        continue;
>    }
>=20
> )  So at this point, the range definitely is *not* allocated in @bs.
>=20
> But second: That still means that we do not have to check @bs itself,
> because we already did.  We know the range isn=E2=80=99t allocated =
there, so we
> can start at its backing file.
>=20
> On a more abstract level: No, we do not need to read all sectors from =
A
> and C and compare them if they are allocated anywhere above A.  If =
they
> are allocated in C, we=E2=80=99re good, because all we=E2=80=99d do is =
write them back
> to C (which is a no-op).  That=E2=80=99s exactly what the existing
> bdrv_is_allocated() check is for.
>=20
> So we only need to know whether the sectors are allocated above the =
base
> (A) and below the top (C), so in your example, whether they are
> allocated in B.  If they are, we need to compare and potentially copy,
> if they are not, we can skip them.
>=20
> So my claim that bdrv_is_allocated_above() would always return true is
> wrong, but it still should use backing_bs(bs) for the top because we
> have checked @bs already.

I see your point, basically we save a single iteration in the loop at =
bdrv_is_allocated_above.
I=E2=80=99ll submit a v4 patch series.

Sam

>=20
> Max
>=20


