Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20E9C73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F90020665
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f5Wyiq71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F90020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hktvn-000275-0x
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 13:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56040)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <maran.wilson@oracle.com>) id 1hktoC-0004xb-Fn
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 13:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maran.wilson@oracle.com>) id 1hktoB-0001Gh-AB
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 13:21:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maran.wilson@oracle.com>)
 id 1hkto9-0001Cj-AD
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 13:21:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x69HIxZh094804;
 Tue, 9 Jul 2019 17:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Wv0QUFTPKvZPvBylNpFSHK+beuMbdZ6PAa8/4zex8pU=;
 b=f5Wyiq713b1LDv5QQVmhayE2rDpYLQH0yecZBlW07bR/zVghQ6J1qqu4ntdJSARAW/Xk
 AbcNX1IiNw5DG78qBaO4yri3Khb+u+A08+CF4qTbMcaxhsmX/rH5yf3oMZUWGQxAwljk
 MOBN5TTltVf431N3644U/JyDbyf0Dxvk/9rl8vqboSG1piy8GAOwYwpijHeHQ3Lbkr02
 KbdClQ7PFfsc5fFnC9sBhfJJsgiUwnykUL4ZKRhiUpcrDuHQDy6KjG6AEjwBnjsAW+P5
 4Se6be5EN+5i31J034NL3m0C8qfkGSXFvVhgiEbEo1gmcZaKdZ8a074a0BUKPwx2fRv0 nA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2tjk2tnqxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2019 17:21:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x69HHwUE028387;
 Tue, 9 Jul 2019 17:21:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2tjjykx7fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2019 17:21:34 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x69HLXgR013704;
 Tue, 9 Jul 2019 17:21:33 GMT
Received: from [10.159.233.89] (/10.159.233.89)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 09 Jul 2019 10:21:33 -0700
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20190705210636.3095-1-liran.alon@oracle.com>
 <20190705210636.3095-4-liran.alon@oracle.com>
From: Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <f264c433-facc-5316-e3e7-11a7bb97ea7a@oracle.com>
Date: Tue, 9 Jul 2019 10:21:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705210636.3095-4-liran.alon@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907090204
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907090204
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH 3/4] target/i386: kvm: Save nested-state
 only in case vCPU have set VMXON region
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
Cc: pbonzini@redhat.com, Joao Martins <joao.m.martins@oracle.com>,
 ehabkost@redhat.com, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/2019 2:06 PM, Liran Alon wrote:
> Having (nested_state->hdr.vmx.vmxon_pa != -1ull) signals that vCPU have set
> at some point in time a VMXON region. Note that even though when vCPU enters
> SMM mode it temporarily exit VMX operation, KVM still reports (vmxon_pa != -1ull).
> Therefore, this field can be used as a reliable indicator on when we require to

s/on when we require/for when we are required/

Also, note that you have commit message lines are longer than 76 
characters (longer than 80, for that matter).

But aside from those nits:

Reviewed-by: Maran Wilson <maran.wilson@oracle.com>

Thanks,
-Maran

> send VMX nested-state as part of migration stream.
>
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>   target/i386/machine.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 851b249d1a39..20bda9f80154 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -997,9 +997,8 @@ static bool vmx_nested_state_needed(void *opaque)
>   {
>       struct kvm_nested_state *nested_state = opaque;
>   
> -    return ((nested_state->format == KVM_STATE_NESTED_FORMAT_VMX) &&
> -            ((nested_state->hdr.vmx.vmxon_pa != -1ull) ||
> -             (nested_state->hdr.vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON)));
> +    return (nested_state->format == KVM_STATE_NESTED_FORMAT_VMX) &&
> +           (nested_state->hdr.vmx.vmxon_pa != -1ull);
>   }
>   
>   static const VMStateDescription vmstate_vmx_nested_state = {


