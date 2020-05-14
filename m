Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151F1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69C320728
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EZcXafgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69C320728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDvu-0002DY-3m
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jZDvI-00019I-36
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:29:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jZDvG-0002H4-BR
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:29:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EDRbim159229;
 Thu, 14 May 2020 13:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=byefpNRMlYTO7Qff3oneL+hr+8a3oU/t3NzTLuXOUCI=;
 b=EZcXafgzYe1+hpX23Zcc+a0RxqijAUVVmtJN4ywKEFp7OMyWrXJ4+rpgwVHloBZtu4o0
 7987NxD/Kou8Y0Y5M3IuPpdMSEQ9losPAEF0BMK5ZDAm0aPE+ClvP++VFpWkQ22D8SBv
 vLG9scTLigj5V9ixJQ7RNEtmN4YSoCDM0CB7m5r32yOXZ9kgnZM2P8eo5nqsFFnXuocv
 G02ZS9wY7LYREwd14RVWYmcNOR0mDacwMFoT5o/drHdcz6pYd2OybijBMlrTSCz+fRiw
 DW/z19I1K7O/t+WWft3vxdVxLi41kRNbQB9cfiYd5/w9YhpwHjzLA+n8btDpAUlK6lfA YQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 3100xwjj0s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 May 2020 13:28:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EDS5O9091522;
 Thu, 14 May 2020 13:28:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 3100ycnqgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 13:28:53 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04EDSqRN011266;
 Thu, 14 May 2020 13:28:52 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 14 May 2020 06:28:52 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id A5B1A696EE12; Thu, 14 May 2020 14:28:44 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 3/3] megasas: use unsigned type for positive numeric
 fields
In-Reply-To: <20200513192540.1583887-4-ppandit@redhat.com>
References: <20200513192540.1583887-1-ppandit@redhat.com>
 <20200513192540.1583887-4-ppandit@redhat.com>
Date: Thu, 14 May 2020 14:28:44 +0100
Message-ID: <m2eermk5mb.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=1 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0
 suspectscore=1 mlxlogscore=999 clxscore=1015 cotscore=-2147483648
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140120
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 09:29:03
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Prasad J Pandit <pjp@fedoraproject.org>,
 Alexander Bulekov <alxndr@bu.edu>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Ding Ren <rding@gatech.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, 2020-05-14 at 00:55:40 +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Use unsigned type for the MegasasState fields which hold positive
> numeric values.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  hw/scsi/megasas.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index b531d88a9b..634af0bbb8 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -86,34 +86,34 @@ typedef struct MegasasState {
>      MemoryRegion queue_io;
>      uint32_t frame_hi;
>  
> -    int fw_state;
> +    uint32_t fw_state;
>      uint32_t fw_sge;
>      uint32_t fw_cmds;
>      uint32_t flags;
> -    int fw_luns;
> -    int intr_mask;
> -    int doorbell;
> -    int busy;
> -    int diag;
> -    int adp_reset;
> +    uint32_t fw_luns;
> +    uint32_t intr_mask;
> +    uint32_t doorbell;
> +    uint32_t busy;
> +    uint32_t diag;
> +    uint32_t adp_reset;
>      OnOffAuto msi;
>      OnOffAuto msix;
>  
>      MegasasCmd *event_cmd;
> -    int event_locale;
> +    uint16_t event_locale;
>      int event_class;
> -    int event_count;
> -    int shutdown_event;
> -    int boot_event;
> +    uint32_t event_count;
> +    uint32_t shutdown_event;
> +    uint32_t boot_event;
>  
>      uint64_t sas_addr;
>      char *hba_serial;
>  
>      uint64_t reply_queue_pa;
>      void *reply_queue;
> -    int reply_queue_len;
> +    uint16_t reply_queue_len;
>      uint16_t reply_queue_head;
> -    int reply_queue_tail;
> +    uint16_t reply_queue_tail;
>      uint64_t consumer_pa;
>      uint64_t producer_pa;
>  
> @@ -2259,9 +2259,9 @@ static const VMStateDescription vmstate_megasas_gen1 = {
>          VMSTATE_PCI_DEVICE(parent_obj, MegasasState),
>          VMSTATE_MSIX(parent_obj, MegasasState),
>  
> -        VMSTATE_INT32(fw_state, MegasasState),
> -        VMSTATE_INT32(intr_mask, MegasasState),
> -        VMSTATE_INT32(doorbell, MegasasState),
> +        VMSTATE_UINT32(fw_state, MegasasState),
> +        VMSTATE_UINT32(intr_mask, MegasasState),
> +        VMSTATE_UINT32(doorbell, MegasasState),
>          VMSTATE_UINT64(reply_queue_pa, MegasasState),
>          VMSTATE_UINT64(consumer_pa, MegasasState),
>          VMSTATE_UINT64(producer_pa, MegasasState),
> @@ -2278,9 +2278,9 @@ static const VMStateDescription vmstate_megasas_gen2 = {
>          VMSTATE_PCI_DEVICE(parent_obj, MegasasState),
>          VMSTATE_MSIX(parent_obj, MegasasState),
>  
> -        VMSTATE_INT32(fw_state, MegasasState),
> -        VMSTATE_INT32(intr_mask, MegasasState),
> -        VMSTATE_INT32(doorbell, MegasasState),
> +        VMSTATE_UINT32(fw_state, MegasasState),
> +        VMSTATE_UINT32(intr_mask, MegasasState),
> +        VMSTATE_UINT32(doorbell, MegasasState),
>          VMSTATE_UINT64(reply_queue_pa, MegasasState),
>          VMSTATE_UINT64(consumer_pa, MegasasState),
>          VMSTATE_UINT64(producer_pa, MegasasState),
> -- 
> 2.25.4

