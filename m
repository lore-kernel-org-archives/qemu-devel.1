Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFA2C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD85B206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgQehRQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD85B206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaiFb-0003KU-LX
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 11:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaiEM-0001vq-Hn
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:35:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaiEJ-0006zB-Ak
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604594117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9II81I9sHIA29S4opVDFXxh3d86ujtOvwHP1WDzeNc=;
 b=MgQehRQCjZmbIV8Uk7+OG/FJZAW74KMJiToo6TxW0f7nhujM6n3ZZSNFSbtHHrxa0GVb7d
 tA58dQMPRGeAAjHeR43rd7p7goGZJ6qj6TKsxZKkRZxfCZurVoN1J18NinqVXqgecBiBAs
 Y+IJ5JEroM1l2cg/NEnnRy0djrLzSkQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-t2LZ7C0NOUKPfrQiKbTkLg-1; Thu, 05 Nov 2020 11:35:16 -0500
X-MC-Unique: t2LZ7C0NOUKPfrQiKbTkLg-1
Received: by mail-ed1-f69.google.com with SMTP id y99so749589ede.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 08:35:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A9II81I9sHIA29S4opVDFXxh3d86ujtOvwHP1WDzeNc=;
 b=f7yBmbIflYgTJ2i1R53TnhFSKPZdJmrIXqK5IL622kVw3rFrxbbh679nIWeOJl/Wsh
 ++YoFIfKpKfd7H2ooPxP1qAzyYveA1bgRSbdyHDlFiWzrhcRT3xS9vBAZDEsOmrD9neI
 6Xzlr8AuMiSblDS7rkmwpP3XHzsEvz6O42QBVV1ebKO9IM3Lp0m2c3ioVtIoDQQOcRz8
 7A9O4SMb4QgOvCycs4ye0AIDju36qWesMaK8KXRJM9vSLqASr7Xk8WhAYtW2nl1uMI4t
 6AU5/Fw1BgvJ96IBTTOR2p1z6mKSczUHcRiWJDfl0OVoyFrkDP/+5KzOd2+p50M2kWEZ
 84iA==
X-Gm-Message-State: AOAM531l8Ovka91rJ5zXzdlaB6IQHl31nMjwEOn8v/OXPTVpqUPgAfIU
 QS/v56vAozyVOaRY2HCwwetODxHGL88QB9+f817cGuTMlmE4RVIsLSwsNymP+1COdv9rtq6oT/V
 ClYuEifvkOUVsJMU=
X-Received: by 2002:a17:906:3bcf:: with SMTP id
 v15mr3244267ejf.244.1604594114652; 
 Thu, 05 Nov 2020 08:35:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3TdkbBvc6ApFdiSOfqghI4vpIhXZrGVakbn21FwEzhu263I1JIYMYlbNuwHZLNlL+OKYWyA==
X-Received: by 2002:a17:906:3bcf:: with SMTP id
 v15mr3244253ejf.244.1604594114433; 
 Thu, 05 Nov 2020 08:35:14 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id y1sm1255845edj.76.2020.11.05.08.35.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 08:35:13 -0800 (PST)
Subject: Re: [PATCH for-5.2? 2/2] Makefile: No echoing for 'make help V=1'
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <160459121308.462591.11794514422987547665.stgit@bahia.lan>
 <160459122012.462591.8467906402712875729.stgit@bahia.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a15bb85f-324a-542b-8048-39c5b9a6463d@redhat.com>
Date: Thu, 5 Nov 2020 17:35:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160459122012.462591.8467906402712875729.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/11/20 16:47, Greg Kurz wrote:
> It doesn't bring much to have echoing with "make help". Suppress it
> unconditionally.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   Makefile |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index df7a02a61a43..ba6b702107a5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -270,7 +270,7 @@ include $(SRC_PATH)/tests/docker/Makefile.include
>   include $(SRC_PATH)/tests/vm/Makefile.include
>   
>   print-help-run = printf "  %-30s - %s\\n" "$1" "$2"
> -print-help = $(quiet-@)$(call print-help-run,$1,$2)
> +print-help = @$(call print-help-run,$1,$2)
>   
>   .PHONY: help
>   help:
> 
> 

Queued, thanks (the first was already in my tree).

Paolo


