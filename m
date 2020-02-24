Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJ_ALL_CAPS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF28C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E572072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZajhM+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E572072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6D0r-0000qR-Ec
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 07:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j6D0I-0000OH-4i
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j6D0G-0001E4-VV
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:38:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52324
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j6D0G-0001Do-Rl
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582547908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1xdIqZgcyicmxr19zD8cD2E2yjdMndIxpkiw5NHfEw=;
 b=GZajhM+zRiBDCLO+UW28Y7Vr0Xb8j1oaCXF44p+knqS+kIzszLEiivETNMd0GlNrUTiUb3
 wjp91TxhIuQgjTNh/+/5/lHZamkEdLSaXrm/EE8relC7um+sVc3iLIALmwlz+1rfF0Itej
 9hPSQcwYeKojf6wQK0cBBbonzPNLnJY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-ZPnVDLaHP7-Ra0MIENQABA-1; Mon, 24 Feb 2020 07:38:26 -0500
X-MC-Unique: ZPnVDLaHP7-Ra0MIENQABA-1
Received: by mail-wr1-f70.google.com with SMTP id p8so5537938wrw.5
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 04:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J1xdIqZgcyicmxr19zD8cD2E2yjdMndIxpkiw5NHfEw=;
 b=DEgZ2X2lMY60pb3d0lwnZTQLhCwjkC82uhHfcmoFQdFCayaxY8B1nZuCXuRpwv8wd2
 TSJju6L46GK2ywr94PQzpy0s7iDd5ptRtygGNtOTkn1G/GAOVVlZNlo7JEmDHGYhUP5X
 O6TFTsoH/Ush7g3t+/mSwPE4WeFz3c1z0SVghLrAtwiE+6jRlbZcwTDxp+bZdinoaqXy
 hYndIlG9530FdlFCR+D5z1zEcqvVhEGVqb1X3XgZkMOU6g1E3Spk23LMRTAGojkJTW2H
 IrW2d0WG+U8qG+OusI5mXVwEq2HBXWviS4AzW6ElqlT+EuqwM/hTVfJFNS7WbmJJ0Dje
 /6FQ==
X-Gm-Message-State: APjAAAV2GeblggCL6RlbXWbqzb/TdQA8qHZ5Eq9wqBN6FtIdBFRUlwAQ
 +iTPFcZgoNC5Dgttmipjgt0WPmSEMfVD+9hrIm6r0oIkRAFY7/tSEXDbcYKfMTpnlsBy3rRUvDV
 gCU2JWo9ETkf91Jw=
X-Received: by 2002:a1c:7315:: with SMTP id d21mr22155712wmb.186.1582547905355; 
 Mon, 24 Feb 2020 04:38:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxtLDym9VVrck1zq118bXBDb16J948Ax0LHZpyHu/rbvJ6Ct4cpDF9JzwS+UMX6PpJKNhhKHg==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr22155699wmb.186.1582547905170; 
 Mon, 24 Feb 2020 04:38:25 -0800 (PST)
Received: from [192.168.178.40] ([151.21.175.179])
 by smtp.gmail.com with ESMTPSA id d13sm19339747wrc.64.2020.02.24.04.38.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 04:38:24 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: KVM/MIPS
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1582545058-31609-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dd3d5d1e-de57-7233-7d7a-109819701f8d@redhat.com>
Date: Mon, 24 Feb 2020 13:38:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582545058-31609-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: James Hogan <jhogan@kernel.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/02/20 12:50, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> This patch is just a follow up to James' wish to be releived
> of QEMU KVM/MIPS mainatainer duties. Many thanks to James for
> his substantial contributions to QEMU for MIPS made over many
> years, and not only in KVM area.
> 
> CC: James Hogan <jhogan@kernel.org>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> 
> Aleksandar Markovic (1):
>   MAINTAINERS: Reactivate MIPS KVM CPUs
> 
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


