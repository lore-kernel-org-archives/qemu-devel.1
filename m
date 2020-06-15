Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0FDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CC920739
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVv0uteQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CC920739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkqiM-0001L7-2r
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jkqhg-0000qy-0F
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:07:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25119
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jkqhe-0006g1-4X
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592233632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WH+76HoBXgxtvbvf2lu7BrhzdhDjDAbFCFs7nh1vauQ=;
 b=XVv0uteQ3wSpSiKQdQxzP05zThQNijfU9KZWnoodUEut94bpgLDQ9+A+0P96fdWKHRh4/H
 7532WqSNi/nb5rTLPHTBPayDm6cSEGrQzvzgE2kOkmhq0tEaG+SyTDKusLxVEVV8IRDm41
 K5mI7p7bVr7+OHcO88E/eay+vbiWqV8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-hmO3kHUaM9iHBsA4Gv4Dlw-1; Mon, 15 Jun 2020 11:07:08 -0400
X-MC-Unique: hmO3kHUaM9iHBsA4Gv4Dlw-1
Received: by mail-il1-f197.google.com with SMTP id v14so12264129ilo.19
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 08:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WH+76HoBXgxtvbvf2lu7BrhzdhDjDAbFCFs7nh1vauQ=;
 b=qUviuNF34/ku0ICVvR2CVT4E2WoXXe6YLUSeDy1v+G0Tm7fvAjSnDQh6adDwC3NM7M
 tBC47p0qE9HiZlxDA+Rgc1GsW6usH9G73vCJPuBcE7SfeZ2YCLgPcVECKdEgHfU0n7Ud
 nkAgsUKOYbGzhu3DLs2RTYRuZolVPzhZaZ+mfh0IjCH3Lovl2l1tQ+GC6cfMfGffX+fN
 xbF5DWDrCin7SUtN1rgfLnatvQm4zAUxEmKXB76XYtKyUzrqbhPQv1qbSNxhtXD++zKe
 dw4evgNERYkiMppdl1XadaUEKZMj3r6OGcjxzXNSCADdK6HyFYR1nFw4Hhps3eU+2oAA
 Am/A==
X-Gm-Message-State: AOAM531sMr4CmivvhaPaI7i6n65WKxNolHIq2ZHcEc7kQQBshUK2I84d
 gD9U/Fr7ztjaSai7xprHhKDQ0H/WpgtiJIfQ0UTOMdwjwnbxBr5rlupLRYkDXKW5vTsxGERoYcZ
 JrV6NCooT9X8rQL/dL2DZHp/wH5Y175A=
X-Received: by 2002:a92:909:: with SMTP id y9mr27546139ilg.165.1592233627754; 
 Mon, 15 Jun 2020 08:07:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnTbryKHeBYJnC239lNUdfLZApamtajnKqdadsvLzKtlwnhKMZAOoZKrh5rH+vpc8aq2oUAlOKwTYk5xWO+cE=
X-Received: by 2002:a92:909:: with SMTP id y9mr27546120ilg.165.1592233627566; 
 Mon, 15 Jun 2020 08:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200615142327.671546-1-stefanb@linux.vnet.ibm.com>
 <20200615142327.671546-2-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200615142327.671546-2-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 15 Jun 2020 19:06:56 +0400
Message-ID: <CAMxuvazRHiZq+Qe36vpsTsKJqH7kdK6KGSF8SFiW35cj9TO2ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] tpm_tis: Allow lowering of IRQ also when locality
 is not active
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:12:36
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 "Bonzini, Paolo" <pbonzini@redhat.com>,
 Philippe Mathieu Daude <philmd@redhat.com>,
 Marek Kedzierski <mkedzier@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Jun 15, 2020 at 6:23 PM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> This patch fixes a bug that occurs when using interrupts. It
> allows to lower the IRQ also when a locality is not active.
>

Can you quote the specification, or is it purely based on testing
(Windows & Linux) or checking expected behaviour from Linux code?

> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  hw/tpm/tpm_tis_common.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
> index 1af4bce139..0f42696f1f 100644
> --- a/hw/tpm/tpm_tis_common.c
> +++ b/hw/tpm/tpm_tis_common.c
> @@ -601,10 +601,6 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
>          /* hard wired -- ignore */
>          break;
>      case TPM_TIS_REG_INT_STATUS:
> -        if (s->active_locty != locty) {
> -            break;
> -        }
> -
>          /* clearing of interrupt flags */
>          if (((val & TPM_TIS_INTERRUPTS_SUPPORTED)) &&
>              (s->loc[locty].ints & TPM_TIS_INTERRUPTS_SUPPORTED)) {
> --
> 2.24.1
>


