Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D37C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 12:00:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFDBC20727
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 12:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKxLwKgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDBC20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWfhv-0000VI-Ov
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 07:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iWfh8-0008Eh-OB
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iWfh7-0007g2-LX
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:59:50 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iWfh7-0007fn-Dm
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:59:49 -0500
Received: by mail-wm1-x344.google.com with SMTP id l1so17052602wme.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 03:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=32xuPZcruzYAWLTbq/vnWzvEbgdTdd0JX465A9g47sQ=;
 b=wKxLwKgNIemN9oLnFL0JN/ckPidNsYLHVC6Zeyj2RUNMaXN4fXzMl4V4hJmOadfnb+
 1XdweVAtq08w/vAwqV3YjVXnFfVtLLfYGo8SMCxo59vPTkJXEJWueZmuIOGzO7g2/Ouo
 dW1QBmeBTH57mkOGkYI1PudVNbZyYb95OZ2ChRGRiNFNKozs/w8Cv+Zd7Gb48+x3fA4j
 QNmPW3LYPtvsYTT02t4dlWZsgddRV3VMfKTvVRsKiq5JVcmCawbweklhUbRuDqK6SypA
 JqrX9awopiX0fytWYX1HoiCB+netda9TiPMadWWVh0W+2b0PvHUB7viLKuSYlNesbc7p
 HLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=32xuPZcruzYAWLTbq/vnWzvEbgdTdd0JX465A9g47sQ=;
 b=Ha7x1SaiX255xOHlS3pl1ojbz2INlelZ1au1OYK/CCH7f8ijBw9wXS2fuJQemop/hc
 NxUxFGX+J+RtrXzXXUSZu4PE5D0kIjkF3dHFyNfNqAyfh62D0YLrilSxTm/Zbopwx2hI
 XVwYBiXSD2Fw7t+ATC4SmIbGvSvW4n1F/gYrQWldSYi954GrexCpPsd2/wIKbT5MkqIK
 Urj+h8E+Jm14/rzfvZr686paTUE3SOpK/3JrmQgyg1jeecgZn2aQLN7QGn40TW0jEdPo
 qVL36iLDEMWOv+8aKhCXMC5t+vQiUYkIlcxfQkVQ0Z8e/dZk049dUyPAMH5LUPgJmov4
 35nQ==
X-Gm-Message-State: APjAAAWduxpM06e5nM0xEugF2meXvN1M7NduPIZfWJY1/yx0TQhkPRv+
 KfCo19d58h5GTdwJFqRNliVm7A==
X-Google-Smtp-Source: APXvYqzAjlfPqdWw1dQQhqUgwS2vsXXDfogJL6Jmxx4RQg2IJSRD7bi7F1r7HCq7YDHxOTtBhpT12g==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr28524678wma.12.1574078388155; 
 Mon, 18 Nov 2019 03:59:48 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u187sm20939244wme.15.2019.11.18.03.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 03:59:47 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7580A1FF87;
 Mon, 18 Nov 2019 11:59:46 +0000 (GMT)
References: <20191115173000.21891-1-alex.bennee@linaro.org>
 <20191115173000.21891-3-alex.bennee@linaro.org>
 <9df9cde2-9689-3658-da7a-74a289d6d4e8@greensocs.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [RFC PATCH 02/11] gdbstub: stop passing GDBState * around
In-reply-to: <9df9cde2-9689-3658-da7a-74a289d6d4e8@greensocs.com>
Date: Mon, 18 Nov 2019 11:59:46 +0000
Message-ID: <87imnhgzt9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: luis.machado@linaro.org,
 Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Damien Hedde <damien.hedde@greensocs.com> writes:

> On 11/15/19 6:29 PM, Alex Benn=C3=A9e wrote:
>> We only have one GDBState which should be allocated at the time we
>> process any commands. This will make further clean-up a bit easier.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  gdbstub.c | 307 +++++++++++++++++++++++++++++++-----------------------
>>  1 file changed, 177 insertions(+), 130 deletions(-)
>
> Do we know why we choose to pass GDBState * everywhere ?
> It sounds like a way to eventually handle multiple gdb connections but I
> don't know if it has some sense.

I'm not sure it does. The gdbserver has quite a degree of control on the
running of the system state. I'm not sure how having two connections
would work in that regard.

The only reference to multiple gdbservers the manual makes is having
--one to allow port sharing between multiple instances (with their own
inferiors).

--
Alex Benn=C3=A9e

