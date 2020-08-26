Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C810BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD2320738
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2YqzzT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD2320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxc4-0002uI-Ql
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kAxZB-0000Et-KY
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kAxZ9-0008OR-Nh
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598456542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U8n3BFjGFZJml+ahlhiogNP+TZYxyMBl8wcxGwtMPs8=;
 b=C2YqzzT/7793BxPaLtobl87dYiA9KDhosoKuH+QzzrhQuX8Cg1fedS7AHPoghE1oW4XiMU
 GM+uc52g2pMDlOjMrs0pqVQmw/Ux/Ull8mpz5pGb8MJ0kPV6HQ2j6HKpXLWzLJXsZ03Bmd
 SE7h9OkFGZNPPRjcEhqXEPVazDpTppI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-E2-6v_LZOO2UEhHqhTEOEw-1; Wed, 26 Aug 2020 11:42:19 -0400
X-MC-Unique: E2-6v_LZOO2UEhHqhTEOEw-1
Received: by mail-qk1-f200.google.com with SMTP id a19so608925qka.15
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=U8n3BFjGFZJml+ahlhiogNP+TZYxyMBl8wcxGwtMPs8=;
 b=sYHf4JUQTsL0Gk84hhYmgiFb+9cvmr6RWhqd19rkXgmgYQsoFIBoZTT6eXDObPKkxl
 FqV1PAIOZp5GF0+oPoLjw8F/Vn50OthIAU1uPIvLOLzEGS9kJBR6bIbTyAzxk26NwXZ8
 8CBNijJrRnIxWeODVSYShDlDbvTZwElrmP98SGbGI11KfFAXuepcsJoM342p5vo4KDFX
 hedAZkAsh8k2Cf4080Axs0fhsNLhfEeWyxv2gstVnc7eBbY9BqN9ytk/sdsgRHajrP4e
 QWe7YAu6V7DwiS20rhD9hzjrUnfMNwd8+DEY8lapSywMBhL2mplkDyQbDbdVf19BJRnK
 hkuw==
X-Gm-Message-State: AOAM531WxErg8ltzXndf53X9/6DeSc+kRRRTacZ73cxG1MYzZKIJHEG4
 zfIwO3EQGQQJdzT8DOb9g8J9gucO+kzNYx+SFMHNl5rwdYYM4+vUf7Lf93slEvBI9FqhwQ8yqHl
 vr8+J7hKcLWE3FvY=
X-Received: by 2002:a37:af06:: with SMTP id y6mr14480843qke.356.1598456538775; 
 Wed, 26 Aug 2020 08:42:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwX6cAofU0pi6MyOOE0D/QEZEQ3OylZBngi26SFZjehDM3LcylrdBabXbq81UIUDicpS30Fqg==
X-Received: by 2002:a37:af06:: with SMTP id y6mr14480818qke.356.1598456538468; 
 Wed, 26 Aug 2020 08:42:18 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id i14sm2208861qtq.33.2020.08.26.08.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 08:42:17 -0700 (PDT)
Date: Wed, 26 Aug 2020 11:42:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC v6 02/13] memory: Add IOMMUTLBNotificationType to
 IOMMUTLBEntry
Message-ID: <20200826154215.GE8235@xz-x1>
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200826143651.7915-1-eperezma@redhat.com>
 <20200826143651.7915-3-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200826143651.7915-3-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 23:30:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 04:36:40PM +0200, Eugenio Pérez wrote:
> This way we can tell between MAPs and UNMAP, and potentially avoid to
> send them to a notifier that does not require them.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  include/exec/memory.h | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 22c5f564d1..f6d91c54aa 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -59,6 +59,12 @@ struct ReservedRegion {
>  
>  typedef struct IOMMUTLBEntry IOMMUTLBEntry;
>  
> +typedef enum {
> +    IOMMU_IOTLB_NONE  = 0,
> +    IOMMU_IOTLB_UNMAP = 1,
> +    IOMMU_IOTLB_MAP   = 2,
> +} IOMMUTLBNotificationType;

Can we directly use IOMMUNotifierFlag as the type rather than introducing a
similar enumeration?  Thanks,

-- 
Peter Xu


