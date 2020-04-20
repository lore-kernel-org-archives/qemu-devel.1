Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE24C38A30
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99DF72071C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OA4T2rnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DF72071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQThc-0006gu-PK
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 06:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55682 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQTgu-0006B6-0X
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:30:16 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQTgt-00041Q-91
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:30:15 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37849)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQTgs-0003z7-Oi
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:30:14 -0400
Received: by mail-oi1-x244.google.com with SMTP id r25so8306349oij.4
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 03:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FyneVnA8GhQbsUNG5sSS0ap+l7DGCIk7AyK1awhXbpc=;
 b=OA4T2rnILU57bnD3tQIgqDFozYA6hunbaZKeO/UDReN152WptQnOmyJoyVuVcVznXF
 RT7OnwhqApCGIUxdoB7GCl/HQBvmu1C3ph3xXiLaMn2vbbDXeGhAQDPHWOlEhMHjDKbc
 wML2KkQIlUcPaNApwSUe3C1xNrhkp8w6Rhkd9LCgWG3ZXWG0BB1lDf9p44LmEoD9tEIx
 hLcEaJ+b2aLhIRVYHijaghZFSvLZpqjjzvXBnntT2tOVVLVZ0QsEEAkJAF+AMahXsvTK
 +rlIOJKsBqZDn2dyln1+MzHuxjL98lsXw/Q/tkGtnfeCD0TQssMJDGrup2anIzLjuDJp
 aXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FyneVnA8GhQbsUNG5sSS0ap+l7DGCIk7AyK1awhXbpc=;
 b=ZV3waeWhusThwnW4KXDbTFwvprRIWDIv81/PAkAymPr9dCZkh68qrPDblYFMPKiuLh
 5o+dzS5O2WVWsdt+5vrx+dXuQi8eOBDMMTnjzUnaq5rdP8sP6KV7UXOITCkF+BzKKsjR
 3x6UIge1c2Ggz1Fv4p2EX/i+FqAsbIWxTUbKUj+n8fSSbuVU9OuTSOxqh/4BUAK/PuKJ
 +Fu2smmQOVsCVI6pZdopJVdF8eicH9bS9YNDbJQp2Jy1F0epvoFiFQn06ZNrqA4Ewr73
 A4vLnFoYkgUBgZOUfATyOqzRrg+RTYIPfDT5OElJ1lVHR0wBdJxak8MIYi/XRTaT2NHi
 hdZQ==
X-Gm-Message-State: AGi0PuY24C8TZWDkuoJCLzDtcOql8/+PidJ2g9NOvfVUMVcq6Dq5mVMi
 8n4lOJK0Ao0yhMXLFEMpp2RftmlDBYpDrHsa5z3G6Q==
X-Google-Smtp-Source: APiQypLF/vzN6hJmQ/cugMJ75O+VVWU7g0wjtQW/BrRM3HOKIhYL7BlMSW1NLfR3HUWLvzgJsd/5JdWu1qO0JzcToME=
X-Received: by 2002:aca:c751:: with SMTP id x78mr9080185oif.163.1587378613517; 
 Mon, 20 Apr 2020 03:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAEme+7FPF+inSJSXQPmuv8Up3Eam0N7fT03zqM-RvcvKsxjfVQ@mail.gmail.com>
 <CAFEAcA9Yk53oK5YstN7DpCCq344+tbyjvDA6RaWcJCrL9QSjMw@mail.gmail.com>
 <CAEme+7Gt+TX99-pun80doARC5gE6=zDsuJLd1PVxt_SvRPf6Yw@mail.gmail.com>
In-Reply-To: <CAEme+7Gt+TX99-pun80doARC5gE6=zDsuJLd1PVxt_SvRPf6Yw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2020 11:30:02 +0100
Message-ID: <CAFEAcA9LpLrUsdGV0rNu-qOhQ08HvJ4nPPDCwD11BTfED082Gw@mail.gmail.com>
Subject: Re: [PATCH 3/3] plugins: avoid failing plugin when CPU is inited
 several times
To: Nikolay Igotti <igotti@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Apr 2020 at 11:18, Nikolay Igotti <igotti@gmail.com> wrote:
>
> Maybe, I've tried least intrusive change as not entirely familiar with plugin login in QEMU.

Me neither, but having the hashtable continuing to contain stale
information about a CPU that's gone away seems like it might
cause problems somehow. (There might be similar situations with
CPU hotplug/unplug in system emulation mode.)

Just noticed Alex wasn't on cc, so I've added him (I'm afraid
you'll have to look back up the thread for context, Alex...)

thanks
-- PMM

