Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A247CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C52A206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJsXpdae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C52A206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmtq-0005Hv-L6
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlmef-0003xU-5f
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 01:00:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45811
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlmec-00083A-HZ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 01:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592456397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=S+DyOews2WknL4XyeiMjP1z5pOYyG1OpuEv+DTKCIt0=;
 b=jJsXpdaexkQ6vKph80jxZQDG347bJv4FmyWpH5rddu14OxWYhJtY8ByqRlD33JLshjB1Ns
 ANJZ4lxRGonAw4EgtLoGijPCexQrAzGlxy6QTattVP0H2trKkk2uOX22iA2yugNShGCzO7
 SKFbMyi1kLo2oUBZI6re9MyZKsrMmC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-FnI4KrUxPfen6E3Svtb_fg-1; Thu, 18 Jun 2020 00:59:56 -0400
X-MC-Unique: FnI4KrUxPfen6E3Svtb_fg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E06018035D7;
 Thu, 18 Jun 2020 04:59:54 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-4.ams2.redhat.com [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EC197CACE;
 Thu, 18 Jun 2020 04:59:49 +0000 (UTC)
Subject: Re: [PATCH] hw/audio/gus: Fix registers 32-bit access
To: Allan Peramaki <aperamak@pp1.inet.fi>, qemu-devel@nongnu.org
References: <20200615201757.16868-1-aperamak@pp1.inet.fi>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <35ef8753-2469-387b-faef-ebf972081a05@redhat.com>
Date: Thu, 18 Jun 2020 06:59:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200615201757.16868-1-aperamak@pp1.inet.fi>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-trivial@nongnu.org, kraxel@redhat.com, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/06/2020 22.17, Allan Peramaki wrote:
> Fix audio on software that accesses DRAM above 64k via register peek/poke
> and some cases when more than 16 voices are used.
> 
> Fixes: 135f5ae1974c ("audio: GUSsample is int16_t")
> Signed-off-by: Allan Peramaki <aperamak@pp1.inet.fi>
> ---
>  hw/audio/gusemu_hal.c   | 6 +++---
>  hw/audio/gusemu_mixer.c | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
> index ae40ca341c..e35e941926 100644
> --- a/hw/audio/gusemu_hal.c
> +++ b/hw/audio/gusemu_hal.c
> @@ -30,9 +30,9 @@
>  #include "gustate.h"
>  #include "gusemu.h"
>  
> -#define GUSregb(position) (*            (gusptr+(position)))
> -#define GUSregw(position) (*(uint16_t *) (gusptr+(position)))
> -#define GUSregd(position) (*(uint16_t *)(gusptr+(position)))
> +#define GUSregb(position) (*(gusptr + (position)))
> +#define GUSregw(position) (*(uint16_t *)(gusptr + (position)))
> +#define GUSregd(position) (*(uint32_t *)(gusptr + (position)))
>  
>  /* size given in bytes */
>  unsigned int gus_read(GUSEmuState * state, int port, int size)
> diff --git a/hw/audio/gusemu_mixer.c b/hw/audio/gusemu_mixer.c
> index 00b9861b92..3b39254518 100644
> --- a/hw/audio/gusemu_mixer.c
> +++ b/hw/audio/gusemu_mixer.c
> @@ -26,11 +26,11 @@
>  #include "gusemu.h"
>  #include "gustate.h"
>  
> -#define GUSregb(position)  (*            (gusptr+(position)))
> -#define GUSregw(position)  (*(uint16_t *) (gusptr+(position)))
> -#define GUSregd(position)  (*(uint16_t *)(gusptr+(position)))
> +#define GUSregb(position)  (*(gusptr + (position)))
> +#define GUSregw(position)  (*(uint16_t *)(gusptr + (position)))
> +#define GUSregd(position)  (*(uint32_t *)(gusptr + (position)))
>  
> -#define GUSvoice(position) (*(uint16_t *)(voiceptr+(position)))
> +#define GUSvoice(position) (*(uint16_t *)(voiceptr + (position)))
>  
>  /* samples are always 16bit stereo (4 bytes each, first right then left interleaved) */
>  void gus_mixvoices(GUSEmuState * state, unsigned int playback_freq, unsigned int numsamples,
> 

This might be a good candidate for the stable branches, too (now on the
CC: list).

 Thomas


