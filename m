Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5563BC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F092070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhQIWJf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F092070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwjIL-0000sa-9k
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 04:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1iwjGm-0007fu-CB
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1iwjGl-0005jt-C6
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:04:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45378)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>)
 id 1iwjGi-0005Qf-RH; Wed, 29 Jan 2020 04:04:16 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7B4AB2070E;
 Wed, 29 Jan 2020 09:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580288655;
 bh=CMVfSWl+2XIT/jE0iJpRVzU7bkl12YJtNotQ4aZTpPk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VhQIWJf3o8U8wrj+cAI9pZfp77ocs6I2lQhUfo/CMYa5c9lwhny94UIMs7Etis/dO
 T5P/mTDJmnumpwg0oTihaXiCSOMdhQ4Zfdm7d9wouhygNhQm6psj+6BYJvW6J7OHSd
 NvU6XJ6BF4j14a6Twa7QieQMiyM6cugRE+Avtc9s=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1iwjGf-001zDK-K4; Wed, 29 Jan 2020 09:04:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Jan 2020 09:04:13 +0000
From: Marc Zyngier <maz@kernel.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
In-Reply-To: <7f6e29e6-1df9-4513-79ba-b53873b0735e@ozlabs.ru>
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
 <7f6e29e6-1df9-4513-79ba-b53873b0735e@ozlabs.ru>
Message-ID: <544f261e4b9c97f1d3a5fb64cef42ba5@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: aik@ozlabs.ru, gshan@redhat.com, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, pbonzini@redhat.com, drjones@redhat.com,
 eric.auger@redhat.com, jthierry@redhat.com, shan.gavin@gmail.com,
 qemu-devel@nongnu.org
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, Gavin Shan <gshan@redhat.com>,
 jthierry@redhat.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 qemu-arm@nongnu.org, shan.gavin@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-01-29 02:44, Alexey Kardashevskiy wrote:
> On 28/01/2020 17:48, Gavin Shan wrote:
>> but a NMI is injected
>> through LAPIC on x86. So I'm not sure what architect (system reset on
>> ppc or injecting NMI on x86) aarch64 should follow.
> 
> I'd say whatever triggers in-kernel debugger or kdump but I am not
> familiar with ARM at all :)

All that is completely OS specific, and has no relation to the 
architecture.
As I mentioned in another part of the thread, the closest thing to this
would be to implement SDEI together with an IMPDEF mechanism to enter it
(or even generate a RAS error).

On the other hand, SDEI is pretty horrible, and means either KVM or QEMU
acting like a firmware for the guest. To say that I'm not keen is a 
massive
understatement.

         M.
-- 
Jazz is not dead. It just smells funny...

