Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3D1C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FCB206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="CKxUI4zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FCB206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXoVp-0006TH-EO
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 10:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1iXoUG-0004rt-SK
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1iXoUE-00080l-1a
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:35:15 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1iXoUD-0007tn-Jx
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:35:13 -0500
Received: by mail-ot1-x342.google.com with SMTP id 23so1503592otf.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 07:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=jphpIYc+qgIXon7yS9vSnUoJR8qULfm76oAyWkA9qDI=;
 b=CKxUI4zqUTXAn5hzUyrnZvC8svpyrQj73cChAtgSq3lHq/qzCK4EN2TCggDY8OWgWQ
 B6tELpafCOKWOOxIij49KSPx/9rTR/twaNn5VwnnrT5VDlg17fXHYaPckuOl1L9/ufs6
 tTS9ueHLg7122o4rK299IUIee+3Tpfuwtcc7eNcbOx3augrFGejgbSZSsxPwFx6ItaMR
 yx/kA0cTpA8UvvNeVLJ2Y+oB900AWFOtvw0MVHqhH0xykGqUautH4VzoNMuzExhaPKhi
 4YJIy78Nw2JEbMp0ra6tUPMaJTjw2HCk1R+sAPGYjfUYWrvB+d1g9shFcuTTboiqZ8AM
 LHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=jphpIYc+qgIXon7yS9vSnUoJR8qULfm76oAyWkA9qDI=;
 b=es8GCB9IhcsfLQYGilrGo7OK3yDGMf6XAAJLTrt3TcGNM5LWDNAuDpkEL7CXxc9ay5
 dXlT4a3Hmd0Rl1WeOVeubXaD0dqKfe/DoGvR4dQiMCqJ+8ly4WM5Fw6jUTf5q9ATReeE
 8nITR1ZeqUpxl/yDCeWZrb7ygN7+tFMBhCiOS5DliWGdhoEQFhfT0beLZbRvS9BSvbWi
 9s96D09iwJ9m+obWSlG15EZoOLaqo9sqc4HehMmSHvLI6x9r6wZFPxXnoBjj6qj5JZI+
 IIXF/9MNOOPOLjdJDF0WULohRPPLiXO+ioH8ZdYoFRz1iTmobsQsrOBVWtVtjTmeMLYD
 Ruzw==
X-Gm-Message-State: APjAAAU3uFGvpsABovARdlbJRjH0ir/waY7gak+kQK91dOEHMsQE+dTm
 PwTtic0KFsghbUsb41whUDJnwQ==
X-Google-Smtp-Source: APXvYqwJsZoVsNMF6OZGYWI0cM6HjaykJieGvQ6HxmbA+M6h4FLuqOil20Faog+OUvPZORV7vBrBxQ==
X-Received: by 2002:a9d:7a93:: with SMTP id l19mr6674554otn.314.1574350509693; 
 Thu, 21 Nov 2019 07:35:09 -0800 (PST)
Received: from minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id j8sm1088508otj.42.2019.11.21.07.35.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Nov 2019 07:35:09 -0800 (PST)
Date: Thu, 21 Nov 2019 09:35:07 -0600
From: Corey Minyard <cminyard@mvista.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] ppc/pnv: Create BMC devices at machine init
Message-ID: <20191121153507.GF3556@minyard.net>
References: <20191118092222.15691-1-clg@kaod.org>
 <20191119005232.GH5582@umbus.fritz.box>
 <2c2dfb82-e5cd-ef94-3542-8ec92b1ef001@kaod.org>
 <20191119220507.GX5582@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191119220507.GX5582@umbus.fritz.box>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Reply-To: cminyard@mvista.com
Cc: qemu-ppc@nongnu.org, Oliver O'Halloran <oohall@gmail.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 09:05:07AM +1100, David Gibson wrote:
> On Tue, Nov 19, 2019 at 07:49:33AM +0100, Cédric Le Goater wrote:
> > On 19/11/2019 01:52, David Gibson wrote:
> > > On Mon, Nov 18, 2019 at 10:22:22AM +0100, Cédric Le Goater wrote:
> > >> The BMC of the OpenPOWER systems monitors the machine state using
> > >> sensors, controls the power and controls the access to the PNOR flash
> > >> device containing the firmware image required to boot the host.
> > >>
> > >> QEMU models the power cycle process, access to the sensors and access
> > >> to the PNOR device. But, for these features to be available, the QEMU
> > >> PowerNV machine needs two extras devices on the command line, an IPMI
> > >> BT device for communication and a BMC backend device:
> > >>
> > >>   -device ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10
> > >>
> > >> The BMC properties are then defined accordingly in the device tree and
> > >> OPAL self adapts. If a BMC device and an IPMI BT device are not
> > >> available, OPAL does not try to communicate with the BMC in any
> > >> manner. This is not how real systems behave.
> > >>
> > >> To be closer to the default behavior, create an IPMI BMC simulator
> > >> device and an IPMI BT device at machine initialization time. We loose
> > >> the ability to define an external BMC device but there are benefits:
> > >>
> > >>   - a better match with real systems,
> > >>   - a better test coverage of the OPAL code,
> > >>   - system powerdown and reset commands that work,
> > >>   - a QEMU device tree compliant with the specifications (*).
> > >>
> > >> (*) Still needs a MBOX device.
> > >>
> > >> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> > > 
> > > This doesn't apply to ppc-for-5.0 for me.  I'm not sure which change
> > > in there it's conflicting with, but there seems to be something.
> > 
> > Sorry I should have been more precise.
> > 
> > 
> > This is because we need an IPMI patch to be merged first in 
> > Corey's tree :
> > 
> >   ipmi: Add support to customize OEM functions
> >   http://patchwork.ozlabs.org/patch/1185187/
> > 
> > and another one merged in the PPC tree: 
> > 
> >   ppc/pnv: Add HIOMAP commands
> >   http://patchwork.ozlabs.org/patch/1185185/
> > 
> > 
> > David, if Corey agrees, I think it would be simpler if you took 
> > them all.
> 
> Ok.  Corey, could I get an Acked-by from you?

Sure

Acked-by: Corey Minyard <cminyard@mvista.com>

> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



