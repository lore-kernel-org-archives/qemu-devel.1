Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7AFC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05815206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfzWzyvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05815206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDvh0-0005AJ-21
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 16:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDvgG-0004Jz-Cd
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:18:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50047
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDvgD-0007i6-Jp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599164275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oKvN/3Sxq8A3petd99IC4PMQL9g40UYvQmtSK8chBQk=;
 b=BfzWzyvmA05swkaSJCelAm4M9Pk/Gnfz8UjiQ5vailL6He43rz4FUqvmUqbr/1U6WQ8x8J
 Xd9b7//BJCs3tmCnumcae/m+Q1bMoYnS6/XXsUoIRdDX1+QezEOqXCnZMxki1z9nLJ/szl
 LCYRwLi+soMZI+IRKkkgc/+mJ1pXZW8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-Y_MSsldwMk2uz8ATtpP7KA-1; Thu, 03 Sep 2020 16:17:53 -0400
X-MC-Unique: Y_MSsldwMk2uz8ATtpP7KA-1
Received: by mail-ej1-f70.google.com with SMTP id li24so795083ejb.6
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 13:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oKvN/3Sxq8A3petd99IC4PMQL9g40UYvQmtSK8chBQk=;
 b=qDvrBTfCVswqW/CQeCH+7HW750uOOx3m899sP1uzTIuMuusiLjEk+xARUJLxxMDYL2
 BKgXCPLwn93CxwEVm9AGvItzUGtqJd0laKCy/am2905czp0xHQgUNNsCir8sNknXJHq5
 7SouBZ2CTleAT/IG805wKXRYjWXFk3D08DHv+K2+QBhNDIlF26pZbA4+vPCL9EHXWDCF
 yAjfdsao+bSRl10ZS4Quj9jxhwv78Tw2ZY6Ry1ZSFQespQN4sXEGpvI2l/kSCbKT2osu
 oKVfyB0QpMRNev7Xft9f5GmEMb11iaNltgPu7k7qbYwBAeEE80Mpw2IYsCGpEL3weh0L
 NI8g==
X-Gm-Message-State: AOAM533PYCIxDD2wxugat99PBYdRXKE4ZTEeznj3a/Ugm9ilkVY4T6en
 T9Z1EA3mI4hVpDnZYbbnq+0hsV+f0nocmYX/y8uC5pdlDxj5t+rlQ/0DcKj1wDmgxr9my+jQQQJ
 8pxXMLITM5leyUFs=
X-Received: by 2002:a17:906:f2d3:: with SMTP id
 gz19mr3855012ejb.377.1599164272903; 
 Thu, 03 Sep 2020 13:17:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXR7H4HIbFHsReiTlGellGUs3+lWoK0mlEyWM6biF7V70t3M4rfI3a/vry8XoCntG+1VQUug==
X-Received: by 2002:a17:906:f2d3:: with SMTP id
 gz19mr3854996ejb.377.1599164272708; 
 Thu, 03 Sep 2020 13:17:52 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id b1sm3954156eja.43.2020.09.03.13.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 13:17:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] Makefile: Skip the meson subdir in cscope/TAGS/ctags
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <159916226258.691541.13056254320330610953.stgit@bahia.lan>
 <159916247553.691541.10480293747685886851.stgit@bahia.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <abd5e0e5-a647-2450-06aa-bd6b9f3cd40e@redhat.com>
Date: Thu, 3 Sep 2020 22:17:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <159916247553.691541.10480293747685886851.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/20 21:47, Greg Kurz wrote:
> If the meson submodule is present, we don't really want to index its
> source code. Consolidate the find command in a single place and use
> it for cscope, ctags and etags. Note that this now causes ctags and
> etags to also index assembly files, but this is okay since they both
> have been supporting assembly since 2001 at least.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  Makefile |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index a9d3e2c4d375..34dd9e6c4c4a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -229,20 +229,22 @@ distclean: clean ninja-distclean
>  	rm -f linux-headers/asm
>  	rm -Rf .sdk
>  
> +find-src-path = find "$(SRC_PATH)/" -path "$(SRC_PATH)/meson" -prune -o -name "*.[chsS]"
> +
>  .PHONY: ctags
>  ctags:
>  	rm -f tags
> -	find "$(SRC_PATH)" -name '*.[hc]' -exec ctags --append {} +
> +	$(find-src-path) -exec ctags --append {} +
>  
>  .PHONY: TAGS
>  TAGS:
>  	rm -f TAGS
> -	find "$(SRC_PATH)" -name '*.[hc]' -exec etags --append {} +
> +	$(find-src-path) -exec etags --append {} +
>  
>  .PHONY: cscope
>  cscope:
>  	rm -f "$(SRC_PATH)"/cscope.*
> -	find "$(SRC_PATH)/" -name "*.[chsS]" -print | sed -e 's,^\./,,' > "$(SRC_PATH)/cscope.files"
> +	$(find-src-path) -print | sed -e 's,^\./,,' > "$(SRC_PATH)/cscope.files"
>  	cscope -b -i"$(SRC_PATH)/cscope.files"
>  
>  # Needed by "meson install"
> 
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

so this can go through the trivial tree as well.

Paolo


