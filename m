Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811B3C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 18:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7BD20673
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 18:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTMGNniR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7BD20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53692 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfTWP-0002en-TS
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 14:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55489)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groeck7@gmail.com>) id 1hfTHr-0003HE-FN
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 14:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1hfTHp-00052f-Ih
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 14:01:51 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1hfTHl-0004ql-Q0
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 14:01:47 -0400
Received: by mail-pg1-x543.google.com with SMTP id s27so7544439pgl.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 11:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=mFheYF+BIWEOVBgxx/dvOxxMQ9l0+ijuNp6PBJXdVXk=;
 b=FTMGNniRLm2dpXfBgOjLUhvPPwdpNz+dWAcdgYDTDxJckM7YmW+q127hqvlLbOOrEV
 w9BxIXlafR8/w0paEO/zRVlOGnf4AQaQa01BtuIVTdS5V2OdqCYbC9umTn0CQLfpVtIl
 Dsf+4ifrCw7lnBO7Yy0P7FjEikM5pKe8vH7ZMKodZ8ZrYDEXtSXSKdB7tQlo6iM8n9DQ
 OwNmzvMxTLr318vvrS0/5rxkQM8WpsLGMHw0MOIZVjvhzyRdGpE0T0tEA3sCNZitHiMl
 Lljs7/tI6K6bz60WGOIZSuNAcRfbsSGhY81u1swFOD5blTEn96YK4y4VKC6bxITIzruz
 ehHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :mime-version:content-disposition:user-agent;
 bh=mFheYF+BIWEOVBgxx/dvOxxMQ9l0+ijuNp6PBJXdVXk=;
 b=WA1LNKUliRyXOd4bxp+lLMOOv4oNrrubP0sjBJRsf3Bs7jSKjywxTcAnIlUiuKXGYC
 HKhlUJSjkH4baGqtK7YsP3lWzwOGUGwuWea1CjQ+5SkMbZZD0LGRMVP1KT/iQWpl3uu2
 2Swwr01DJjnAx44RBmJeGMyXMMHBqjwFqXaYJfHhAy2PTaLHfXdJ4wwdnl8RoYRWsmdO
 r5msCZuFmoJ8fcOd8VyRMwF8wyHikkZSJtQBbxa/D4Nq8a62wD+GVD8geuxEVzP3AL1X
 hKSUcMTcuOZ8EqZwb5FgHxFwxcqXSzVYGDLrBHDxgLgyur/59Cfg7ghBKD+Iq2R+Jjtw
 YASg==
X-Gm-Message-State: APjAAAULdTY5wAz5sSVXG1bgXsqqcognZE1Y2xto0a0l86BOvyRg8q7+
 mjVa3L7jRpnR+F2FrBq6X7JO34Fj
X-Google-Smtp-Source: APXvYqwRPlUx6bPI2XdsTtrhzL4ec/vllJ0tMW8PoTe9p1KY1Obc4bCAZSVlJgHnF1cMXfw2yc0k9g==
X-Received: by 2002:a63:d66:: with SMTP id 38mr35167370pgn.59.1561399301973;
 Mon, 24 Jun 2019 11:01:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id v9sm11942028pfm.34.2019.06.24.11.01.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Jun 2019 11:01:40 -0700 (PDT)
Date: Mon, 24 Jun 2019 11:01:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Message-ID: <20190624180139.GA17161@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] qemu-system-x86_64: hw/usb/core.c:720: usb_ep_get:
 Assertion `dev != NULL' failed
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I have seen the following problem several times recently. This is with qemu-4.0.

qemu-system-x86_64: hw/usb/core.c:720: usb_ep_get: Assertion `dev != NULL' failed

Backtrace gives me the following call path.

main_loop()
  main_loop_wait()
    glib_pollfds_poll()
      aio_ctx_dispatch()
	aio_dispatch()
	  aio_bh_poll()
            ehci_work_bh()
              ehci_advance_async_state()
                ehci_advance_state()
                  ehci_execute()
                    usb_ep_get()

The problem always happens during shutdown, maybe once every 100 boots.
It seems to be more likely to happen when the system is under heavy load.

...
umount: devtmpfs busy - remounted read-only
[   49.018682] EXT4-fs (sda): re-mounted. Opts: (null)
[   49.028052] sd 6:0:0:0: [sda] Synchronizing SCSI cache
qemu-system-x86_64: hw/usb/core.c:733: usb_ep_get: Assertion `dev != NULL' failed.

Essentially that means that p->queue->dev is NULL in ehci_execute().

Has anyone else seen this problem ? Any idea what I can do to debug
this further ?

Thanks,
Guenter

