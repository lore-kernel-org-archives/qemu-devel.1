Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7236AC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3CB214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rIWOMtD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3CB214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31fr-0004kj-G2
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 13:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.kanda@oracle.com>) id 1i31f3-0004HN-9S
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 13:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.kanda@oracle.com>) id 1i31f2-00010j-3Z
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 13:23:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.kanda@oracle.com>)
 id 1i31f1-0000wI-Lq
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 13:23:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SHKD7i062792;
 Wed, 28 Aug 2019 17:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=fjN9BisfYWfvpa56e4I2eAthao944GMtB1GLXI67HpY=;
 b=rIWOMtD3OKog3Mfc3zfv3j90EhOCq7JgH0INZiFSw/fCQYdnKAMNFSMx9+zwA6wV4wKw
 5db7QO1sFPndkaptt7eetl6wD0rnEIp/9n0GSrsYJ6Wg789i5M233opdgGcVKkBgaSPF
 fPPfAN27PuIqd+y85qTXR6GRyS9GCZcJ21Yb/SyvdxQ6498cRcGCHRby93K8t5tWOZ/q
 X1OtwizoEaS0FbLMXD2vM3eW63jdzLKVCb4BykKUrD42xpAdJoJuUqaXQoLp3wACQVqP
 Bb9Rs4McDAKMFZ/wxo6WPby04wps1/9YEKft7nHmmCems6552nRCjFFWhTAgtPwDJGa/ Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2unwwrr0k7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Aug 2019 17:23:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SHErFA005946;
 Wed, 28 Aug 2019 17:23:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2untetkgau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Aug 2019 17:23:02 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7SHN1e3004334;
 Wed, 28 Aug 2019 17:23:02 GMT
Received: from [192.168.0.236] (/72.179.5.40)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 28 Aug 2019 10:23:01 -0700
To: qemu-devel@nongnu.org
References: <1563374298-17323-1-git-send-email-mark.kanda@oracle.com>
From: Mark Kanda <mark.kanda@oracle.com>
Organization: Oracle Corporation
Message-ID: <277b5916-4e46-1aef-6368-a414de4d2149@oracle.com>
Date: Wed, 28 Aug 2019 12:22:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563374298-17323-1-git-send-email-mark.kanda@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280169
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v2] Only enable the halt poll
 control MSR if it is supported by the host
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
Cc: pbonzini@redhat.com, mtosatti@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gentle ping - I would like to confirm this patch is acceptable.

Thanks/regards,
-Mark

On 7/17/2019 9:38 AM, Mark Kanda wrote:
> The halt poll control MSR should only be enabled on hosts which
> support it.
> 
> Fixes: ("kvm: i386: halt poll control MSR support")
> 
> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> 
> ---
> v2: Remove unnecessary hunks which break migration with older hosts (Paolo)
> ---
>   target/i386/cpu.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a8bafdb8b9..543bc25f64 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2838,7 +2838,6 @@ static PropValue kvm_default_props[] = {
>       { "kvm-asyncpf", "on" },
>       { "kvm-steal-time", "on" },
>       { "kvm-pv-eoi", "on" },
> -    { "kvm-poll-control", "on" },
>       { "kvmclock-stable-bit", "on" },
>       { "x2apic", "on" },
>       { "acpi", "off" },
> 

