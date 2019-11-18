Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1764FC432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB35A206CC
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="kimbKtoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB35A206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWdZd-0006Sg-RQ
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 04:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iWdWh-0005or-2V
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iWdWf-0005sb-NA
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:40:54 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:37666)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iWdWf-0005sJ-7l
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:40:53 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 7BB2496EF0;
 Mon, 18 Nov 2019 09:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1574070050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UkN2zFY2j4vOtaSzwekFWC/w6XyaCJHF5JjVPvIYnnw=;
 b=kimbKtoFC6qxfnCRDYWYSR92/uLZYUOTowQCa8VGZEt4xvUOos9d2GcxM2LmhHx3Hmmgud
 2PsueRAWevf983/vuTEYjMSuzrkB+xS4eKmP3cvnVag+ovdmO9i2msGBUvd4NEuZ3FryaY
 FLRku/H2uB3+VIq90JbUp7vP+AOB7SM=
Subject: Re: [RFC PATCH 02/11] gdbstub: stop passing GDBState * around
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191115173000.21891-1-alex.bennee@linaro.org>
 <20191115173000.21891-3-alex.bennee@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <9df9cde2-9689-3658-da7a-74a289d6d4e8@greensocs.com>
Date: Mon, 18 Nov 2019 10:40:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191115173000.21891-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1574070051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UkN2zFY2j4vOtaSzwekFWC/w6XyaCJHF5JjVPvIYnnw=;
 b=rnACP60cwn76mW9Mvgex6UtK665ICFlfVR8U7iarDOl6CPrFaOKLATEcUDyYOAo4euAQg7
 OHM0Bh5xLYrTd9WocA9n/7rgUlFtHYKh6QNbOWZkwiaRa+sGfvTj5mJTpMomMDGaAcgGGg
 HsuF+WaqwPwsyswTb14WBqnH39Kd1pU=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1574070051; a=rsa-sha256; cv=none;
 b=uBOm0Q+gYyIe9g5CGJfNutdq2Uk5IYZbRXnclqv6sC1WWgzMce4sFakzO/slfUQ09IPrfl
 j09GW903Y7dV69tzJceBVoOSIApOJ+1+3mRXL8m48OaoAziygtX0AeeKwlM/zv7zYgp5Do
 uo4I3jWAjgt84piRIOZrq0mAlrbeGY8=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/15/19 6:29 PM, Alex Benn=C3=A9e wrote:
> We only have one GDBState which should be allocated at the time we
> process any commands. This will make further clean-up a bit easier.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  gdbstub.c | 307 +++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 177 insertions(+), 130 deletions(-)

Do we know why we choose to pass GDBState * everywhere ?
It sounds like a way to eventually handle multiple gdb connections but I
don't know if it has some sense.

Damien

