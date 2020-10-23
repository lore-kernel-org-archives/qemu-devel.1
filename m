Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91354C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30D120E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVPGvgS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30D120E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0fU-0001a8-Id
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kW0GT-0007ns-Ai
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kW0GR-0003vT-2l
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603471802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxgP9AD59gDL6aQ96qyDjbhP4x8bXG3rp795fp2AuMk=;
 b=XVPGvgS0eQUd6j1SVqZ5iFfe+o9YMOWCVpm3bI9+s++CWTtPO9Yiqpyn4e5MMdUY4o7hK5
 D3rPzkDNkHZBvPAV95/dbDHcjPDnExiTekVND27194ZT8+DxC8jzx51rdT928I+eCrKSDv
 7QJKP+pVUhrUM4xGGVYGArO1hEnQcYs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-3cUbEoCaMmmFBxFMXJFg_A-1; Fri, 23 Oct 2020 12:49:58 -0400
X-MC-Unique: 3cUbEoCaMmmFBxFMXJFg_A-1
Received: by mail-wm1-f69.google.com with SMTP id u5so490887wme.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 09:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YxgP9AD59gDL6aQ96qyDjbhP4x8bXG3rp795fp2AuMk=;
 b=klL+1F1PahIE3aCbJ4pYFqN0XQ5kGdNddWt6wmHL1MDuTB6bXzUNhlMQYp2KYlQufk
 fRNy1MJRMuiKpRtbODE9smLYZzSpNWH6emRdaFNNQOH3/TV0qhce6y24roncPV/RuBtu
 ZfrxLMgIxykvGpNbjJ4E2UrObAMpjMVEHqhrzIRlvmQxWsvH+m74ahqZE+iD8HWQOs3v
 7lKID0kZyWgZ0Hjfckw2fTlsmXrcU+9BaH7w3YKkIVcmZvoSZ7Wd3YoTTIQkgTgCFNYg
 DiyAxp25wb6n4F0UzPWiZm2lYv2BiHbYq2nmQib+iz+vUTWya/d4+xMyFJxyRmfAWcGR
 9cJg==
X-Gm-Message-State: AOAM531KU0+wE0j4tInIz6/N6rfNCofGcAa4UgPI8aFpC1UMe+hRJtJ8
 7N+/pqyUGftBN6/BqLaUZ5XylZ6r3+Bcg3vPzkkBF5SgVg8E0GHKCeT8K4L2YxFl9B29PCWdgVk
 PUofBLmDwXtZwsM0=
X-Received: by 2002:adf:cc82:: with SMTP id p2mr3626428wrj.177.1603471797830; 
 Fri, 23 Oct 2020 09:49:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkr3eqW7sw1wTTVpSijgs3WYWDGhDgTQBppLIM6jUIWc9lZvadTMCq5pflQHG6yOGsUf723g==
X-Received: by 2002:adf:cc82:: with SMTP id p2mr3626376wrj.177.1603471797574; 
 Fri, 23 Oct 2020 09:49:57 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id q8sm4397533wro.32.2020.10.23.09.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 09:49:56 -0700 (PDT)
Subject: Re: [PATCH v11 02/19] multi-process: Add config option for
 multi-process QEMU
To: Jagannathan Raman <jag.raman@oracle.com>, qemu-devel@nongnu.org
References: <cover.1602784930.git.jag.raman@oracle.com>
 <acf32d0e54e0aec669723f2f1b64f87788b2c8b4.1602784930.git.jag.raman@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <071dc8d8-ecbd-a1ad-f503-bc278efce038@redhat.com>
Date: Fri, 23 Oct 2020 18:49:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <acf32d0e54e0aec669723f2f1b64f87788b2c8b4.1602784930.git.jag.raman@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, quintela@redhat.com,
 mst@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 8:04 PM, Jagannathan Raman wrote:
> Add a configuration option to separate multi-process code
> 
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   configure   | 10 ++++++++++
>   meson.build |  1 +
>   2 files changed, 11 insertions(+)
> 
> diff --git a/configure b/configure
> index f839c2a..2025e89 100755
> --- a/configure
> +++ b/configure
> @@ -447,6 +447,7 @@ meson=""
>   ninja=""
>   skip_meson=no
>   gettext=""
> +mpqemu="no"
>   
>   bogus_os="no"
>   malloc_trim="auto"
> @@ -1520,6 +1521,10 @@ for opt do
>     ;;
>     --disable-libdaxctl) libdaxctl=no
>     ;;
> +  --enable-mpqemu) mpqemu=yes
> +  ;;
> +  --disable-mpqemu) mpqemu=no
> +  ;;
>     *)
>         echo "ERROR: unknown option $opt"
>         echo "Try '$0 --help' for more information"
> @@ -1838,6 +1843,8 @@ disabled with --disable-FEATURE, default is enabled if available:
>     xkbcommon       xkbcommon support
>     rng-none        dummy RNG, avoid using /dev/(u)random and getrandom()
>     libdaxctl       libdaxctl support
> +  mpqemu          multi-process QEMU support

When I first heard about this, I was expecting something
else. It could be better named as "remote-device emulation"
or maybe "manifold (device) emulation" :) Anyway too late
I presume.


