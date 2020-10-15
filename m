Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B630C43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B619722256
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjdVnjJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B619722256
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT4rK-0007s6-Im
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kT4pv-0006Xu-GN
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kT4pt-00048V-Ba
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602774392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1RJ3DyiwwpRwvoNkb4PFnt+mf8SoKW5A/k4t5y8tXQQ=;
 b=TjdVnjJOYIpVK/zVVIYeEugjjpyKtlH9cfGNgwdlJq8+QIj+OZ4oILSPt37x4HJUDxg07O
 gehNE+b7kfwt40KfUUidFWt0iKJEDeY5EjZnZ+kkW7qXNkUxE8+iX0swQ+MI5h16g2a8pz
 tD/j1aQsL7mYSpyEumT3r7dB4BUQy58=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-drufaNZUNbC6YB5_FlJlaA-1; Thu, 15 Oct 2020 11:06:30 -0400
X-MC-Unique: drufaNZUNbC6YB5_FlJlaA-1
Received: by mail-wm1-f72.google.com with SMTP id 13so2072763wmf.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 08:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1RJ3DyiwwpRwvoNkb4PFnt+mf8SoKW5A/k4t5y8tXQQ=;
 b=Mf4d1tZIXlMhLfSR9h1B9YHVmM8S206XUzcE9z7C0fyPWnGtvLMZ1rR1i//80cG97a
 gxqeTFaSteTWGqfNCkNUGFEygRbChfT7nIuGRdAe7EqND24Ed7HegoukkPuuTmGgVgkk
 dDTE97Ua7xoXqpOa9fUS0k+jexRSUEhZYimu3FyN2IT6Mcbb8wf1F7rDmcCxyDp10WCK
 yQfL2jNnL+6xG/FDYwK7vibrTTQsvolAAS3d+SpuWvxRQ9AyZlI2TqSHsxJ1v8/Pq5r9
 Y/06vl8nh2ucapCY4VYA5WGVf+0R3rn0ynR/wz7MciPZwhwb3Qt28QcU4AqKj2XlNAj0
 zA7g==
X-Gm-Message-State: AOAM531kP6RLft3fhWPNFW0Tgknc6yuIMSSMOE6aINmuxyp71XHL2G8Z
 Smb55KcvEcBuddS2SV24eagBZdBYijQq37aNSJJ2SRpwPRaAsQlzRDuSckXhg1boIWhjMvS045t
 NwW7ImlIUki9wJPY=
X-Received: by 2002:adf:bb43:: with SMTP id x3mr4854095wrg.250.1602774389173; 
 Thu, 15 Oct 2020 08:06:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZyvfPEG/maBD2hfLHtzVOJwGCNmVZTz/tMxHIdLJFOD/G6B/HLXKN2khB3IjR7W2MS5MJgg==
X-Received: by 2002:adf:bb43:: with SMTP id x3mr4854062wrg.250.1602774388877; 
 Thu, 15 Oct 2020 08:06:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2110:4ced:a13b:6857?
 ([2001:b07:6468:f312:2110:4ced:a13b:6857])
 by smtp.gmail.com with ESMTPSA id n2sm4871216wrt.82.2020.10.15.08.06.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 08:06:27 -0700 (PDT)
Subject: Re: [PATCH] Makefile: Ensure cscope.out/tags/TAGS are generated in
 the source tree
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <160277334665.1754102.10921580280105870386.stgit@bahia.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1bb86de1-75b3-be22-0363-505363478ada@redhat.com>
Date: Thu, 15 Oct 2020 17:06:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160277334665.1754102.10921580280105870386.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/10/20 16:49, Greg Kurz wrote:
> Tools usually expect the index files to be in the source tree, eg. emacs.
> This is already the case when doing out-of-tree builds, but with in-tree
> builds they end up in the build directory.
> 
> Force cscope, ctags and etags to put them in the source tree.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  Makefile |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 3c5a0b0f7a11..45f983d9ef08 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -194,19 +194,19 @@ find-src-path = find "$(SRC_PATH)/" -path "$(SRC_PATH)/meson" -prune -o \( -name
>  
>  .PHONY: ctags
>  ctags:
> -	rm -f tags
> -	$(find-src-path) -exec ctags --append {} +
> +	rm -f "$(SRC_PATH)/"tags
> +	$(find-src-path) -exec ctags -f "$(SRC_PATH)/"tags --append {} +
>  
>  .PHONY: TAGS
>  TAGS:
> -	rm -f TAGS
> -	$(find-src-path) -exec etags --append {} +
> +	rm -f "$(SRC_PATH)/"TAGS
> +	$(find-src-path) -exec etags -f "$(SRC_PATH)/"TAGS --append {} +
>  
>  .PHONY: cscope
>  cscope:
>  	rm -f "$(SRC_PATH)"/cscope.*
>  	$(find-src-path) -print | sed -e 's,^\./,,' > "$(SRC_PATH)/cscope.files"
> -	cscope -b -i"$(SRC_PATH)/cscope.files"
> +	cscope -b -i"$(SRC_PATH)/cscope.files" -f"$(SRC_PATH)"/cscope.out
>  
>  # Needed by "meson install"
>  export DESTDIR
> 
> 

Queued, thanks.

Paolo


