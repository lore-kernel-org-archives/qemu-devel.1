Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2D4C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7FA2133F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXdpeHi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7FA2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hybsC-0001iC-NJ
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hybp4-0007bk-P5
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hybp3-00014O-KV
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:59:14 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43679)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hybp3-00013f-Ek
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:59:13 -0400
Received: by mail-ot1-x343.google.com with SMTP id e12so9433947otp.10
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pOya4liDh1r6J7HSlUAwikfeRcHXp1iQdgIp6a1XrCk=;
 b=gXdpeHi16DPJgoVxuEhW8f9igI29vNzMsSXbJVfKK3/F4Vi5zTAX/rS6LG77RA6hru
 TeMbhQgOrQMsWOoZKzCBN9RbMlTgGpXlrK2dbN5XGs5R/SqpMfvxUqRJZzatahVymQaV
 +DD5Rl90AYmTb77WcZINwRBy1/smH5/IbvMBGC13SVBy4avMXpaAD8KunnEgEFyY7H5T
 JMnN6Q/siQrVtp/rWuQ+xjEGLpLtrQbGCefh2T+WtKFc3xHYrGu+sA/yt97d8mjotowE
 0mUvxwI1EZqL1xoOZFqSdVt8LX4EQ4OXSOP8SQ+YRYYi7v/pXKjjPbIzh0YB1iYIMs/t
 vjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pOya4liDh1r6J7HSlUAwikfeRcHXp1iQdgIp6a1XrCk=;
 b=JjcrlceGhJZh2AD/v4HA4YnlbfKawEpcUsNISeVYgvLAnqdpdo3aARwzuKeEsAc47q
 JaG0fVW2KjTMOwtIR0sdp7x+RCZRejeRCnQqzPDhZ953OUvtnVQvr8Uctp29oTjFrSmp
 vgPdoiMSxbYqs2w1hhYM8KsfW0MPPIIJoycyA2e3F09ZOc2v8Ajkd0F8OHyyAjbTbrlZ
 r9cGkiu+gpYnVH9RKsiq48+aOYAlGuhQ5cd/MV5a2TG+Tp6a3xwcME0EVGlbrLG/rsTM
 aLCVWC6A0G03qoIlbDxz+Cr9yy+xnE1cMquipPONRk66ba3gyb7gxRD1I0g7aAHM7Q05
 INxg==
X-Gm-Message-State: APjAAAUjbLO4gKmCJW4gezca+tuFs1XOLBFhiECLn6nXT6HUmpVBEHHg
 ETSY94Y13cDKrmHcpIw4jFKzsaGNUBnxuKVd+VYPpg==
X-Google-Smtp-Source: APXvYqxRrEWE4TfDKiQsMop8aZRfEgrnN+X04D00wBeGqK0zzbBxO7tjFL8DO3EWdep2fH3Jk49xA/f9CrTqpRNPsa4=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr6749248otf.97.1565960352702; 
 Fri, 16 Aug 2019 05:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190625112752.83188-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20190625112752.83188-1-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Aug 2019 13:59:02 +0100
Message-ID: <CAFEAcA8cLy+QfswCD6iGHcQywDA6hHYaBdxT9Zfa2zAzSotm_w@mail.gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [RFC PATCH 0/7] qemu: CCIX pcie config space
 emulation
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
Cc: Auger Eric <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Jon Masters <jcm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Jun 2019 at 12:28, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> CCIX topologies are 'layered' on top of PCIe tree topologies.
> This is done primarily by allowing a single CCIX device to appear as
> multiple disjoint nodes in the PCIe tree.

> This patch is being distributed by the CCIX Consortium, Inc. (CCIX) to
> you and other parties that are paticipating (the "participants") in
> qemu with the understanding that the participants will use CCIX's
> name and trademark only when this patch is used in association with
> qemu.
>
> CCIX is also distributing this patch to these participants with the
> understanding that if any portion of the CCIX specification will be
> used or referenced in qemu, the participants will not modify the cited
> portion of the CCIX specification and will give CCIX propery copyright
> attribution by including the following copyright notice with
> the cited part of the CCIX specification:
> "=C2=A9 2019 CCIX CONSORTIUM, INC. ALL RIGHTS RESERVED."

(Apologies for replying to this now quite old email, but your
more recent followup email drew it to my attention.)

I think that as a project, QEMU can't take patches which come
with this kind of additional constraint on top of the GPL. Could
you drop these extra legal clauses, please?

thanks
-- PMM

