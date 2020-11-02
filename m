Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB6DC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03AB2084C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQVDdBsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03AB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbBi-0004CV-DQ
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 09:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZbAY-0003DV-JH
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:50:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZbAW-0007tc-Eq
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604328643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AP3m3jyCmduWEdXloTHdRs1y8AGJRf/fYO7hTkW/Nck=;
 b=BQVDdBsKcR8ZsaStiv/RNIhmX+IRP8+ri2OcuRTM1OTiTerqL9fgtbJQZjl3wKf/P6oYW6
 K8F+W8lSkncnEL7FqRP8uYUMakdMlIxmw4UTDGiy3F7XzvQEahsUgJPn9NJUwNpMPMoOZU
 PFwfM21WyM4V9/FLnZAQQ6fdg+Nx5Os=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-cCQNslnYOZGgRqUcNNIMPA-1; Mon, 02 Nov 2020 09:50:42 -0500
X-MC-Unique: cCQNslnYOZGgRqUcNNIMPA-1
Received: by mail-wr1-f70.google.com with SMTP id 2so6555721wrd.14
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 06:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AP3m3jyCmduWEdXloTHdRs1y8AGJRf/fYO7hTkW/Nck=;
 b=VxggI9CO57Eu0H2EGAhahLQgQAbsoy+66DTuokTrMax0KIXCtK3lQjMjLvEkZ+QwWC
 wlqjGyXtIv1hxAiJAJ5Abu1f7vX76QmzvGiQbWuwD9upUahTiN2azjB1fY5cqTzXgPen
 Jsot4D5L4Mbu3TNmA6/hXVUPqGuLt7tfoJx44CAHdDWr8BvYrhVk2TZQSiLjf5z2/VhM
 jIJkZHQK2VPwWyoJ1oGhmal/bz+uUQbzIDDvo45GfTm2vqUF5qFfr822f9MdqZSwqM0D
 RzthXxPk/Nt7e3NQcZJTnH8RCR1z143H2J+95pdmFQVRhuvVsZgP2JxFJ6wN7+sDrJvj
 WNqw==
X-Gm-Message-State: AOAM5326mgomQbFJ8yG7d6b3tYC0UpbZztcR/hguTGDWFR2zB+7j4sX+
 SQ5tC+NSJE4PrXx16ekLjMNXHja3sAJs2Kb8ahL6iBuegUzxrajkD4z8Ac6v4npOHtOHyyq23NL
 +RMzSNKyJKOuIo7Q=
X-Received: by 2002:a7b:c04a:: with SMTP id u10mr19213690wmc.83.1604328641108; 
 Mon, 02 Nov 2020 06:50:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUx6h+WMwxale5RCRIFuoYW/7rErRNMiOvwhRve7dOMvXR9Na0pPDYdOCxT4+SwDHheS/eCA==
X-Received: by 2002:a7b:c04a:: with SMTP id u10mr19213674wmc.83.1604328640883; 
 Mon, 02 Nov 2020 06:50:40 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v67sm15865137wma.17.2020.11.02.06.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 06:50:40 -0800 (PST)
Subject: Re: [PATCH 2/4] gitlab: force enable docs build in Fedora, Ubuntu,
 Debian
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201102130926.161183-1-berrange@redhat.com>
 <20201102130926.161183-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <04a3654c-de8c-d16d-f45a-66cbc6ffbef0@redhat.com>
Date: Mon, 2 Nov 2020 15:50:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102130926.161183-3-berrange@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 2:09 PM, Daniel P. Berrangé wrote:
> Meson runs a test to see if Sphinx works, and automatically disables it
> on error. This can lead to the CI jobs skipping docs build without
> maintainers noticing the problem. Use --enable-docs to force a fatal
> error if Sphinx doesn't work on the jobs where we expect it to be OK.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.yml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Shouldn't this patch go first in your series? Inverting 1<->2.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


