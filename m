Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B660C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0410F21721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOkB3MEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0410F21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iafpA-0008GB-6F
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iafiF-0003RH-OY
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:49:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iafiB-00087T-OP
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:49:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23135
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iafiB-00082w-I5
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575031766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8xXE6Vlur98LoO7ZZkAYZPIUiwnW/v7s5HnEbPccNI=;
 b=HOkB3MEZ7ql1tnz24sidwttlzaHR8FUiVWZZBcqOaHRfOH1YOJ6ZwBJ1ER3DxLNoFPzy1y
 ArQE4Du+tB2T/FgrIEoXwYQFg7SOoKzrLvJtNm+rp/eNgwDALMJOGEPhC/RM6qi6Ckn88R
 SDSM+TQqs4G5bq8ZCmWHFQBeXCf1XM4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-C8rsLPIlNVqHnUXCiV_7Fg-1; Fri, 29 Nov 2019 07:49:23 -0500
Received: by mail-wm1-f70.google.com with SMTP id y125so3333092wmg.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:49:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M8xXE6Vlur98LoO7ZZkAYZPIUiwnW/v7s5HnEbPccNI=;
 b=ZTfVi3o9OosLeP/3LaM6fYw6UooixCJFrx/pcEIgRXWLJnP04sGgSTO/NwyCis6kEM
 HALe03g78C9o49+OoyUihBOHdRo7uAMjJW/kOp1IArSeJS95CJm0rnlt2StG6B8pw6BJ
 O2LkuYU7ZVCWwwnpLTJ8z+QS526zwuEugdMqrLMkDGleqev4fEAJEeYaERqk+a5wBXom
 hvhkoMXP3fD3nKL6BD2pSCTitjPb3OBnOVOlS7bWMowRmdTdsp4bNi/lQ15BG05UFwfu
 ObtZdTTaUDzok5t8aM1G52OM0rfEImFU0q2GYNk3qLlSoVIm24vN4NTXG/uRoEbXYC9Y
 nXNg==
X-Gm-Message-State: APjAAAWEEpSBz2/5iy9RbZVLOzv4WUKyPkELwNB+47e1V62pc/i18ihj
 9rTn8jv+mei2fuC45JCO6GCcoAlkRjwpskMxWkrDnv8/ddxJSSIZVTRTryxLPEy84dLO1IksvEw
 BG98+WL2vW6JT1rQ=
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr14132768wmc.62.1575031762514; 
 Fri, 29 Nov 2019 04:49:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqz5+OdVbYC6LAfoabwWWWRARSN2nl+uTtzrktIqeUnG3LQmPd7veBuf0qDf3cbn9skuVDCOdQ==
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr14132737wmc.62.1575031762228; 
 Fri, 29 Nov 2019 04:49:22 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:459f:99a9:39f1:65ba?
 ([2001:b07:6468:f312:459f:99a9:39f1:65ba])
 by smtp.gmail.com with ESMTPSA id x17sm6062954wrt.74.2019.11.29.04.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2019 04:49:21 -0800 (PST)
Subject: Re: [PATCH] virtfs-proxy-helper: switch from libcap to libcap-ng
To: Greg Kurz <groug@kaod.org>
References: <20191129111632.22840-2-pbonzini@redhat.com>
 <20191129133241.738b70ed@bahia.w3ibm.bluemix.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4e49ea13-fe0c-2b06-052e-474d714b88ad@redhat.com>
Date: Fri, 29 Nov 2019 13:49:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129133241.738b70ed@bahia.w3ibm.bluemix.net>
Content-Language: en-US
X-MC-Unique: C8rsLPIlNVqHnUXCiV_7Fg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Thomas Huth <thuth@redhat.com>, berrange@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/19 13:32, Greg Kurz wrote:
> Nice. :)
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> Paolo,
> 
> I can take this through my 9p tree if you want. Otherwise,
> 
> Acked-by: Greg Kurz <groug@kaod.org>

Yes, please do it since it's self-contained.  You'd probably also test
it better than me. :)

Paolo


