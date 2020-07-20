Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1541C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10812070A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYqLIxrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10812070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxUGh-0004lm-SE
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxUFD-00033O-Gi
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 07:46:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27260
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxUFA-0006Ei-LW
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 07:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595245563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=6K2cZnKBSmqNJJHaoBjkJCXIDRoxysZ7Lc1lCpBnjSs=;
 b=bYqLIxrEFxda84CRCCgsfb+wjqxOQ+ZZ9PlOuQQ5Rj3DT44ZuKJ2frpfLF8/zwK3cHOiWu
 q33vuiEC4EknFvUi1H/osIfKZXP6ebXL79IyzRehCBM7hob9zWBxPqY+8IbNXqRAXa5929
 iOVpnd623gji2upAKjPyZ+wJ6ltUHP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-OYRsO75UNUC4U_PI9EzUQQ-1; Mon, 20 Jul 2020 07:46:01 -0400
X-MC-Unique: OYRsO75UNUC4U_PI9EzUQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5041B10AE;
 Mon, 20 Jul 2020 11:46:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33B2B5D9E4;
 Mon, 20 Jul 2020 11:45:56 +0000 (UTC)
Subject: Re: [PATCH 3/7] pc-bios: s390x: Remove unneeded dasd-ipl.c reset psw
 mask changes
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200715094045.381984-1-frankja@linux.ibm.com>
 <20200715094045.381984-4-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <fdc4168f-ea1d-de51-9b6f-ddced1d19f5e@redhat.com>
Date: Mon, 20 Jul 2020 13:45:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200715094045.381984-4-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:11:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/07/2020 11.40, Janosch Frank wrote:
> jump_to_low_kernel() and the functions that it calls will already or
> 64 bit addressing into the reset psw mask when executing
> jump_to_IPL_2() after the diag308 subcode 1.

But there is also a check in jump_to_low_kernel that could be affected
by your change:

    if (*((uint64_t *)0) & RESET_PSW_MASK) {
        jump_to_IPL_code((*((uint64_t *)0)) & PSW_MASK_SHORT_ADDR);
    }

... but I assume that there should not be any kernels out there in the
wild which do not have these bits set, so I think your modifications
here should be ok.

Acked-by: Thomas Huth <thuth@redhat.com>


> The kernel proper is then branched to rather than doing a full PSW
> change.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/dasd-ipl.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c
> index 0fc879bb8e..e8f2846740 100644
> --- a/pc-bios/s390-ccw/dasd-ipl.c
> +++ b/pc-bios/s390-ccw/dasd-ipl.c
> @@ -206,7 +206,6 @@ static void run_ipl2(SubChannelId schid, uint16_t cutype, uint32_t addr)
>   */
>  void dasd_ipl(SubChannelId schid, uint16_t cutype)
>  {
> -    PSWLegacy *pswl = (PSWLegacy *) 0x00;
>      uint32_t ipl2_addr;
>  
>      /* Construct Read IPL CCW and run it to read IPL1 from boot disk */
> @@ -229,7 +228,5 @@ void dasd_ipl(SubChannelId schid, uint16_t cutype)
>      run_ipl2(schid, cutype, ipl2_addr);
>  
>      /* Transfer control to the guest operating system */
> -    pswl->mask |= PSW_MASK_EAMODE;   /* Force z-mode */
> -    pswl->addr |= PSW_MASK_BAMODE;   /* ...          */
>      jump_to_low_kernel();
>  }


