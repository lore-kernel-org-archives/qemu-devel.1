Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61BFC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E94239D0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8cFx5NV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E94239D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLu67-00053Y-VB
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 16:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLu59-0004VO-GU
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLu56-00028u-Cp
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:12:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601064755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGTZRba0keDGpa2BfPuVyfRcUixYmMaxVgpMXya3MGI=;
 b=P8cFx5NVk0DiyEFvfz6Td4LKmAh5foX4g3Efdfohg18/IDvgHG8H3T4IW3Bp8LX5sHaeqV
 ollJatLJ7A2n40fSbJxH9oHcwIyOKF4C+EsSFEya1kzVysPs+t2qc/cIuTLWFvz28c+tfR
 1/P9/Xu7FALAGja6aaaSQFkCwxDMERY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-GfPew_DcPz-ScQ5svDE_GA-1; Fri, 25 Sep 2020 16:12:33 -0400
X-MC-Unique: GfPew_DcPz-ScQ5svDE_GA-1
Received: by mail-wr1-f70.google.com with SMTP id r16so1485237wrm.18
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 13:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VGTZRba0keDGpa2BfPuVyfRcUixYmMaxVgpMXya3MGI=;
 b=WPz9PmHZxokdlx0HLwQ0PY3oq0EnSzjo7oIgEi9vVs9wkNYJYIN2+0rNCHdIHgHOI3
 QQS9Va+XxcB9dn/A+ZhjCRxvBMB+GuRhwt5B6J+npG+piPkVYTX2pHaN7HbtMv1uYHyt
 2JuGZIHD/JF8sfraQW+rV4Lpn4KcEZwG0yWg6TW1FgW7d68VixGzqBYgIEAfli39cKas
 E0wPhcI96/j11JsuGplcHXFOqujZ4pZ39s5e+9meLKJpKsVhOGBJTRlyMXmGgp5c8urs
 wtPlMevkv9mEUKdyLYWKMCVOMaLf8wZdK4bB767kzpFMumK0oEgQJB3EJq6Fu90zJdvU
 PLcQ==
X-Gm-Message-State: AOAM531b9YMxMZuqX/R649Qols7bZVCizhvhGLsg9B6okOP4nx+qJPq0
 oSpF6IpZcCIbohq5pQ81kgstTtdaYD8u4KbhdIS5wlzG5+KQ3tV5qhqKzhST2GYdUDHKBrGcIKX
 alkoDM5DfBGP57Yo=
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr235252wml.139.1601064751961; 
 Fri, 25 Sep 2020 13:12:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjaOnD//kLc8F/UcS1x3gDOkTN9eZkxAi3ihfH8eHBYzgYGSJdkFnqTNu4HgmTUrpXmHJMDQ==
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr235231wml.139.1601064751689; 
 Fri, 25 Sep 2020 13:12:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id 31sm1580219wre.57.2020.09.25.13.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 13:12:29 -0700 (PDT)
Subject: Re: [PATCH] hw/scsi/lsi53c895a: Sanitize some trace events format
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200915174639.1366226-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8934c787-b909-e885-b15a-c4bcd194f458@redhat.com>
Date: Fri, 25 Sep 2020 22:12:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915174639.1366226-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-trivial@nongnu.org, Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/09/20 19:46, Philippe Mathieu-Daudé wrote:
> Make some lsi53c895a trace events more understandable.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/scsi/trace-events | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
> index 9a4a60ca635..ac4209f361e 100644
> --- a/hw/scsi/trace-events
> +++ b/hw/scsi/trace-events
> @@ -234,9 +234,9 @@ spapr_vscsi_do_crq(unsigned c0, unsigned c1) "crq: %02x %02x ..."
>  
>  # lsi53c895a.c
>  lsi_reset(void) "Reset"
> -lsi_update_irq(int level, uint8_t dstat, uint8_t sist1, uint8_t sist0) "Update IRQ level %d dstat 0x%02x sist 0x%02x0x%02x"
> +lsi_update_irq(int level, uint8_t dstat, uint8_t sist1, uint8_t sist0) "Update IRQ level %d dstat 0x%02x sist 1:0x%02x 0:0x%02x"
>  lsi_update_irq_disconnected(void) "Handled IRQs & disconnected, looking for pending processes"
> -lsi_script_scsi_interrupt(uint8_t stat1, uint8_t stat0, uint8_t sist1, uint8_t sist0) "SCSI Interrupt 0x%02x0x%02x prev 0x%02x0x%02x"
> +lsi_script_scsi_interrupt(uint8_t stat1, uint8_t stat0, uint8_t sist1, uint8_t sist0) "SCSI Interrupt stat 1:0x%02x 0:0x%02x sist 1:0x%02x 0:0x%02x"
>  lsi_script_dma_interrupt(uint8_t stat, uint8_t dstat) "DMA Interrupt 0x%x prev 0x%x"
>  lsi_bad_phase_jump(uint32_t dsp) "Data phase mismatch jump to 0x%"PRIX32
>  lsi_bad_phase_interrupt(void) "Phase mismatch interrupt"
> 

The idea of the patch is that SIST0 and SIST1 are usually read in pairs.
 So it's a bit weird in the tracepoint format but it's actually more
understandable this way when you see it printed.

Laurent, can you please unqueue this?

Paolo


