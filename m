Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C904C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9DC2222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmHHdkkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9DC2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvNF-0005j7-Ey
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUvKu-0003xV-8c
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUvKq-0007jb-DQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJrMDmWXAoJsYBWvPoYOncsbayFwpOVz31ivwfGSjkg=;
 b=dmHHdkkxUvN2eFF0u6pjCN7FJs+NB8Cal4wNbeApEatJM9qn7rKzj1ijGVjEevoqWYsUOq
 C3R6q2ra9K+IrPojeEffUrKUfyetDD/07oahrkoYIL525YFlw7arudPDVHjw6JFC6pepis
 DzpOPOYmtDhE6L7Mlx64Or3WDSHyCFs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-Hgd6bCqzMAW-O5ULP5p35w-1; Tue, 20 Oct 2020 13:22:05 -0400
X-MC-Unique: Hgd6bCqzMAW-O5ULP5p35w-1
Received: by mail-wm1-f70.google.com with SMTP id i9so627692wml.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dJrMDmWXAoJsYBWvPoYOncsbayFwpOVz31ivwfGSjkg=;
 b=Aj8M4zzJTihXTfjtuLNac1V0deZI1/Bu/rjS4hQtygy5purvWJxwdwor7QWjk7AJHR
 VFJh5GGt9u1YZgw3fGnvdg8YYaAcaPAEEcGMQ3snZ/oxiWG4m5Z5g5N7RAICSLyxbghm
 SJFFpQSk3d5ecw5Afb8EZdPpfMzIzumjIF5CXxXbDuMjVWI+MVuoimARevB1pY2h4zDH
 5eQ9isafBjvF6nFbTY+uBN4Qf6q++R8nt8BWyQKTEkAgF2KToFmEhfnaIE1Lrb8Xc51A
 fR6J7MX5xxkJfe8fXir+gIRnQhWZ8ZSiEZQ17nMQozIIULpHu4MLVKHQJU4VhEOKKb09
 +NCg==
X-Gm-Message-State: AOAM532Vl07ALsfcTpZJ7tkNl6RA5bPdCACvSJijHDEer014UFuUzIJg
 WXHDK+rfk3bBG3ibimepNu26pP/SWQ+wpUBBT9CFCbJhKxkzlCGHTM0LpygNBmvo72X5te6Ua2n
 MPtB337KdxNBbbpg=
X-Received: by 2002:adf:e4ca:: with SMTP id v10mr4957166wrm.53.1603214524366; 
 Tue, 20 Oct 2020 10:22:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYz46JVID6SkBPcwIOH50f9qEedGmovlH2E9oVOai5qypi8ve9JH6EvgziG22oHKc+k2AHhA==
X-Received: by 2002:adf:e4ca:: with SMTP id v10mr4957137wrm.53.1603214524178; 
 Tue, 20 Oct 2020 10:22:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id y21sm3411249wma.19.2020.10.20.10.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 10:22:03 -0700 (PDT)
Subject: Re: [PATCH] os: deprecate the -enable-fips option and QEMU's FIPS
 enforcement
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201020162211.401204-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f97dc04a-0cc4-3ba0-ea5e-b185cd0958a7@redhat.com>
Date: Tue, 20 Oct 2020 19:22:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020162211.401204-1-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: libvir-list@redhat.com, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/10/20 18:22, Daniel P. Berrangé wrote:
> @@ -153,6 +153,9 @@ int os_parse_cmd_args(int index, const char *optarg)
>          break;
>  #if defined(CONFIG_LINUX)
>      case QEMU_OPTION_enablefips:
> +        warn_report("-enable-fips is deprecated, please build QEMU with "
> +                    "the `libgcrypt` library as the cryptography provider "
> +                    "to enable FIPS compliance");
>          fips_set_state(true);
>          break;
>  #endif

Should you also remove fips_set_state(true) and make fips_get_state()
return the contents of /proc/sys/crypto/fips_enabled, so that VNC
password authentication is disabled?

Paolo


