Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89F8C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 06:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30CFE2067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 06:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="LvUCcvBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CFE2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipR9n-0000ra-2R
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 01:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cota@braap.org>) id 1ipR9B-0000Qq-1u
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 01:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cota@braap.org>) id 1ipR9A-0003jC-0q
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 01:18:20 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:45966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cota@braap.org>) id 1ipR99-0003gC-LG
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 01:18:19 -0500
Received: by mail-qk1-x741.google.com with SMTP id x1so4958637qkl.12
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 22:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=3Rdhq6g32Z/x4o0cSyYHE6X135X9G6tjQBtCP0xIDCw=;
 b=LvUCcvBEmsd8sh2PmHD+n6yocdRqBu+VF9HGUddhbY3Hh5KdxXZJDrZP4Y8SDfFjxO
 CwL9B8SDwkfb+vpHzuc7XFP2zrvDXzbHQjW0ZJZNPnuRdfI3XKvIJnxRCPsK8tiexY19
 rRa9OxhXwPeM/Txt8CQxzzfl6S1U/I7T5QD1b4uZPLkRoV7vGZ4uAjuNzxqxP2Z4XzjG
 OEnDZrtxZG42yOOUdt0HA4EZGXdhIiRdh3Ft9XNGSqWVi7SoJ/GDclQikBHyKrQi3cZ0
 bVuboOXMxiWJ3C2a3VrnFOwFXlV66y05SkDmg9PGKDDhVN1qZ0OZcS8FuGIXaVnxlSSb
 CRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=3Rdhq6g32Z/x4o0cSyYHE6X135X9G6tjQBtCP0xIDCw=;
 b=OoFzd4Nt3bD5xpHw8bQHyoXV0415Hj+hVJbGa4ThFYsZd16VjGddOqE6w8fFRTkTe+
 i2lzAD3N5Gsuh7Q6oeiawBBAB2iuHnB97Hcm9dMTGSIzoFowNoaFR0j5w5DmuTWhk32j
 c4xj56CMdFvMtdBk7SEqvcEs/XgrgbtsN//hHiKsTbJCI8zdkK6QLeCX+5bexDYYJLEZ
 JPsElIOimfMqNYvGItZ4ktoIhucFDbY7vJplPLwTLURwcpXjvWT40zuGubOATWvNERMq
 jY59qbL8GZ1rn7ZG0Vn4yREbhdx/L65GYmIOJBxNzbVByNefHAdqGsx+oEIleG3O4zYJ
 7vGA==
X-Gm-Message-State: APjAAAUXNx58atrIq2q0iG5dcLZyhR/JcaGOJhLy0jioilgU1pRMP+y3
 TJ1I4gJjUjHDM2GMhdcPpJh3Zg==
X-Google-Smtp-Source: APXvYqxFzqxhzwVDOEuIevdD6Waj/oaeY1L3ASmT8FRL5tM78bHRIcYj5HN8Hx2tr4DjxBKWIKOcaw==
X-Received: by 2002:a37:6704:: with SMTP id b4mr8210747qkc.32.1578550698681;
 Wed, 08 Jan 2020 22:18:18 -0800 (PST)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id f23sm2538591qke.104.2020.01.08.22.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 22:18:18 -0800 (PST)
Date: Thu, 9 Jan 2020 01:18:17 -0500
From: "Emilio G. Cota" <cota@braap.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] testing: don't nest build for fp-test
Message-ID: <20200109061817.GA9406@t420>
References: <20200107180003.6753-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107180003.6753-1-alex.bennee@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 07, 2020 at 18:00:03 +0000, Alex Bennée wrote:
> Re-calling the main make is counter-productive and really messes up
> with parallel builds. Just ensure we have built the pre-requisites
> before we build the fp-test bits. If the user builds manually just
> complain if the parent build hasn't got the bits we need.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.

