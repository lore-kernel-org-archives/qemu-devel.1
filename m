Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0130DC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 21:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B004020820
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 21:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qRcd41UE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B004020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38321 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEL9J-000189-2i
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 17:52:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hEL8Z-0000hW-0v
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 17:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hEL8X-00008t-Rr
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 17:52:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lidong.chen@oracle.com>)
	id 1hEL8X-00007p-FM
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 17:52:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3ALn7lU082159; Wed, 10 Apr 2019 21:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=subject : to : cc :
	references : from : message-id : date : mime-version : in-reply-to :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=cHY5jk5uWLBNRtQrqkt6ybvu0nZmC8GayWoxtCBRRrA=;
	b=qRcd41UECsSiZzPUwkJgKi62cIu7qI+EC6hIbUsihm+Gu1SN/f7q7weRb7PFKhXewgWL
	ghUHmIbd8bq765rpbkePLYsN7br0+fsC29GIAp2iM47xyVKRRSqz82vRyM0K/oP8YvzF
	yHhYpNowIAgUB3M5XVQ3wzDUIrHy1SxIB99eXhMCd+bA3PQNWU3XvSPq+9ZmpRf0EfKJ
	OE3O6J0wZMGTdA2OjBC7CAiZ9kOKOYX1toBWyuyw649bsCntx8bnpP06gh399pUl+njc
	Mm73+5R2ewaXOJpAh8hMI8yJp7L/DgWgomEVoGy5omA8TbgwaC5WjDnZ0zGdReWX94TF
	mA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 2rpkht5nfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2019 21:51:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3ALnbJR177473; Wed, 10 Apr 2019 21:49:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 2rpj5be0r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2019 21:49:37 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3ALnNZi001207;
	Wed, 10 Apr 2019 21:49:23 GMT
Received: from [10.159.134.162] (/10.159.134.162)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 10 Apr 2019 14:49:22 -0700
To: Liam Merwick <liam.merwick@oracle.com>,
	Markus Armbruster <armbru@redhat.com>
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
	<87mukziv48.fsf@dusky.pond.sub.org>
	<ea798b5f-d48a-c05f-a8cb-d2eb1f6a5a23@oracle.com>
From: Lidong Chen <lidong.chen@oracle.com>
Organization: Oracle Corporation
Message-ID: <e1ccef20-7807-8045-1c69-ae8c1a79cdcd@oracle.com>
Date: Wed, 10 Apr 2019 14:49:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ea798b5f-d48a-c05f-a8cb-d2eb1f6a5a23@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904100142
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904100142
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
	x3ALn7lU082159
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
	f4bug@amsat.org, darren.kenny@oracle.com,
	Gerd Hoffmann <kraxel@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410214919.HUEJyXU78fUrwV3mF4Ypb0DoGYz0g4r52IemmBx9oeU@z>

Hi,

Thank you all for the reviews and comments! Since the fixes in sd.c have=20
gone through the review, I can fix the issue in util/main-loop.c=20
(mentioned in the reviews of Peter and Liam) in a separate patch.

Thanks,

Lidong

On 4/9/2019 3:39 AM, Liam Merwick wrote:
> On 09/04/2019 06:51, Markus Armbruster wrote:
>> Lidong Chen <lidong.chen@oracle.com> writes:
>>
>>> Due to an off-by-one error, the assert statements allow an
>>> out-of-bounds array access.
>>>
>>> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
>
>
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
>
>
>>> ---
>>> =C2=A0 hw/sd/sd.c | 4 ++--
>>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index aaab15f..818f86c 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum=20
>>> SDCardStates state)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (state =3D=3D sd_inactive_state) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "inacti=
ve";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 assert(state <=3D ARRAY_SIZE(state_name));
>>> +=C2=A0=C2=A0=C2=A0 assert(state < ARRAY_SIZE(state_name));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return state_name[state];
>>> =C2=A0 }
>>> =C2=A0 @@ -165,7 +165,7 @@ static const char=20
>>> *sd_response_name(sd_rsp_type_t rsp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rsp =3D=3D sd_r1b) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rsp =3D sd_r1;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 assert(rsp <=3D ARRAY_SIZE(response_name));
>>> +=C2=A0=C2=A0=C2=A0 assert(rsp < ARRAY_SIZE(response_name));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return response_name[rsp];
>>> =C2=A0 }
>> This is the second fix for this bug pattern in a fortnight. Where's
>> one, there are more:
>
>
> As Lidong mentioned, an internal static analysis tool (Parfait) was=20
> used to catch these. Not every arch/board is compiled but I had=20
> eyeballed the code of most interest to me and they seemed fine (e.g.=20
> for array accesses, the subsequent loops used a less-than check)
>
> However, this WIN32 code in util/main-loop.c seems wrong.
>
> 425=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(n_poll_fds <=3D ARRAY_SIZE(poll_fd=
s));
> 426
> 427=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < w->num; i++) {
> 428=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 poll_fds[n_poll_fds=
 + i].fd =3D (DWORD_PTR)w->events[i];
> 429=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 poll_fds[n_poll_fds=
 + i].events =3D G_IO_IN;
> 430=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> Seems like this should be:
>
> g_assert(n_poll_fds + w->num <=3D ARRAY_SIZE(poll_fds));
>
> Otherwise, the rest seem fine.
>
> Regards,
>
> Liam
>
>
>>
>> $ git-grep '<=3D ARRAY_SIZE'
>> hw/intc/arm_gicv3_cpuif.c:=C2=A0=C2=A0=C2=A0 assert(aprmax <=3D=20
>> ARRAY_SIZE(cs->ich_apr[0]));
>> hw/intc/arm_gicv3_cpuif.c:=C2=A0=C2=A0=C2=A0 assert(aprmax <=3D=20
>> ARRAY_SIZE(cs->ich_apr[0]));
>> hw/net/stellaris_enet.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(s->tx_fifo_len + 4 <=3D=20
>> ARRAY_SIZE(s->tx_fifo)) {
>> hw/sd/pxa2xx_mmci.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 && s->t=
x_len <=3D ARRAY_SIZE(s->tx_fifo)
>> hw/sd/pxa2xx_mmci.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 && s->r=
x_len <=3D ARRAY_SIZE(s->rx_fifo)
>> hw/sd/pxa2xx_mmci.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 && s->r=
esp_len <=3D ARRAY_SIZE(s->resp_fifo);
>> hw/sd/sd.c:=C2=A0=C2=A0=C2=A0 assert(state <=3D ARRAY_SIZE(state_name)=
);
>> hw/sd/sd.c:=C2=A0=C2=A0=C2=A0 assert(rsp <=3D ARRAY_SIZE(response_name=
));
>> hw/usb/hcd-xhci.c:=C2=A0=C2=A0=C2=A0 assert(n <=3D ARRAY_SIZE(tmp));
>> target/mips/op_helper.c:=C2=A0=C2=A0=C2=A0 if (base_reglist > 0 && bas=
e_reglist <=3D=20
>> ARRAY_SIZE (multiple_regs)) {
>> target/mips/op_helper.c:=C2=A0=C2=A0=C2=A0 if (base_reglist > 0 && bas=
e_reglist <=3D=20
>> ARRAY_SIZE (multiple_regs)) {
>> target/mips/op_helper.c:=C2=A0=C2=A0=C2=A0 if (base_reglist > 0 && bas=
e_reglist <=3D=20
>> ARRAY_SIZE (multiple_regs)) {
>> target/mips/op_helper.c:=C2=A0=C2=A0=C2=A0 if (base_reglist > 0 && bas=
e_reglist <=3D=20
>> ARRAY_SIZE (multiple_regs)) {
>> target/ppc/kvm.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 <=3D ARRAY_SIZE(hw_debug_points));
>> target/ppc/kvm.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 <=3D ARRAY_SIZE(hw_debug_points));
>> target/ppc/kvm.c:=C2=A0=C2=A0=C2=A0 assert((nb_hw_breakpoint + nb_hw_w=
atchpoint) <=3D=20
>> ARRAY_SIZE(dbg->arch.bp));
>> tcg/tcg.c:=C2=A0=C2=A0=C2=A0 tcg_debug_assert(pi <=3D ARRAY_SIZE(op->a=
rgs));
>> util/main-loop.c:=C2=A0=C2=A0=C2=A0 g_assert(n_poll_fds <=3D ARRAY_SIZ=
E(poll_fds));
>> util/module.c:=C2=A0=C2=A0=C2=A0 assert(n_dirs <=3D ARRAY_SIZE(dirs));
>>
>> Lidong Chen, would you like to have a look at these?
>>
>> Cc'ing maintainers to help with further investigation.
>>
>

