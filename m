Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBBEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9A920679
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+ca9qHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9A920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joP6Y-0004cB-Ey
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joP5n-0004Ab-OP
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:26:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20828
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joP5j-0007Db-QE
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593080807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5UbV+kbMayslyhlBCXvzNvfEWbrA6P+ejDFboqY2is=;
 b=R+ca9qHfhzNRBlnVcU8De4ovMKAOmUrjduwVxsCm3mDGW+ZXqfrWSKE8n+seK5AQ1tl/Gp
 izGC6VwxemZtw0Y1Fh4DDsWwRPEOi9rw78shZDXkCuRyeWeGO9QNnPEbBA7LbFCB2ARoBf
 TBYjoetbVZ/DSS8P+MV3SoiUkUiQI6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-uaqBWlFjMwqMg_HSdl1usQ-1; Thu, 25 Jun 2020 06:26:45 -0400
X-MC-Unique: uaqBWlFjMwqMg_HSdl1usQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B5F81883607;
 Thu, 25 Jun 2020 10:26:44 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0748F2C9F9;
 Thu, 25 Jun 2020 10:26:38 +0000 (UTC)
Subject: Re: [PATCH v5 04/12] pc-bios: s390x: Get rid of magic offsets into
 the lowcore
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200624075226.92728-1-frankja@linux.ibm.com>
 <20200624075226.92728-5-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <df12e713-14a5-2ea9-9f10-de996086d847@redhat.com>
Date: Thu, 25 Jun 2020 12:26:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200624075226.92728-5-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/2020 09.52, Janosch Frank wrote:
> If we have a lowcore struct that has members for offsets that we want
> to touch, why not use it?
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   pc-bios/s390-ccw/cio.h  | 17 +++++++++++------
>   pc-bios/s390-ccw/main.c |  8 +++-----
>   2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
> index aaa432dedd..1e5d4e92e1 100644
> --- a/pc-bios/s390-ccw/cio.h
> +++ b/pc-bios/s390-ccw/cio.h
> @@ -122,12 +122,17 @@ typedef struct schib {
>   } __attribute__ ((packed, aligned(4))) Schib;
>   
>   typedef struct subchannel_id {
> -        __u32 cssid:8;
> -        __u32:4;
> -        __u32 m:1;
> -        __u32 ssid:2;
> -        __u32 one:1;
> -        __u32 sch_no:16;
> +    union {
> +        struct {
> +            __u16 cssid:8;
> +            __u16 reserved:4;
> +            __u16 m:1;
> +            __u16 ssid:2;
> +            __u16 one:1;
> +        };
> +        __u16 sch_id;
> +    };
> +    __u16 sch_no;
>   } __attribute__ ((packed, aligned(4))) SubChannelId;
>   
>   struct chsc_header {
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 4e65b411e1..8b912454c9 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -36,11 +36,9 @@ LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
>    */
>   void write_subsystem_identification(void)
>   {
> -    SubChannelId *schid = (SubChannelId *) 184;
> -    uint32_t *zeroes = (uint32_t *) 188;
> -
> -    *schid = blk_schid;
> -    *zeroes = 0;
> +    lowcore->subchannel_id = blk_schid.sch_id;
> +    lowcore->subchannel_nr = blk_schid.sch_no;
> +    lowcore->io_int_parm = 0;
>   }

Ok, I have to admit that I had to read it multiple times (maybe not 
enough coffee the last time), but it looks fine to me now.

Reviewed-by: Thomas Huth <thuth@redhat.com>


