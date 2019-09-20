Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E43C4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2743D207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVX3ElFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2743D207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBHvI-0006vx-96
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 08:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iBHsq-0005Oa-Qq
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iBHsp-0005At-Bm
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:19:32 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41261)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iBHsl-00057j-Fl
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:19:29 -0400
Received: by mail-oi1-x242.google.com with SMTP id w17so1545613oiw.8
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 05:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EB/SsHYpV2+iIQpQMoDnhWDrHjvxspNUdHc3aN2Lohw=;
 b=qVX3ElFH4lEhYCuOH0GiBH+owNiTq6hOXmzcZNlBX6eGMuyos3dcWmOY69D7MNCSpW
 11yjY9GFgL9hNJWxQD4tMDWnBsVMEOM6m/ot3NYdwTueYBqf1BkK6j6rRxxR2+j/8c/l
 Anq4HLx1yI5c+b7xwbyIjEbklV3DCno6yUtSJZmqcQdfZKmP0xnmKDUrZgiJ1YEWyTjj
 X7T1GPgPnVYl/jODGz99GsDkvTrx+8WeU4Qs45chGpxzsNT++HklkFHeslDddDaw7BKC
 6R1k/Q8e0LAt1Btji2KTZy+L+7/gYn3p7cdBqPMpsI35JpbrX6jq+nsytOky2Ka2VF8u
 QyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition:in-reply-to
 :user-agent;
 bh=EB/SsHYpV2+iIQpQMoDnhWDrHjvxspNUdHc3aN2Lohw=;
 b=almuAoOId2Zdr+ytEjEFPxt+KDiblGSL/rQJHiWdCM9TCDh9oBx7YtqkCqcVwaHXqh
 DsO+6Ef6Y/t+2hWkM2DKe/qkNBWyDK/6r3mdFz95/GSET30n7OKl5WmPvwEZ73MgAoju
 7RZZ776EW0MpNmbWn3o9vOmEj9lsARCzwjqxlEyx+2JMCQ2L5tRDGj9kKgojwypGH7Kz
 aCwN2qH/GHuDCGiMurJhyeGLdsL9F0H4iTCIV5wbL+ZRXPtLNXokdDYOh4bWIVAWoEkC
 FryQylsXGM5IP+rhTLUqBKNx25hsBP0XHQZ9/VYyeSK4Bl08vB5upZyzYVtO0JumAvPh
 awPA==
X-Gm-Message-State: APjAAAUOk37INAvxFF4U8obuJMhhhXG5Mga3guVNiNe3wdu9WgtACesv
 qUnfviRTYPzU84lex6Y38g==
X-Google-Smtp-Source: APXvYqziqyk2y4COehruHx+35ifIZFoQ0DRn1ivoCwg5ojq/sVo7ckTmy4sEgybim1anNK1tp0f3Lw==
X-Received: by 2002:aca:5ed4:: with SMTP id s203mr2600943oib.101.1568981962090; 
 Fri, 20 Sep 2019 05:19:22 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id x140sm512067oix.42.2019.09.20.05.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 05:19:21 -0700 (PDT)
Received: from t560 (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPSA id D9A22180580;
 Fri, 20 Sep 2019 12:19:20 +0000 (UTC)
Date: Fri, 20 Sep 2019 07:19:19 -0500
From: Corey Minyard <minyard@acm.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/15] ipmi: Bug fixes, add new interfaces
Message-ID: <20190920121919.GB31565@t560>
References: <20190919213924.31852-1-minyard@acm.org>
 <2e9b4b2e-ac56-6039-a800-fbdc48ca1958@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e9b4b2e-ac56-6039-a800-fbdc48ca1958@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 01:43:32PM +0200, Paolo Bonzini wrote:
> On 19/09/19 23:39, minyard@acm.org wrote:
> > I haven't gotten a lot of commentary on this, but I assume that means
> > that everything is ok.  It's been posted a few times and the last time
> > I received no issues, just a couple of reviews.  I would like more
> > review.  But I'm not quite sure what to do about that, I've been
> > hanging on to these changes far too long.
> 
> It's just that not many people here are IPMI-savvy.  I took a quick look
> at patches 5 and 15, and they look fine.

Thanks a bunch for looking at those.  Patch 15 was my biggest worry.

-corey

> 
> Paolo
> 
> > The following changes since commit a77d20bafcd4cb7684168a9b4c6dc2a321aaeb50:
> > 
> >   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190919-pull-request' into staging (2019-09-19 17:16:07 +0100)
> > 
> > are available in the Git repository at:
> > 
> >   https://github.com/cminyard/qemu.git tags/ipmi-for-release-2019-09-19
> > 
> > for you to fetch changes up to d9b74295c6528fd68cebdea116b283e46543b2a2:
> > 
> >   pc: Add an SMB0 ACPI device to q35 (2019-09-19 14:41:58 -0500)
> > 
> > ----------------------------------------------------------------
> > ipmi: Some bug fixes and new interfaces
> > 
> > Some bug fixes for the watchdog and hopeful the BT tests.
> > 
> > Change the IPMI UUID handling to give the user the ability to set it or
> > not have it.
> > 
> > Add a PCI interface.
> > 
> > Add an SMBus interfaces.
> > 
> > -corey
> > 
> > ----------------------------------------------------------------
> > Corey Minyard (15):
> >       ipmi: Fix watchdog NMI handling
> >       ipmi: Fix the get watchdog command
> >       ipmi: Generate an interrupt on watchdog pretimeout expiry
> >       tests:ipmi: Fix IPMI BT tests
> >       qdev: Add a no default uuid property
> >       ipmi: Add a UUID device property
> >       ipmi: Split out KCS-specific code from ISA KCS code
> >       ipmi: Split out BT-specific code from ISA BT code
> >       ipmi: Allow a size value to be passed for I/O space
> >       smbios:ipmi: Ignore IPMI devices with no fwinfo function
> >       ipmi: Add PCI IPMI interfaces
> >       ipmi: Add an SMBus IPMI interface
> >       acpi: Add i2c serial bus CRS handling
> >       ipmi: Fix SSIF ACPI handling to use the right CRS
> >       pc: Add an SMB0 ACPI device to q35
> > 
> >  default-configs/i386-softmmu.mak |   3 +
> >  hw/acpi/aml-build.c              |  40 ++++
> >  hw/acpi/ipmi-stub.c              |   2 +-
> >  hw/acpi/ipmi.c                   |  13 +-
> >  hw/i386/Kconfig                  |   3 +
> >  hw/i386/acpi-build.c             |  17 +-
> >  hw/i386/pc_piix.c                |  12 +-
> >  hw/i386/pc_q35.c                 |   9 +-
> >  hw/ipmi/Kconfig                  |  15 ++
> >  hw/ipmi/Makefile.objs            |   5 +-
> >  hw/ipmi/ipmi.c                   |   6 +-
> >  hw/ipmi/ipmi_bmc_sim.c           |  30 ++-
> >  hw/ipmi/ipmi_bt.c                | 437 ++++++++++++++++++++++++++++++++++++++
> >  hw/ipmi/ipmi_kcs.c               | 423 +++++++++++++++++++++++++++++++++++++
> >  hw/ipmi/isa_ipmi_bt.c            | 443 ++-------------------------------------
> >  hw/ipmi/isa_ipmi_kcs.c           | 419 ++----------------------------------
> >  hw/ipmi/pci_ipmi_bt.c            | 146 +++++++++++++
> >  hw/ipmi/pci_ipmi_kcs.c           | 146 +++++++++++++
> >  hw/ipmi/smbus_ipmi.c             | 384 +++++++++++++++++++++++++++++++++
> >  hw/smbios/smbios_type_38.c       |   3 +
> >  include/hw/acpi/aml-build.h      |  18 ++
> >  include/hw/acpi/ipmi.h           |   2 +-
> >  include/hw/i386/pc.h             |   2 +
> >  include/hw/ipmi/ipmi.h           |   7 +-
> >  include/hw/ipmi/ipmi_bt.h        |  73 +++++++
> >  include/hw/ipmi/ipmi_kcs.h       |  76 +++++++
> >  include/hw/pci/pci.h             |   1 +
> >  include/hw/qdev-properties.h     |   7 +
> >  qemu-options.hx                  |  10 +-
> >  tests/Makefile.include           |   3 +-
> >  tests/data/acpi/q35/DSDT         | Bin 7841 -> 7879 bytes
> >  tests/data/acpi/q35/DSDT.bridge  | Bin 7858 -> 7896 bytes
> >  tests/data/acpi/q35/DSDT.cphp    | Bin 8304 -> 8342 bytes
> >  tests/data/acpi/q35/DSDT.dimmpxm | Bin 9494 -> 9532 bytes
> >  tests/data/acpi/q35/DSDT.ipmibt  | Bin 7916 -> 7954 bytes
> >  tests/data/acpi/q35/DSDT.memhp   | Bin 9200 -> 9238 bytes
> >  tests/data/acpi/q35/DSDT.mmio64  | Bin 8971 -> 9009 bytes
> >  tests/data/acpi/q35/DSDT.numamem | Bin 7847 -> 7885 bytes
> >  tests/ipmi-bt-test.c             |   6 +-
> >  39 files changed, 1902 insertions(+), 859 deletions(-)
> >  create mode 100644 hw/ipmi/ipmi_bt.c
> >  create mode 100644 hw/ipmi/ipmi_kcs.c
> >  create mode 100644 hw/ipmi/pci_ipmi_bt.c
> >  create mode 100644 hw/ipmi/pci_ipmi_kcs.c
> >  create mode 100644 hw/ipmi/smbus_ipmi.c
> >  create mode 100644 include/hw/ipmi/ipmi_bt.h
> >  create mode 100644 include/hw/ipmi/ipmi_kcs.h
> > 
> > 
> > 
> 

