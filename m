Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B85DC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC58B2225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpKTf5ux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC58B2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZf2K-0003Oh-F7
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZf1N-0002Ma-AW
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:57:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZf1L-0003Ac-AM
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604343453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7zgatuCyH8zLfwZ/2ME7iwCfn1jQ9i3vqlWCCUXj/fo=;
 b=KpKTf5uxjNzuLc2pViOIPDTTsep3DsbmFBRZtoJBeo6KxRYGHu3Tke+MtCEd+0pOU1DklV
 5YaflIiYGDHTQPW9wWJAzWP4lzrlqtfAyEa3bfFDhQdO9XmqlbgY56WnyIb58ZjZISW5lL
 t4EpRwv4yrOmOkS3rqKf3GbC+MSxtNs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-WAnd7Wd4MIe-OC8MZmaUXw-1; Mon, 02 Nov 2020 13:57:32 -0500
X-MC-Unique: WAnd7Wd4MIe-OC8MZmaUXw-1
Received: by mail-wr1-f72.google.com with SMTP id b6so6731728wrn.17
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 10:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7zgatuCyH8zLfwZ/2ME7iwCfn1jQ9i3vqlWCCUXj/fo=;
 b=bbvM2a3cwiRQXfypcZiBQ9/+Awq3TSunKoMCTIpa6Yl7RVdE2Biy56XC7u2lCQbWYz
 3elqNDgfnSbp8LP3HKGBAvb9kiWUYEfO/lQPIYpIdnjAIm0zECD8sAB+0SPeIAUIoWxd
 gxqNbkGg7CJX1HJ+3i+yXulids1lMFjZZDrjb+gN7vYASr7BaFzkA0eLSZFl3MDZAi9p
 U2MGYn3C4jS3bI56F8CruD/oIZJo79Cr6B4czYGDu8L7eSQHCexSKfGbtbV/TlrS/gSU
 7gwn5z/NeuNaLwjLLIaPIS9sNwNOc0WsynekALKl4ziXhvXEvYd9RFzC1XBaCxi5Agy1
 bCKQ==
X-Gm-Message-State: AOAM532kOOUD03rHEBaFFHmL4hdvFI49axFmeemEPmzxac0qegD9YzAp
 CpIgUnO5J3GP6HIQPi/zQJ+2qZapPQCr2B1MXCK4/0MnHezdQwp6HR6y5tDLU48byWdqeod9ZN1
 nakQtVQpEdaxrIuA=
X-Received: by 2002:a5d:48c2:: with SMTP id p2mr21847598wrs.366.1604343451006; 
 Mon, 02 Nov 2020 10:57:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6MaA7nai4SbmFRkOpXZf8JyJdYiYMzYS/J1JfL4SyUn1TUK50Z6kIidcWjUp1X/+qAv8pPQ==
X-Received: by 2002:a5d:48c2:: with SMTP id p2mr21847591wrs.366.1604343450882; 
 Mon, 02 Nov 2020 10:57:30 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f17sm344572wmf.41.2020.11.02.10.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 10:57:30 -0800 (PST)
Subject: Re: [PATCH] cutils: replace strdup with g_strdup
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201102182205.5498-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <abe3de0d-d72c-277f-a4d3-bd195d8360c3@redhat.com>
Date: Mon, 2 Nov 2020 19:57:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102182205.5498-1-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 7:22 PM, Paolo Bonzini wrote:
> Memory returned by get_relocated_path must be freed with
> free or g_free depending on the path that the function
> took; Coverity takes exception to this practice.  The
> fix lets caller use g_free as is standard in QEMU.
> 
> While at it, mention the requirements on the caller in
> the doc comment.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/cutils.h | 1 +
>  util/cutils.c         | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


