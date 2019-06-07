Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D880FC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 21:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F9C2083D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 21:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kyIVi3Fo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F9C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZMZN-0006d9-TB
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 17:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43134)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lidong.chen@oracle.com>) id 1hZMXW-0004tK-HV
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lidong.chen@oracle.com>) id 1hZMXU-00007v-Jq
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:36:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lidong.chen@oracle.com>)
 id 1hZMXS-0008RV-N0
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:36:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57LYGaI170229;
 Fri, 7 Jun 2019 21:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=skpdMvg09h+rd1PwT7CzRc04JFOEc0JVPbyYt6pWZTk=;
 b=kyIVi3FoCFoRcrbTfaYGoD8wRJBuKYX+FfAvJ7oDCre7PwqOh31VgTU+tbng9DZv2iBP
 33329QcZByM2Z80+Sa6r5E/N7knSVAoPaQP8uwI9vcY59913TkLMlYFuTzQOs1Qm2b9h
 20du+J1raS2a5ZK+uWhwg43M4rlIQ9f2hDD8KYlFkW2fcl+iM/t9WiGV5KC+G2AQsB7S
 aJHeqVH861z5Ugg05rDp6vr92DJTQv+vyJmrPs9d28kp5vk82Ks27VxrVxlcYqCrXfjl
 P3yV2CveB4PDFrNMnWnMy/lZl2VvibaG308gRrqqO1ZHnYK+ZagDh+VMqua11YPswZZZ wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2sugsu0mg6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jun 2019 21:36:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57La41K093409;
 Fri, 7 Jun 2019 21:36:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2swngk8a4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jun 2019 21:36:35 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x57LaYZN022537;
 Fri, 7 Jun 2019 21:36:34 GMT
Received: from [10.159.153.100] (/10.159.153.100)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 07 Jun 2019 14:36:34 -0700
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <cover.1559761541.git.lidong.chen@oracle.com>
 <00742cd052c0b66e8da0b6b684cd460d6a051175.1559761541.git.lidong.chen@oracle.com>
 <7861c01a-c658-e777-634f-9d299b7abbaa@redhat.com>
From: Lidong Chen <lidong.chen@oracle.com>
Organization: Oracle Corporation
Message-ID: <c025cd93-0977-367f-63f7-ee3ce7c0826c@oracle.com>
Date: Fri, 7 Jun 2019 14:36:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7861c01a-c658-e777-634f-9d299b7abbaa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070143
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 x57LYGaI170229
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [Qemu-devel PATCH v2 2/2] util/main-loop: Fix
 incorrect assertion
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, berrange@redhat.com, liran.alon@oracle.com,
 liq3ea@gmail.com, armbru@redhat.com, darren.kenny@oracle.com,
 marcandre.lureau@gmail.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 6/6/2019 4:18 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 6/5/19 9:15 PM, Lidong Chen wrote:
>> The check for poll_fds in g_assert() was incorrect. The correct assert=
ion
>> should check "n_poll_fds + w->num <=3D ARRAY_SIZE(poll_fds)" because t=
he
>> subsequent for-loop is doing access to poll_fds[n_poll_fds + i] where =
i
>> is in [0, w->num).
>>
>> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Suggested-by: Liam Merwick <liam.merwick@oracle.com>
> Ah, so this is not a plain "v2 RESEND" patch of
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg00636.html
> since you added Peter 'Suggested-by' tag...
So,=C2=A0 should I resend it as v3 patch?
>> Reviewed-by: Liran Alon <liran.alon@oracle.com>
>> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
>> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> ... but then you dropped my 'Reviewed-by'. Assuming this is a typo, and
> since there is no logical change in this patch with the previous one,
> here it goes again:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks for catching that!=C2=A0 Sorry about it, I will add your 'Reviewed=
-by'.

Thanks,

Lidong

>
> Regards,
>
> Phil.
>
>> ---
>>   util/main-loop.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/util/main-loop.c b/util/main-loop.c
>> index e1e349c..a9f4e8d 100644
>> --- a/util/main-loop.c
>> +++ b/util/main-loop.c
>> @@ -422,7 +422,7 @@ static int os_host_main_loop_wait(int64_t timeout)
>>       g_main_context_prepare(context, &max_priority);
>>       n_poll_fds =3D g_main_context_query(context, max_priority, &poll=
_timeout,
>>                                         poll_fds, ARRAY_SIZE(poll_fds)=
);
>> -    g_assert(n_poll_fds <=3D ARRAY_SIZE(poll_fds));
>> +    g_assert(n_poll_fds + w->num <=3D ARRAY_SIZE(poll_fds));
>>  =20
>>       for (i =3D 0; i < w->num; i++) {
>>           poll_fds[n_poll_fds + i].fd =3D (DWORD_PTR)w->events[i];
>>

