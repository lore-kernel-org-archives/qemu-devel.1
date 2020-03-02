Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855D2C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5093F2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A192xGTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5093F2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8kGH-0006gu-H1
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8kFS-0005n2-HN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8kFR-0006BO-Hp
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:32:38 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8kFR-0006Ay-AH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:32:37 -0500
Received: by mail-wr1-x442.google.com with SMTP id r7so12374522wro.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BRMDXWgfpF54NFk2HNW6Zxr/UQoii9W1VXMuBWGjx9E=;
 b=A192xGTcOlLyuEyfRkB/nlobhFndnTbZpB2quAom18NWlgQCCvB2R/tVtvXTB/gDnu
 tVxwcPvzF6XCB8iO1D+J9otg7HTiFiiBJLK9pt50iNM5SpcZPDft7oygKD+h/fo0GVwR
 IfbClsXMTz6/Mblo8yxdlWuH401cj2ipC4sgrxnn6bd+MYVtZkxijpZccBJiIz9eM5cM
 FBg/7FxjFhY2ANLVRCHwH78st0G8DREiKuDAWBxLsZDT3YSNsf1FyEklewPuN+pYvwuK
 GHY5hmWOO2UzmC3GMBLlYbadWyB9qWRiIUpkBD0IvLAqSNifOPsvdRhjGIBUmcw6cl2q
 977A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BRMDXWgfpF54NFk2HNW6Zxr/UQoii9W1VXMuBWGjx9E=;
 b=jdqOmx77XCQPs/XMgKvW9ppPXgIF4y2hU/8T4GIqdWYKkmL9Vq7IFKJDprOzhkD2Wi
 6c/nT8J/CLq/gfgHvJYewIVlsmkT994A6UFf+qObjdwsHiPMUa1c8Yi+Kb12XKWh2Fp+
 saMLTbf/AuosefsBdQQjqFxBMhh5d6GBpYWl26UgUj7S8qxv3vqjZdp+FRA56vcFrGny
 p/JxNg2N1qcolLrlVQB3ZxPPiVSaa1eobQMcp1hQRT8LLJS4PQW5ckycE/E+011M+yvA
 CHi9jN6zsrgQaQ8dRzxR5oJrruiksgOfwFwm9bC4V3VsAFdhrdyzBgHVHgp01VvO775G
 eYBw==
X-Gm-Message-State: APjAAAUOo3HrH7l2RbEMvLZcXhPL9MuaRIKXhPcvk4uzGUTKlc2esCUM
 EROVvdHGunUjNuyuLP8z5XKykA==
X-Google-Smtp-Source: APXvYqydvwTf3OrZdrZPcm+9S0H1b/cgKtE8V7xOeIhiZoyFQI65dKVJW5hhq7kYryYlc2HYXby+oA==
X-Received: by 2002:adf:f84a:: with SMTP id d10mr22598385wrq.208.1583152356397; 
 Mon, 02 Mar 2020 04:32:36 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z12sm1457263wrs.43.2020.03.02.04.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:32:35 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 83A241FF87;
 Mon,  2 Mar 2020 12:32:34 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-32-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 31/33] docs: Stop building qemu-doc
In-reply-to: <20200228153619.9906-32-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:32:34 +0000
Message-ID: <87zhcz7x99.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Stop building the old texinfo qemu-doc; all its contents are
> now available in the Sphinx-generated manuals and manpages.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

