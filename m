Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C567CC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB2620842
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYZxKA7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB2620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxZwn-0000hL-UJ
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 12:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60112)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hxZwA-000843-EX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hxZw9-0007Av-Gc
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:46:18 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36215)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hxZw9-00079n-BE
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:46:17 -0400
Received: by mail-ot1-x343.google.com with SMTP id k18so42907238otr.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=e3sPDNYYXzzvD0+8cek8RYmAaSSppeMcTbXL3Plj4h4=;
 b=CYZxKA7/kQCAMpulkBQJVLtGWkTigqX0yAE5zBVEKkdE5m328h8eiMoRqeGo3RTEsH
 qoOklvn8azysK7n8uGRn3qUEEhOcf/RdDaIbYlJ9sk+lFnTIfhLOUSgV8j3L9RRFgj3u
 G3TgG7Bj0rs9rAef6A3fBiLnskrreyeRWOjQufkAZSMMGQfj7cXbIGwmULiaH4c1UxEg
 1Z7r1CRmJnfEF3R3mlT/manrWaTXdF4++hZGT9Z2GX7mumIrtDtdnvHgTfFl4cPKN0jU
 RfFEyJ/OnZZ5XDi4lla/S7BqeqssW7uFzBawTC11DCt3H09zoqfVuYLz119aTfsdnr0G
 OHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=e3sPDNYYXzzvD0+8cek8RYmAaSSppeMcTbXL3Plj4h4=;
 b=hHtLkzFbbmzcuIhj4F5B72bTzkpum3wckdEjMHXoEATOftwu6D8PS45F4/QXXN3zmI
 F3GXZ9ClfgnomoOoTs9BipYyswTtGz8ifhS1cKAx7op3EQjpc9wDSF1zMcIr9DGyM892
 biSUvlejNQ5RDmLISjaujNQx9lpxEB+dd8bp45E5vARtKHsYG62kXdpbDAuhMwZ1pj+B
 p08jyhl5b/6qkAi02FOD4IhFnqA2fEsHWhj4M4XchbWX/uuu7kUhs8jnZAjJQfi2GS6P
 VmYeW2qHa9nnYl35CmqzT4JjHp8WHzyMtqOYaEC3qWp9IrMp764qnyRoRBHIj8GbXSym
 /GpQ==
X-Gm-Message-State: APjAAAW6fAR/tuoU8kBPuLQYZJBHRjlYgnYMksdbgqNJm+IGL3zZY98s
 LZulBiWXungD/+4y1O/xIgJ/zFvhSZGMsYnVuO1ZgA==
X-Google-Smtp-Source: APXvYqwwUGRez/pXI/5N9VVbE3Ew3dKvT9PnvDkoV5orRFRu0slM7b6ohvLiYp1KLjfIWykt/P4sQuQHiBmibcr/PXs=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr2123047otf.97.1565714775436; 
 Tue, 13 Aug 2019 09:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190813164420.9829-1-clg@kaod.org>
In-Reply-To: <20190813164420.9829-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Aug 2019 17:46:04 +0100
Message-ID: <CAFEAcA-OmF+gOmhJjsaRVJVg1DAj5nXQz0rJ6wEFfAht+VSqnQ@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] spapr/xive: Mask the EAS when allocating
 an IRQ
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
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 13 Aug 2019 at 17:44, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> If an IRQ is allocated and not configured, such as a MSI requested by
> a PCI driver, it can be saved in its default state and possibly later
> on restored using the same state. If not initially MASKED, KVM will
> try to find a matching priority/target tuple for the interrupt and
> fail to restore the VM because 0/0 is not a valid target.
>
> When allocating a IRQ number, the EAS should be set to a sane default :
> VALID and MASKED.
>
> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>
>  David, this fixes a "virsh save/restore" issue in certain configurations
>  of CPU topology which never showed up before :/
>
>  Peter, I was busy on a KVM/passthru issue and lacked the time to
>  investigate all ... you decide.

rc5 has been tagged so this is definitely too late for 4.1.

thanks
-- PMM

