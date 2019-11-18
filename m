Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2E2C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8378420692
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="3RgI2y1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8378420692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWdir-0001yi-Bp
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 04:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iWdfw-0000Qo-HP
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:50:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iWdfv-0000dL-8r
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:50:28 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:37934)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iWdfu-0000c8-Od
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:50:27 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 9D58296EF0;
 Mon, 18 Nov 2019 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1574070623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4N2V6xEzTwX1koc7JORXx0veacFCSQ5NvaTlorb7eA=;
 b=3RgI2y1HOJ75+z2kR7St9vpkxGbCK8/LpkE5Ccyw4e1S4ShB1VSl/c0yLCQGta7zAFImcx
 aKdWYQWrqkYfdWqpsZgqf0RKp/+aZBRKPwr0VMDX5+iMqzJ0iIiCyJX0fg8JOazeJiv1dN
 ecM9abwD1+KlM2wVqzNMyxtXgOX/4Lw=
Subject: Re: [RFC PATCH 01/11] gdbstub: move allocation of GDBState to one
 place
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191115173000.21891-1-alex.bennee@linaro.org>
 <20191115173000.21891-2-alex.bennee@linaro.org>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <b183970c-0507-ed50-3c44-bf40c399e654@greensocs.com>
Date: Mon, 18 Nov 2019 10:50:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191115173000.21891-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1574070624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4N2V6xEzTwX1koc7JORXx0veacFCSQ5NvaTlorb7eA=;
 b=dfYf+YFtQh5vzCFb+/6UTa0dCtU/TYlNd2Kx9NYLZXdyGOp5nO7bKP6vWPXOBM6NoGtj+R
 ArXkgf20aCazh/5ILtNSB/scwRobhFiVyGLJs9Z2Z6g1lvuwxL8C+/L21X3c8JfPaiG5Wn
 6gAvB7Bhlgp12354RUmQ1VKFAHECWSU=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1574070624; a=rsa-sha256; cv=none;
 b=Vm7iRaMM8Ch2fdu9cPORj10bCP/iouX3gzL1NGU4n0m6AWqqKALlS6eX34s5OgZPL0XvMY
 rJ2tpNPIx+OU2eYSzcp5IK+KOwvq4g5SMnPOmUSdYGm3BROhLsXU63gLzaslEmqQQIQkPP
 yMuPNVsWw9hK6qc/VzHjqwVwmTQ4Da4=
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
> We use g_new0() as it is the preferred form for such allocations. We
> can also ensure that gdbserver_state is reset in one place.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  gdbstub.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

--
Damien


