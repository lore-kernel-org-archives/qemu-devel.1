Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5831CC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D4E20848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8PdpSB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D4E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2CQ5-0000kT-Ai
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 06:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2CPL-0000CF-4a
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2CPJ-0006Jz-Vf
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:11:46 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34659)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2CPJ-0006JW-Po
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:11:45 -0500
Received: by mail-ot1-x343.google.com with SMTP id j16so5199703otl.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 03:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y3o+/F6hlUAiW92XSO6P5taF12AhRImG4+u9cXm2jwY=;
 b=A8PdpSB9g2CyOxaKAOs+KYXaL4x6hUVOqHF1hOpIGS5/YFLhYdUo+nkjWkaocIhSG/
 iuxXBsHnuXSyQT2L0PN0lZkab7evRn2kqMl8d3RGMEZycUXAChWYoB5Ye1rwrs0//iyZ
 iF8lkL6ck+oB3QWJ4jYCcWCGQmpurAWHVUJelmJP61ny7DJM2q+a3zxu/ptgkdjHoCeT
 l4M9COy7XeFl6yzZ1TT6Ay5TBqxfdhlTIaUjqcLWlJo+lPBrTR7kVkaUn+o1uHckpnnf
 4n1J5SDjhbwNtPG3Ni6v8IBs/ix2qDuVjuTELeXStZ398QzraW5J3SzhZyjlF1R7CXa+
 g1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y3o+/F6hlUAiW92XSO6P5taF12AhRImG4+u9cXm2jwY=;
 b=XSD4W9N1u5lbt97WRpzseflncu7epyJa6bK0JkfrxVRLwiQo2t20eop1VfVmHA0+7A
 QPtHcm6KKoQ0JT2a1lKZVJdgE7RXrhW6kzP9N7HY2cSTTx2GGFuI6wWOLDNCpBAPN5gS
 YA9rC6rAsP6CqlPSKiZ/iwbnSJCldG2HqFFU/QxAi8HERXf5aSiN6simhZA/VY5wpPr/
 B1cXQd3ES1h4mv+dgqtOolRBHn/BbQJ/4K2CTquyK8OHbqMjCgOcFHWr/p0WmfwvS6cH
 6aNBfdTkDIICGpCpGMba3iY22+E4b3inxefgTdEqEvqkC4mMtMyFcPqEu9PeX5+XlaGV
 Jh+A==
X-Gm-Message-State: APjAAAVReRhERedOJDy6nGnV+U6N9YhO+vvIr1CS164eAwtV9wFaRCcR
 ZATR0wwyPLJwxpn01hrxxxh8UqCIBWditOee3YpPYQ==
X-Google-Smtp-Source: APXvYqwk2Tarr3xIOuBhiD7NkL3Vmf1pg3kpos18ap+9P6lvm5crZEj278Y1EPrEcTgndsAauVi2tOxk4fsIVrgKINo=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr12949937otq.135.1581592304702; 
 Thu, 13 Feb 2020 03:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20200205110541.37811-3-gshan@redhat.com>
In-Reply-To: <20200205110541.37811-3-gshan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 11:11:32 +0000
Message-ID: <CAFEAcA8LJf3rQhi1VyBqSrC9Rj_ZKiYeVMJ8Gb-U7HA4LVagLA@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH v2 2/2] target/arm: Support NMI injection
To: Gavin Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Andrew Jones <drjones@redhat.com>, jthierry@redhat.com,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Marc Zyngier <maz@kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Shan Gavin <shan.gavin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Feb 2020 at 11:06, Gavin Shan <gshan@redhat.com> wrote:
>
> This supports QMP/HMP "nmi" command by injecting SError interrupt to
> guest, which is expected to crash with that. Currently, It's supported
> on two CPU models: "host" and "max".
>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  hw/arm/virt.c          | 18 ++++++++++++++++
>  target/arm/cpu-qom.h   |  1 +
>  target/arm/cpu.c       | 48 ++++++++++++++++++++++++++++++++++++++++++
>  target/arm/cpu64.c     | 25 ++++++++++++++++++----
>  target/arm/internals.h |  8 +++++++
>  5 files changed, 96 insertions(+), 4 deletions(-)

A few quick general notes:

(1) as I mentioned on the cover letter, the mechanism
for injecting an SError/async external abort into the
CPU should be a qemu_irq line, like FIQ/IRQ, not a
special-purpose method on the CPU object.

(2) for function naming, there's a dividing line between:
 * code that implements the (unfortunately x86-centric)
   monitor command named "nmi"; these functions can have
   names with 'nmi' in them
 * code which implements the actual mechanism of 'deliver
   an SError to the CPU'; these functions should not
   have 'nmi' in the name or mention nmi, because nmi is
   not a concept in the Arm architecture

(3) Before we expose 'nmi' to users as something that
delivers an SError, we need to think about the interactions
with RAS, because currently we also use SError to say
"there was an error in the host memory you're using",
and we might in future want to use SError for proper
emulated RAS. We don't want to paint ourselves into a
corner by grabbing SError exclusively for 'nmi'.

thanks
-- PMM

