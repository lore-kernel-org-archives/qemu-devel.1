Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7620C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FA9205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ayw8mEgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FA9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDoCI-0006Ly-Tm
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 06:41:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1hDoBE-0005cp-JB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1hDoBD-0003Mj-Gg
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:40:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1hDoB9-0003IW-OY
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:40:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x39AYB1F105018; Tue, 9 Apr 2019 10:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=subject : to : cc :
	references : from : message-id : date : mime-version : in-reply-to :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=TVd+mZ5xDer/1mByyrEhbwQMf3QoAM1OH05rbhVXEO0=;
	b=ayw8mEgfSqlocopyesUPkHrUHdlMa3ReMYR/O2ob+EwBdPeHDliw4MHetFf6pjgVM/nr
	8OXf73x4ZCEZ9H+Ii96MlRFQrTHpxWHRHx0nvpt7CWU7prZdjrj3rjWCGEw1oeBiDeo7
	Rsw5xSO2AgPIiOE2CUqx1rXGXy0q2ezqYi8nsGYEWly9kGvNuB0+vme14J18JCzAkzNY
	qvmpRTM/n94vihXRPlV+/lyAIilPqlk456rIRxG31/PxXzxFgjGvwsZpw/4+oZKtWsrW
	ecL8UWPNIk95PbptDXXj0DMA6mpKhQih5hhDayxaEwnBB6MC0voEitmzrQc+WsvWf0xM
	bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 2rpkhsv5kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2019 10:40:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x39AdXHP067253; Tue, 9 Apr 2019 10:39:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3030.oracle.com with ESMTP id 2rpj5afx4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2019 10:39:59 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x39AdnSF008119;
	Tue, 9 Apr 2019 10:39:50 GMT
Received: from [10.175.208.155] (/10.175.208.155)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 09 Apr 2019 03:39:49 -0700
To: Markus Armbruster <armbru@redhat.com>, Lidong Chen <lidong.chen@oracle.com>
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
	<87mukziv48.fsf@dusky.pond.sub.org>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <ea798b5f-d48a-c05f-a8cb-d2eb1f6a5a23@oracle.com>
Date: Tue, 9 Apr 2019 11:39:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87mukziv48.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-GB
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904090069
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904090069
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
	x39AYB1F105018
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
	f4bug@amsat.org, Darren Kenny <darren.kenny@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409103945.kB8layQlcPG87Y05P0pKG47jTWAINUo482-KIN8p4Y0@z>

On 09/04/2019 06:51, Markus Armbruster wrote:
> Lidong Chen <lidong.chen@oracle.com> writes:
>
>> Due to an off-by-one error, the assert statements allow an
>> out-of-bounds array access.
>>
>> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>


Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


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
> This is the second fix for this bug pattern in a fortnight.  Where's
> one, there are more:


As Lidong mentioned, an internal static analysis tool (Parfait) was used=20
to catch these. Not every arch/board is compiled but I had eyeballed the=20
code of most interest to me and they seemed fine (e.g. for array=20
accesses, the subsequent loops used a less-than check)

However, this WIN32 code in util/main-loop.c seems wrong.

425=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(n_poll_fds <=3D ARRAY_SIZE(poll_fds)=
);
426
427=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < w->num; i++) {
428=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 poll_fds[n_poll_fds +=
 i].fd =3D (DWORD_PTR)w->events[i];
429=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 poll_fds[n_poll_fds +=
 i].events =3D G_IO_IN;
430=C2=A0=C2=A0=C2=A0=C2=A0 }

Seems like this should be:

g_assert(n_poll_fds + w->num <=3D ARRAY_SIZE(poll_fds));

Otherwise, the rest seem fine.

Regards,

Liam


>
> $ git-grep '<=3D ARRAY_SIZE'
> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <=3D ARRAY_SIZE(cs->ich_apr=
[0]));
> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <=3D ARRAY_SIZE(cs->ich_apr=
[0]));
> hw/net/stellaris_enet.c:        if (s->tx_fifo_len + 4 <=3D ARRAY_SIZE(=
s->tx_fifo)) {
> hw/sd/pxa2xx_mmci.c:        && s->tx_len <=3D ARRAY_SIZE(s->tx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->rx_len <=3D ARRAY_SIZE(s->rx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->resp_len <=3D ARRAY_SIZE(s->resp_fifo=
);
> hw/sd/sd.c:    assert(state <=3D ARRAY_SIZE(state_name));
> hw/sd/sd.c:    assert(rsp <=3D ARRAY_SIZE(response_name));
> hw/usb/hcd-xhci.c:    assert(n <=3D ARRAY_SIZE(tmp));
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D A=
RRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D A=
RRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D A=
RRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D A=
RRAY_SIZE (multiple_regs)) {
> target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <=3D =
ARRAY_SIZE(dbg->arch.bp));
> tcg/tcg.c:    tcg_debug_assert(pi <=3D ARRAY_SIZE(op->args));
> util/main-loop.c:    g_assert(n_poll_fds <=3D ARRAY_SIZE(poll_fds));
> util/module.c:    assert(n_dirs <=3D ARRAY_SIZE(dirs));
>
> Lidong Chen, would you like to have a look at these?
>
> Cc'ing maintainers to help with further investigation.
>


