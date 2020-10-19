Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ED9C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00652225F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVkBYlu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00652225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUR8G-0001Xy-Mx
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUR6l-00008t-Oz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25156)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUR6k-0005hg-5I
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603098332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KHH7AUeJjM10KBEJPc95hnWGwBkzMVPFapImEdSf9U4=;
 b=bVkBYlu1JIk69cJ9o5dPQmWP5WHVy72yrqP8muMPFlWmHZErumyESKSmZ0Lmt29byx+4aL
 eGfjPgxSV98vXEjXAu4eOZEI0yV6tC027vSQTyysqxOHeD3QeLOj7VO33tNB92Vyoc8xg4
 tc6eTBHndGLv8aj5UtVLzOv3bDWY2BE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-bt6MNz-KPKy9v7ArMaQMyg-1; Mon, 19 Oct 2020 05:05:28 -0400
X-MC-Unique: bt6MNz-KPKy9v7ArMaQMyg-1
Received: by mail-wr1-f72.google.com with SMTP id n14so7140142wrp.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 02:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KHH7AUeJjM10KBEJPc95hnWGwBkzMVPFapImEdSf9U4=;
 b=Rb9hDZ+RKXTqIfdvXGO0qqej2ILt44RZN5/Lj4MrJW5TmaJQmUKioe/yOIk1974ffq
 Ic3OQFGEvRr1xTsaaMc7wzN8kCqhvM/1N1PShhqs/BtP32hS+2ACJB9WK0sKkTYNlDrm
 f6P/QukdewnH9x1f97q5FiPxmEM9hlMSuX8Th2TNem3s1QbgQ/ZxnCjN4P+KN+NrJzsu
 jHSWRhQq1gVSu5Udbm0oW72nGSnKZMNQnEHww+32YeeWQ3dmiEqxm2qNyM9Cftl31uLc
 qVfkfjKhhrHagXHLmjPAZIHfzPp8+O2DbVDLhzK0BdEz6w5hJ++bjgt6h3c9GBsteCZL
 jL+Q==
X-Gm-Message-State: AOAM532TRyrt7MX25cw2aMIN4EKwcXdDazkkTZWvVGR8crDdchCIs4Sl
 Prs4F/Wj+CQk7Um15Lia5bYc9RVRFBX3A0/TJ2QkrwjuH0+3nMQuVVZkSicjTxT+cP3h98grdPP
 +mbPvgVBVlx5+0Gc=
X-Received: by 2002:adf:f9cf:: with SMTP id w15mr19115602wrr.185.1603098327398; 
 Mon, 19 Oct 2020 02:05:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5bg2YhtOQTNQVSCulEJNbctskVUEueSxYH7LmRSkBxOXBSAWtqr8oiSdmCyRcIx88X2JkSg==
X-Received: by 2002:adf:f9cf:: with SMTP id w15mr19115570wrr.185.1603098327111; 
 Mon, 19 Oct 2020 02:05:27 -0700 (PDT)
Received: from [192.168.1.36] (36.red-83-57-175.dynamicip.rima-tde.net.
 [83.57.175.36])
 by smtp.gmail.com with ESMTPSA id y4sm6616523wmj.2.2020.10.19.02.05.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 02:05:26 -0700 (PDT)
Subject: Re: [PATCH 2/5] spapr: Use appropriate getter for PC_DIMM_ADDR_PROP
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <160309729609.2739814.4996614957953215591.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6e2471f8-5369-c36d-6721-730efd73dd58@redhat.com>
Date: Mon, 19 Oct 2020 11:05:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160309729609.2739814.4996614957953215591.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 10:48 AM, Greg Kurz wrote:
> The PC_DIMM_ADDR_PROP property is defined as:
> 
>      DEFINE_PROP_UINT64(PC_DIMM_ADDR_PROP, PCDIMMDevice, addr, 0),
> 
> Use object_property_get_uint() instead of object_property_get_int().
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/ppc/spapr.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4edd31b86915..115fc52e3b06 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3572,8 +3572,8 @@ static SpaprDimmState *spapr_recover_pending_dimm_state(SpaprMachineState *ms,
>       uint64_t addr_start, addr;
>       int i;
>   
> -    addr_start = object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP,
> -                                         &error_abort);
> +    addr_start = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
> +                                          &error_abort);
>   
>       addr = addr_start;
>       for (i = 0; i < nr_lmbs; i++) {
> 
> 
> 


