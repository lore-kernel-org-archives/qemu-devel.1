Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4360AC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8FC21739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HND4zrJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8FC21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOqB-00043Q-8R
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1iwOoW-0002Tz-IX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1iwOoV-0004Hp-Hp
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:13:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>)
 id 1iwOoT-0004G2-BJ; Tue, 28 Jan 2020 06:13:45 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 29DF821739;
 Tue, 28 Jan 2020 11:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580210024;
 bh=M+CDq/a4jwD0PmQTrnO8ciZK2J5DAAtG91pLWGSuqUc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HND4zrJoUI5Fs2HHJbyJkEF2kn6rn4d9oLFnHse11yGmuLVd8js9MCrFi0hzky5hI
 bzTRwQiqvWo1TYiv/5M65Ab5HuKN/zcw08EsdS0niLgWF5bOmLokRDPMXtG3/Zk986
 kNXXUtoAeXfnH2Ks4IeUNPm5dUMmROjp31xUht1M=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1iwOoQ-001nok-EY; Tue, 28 Jan 2020 11:13:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Jan 2020 11:13:42 +0000
From: Marc Zyngier <maz@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
In-Reply-To: <CAFEAcA92URHhhm8TiGqijig_jM1=94PZz5Ptmfg1JrWSP7mSHQ@mail.gmail.com>
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
 <1b718429-c74e-fbac-84b8-379f3291db40@redhat.com>
 <ff78ed012e7b8fbd656e7e4b477ee0a4@kernel.org>
 <3ae0557c-c289-8a23-d62f-3dc2a12c0623@redhat.com>
 <CAFEAcA92URHhhm8TiGqijig_jM1=94PZz5Ptmfg1JrWSP7mSHQ@mail.gmail.com>
Message-ID: <97bd5cbfec30624aead987a0fd1c4ac6@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: peter.maydell@linaro.org, eric.auger@redhat.com,
 drjones@redhat.com, gshan@redhat.com, jthierry@redhat.com, aik@ozlabs.ru,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, shan.gavin@gmail.com,
 pbonzini@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: Andrew Jones <drjones@redhat.com>, Gavin Shan <gshan@redhat.com>,
 jthierry@redhat.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Auger Eric <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Shan Gavin <shan.gavin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-01-28 10:59, Peter Maydell wrote:
> On Tue, 28 Jan 2020 at 10:56, Auger Eric <eric.auger@redhat.com> wrote:
>> On 1/28/20 10:25 AM, Marc Zyngier wrote:
>> > You *could* try something like SDEI [1], but that's a pretty terrible
>> > interface too.
>> 
>> Thank you for the pointer.
> 
> There was a patchset recently that had an SDEI implementation,
> but I would strongly prefer not to have QEMU itself take
> on the job of firmware API implementation, and the facilities
> provided are somewhere between awkward and impossible to
> implement from within a guest firmware blob :-/

Hey, I said it was terrible! ;-)

         M.
-- 
Jazz is not dead. It just smells funny...

