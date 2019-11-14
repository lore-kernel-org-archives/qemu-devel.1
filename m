Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB52AC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6301F206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWbYdotP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6301F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVHAN-0002rC-Ft
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 10:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <teemu.kuusisto@gmail.com>) id 1iVDwA-0005HN-0G
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 07:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <teemu.kuusisto@gmail.com>) id 1iVDw8-0000i4-LK
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 07:09:21 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <teemu.kuusisto@gmail.com>)
 id 1iVDw8-0000hZ-AS
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 07:09:20 -0500
Received: by mail-wr1-x42d.google.com with SMTP id s5so6202381wrw.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 04:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=62ETJS+gaqrGC7EP26bg+n7vv+D7wUKd2Eb4H4GhNUA=;
 b=rWbYdotPtmGBVCWHeoydI2TBaPCFFMHxRsoUFeod7wc5h4tnk/FZf8hvr3uTrEqU8h
 kyn57tkcFgNpb8EiW//cUyNe6canIcv3FvxotTzetwz7CyWehqlHsEvo00Qj3Hu+w0rR
 i1w8RbuuNBzpMrwHaJ1Ow5ETko1Gh/tFVpXKz2N3nNNSIapQOiNOCVCyWxydRxJJzx27
 XqWk2iMEPhdgmKN1CcmOEQcXWIa3uu1XS11iOsZRL1sKS21q3RDorkdWm7b9/C4Mq1CY
 HIuK+EVc949QPfehF0KLDTpBBaRXrn9CSIYXkrKW2eBbdVMw+7BTIPFXaQQArFjiThNU
 QMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=62ETJS+gaqrGC7EP26bg+n7vv+D7wUKd2Eb4H4GhNUA=;
 b=TFthaoQIprgr1o2CEL7UTk1W52JqRCEO3Z8dP6pLsjVys84w2yxZjJDKIkitPABbhN
 1Hm5kbAFog7R1vtnU7DiKinVYRNsCKpu8JqhBwO6SP9rcZSJ2EcfgoyGz/+NKX9bm4N/
 hGXCY8FrOQqustOM/GfU5wChZLiFSDp8br9wHn9KWANfcIwOCxFMoS0xS9NcE7OY89fE
 H+ATBe7f1+UuThdc+e4zEQHYfB7BlSpN9mvTYcCpmtFFXLfpcBBuFqzbugQmut7t9w+p
 k4e6pbtVodqoIsoH5FH+wzfuGK8ytQxECrjVQile8bPlp/enmu55cLJlnHFRPEENEHi8
 JGTQ==
X-Gm-Message-State: APjAAAUCosRRRHt/l4KFqMw/JZODaqtOZTgnphqnI8ufGyEsFxHTzzzt
 9AUv0ZAVTV+pyxVC4qBFuvEZyWpY
X-Google-Smtp-Source: APXvYqznmdlrnTihTNG14ugFdd5DRZQ+i1eehzdABTwhOUtrzLmVvxcpL7O7qDiFcm5vr0ogdwRPdA==
X-Received: by 2002:adf:f445:: with SMTP id f5mr8206325wrp.193.1573733358198; 
 Thu, 14 Nov 2019 04:09:18 -0800 (PST)
Received: from valhalla (guest.anygraaf.fi. [62.44.192.148])
 by smtp.gmail.com with ESMTPSA id t5sm6661259wro.76.2019.11.14.04.09.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Nov 2019 04:09:17 -0800 (PST)
Date: Thu, 14 Nov 2019 14:09:15 +0200
From: Teemu Kuusisto <teemu.kuusisto@gmail.com>
To: qemu-devel@nongnu.org
Subject: Braille device (chardev/baum.c) is unable to detect the TTY
 correctly and does not act on graphic console connect/disconnect
Message-ID: <20191114120915.GA31365@valhalla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
X-Mailman-Approved-At: Thu, 14 Nov 2019 10:21:44 -0500
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

As a blind developer I would be very happy to use QEMU's baum chardev for a braille display. Unfortunately, this device fails to detect the tty in which 
the spice client is running. I would like to improve this device but I don't yet know how to achieve a better solution.

The current code calls qemu_console_get_window_id() to get the tty. This function returns zero, which causes the code to skip even the default behavior 
of brlapi's brlapi__enterTtyMode() (including checcking some env variables such as CONTROLVT). Furthermore, window id sounds like something different 
than a tty number, maybe a number of X display? The code does not currently consider the fact that the lifetime of the connected graphical consoles is 
not the same as the lifetime of the VM.

I hardcoded a tty number to the sources of QEMU version 3.0.0 to gladly verify that the device is working besides these problems.

So, I have a handful of open questions to start with: Is it possible to get callbacks for connect and disconnect of a graphical console (like spice and 
vnc)? How? Is it further possible to get any information of the connected client to determine the tty, and possibly sub-windows too (see 
brlapi__enterTtyModeWithPath), in which the client is running? Such events should lead to calls of brlapi__EnterTtyMode() and brlapi__leaveTtyMode().

To get this device working properly would be a life changing lifehack for me so I highly appreciate any help!
It would allow the use of Linux side by side with Windows and ChromiumOS, which is a big leap in this rather poorly accessible world.
If this is successful, I'm looking forward to spreading the word and helping others too!

With kind regards and informally on behalf of the Finnish braille authority,
-- Teemu Kuusisto

