Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17533C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96C62073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TjZh1j5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96C62073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieinx-0006Dx-Nq
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1ieigl-0006tk-ML
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1ieigk-0005qJ-KU
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:48:43 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1ieigk-0005pm-E2
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:48:42 -0500
Received: by mail-wr1-x443.google.com with SMTP id b6so20925736wrq.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 08:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=B1cDfx8s5f/9QR+mlmSpW12qDckt3D/lvXSVtrdKzq4=;
 b=TjZh1j5u0sa58MCh/35yKK+h02dV1GjVfZe+pZwtrsCnoyLkP7xvCCCWrdv2R7YtBi
 r/nkuPds7iWxCZeOgtoT/asSpTkJr/raf6ErdGyZsDVrWA1CGpQoRNE4iiXjFlqQO71x
 jUof0258cALt89i/pRukTOHkweDwYQ0QaczoaCV8uxlRheK0+XBCo+gjda4JsH1oTywc
 tEBDwIhEPY8O8e9e8yiKtMHnTMh3P9QkiAQc3LryvfaPCLUKA/lVq5Zr4gJ6GxBaZOe2
 /dq/yJwVcoWOBcrTYnAC6c5U+/mh2S8KE8neWL/lDVbwdIJ9RoTFusvURtADhl2Wge9k
 90Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=B1cDfx8s5f/9QR+mlmSpW12qDckt3D/lvXSVtrdKzq4=;
 b=CtMegkOAIp7PRZMZkf+BJbMAG2QOxN83uMI+bq/16iWSRGKi1C90/AIZJzsk2TTdi9
 iv/2AXdEWBFLZAZh9Up5c9tAAHD1C9rYYFtzmzWlkUFafK43Kr0uj13B3dXcA5yyFLw+
 Z+DKgqPZ4hHW0HEyOguUyir/lEIH1jcddChyQWwTNXfmb4Y1fZZp+fvTu/3mPhptKzO2
 xA9K+APVCZUGjb5E5Nvdky79wPlDNgtUg6SGbM+8P4vgFdBQcz6JTJFZWHmgWwMCzszD
 YiNS9BkRQthat3J3szzNEYIGXRGYwTO00VWA4MtGulzbC2JWn60mNCXisXuSs2mgPoBi
 5bRQ==
X-Gm-Message-State: APjAAAXlbEKE8wMx75zpCrotsOPfLyBVDAJUFSKdl8KhXCTIOMs60VHG
 hUXAIhrh/LT9P7qTlDXbkE0N1A==
X-Google-Smtp-Source: APXvYqxZ3nPGlovSWWgbV+/mrQ268XN14/6vPkqO/GWDigotiGR14SRQfC1U161GtPZldIB0vEwDdg==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr4319211wrj.344.1575996521389; 
 Tue, 10 Dec 2019 08:48:41 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id o7sm3695579wmc.41.2019.12.10.08.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 08:48:40 -0800 (PST)
Date: Tue, 10 Dec 2019 17:48:36 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 17/20] hw/arm/virt-acpi-build: Add
 virtio-iommu node in IORT table
Message-ID: <20191210164836.GO277340@myrica>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-18-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122182943.4656-18-eric.auger@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 07:29:40PM +0100, Eric Auger wrote:
> This patch builds the virtio-iommu node in the ACPI IORT table.
> 
> The RID space of the root complex, which spans 0x0-0x10000
> maps to streamid space 0x0-0x10000 in the virtio-iommu which in
> turn maps to deviceid space 0x0-0x10000 in the ITS group.
> 
> The iommu RID is excluded as described in virtio-iommu
> specification.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Although VIOT changes the layout of the IORT node slightly, the
implementation should stay pretty much the same.

