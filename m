Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A62C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FBD02148E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bO6KMEiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBD02148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59541 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDcIN-0004o4-8R
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 17:59:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hDcHC-0004Dl-IK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hDcHB-0008Nq-EB
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:58:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lidong.chen@oracle.com>)
	id 1hDcHA-0008Kx-US
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:58:01 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x38Lj5K7106882; Mon, 8 Apr 2019 21:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=subject : to : cc :
	references : from : message-id : date : mime-version : in-reply-to :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=+aSuA7jSZSleIlfevt3SJNFrPoevbw6SdfxioxbRVNw=;
	b=bO6KMEiIBpY+h/nSvkY3bkfRugk8H9CuBzdESZE59SqQR2T8O9OZSXvXda8/7npCkppe
	a732dGrFxFy6FY2+UlUGXOjKm3aumr7uqUey9vXG8BhjZWPDjaEZpOyo21OKTWIvdey/
	3RA/yLnb0ZFIwFpGYmr+myoU2r4PCDSiJkMWpRafsosD7Q7o+1nXzthVE8l+fyC6iNxD
	ngLFLaFsCVEbM3C+IZd+jqp6jQzyZTcXke+saN/CsMZ7rfmcgeEkb3/MR7a40cZtZ402
	mSKpQ7ISpzmZ+Wi+Ng7elaga21qHkbG8V/TQ3R0rtId/12/5mCEFuzrbo4ayw4JLwJPY
	TQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 2rphme9ghc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2019 21:57:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x38Lvn0t087834; Mon, 8 Apr 2019 21:57:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 2rpkehxkg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2019 21:57:57 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x38LvuQJ005863;
	Mon, 8 Apr 2019 21:57:56 GMT
Received: from [10.159.131.36] (/10.159.131.36)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 08 Apr 2019 14:57:56 -0700
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
	<d35048f6-44e7-46a0-3d70-51123896f1ef@redhat.com>
From: Lidong Chen <lidong.chen@oracle.com>
Organization: Oracle Corporation
Message-ID: <e67e84dc-193a-3b28-7016-9113652e11fd@oracle.com>
Date: Mon, 8 Apr 2019 14:57:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d35048f6-44e7-46a0-3d70-51123896f1ef@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904080159
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904080159
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2130.oracle.com id
	x38Lj5K7106882
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
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
Cc: darren.kenny@oracle.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408215737.7Vl1i7CECEm9cC6vZbgvtzzSymeZuEPxiDwvpl1PXIU@z>

Hi Philippe,

On 4/8/2019 2:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Lidong
>
> On 4/8/19 9:04 PM, Lidong Chen wrote:
>> Due to an off-by-one error, the assert statements allow an
>> out-of-bounds array access.
> ... which can't happen. Thus harmless for 4.0.
>
> I suppose this is a static analysis warning and you didn't triggered it
> while tracing.

Right, it was found by the static analysis.=C2=A0 Thank you for your revi=
ew.

Regards,

Lidong


>
> Thanks for cleaning this :)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
>> ---
>>   hw/sd/sd.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index aaab15f..818f86c 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates=
 state)
>>       if (state =3D=3D sd_inactive_state) {
>>           return "inactive";
>>       }
>> -    assert(state <=3D ARRAY_SIZE(state_name));
>> +    assert(state < ARRAY_SIZE(state_name));
>>       return state_name[state];
>>   }
>>  =20
>> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t =
rsp)
>>       if (rsp =3D=3D sd_r1b) {
>>           rsp =3D sd_r1;
>>       }
>> -    assert(rsp <=3D ARRAY_SIZE(response_name));
>> +    assert(rsp < ARRAY_SIZE(response_name));
>>       return response_name[rsp];
>>   }
>>  =20
>>

