Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDA8C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4FC20936
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kmX4brtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4FC20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVg7-0007AE-3Q
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kVVfN-0006Iw-Mg
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 04:09:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kVVfL-00007w-Bn
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 04:09:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M84Dn2168772;
 Thu, 22 Oct 2020 08:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=AVv61J62gDAOs/38d+6midlTJ2E2oTEM1s3L/RZIloY=;
 b=kmX4brtI1mNzOkeM0e9mZ9EWL/ygFWlU2ijlHoA8CSNS8JnBKTrL9LyGTFLlkUq//c1H
 XlhbqxEpdJt2pjglXH/kc/rS8gvSHF1MX+JlBR/FougxqWrRjNw/zoR+KSJjLtwAi4wF
 CSIEMt358UtIvUpRJOemnwPSK3imTKJ0ZZWf7XyAkJIoNk1dBt13FagJFJ2fOYQ0/5hI
 8jR8BcH57NnwbxyoYV2+bmBTCdCCs7b4XyqCvvovHm6QdTa5mjuhVq1GmX1DLuvDDxV5
 qJgv7Ur/KI4IO9xV0LUHbveDzIbNSSFQW2flM4iIMzO0f4V87nmohd6G49nNdqIDHJzt QQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 34ak16msys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Oct 2020 08:09:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M85xXe191366;
 Thu, 22 Oct 2020 08:09:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 34ak19k1yj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2020 08:09:33 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09M89VAs011909;
 Thu, 22 Oct 2020 08:09:32 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 22 Oct 2020 01:09:31 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 988FC1D6B84C; Thu, 22 Oct 2020 09:09:26 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 01/16] memory: Add FlatView foreach function
In-Reply-To: <20201021210922.572955-2-alxndr@bu.edu>
References: <20201021210922.572955-1-alxndr@bu.edu>
 <20201021210922.572955-2-alxndr@bu.edu>
Date: Thu, 22 Oct 2020 09:09:26 +0100
Message-ID: <m24kmm8yx5.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220053
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:09:38
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Cc: f4bug@amsat.org, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On Wednesday, 2020-10-21 at 17:09:07 -04, Alexander Bulekov wrote:
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  include/exec/memory.h | 5 +++++
>  softmmu/memory.c      | 9 +++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 622207bde1..042918dd16 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -719,6 +719,11 @@ static inline FlatView *address_space_to_flatview(AddressSpace *as)
>      return qatomic_rcu_read(&as->current_map);
>  }
>  
> +typedef int (*flatview_cb)(Int128 start,
> +                           Int128 len,
> +                           const MemoryRegion*, void*);
> +
> +void flatview_for_each_range(FlatView *fv, flatview_cb cb , void *opaque);
>  
>  /**
>   * struct MemoryRegionSection: describes a fragment of a #MemoryRegion
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 403ff3abc9..c46b0c6d65 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -656,6 +656,15 @@ static void render_memory_region(FlatView *view,
>      }
>  }
>  
> +void flatview_for_each_range(FlatView *fv, flatview_cb cb , void *opaque)
> +{
> +    FlatRange *fr;

Just to be complete, you probably should check that both fv and cb are
not NULL here - if not using an explicit if/return, at least with
assertions just in case a developer does something silly...

> +    FOR_EACH_FLAT_RANGE(fr, fv) {
> +        if (cb(fr->addr.start, fr->addr.size, fr->mr, opaque))
> +            break;
> +    }
> +}
> +
>  static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
>  {
>      while (mr->enabled) {

Otherwise, all looks good, so:

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

