Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2A2C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C71D206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AyN6DCaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C71D206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZrb-0005yL-7B
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 07:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZm3-000857-Je; Wed, 30 Sep 2020 06:55:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1kNZlx-00013D-SO; Wed, 30 Sep 2020 06:55:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAt9SN042851;
 Wed, 30 Sep 2020 10:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 in-reply-to : references : sender : from : date : message-id :
 mime-version : content-type; s=corp-2020-01-29;
 bh=LK4mrkfkFt0h0TDkpajytllCo+54t/wECyX2TcqqHV4=;
 b=AyN6DCaJZO42Vg7ozpHM4kmdTkEnR+kXgdVGk/PmB/U++8ge3KnKy2zsT4z/v427PF08
 bHs48sgrPeBA6iO4FISa0teZ2QI1N2j+OxSkUsOgpP0ldZcivSiekYXTXQsZtB4Eykos
 jSsjjbXfMRGiOPm3EyFHryvRSLWH0k62koq5o7pyDgf7pLV7SB7SF/iBmY9bOlh4AbQI
 9Lpz3OyNt8wSu3EfVUb+STEqswdVYKZ9nKfePaiGoCBpZiILv19JcCMfJIM0WHZFhIHi
 luHx/3NeaGHpz4Mn6nZbpfEbacYSA3yKvYPsDr5UYO0pJdZg3/Icma6qKpgdZbVH2XOI GA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 33sx9n7reh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Sep 2020 10:55:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UAssu6014007;
 Wed, 30 Sep 2020 10:55:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 33uv2f6h4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 10:55:38 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08UAtc5u027002;
 Wed, 30 Sep 2020 10:55:38 GMT
Received: from disaster-area.hh.sledj.net (/81.187.26.238)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 30 Sep 2020 03:55:37 -0700
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 126917a2;
 Wed, 30 Sep 2020 10:55:35 +0000 (UTC)
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH RFC 11/14] avr/: fix some comment spelling errors
In-Reply-To: <20200930095321.2006-12-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-12-zhaolichang@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <david.edmondson@oracle.com>
Date: Wed, 30 Sep 2020 11:55:35 +0100
Message-ID: <m2ft6zpm8o.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=1 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=1
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300088
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=david.edmondson@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 06:51:12
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.373, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: zhaolichang <zhaolichang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-09-30 at 17:53:18 +08, zhaolichang wrote:

> I found that there are many spelling errors in the comments of qemu/target/avr.
> I used spellcheck to check the spelling errors and found some errors in the folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  target/avr/helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index d96d143..9f325bc 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -97,7 +97,7 @@ int avr_cpu_memory_rw_debug(CPUState *cs, vaddr addr, uint8_t *buf,
>  
>  hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>  {
> -    return addr; /* I assume 1:1 address correspondance */
> +    return addr; /* I assume 1:1 address correspondence */
>  }
>  
>  bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> @@ -298,7 +298,7 @@ void helper_outb(CPUAVRState *env, uint32_t port, uint32_t data)
>  }
>  
>  /*
> - *  this function implements LD instruction when there is a posibility to read
> + *  this function implements LD instruction when there is a possibility to read
>   *  from a CPU register
>   */
>  target_ulong helper_fullrd(CPUAVRState *env, uint32_t addr)
> @@ -322,7 +322,7 @@ target_ulong helper_fullrd(CPUAVRState *env, uint32_t addr)
>  }
>  
>  /*
> - *  this function implements ST instruction when there is a posibility to write
> + *  this function implements ST instruction when there is a possibility to write
>   *  into a CPU register
>   */
>  void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
> -- 
> 2.26.2.windows.1

dme.
-- 
I'm in California dreaming about who we used to be.

