Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C93AC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F33238A1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REwIMjoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F33238A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPlZ-0000eY-DL
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kLPkx-0000BO-8m
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kLPks-0007sX-25
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600948180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=itf/UKi4SOQZst2daizsyMu83mp9as4Q3urTHliP3A0=;
 b=REwIMjoaJWhdlzUAZhqQ0qKt+eRxE7zul374rIXxP4kWrl3rNQZbhm/klEVX/ZSBuo/fW0
 CLL0MSXm5dePSeU9J7b1mGklytczeNrMKLEmyECV5W7utnbkz5k4Y2QET7p7eCLXdSRHwP
 Eb4WdRB9+vH7xeOPprKJbwFZxD9FRtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-djv0-feNOUCzx6B2zhygyw-1; Thu, 24 Sep 2020 07:49:38 -0400
X-MC-Unique: djv0-feNOUCzx6B2zhygyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98867186842F;
 Thu, 24 Sep 2020 11:49:37 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-113.ams2.redhat.com [10.36.113.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FCB75576C;
 Thu, 24 Sep 2020 11:49:31 +0000 (UTC)
Subject: Re: [PATCH 2/3] pc-bios/s390-ccw: break loop if a null block number
 is reached
To: Marc Hartmayer <mhartmay@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200924085926.21709-1-mhartmay@linux.ibm.com>
 <20200924085926.21709-3-mhartmay@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e5067875-2c38-a114-5752-926c208dedb2@redhat.com>
Date: Thu, 24 Sep 2020 13:49:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200924085926.21709-3-mhartmay@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, Janosch Frank <frankja@linux.ibm.com>,
 "Collin L. Walling" <walling@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/2020 10.59, Marc Hartmayer wrote:
> Break the loop if `cur_block_nr` is a null block number because this
> means that the end of chunk is reached. In this case we will try to
> boot the default entry.
> 
> Fixes: ba831b25262a ("s390-ccw: read stage2 boot loader data to find menu")
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 0d29dceaa3cc..08f16c5595a3 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -192,7 +192,7 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
>      for (i = 0; i < STAGE2_BLK_CNT_MAX; i++) {
>          cur_block_nr = eckd_block_num(&s1b->seek[i].chs);
>  
> -        if (!cur_block_nr) {
> +        if (!cur_block_nr || is_null_block_number(cur_block_nr)) {
>              break;
>          }

Reviewed-by: Thomas Huth <thuth@redhat.com>

I'll queue the two patches on my s390-ccw bios branch. Just let me know
if you'd like to have the "< ... - 3" changed into "<= ... - 4" in the
first patch, I can tweak it directly if you like.

 Thomas


