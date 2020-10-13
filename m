Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E75C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08000214DB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOU+HuoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08000214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIJB-0004ax-Pb
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSHzn-0007Nm-Vj
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSHzm-0006Ma-As
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602586649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tPOR8UvJfhV8EWaTgUYjBNeWZODIBwD4pPIQKAcvRQ0=;
 b=NOU+HuoTT10WgYM83w1dwAoSHkvbdG4TCX3i6bw+ANjjTrfPiLB+BjiAEYVDX1SuJ2ReSC
 Xfd+xuRRaRdj+tBhabsaIudtUkGjoes+NGPvCuzanruV0hqKssJhQsS29f0yXvibPmUNEq
 wb+LhMDqhC3uLxwld2/mbamGDvnYiy0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-Sbz2-ytqMUW081U6KA45gw-1; Tue, 13 Oct 2020 06:57:28 -0400
X-MC-Unique: Sbz2-ytqMUW081U6KA45gw-1
Received: by mail-wm1-f71.google.com with SMTP id d197so5808545wmd.4
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 03:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tPOR8UvJfhV8EWaTgUYjBNeWZODIBwD4pPIQKAcvRQ0=;
 b=sn3rsqwRvg20T0xk42wlGP2pzvOl9MygMCbebN4BZyb5vb9xbNw4eFNZIBisiT6i00
 pv93ggU4OMdhk3fg+pet2q/P6gG6h5bAjUeBOmQ/CVRr92Iot7gRoHt29cPqhzY5qmNY
 LSAqlchU/yRcjcfuiZcnT97lLrPDZFhumlhk0i65AmL9F31B83U2sJK22O8MbjnWCsQ6
 k8lHha6NI/KzXzfncAuxPg14yo/xeZTANAEIeQGL87eB3ruV4TQPICzcQS3FjFndsEFz
 PHldP/tYNN5O0NSVs7b2iCpZRd3Y8WK2yFRou4U6noLrOYaTpoDeb1NVHx4p9OGST7f9
 9aiQ==
X-Gm-Message-State: AOAM533y38WSxl1QTeb0YiFooV6vjNhXW4nsh9iY15jimYQGF3T6Huzc
 5pQj7EyBvXiXhga5EQd0ca8bRq4lLFOt0IA5GsxhjqqCya0nmRYC+BsDyLnCAMaJUBE8i735eXt
 PyJ4oaN/bfh52DHs=
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr15855845wmi.140.1602586645544; 
 Tue, 13 Oct 2020 03:57:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTRAO8FwNEyMWALwBX+2n4BjoC3Vhe+REBAyyQADGKcLnDf20g00IPUNBa4H1TWQjFrMe63w==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr15855822wmi.140.1602586645230; 
 Tue, 13 Oct 2020 03:57:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:61dd:85cb:23fc:fd54?
 ([2001:b07:6468:f312:61dd:85cb:23fc:fd54])
 by smtp.gmail.com with ESMTPSA id k18sm10263779wrx.96.2020.10.13.03.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 03:57:24 -0700 (PDT)
Subject: Re: [PATCH v2] Makefile: Add *.[ch].inc files to cscope/ctags/TAGS
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <160258069310.900922.1495166540282536628.stgit@bahia.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a62bfc14-2da7-1e63-0740-7188f82cd89d@redhat.com>
Date: Tue, 13 Oct 2020 12:57:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160258069310.900922.1495166540282536628.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/10/20 11:18, Greg Kurz wrote:
> The code base has some C source and header files that don't get indexed
> because their name ends with .inc:
> 
> $ git ls-files "*.[ch].inc" | wc -l
> 66
> 
> Add them to the list.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> --
> v2: add the missing \( and \)
> ---
>  Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index c37e513431fe..3c5a0b0f7a11 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -190,7 +190,7 @@ distclean: clean ninja-distclean
>  	rm -f linux-headers/asm
>  	rm -Rf .sdk
>  
> -find-src-path = find "$(SRC_PATH)/" -path "$(SRC_PATH)/meson" -prune -o -name "*.[chsS]"
> +find-src-path = find "$(SRC_PATH)/" -path "$(SRC_PATH)/meson" -prune -o \( -name "*.[chsS]" -o -name "*.[ch].inc" \)
>  
>  .PHONY: ctags
>  ctags:
> 
> 

Cc: qemu-trivial@nongnu.org


