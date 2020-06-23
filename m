Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C88C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB7620738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gK1J4QlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB7620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnghu-0002u9-IM
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liran.alon@oracle.com>)
 id 1jnghC-00028W-Hq
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:02:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liran.alon@oracle.com>)
 id 1jngh8-0005bg-N8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:02:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05NB1lKr108127;
 Tue, 23 Jun 2020 11:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=O1PQZtYeDKDpJvlFr4mN82x+eoq4SFMub3fgkluk08U=;
 b=gK1J4QlIvsfSzlUQvPi0d612se4o25xNppYCRjMaf9tGdgXWZxicpFHLEZe7sidkk42N
 MdXhja0642Yg7cRiD1JbeHmCYsz05z+dWrHu7qGGCEorGE/9hZQBah1Rqre+C90QFej3
 DSq3YZcRlLWOGKkomvY6gJLUUB2i5mI60PM9EDkXtrlHoPFeo11FzNWs6RXrpi0ODYod
 kdqzT5cvxVPfTcj8zfANJJDyHprLdm3YjXSvrFlxyC6VQXd0xt3rRaXGxljtMAO01NGO
 9iYZCs0slWHqokacnnSdu4Kbqbi2OmMJIuTjysM6/sOuxilWrMD/6bPEalZKlqEIzntD 7w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 31sebbckn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 23 Jun 2020 11:02:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05NAx9RV130067;
 Tue, 23 Jun 2020 11:02:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 31svcwjxrr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2020 11:02:23 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05NB2MXA008968;
 Tue, 23 Jun 2020 11:02:22 GMT
Received: from [192.168.14.112] (/79.176.227.138)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 23 Jun 2020 11:02:22 +0000
Subject: Re: [PATCH] vmport: move compat properties to hw_compat_5_0
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200623102834.4816-1-pbonzini@redhat.com>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <41297039-e7af-a9cd-b1e4-3db2c8fe4f94@oracle.com>
Date: Tue, 23 Jun 2020 14:02:20 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623102834.4816-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 cotscore=-2147483648
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006230088
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=liran.alon@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 07:02:25
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 23/06/2020 13:28, Paolo Bonzini wrote:
> The patches that introduced the properties were submitted when QEMU 5.0
> had not been released yet, so they got merged under the wrong heading.
> Move them to hw_compat_5_0 so that 5.0 machine types get the pre-patch
> behavior.
>
> Reported-by: Laurent Vivier <lvivier@redhat.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
> ---
>   hw/core/machine.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1d80ab0e1d..211b4e077a 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -30,6 +30,10 @@
>   
>   GlobalProperty hw_compat_5_0[] = {
>       { "virtio-balloon-device", "page-poison", "false" },
> +    { "vmport", "x-read-set-eax", "off" },
> +    { "vmport", "x-signal-unsupported-cmd", "off" },
> +    { "vmport", "x-report-vmx-type", "off" },
> +    { "vmport", "x-cmds-v2", "off" },
>   };
>   const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
>   
> @@ -45,10 +49,6 @@ GlobalProperty hw_compat_4_2[] = {
>       { "qxl", "revision", "4" },
>       { "qxl-vga", "revision", "4" },
>       { "fw_cfg", "acpi-mr-restore", "false" },
> -    { "vmport", "x-read-set-eax", "off" },
> -    { "vmport", "x-signal-unsupported-cmd", "off" },
> -    { "vmport", "x-report-vmx-type", "off" },
> -    { "vmport", "x-cmds-v2", "off" },
>   };
>   const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
>   

