Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55664C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21171214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RjIsWQHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21171214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9lMO-0001h5-4q
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 03:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i9lLT-000199-Rx
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i9lLS-0006Y5-Al
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:22:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38221)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i9lLR-0006XG-Ul
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:22:46 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so37622802wrx.5
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 00:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dVXOX2aTpi0aTDNv62OGxs8SMmwiXvsCRO5IlQagJg0=;
 b=RjIsWQHbRehqNYQhTC+WE8B2z/7V/7coPw6kTvVgmj2sPZ5Yfh/6FC5YwupDGzncS5
 U1PtUFc3W+/nm6H+kUtmALfyYqrM+5ZWcRwlx0/+nKg3730vzSRCaC+Inmp+jAvPPgfy
 j0X/YDobPG+wzjSFyy7uufqs5nzko67aMIfRy4/iJKPTTsDw3SJ2YsqxJoO3i4ISG6Pj
 gOV7bPASde4cRngStMt9BaqHu/0WQdVL6H57kqSRFNPetSxW0KoxRyt2i49fTRNvpbTY
 NObGxsOagrvpIQDDbv8QEudN+K/irLa9IuDqB+veIoxZL+lZ33CbzD9tk8H0qoWNnZXa
 ku9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dVXOX2aTpi0aTDNv62OGxs8SMmwiXvsCRO5IlQagJg0=;
 b=RBiqFNZ7d1IWubD1VdaPw26SkZsUxkyhpBP7RAaKjsUi41wJ7dYH785xwpLFMj1d9T
 JYWqnJaWWXcpCFXQScfhm6WH3MBXoB/9dN4EbfoDrj0f28/c1JwNQU6tbf5uDzNX8MGs
 tGNcLg8kO7tGxHBnkrNI529oxkAIE2jGVTrR88d9nnQXK0XyI3cy0rqU3vl6NM2oM2AG
 jhHPvcw8cgVe/2oCjDJOeBX8fi0NYRlCb4TD3eaCm+ngh19V0OdqaDMGf+IubX9YMgqr
 +dAZl6NfFEByIn9EfRcX73TXvAlEb7t3I9x4SnCmvcc2Ure0HdLM6jLZjyXGqC9k3pva
 pIhw==
X-Gm-Message-State: APjAAAVqDqesNEwaCHRUHqCeAwAwmyg8Abo5MP7ws21Ypt/vNhjMPLZB
 hOPTXbnIO19HcGkRGSos6eaPBw==
X-Google-Smtp-Source: APXvYqwbKnFq0qV3rD3silKB5GMA7eGJ/ICzCg6Ent6WtKPyJKF1ustPDAgxrbRiz9za01jmmtFHAg==
X-Received: by 2002:adf:f081:: with SMTP id n1mr19604550wro.273.1568618564049; 
 Mon, 16 Sep 2019 00:22:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a205sm23255446wmd.44.2019.09.16.00.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 00:22:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 35F8A1FF87;
 Mon, 16 Sep 2019 08:22:42 +0100 (BST)
References: <20190911093951.6244-1-alex.bennee@linaro.org>
 <8f76ef47-0cf8-c662-0100-d416f5f2e0c1@linaro.org>
 <20190916014858.GH2104@umbus.fritz.box>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-reply-to: <20190916014858.GH2104@umbus.fritz.box>
Date: Mon, 16 Sep 2019 08:22:42 +0100
Message-ID: <87pnk01z99.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: fix signal delivery
 for ppc64abi32
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
Cc: qemu-ppc@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Gibson <david@gibson.dropbear.id.au> writes:

> On Wed, Sep 11, 2019 at 10:33:45AM -0400, Richard Henderson wrote:
>> On 9/11/19 5:39 AM, Alex Benn=C3=A9e wrote:
>> > We were incorrectly setting NIP resulting in a segfault. This fixes
>> > linux-test for this ABI.
>>
>> Perhaps better:
>> We were incorrectly using the 64-bit AIX ABI instead of the 32-bit SYSV =
ABI for
>> setting NIP for the signal handler.
>
> Applied to ppc-for-4.2, with Richard's updated description.
>
> For future reference, it's better to directly CC me on such patches.
> I only barely keep on top of the mailing lists, so if you just send it
> there it's likely to be some time before I pick it up, or even get
> lost entirely.

Should you be added to linux-user/ppc/ in MAINTAINERS?

>
>>
>> ?
>>
>> >
>> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> > ---
>> >  linux-user/ppc/signal.c | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> Anyway,
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>


--
Alex Benn=C3=A9e

