Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D33BC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 22:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597AD217F9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 22:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E86/XccI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597AD217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK8op-0004Lz-FB
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 18:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iK8o4-0003tQ-43
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 18:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iK8o3-0008LV-2S
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 18:27:12 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:44902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iK8o2-0008Ie-Tk
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 18:27:11 -0400
Received: by mail-oi1-x233.google.com with SMTP id w6so15041466oie.11
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=45Ouz/KmciYmGQL4SqVu58W0tUDLpZvvIBqcXSbwB3Y=;
 b=E86/XccI4XCB0lPVXIYg6r0lCmbQ1rJnp+aaIfAKm7WTIZ6m4zn+AIj/ZAkuzlj9Lf
 WMGbFOzAK+TocETb+4QKdecawFTYwi8Hd1wFXrpMTM5/LQbA6m6w1Ty3bFDUpFRp4cL/
 GMy/zud8mby04dqbV0FznPsWLv3nNorUQsyoLgWaVKtHfo8QOFmrfubmAqreSwxWnyO6
 7UEnCVZrpeT2mm5K6qq2h2fOdG0xLSYhXZU9i+ugoSOg6QjhbmkwqHtIYtznvH/wETBx
 k+Qm0KCX3569Qfy8edDinhIlyBtK4CM7cBVsmxj1drn04IWw9lB9xukS95KsmrNT3TJ/
 RIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=45Ouz/KmciYmGQL4SqVu58W0tUDLpZvvIBqcXSbwB3Y=;
 b=rKhAgnjlW7YjwUaLUgnBPe1/JjAAb2VfrgrVY7eCswTUaNcjohJmrgCHID9K5wW/ys
 mtl9W5Fj15iKpv57A/79/Bzn8yLOeDvnThNIMhhULSqpp1sKINzRcHkR7WFls6jCWlYc
 QZQ6kDdJzZfVe0y+femQ3ITmvfO+F7CvcOEA7RABzqzswA9qdHn0lvyCvDx89hcWxafX
 GYS0SpaVjlWd/fs4/zzqxaVm9BOxTlbLFKUbLNPMsFUETs3VM/keg6nSeh8WKB7qznk/
 NmvDVyE9B0UKAmNVZYMtErP7vWghWmtGQdsN1CyRx2TYxSd+v7uOz2vGzh6wLRmSXc6m
 +ZoQ==
X-Gm-Message-State: APjAAAX10mo0fbfJwOJmqzr0Sd+9qjAHaYUqsmJNhXiLHRW4RA36yHL9
 R117KfhVD/OHUF40Mgn/EQ==
X-Google-Smtp-Source: APXvYqwGUbk5y/46gA/PNB3LxX+kRecFJ/qHgzBWywDm2nd8M5FLBVpxjVEXCL3TqVSrDNQNe5hytA==
X-Received: by 2002:a05:6808:255:: with SMTP id
 m21mr26634015oie.32.1571092029258; 
 Mon, 14 Oct 2019 15:27:09 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id 93sm6323276ota.16.2019.10.14.15.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 15:27:08 -0700 (PDT)
Received: from t560 (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPSA id 191D0180046;
 Mon, 14 Oct 2019 22:27:08 +0000 (UTC)
Date: Mon, 14 Oct 2019 17:27:06 -0500
From: Corey Minyard <minyard@acm.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: ACPI table modifications
Message-ID: <20191014222706.GK14232@t560>
References: <CAM2a4uzF-mtTEYwQE3+MvvDiQrfC_KQMwX4vqCg_dY9ytjZrjA@mail.gmail.com>
 <8a3d99b5-d9d3-28a7-2de0-e8a0a17356c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a3d99b5-d9d3-28a7-2de0-e8a0a17356c1@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
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
Reply-To: minyard@acm.org
Cc: Gautam Bhat <mindentropy@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 09:22:19PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Gautam,
> 
> On 10/11/19 8:47 PM, Gautam Bhat wrote:
> > Hi,
> > 
> > I want to add some I2C based temperature sensors to the -M Q35 machine.
> > I want to update the ACPI tables to add this device information. How can
> > I go about  doing this?

FYI, I just added the SMB ACPI entry to q35, change:

  ebe15582cafeb "pc: Add an SMB0 ACPI device to q35"

I did this for IPMI, but it should be easy to add your own entries
the same way.

-corey

> 
> QEMU provides a MAINTAINERS file with persons to contact sorted by topics (I
> Cc'ed in this reply).
> 
> This is the relevant ACPI section, it also lists the files you might look
> at:
> 
> ACPI/SMBIOS
> M: Michael S. Tsirkin
> M: Igor Mammedov
> S: Supported
> F: include/hw/acpi/*
> F: include/hw/firmware/smbios.h
> F: hw/mem/*
> F: hw/acpi/*
> F: hw/smbios/*
> F: hw/i386/acpi-build.[hc]
> F: hw/arm/virt-acpi-build.c
> F: tests/bios-tables-test.c
> F: tests/acpi-utils.[hc]
> F: tests/data/acpi/
> 
> Eventually the bios-tables-test.c file is a good starting point.
> 
> Regards,
> 
> Phil.
> 

