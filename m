Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A48FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573E220771
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSmtvxB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573E220771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfm1-00006i-K9
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnflQ-00088D-Ok
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:02:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32189
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnflO-0000U1-NJ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592906565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MocT5qC4grhnOIevTtafb5bvzTxeYyyjRygSpJziaXE=;
 b=RSmtvxB7zxIcix1TE4WhN5r1KCFILduFx3jAWwkLZ+3RNWhgHV9bhdev5gRVrrlcdSUbMA
 Soy2cBamSChKqjehBAu9RU9TacC+B3LToZYMEF4Hwpc9Judhn77sX6TySmAtu8Re+MuTnk
 9rSparybcFzHoltomwdZO+lr7A6SFSs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-4IFx9B1CMhKs9p987tC7Aw-1; Tue, 23 Jun 2020 06:02:43 -0400
X-MC-Unique: 4IFx9B1CMhKs9p987tC7Aw-1
Received: by mail-wm1-f69.google.com with SMTP id q7so3263438wmj.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 03:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MocT5qC4grhnOIevTtafb5bvzTxeYyyjRygSpJziaXE=;
 b=ByA7GBSGy88oyaefva9/pa2RoNP+v1U1WwMdNCEiLIjR1qQW0B90f4OOaWPhEOpiY9
 uHmEpaJdwbeiHH8FZBBPSCGFKYSCPExwC17GVeuZqv+p0thPtdloPX1JOupPdSry9Sqs
 8PuE3eglqmRpjr+6F8sC+y1YZy/BvAAlvHG2IZwcGF63x2BhQ/HoXwknTaeV4DIdRNVp
 6I5jJHZK+IrMmCjH4PBydV7T3aV2yGlERSNZFT4aEJBbMxf+C+Mpcp/nPD4l0fI3tdrz
 NGDHzMbrBGWqLNCCNTgKGe1vz7yyKpSJV1xhUociYwy3CjqQuFTEl8gsBRFwDMtAv5wh
 ADPA==
X-Gm-Message-State: AOAM5326+Nx7hkQATJMqTOI47rZa9e3EB+0MiZn+Di+bAoB1VXq6EdnV
 To6OYP+qFmjCdFEdpaURIQaRqxr6IF4wwPcCERIQAVOGcaHS/cFuO03h1ZgGvMoI+nbt8pToaaS
 o/Z1iwcj8VWxnTfo=
X-Received: by 2002:adf:8444:: with SMTP id 62mr23302400wrf.278.1592906562251; 
 Tue, 23 Jun 2020 03:02:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1oQI+vD4k68KztBDQFx7S/pX95MP1T/Qopn+/PY+Z3B6Vxx2P0gRFwVuTiD6fSAfTO+uDIQ==
X-Received: by 2002:adf:8444:: with SMTP id 62mr23302377wrf.278.1592906561980; 
 Tue, 23 Jun 2020 03:02:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879?
 ([2001:b07:6468:f312:24f5:23b:4085:b879])
 by smtp.gmail.com with ESMTPSA id d63sm3105836wmc.22.2020.06.23.03.02.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 03:02:41 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] hyperv: vmbus: ACPI various corrections
To: Jon Doron <arilou@gmail.com>, qemu-devel@nongnu.org
References: <20200617160904.681845-1-arilou@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e467716d-19cb-ffec-b464-494e975463e3@redhat.com>
Date: Tue, 23 Jun 2020 12:02:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200617160904.681845-1-arilou@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: rvkagan@yandex-team.ru, imammedo@redhat.com, vkuznets@redhat.com,
 mail@maciej.szmigiero.name
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/06/20 18:09, Jon Doron wrote:
> After doing further tests and looking at the latest HyperV ACPI DSDT.
> Do minor fix to our VMBus ACPI entry.
> 
> v2:
> Renamed irq0 to irq now that there is a single IRQ required
> 
> Jon Doron (3):
>   hyperv: vmbus: Remove the 2nd IRQ
>   i386: acpi: vmbus: Add _ADR definition
>   acpi: i386: Move VMBus DSDT entry to SB
> 
>  dtc                              |  2 +-
>  hw/hyperv/vmbus.c                |  3 +--
>  hw/i386/acpi-build.c             | 17 +++++++++--------
>  include/hw/hyperv/vmbus-bridge.h |  3 +--
>  4 files changed, 12 insertions(+), 13 deletions(-)
> 

Queued, thanks.

Paolo


