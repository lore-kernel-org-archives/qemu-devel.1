Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27457C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5574222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FMqwFIBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5574222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIbG-0001eR-3k
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:45:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiIaK-00015A-VU
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiIaJ-000082-Bi
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:44:52 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiIaI-0008Vg-KR
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:44:50 -0500
Received: by mail-ot1-x344.google.com with SMTP id r27so11918415otc.8
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 05:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VRcUdbDrthaJqJ9M/pTbzkrtzAV4OuFcKXWsaWcpvV0=;
 b=FMqwFIBqHUOoVfxBI1lFPwqfetK5uXzkNUimwNggnBjmix0mcKsswpCbKkOwAj26cL
 WBD/1cajMSgO+xQTJqqFyx9mqyXS4PJZqjLzY0YYWPNiHcsxUOkAN0un+RVT9mKzZ0py
 jG1H4kRtP5crTlVocfgUoXJYbRXJPpzWz/Hr1UmJSzLy4lhc+fQtfCru0/NgmSajKuud
 +C4Ra2gHtETI+pyIPBslGjKdJvC+C+AQlPVpE6DDEklGj+/Q9EVKGTCiJ5WnsFF1E6gp
 Q9/rk2PA4cIN0IgBvLUoh9trAsJFbImluXoeVg3LvPGk5u0jesq6OJTkte2/zwcCgyD2
 NjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VRcUdbDrthaJqJ9M/pTbzkrtzAV4OuFcKXWsaWcpvV0=;
 b=r9XnWtlERLhg4QpYaP4ytdZjhkd2yoS5rhqND7WQYtYVjruoBIZ16Aqnv7lm+9ASPP
 1q8y6KawuSHh/8v4tXjwU/S2HFMfbPXkZo82XFfGiiAaPI425tgEdrjnk3xYWJGUPcLO
 Wpy0r+hnFlC3eiB+OExVc5TzBE8qrCWKTEjOLGYJp0qWDZpMIzRYNWcIH9xTNfFu1zsx
 fY5KtepEfO3Pi09XU2lLycQxVLvt/DokJm7XEKOrImEZMuxgQNZ255WYMX5F4Ei5+kz4
 pvhytPZT+v3M+//cUx9zOEVt/ldyPKifFYnp1wQbyY1NAQlUmK2fZGFRQGsXq3RXURKW
 sPqg==
X-Gm-Message-State: APjAAAXXqq1WcVlmhN7oKPeAHtS81LEyj04XzWhCu6iaXsWSrruCQtIX
 7rEfLA972FdyTZNFGUqGdA4RGzZKz++KFjMFyPFq/Q==
X-Google-Smtp-Source: APXvYqymzDItEWgVmv+DrsM2Q0919+2QU+g2Ojb5VTEGgHCQhW9fXonGfmyp8foWjy4rN1PKdP9xPhghQmfy0jOKxrU=
X-Received: by 2002:a9d:3f21:: with SMTP id m30mr1208123otc.232.1576849489459; 
 Fri, 20 Dec 2019 05:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20191105091056.9541-1-guoheyi@huawei.com>
In-Reply-To: <20191105091056.9541-1-guoheyi@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Dec 2019 13:44:38 +0000
Message-ID: <CAFEAcA-+tAbb9h2wZOm56TqUvjQJT0OYFLwTVS-UxKrF5PO3mQ@mail.gmail.com>
Subject: Re: [RFC v2 00/14] Add SDEI support for arm64
To: Heyi Guo <guoheyi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Mark Rutland <mark.rutland@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, wanghaibin.wang@huawei.com,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 Nov 2019 at 09:12, Heyi Guo <guoheyi@huawei.com> wrote:
> SDEI is for ARM "Software Delegated Exception Interface". AS ARM64 doesn't have
> native non-maskable interrupt (NMI), we rely on higher privileged (larger
> exception level) software to change the execution flow of lower privileged
> (smaller exception level) software when certain events occur, to emulate NMI
> mechanism, and SDEI is the standard interfaces between the two levels of
> privileged software. It is based on SMC/HVC calls.
>
> The higher privileged software implements an SDEI dispatcher to handle SDEI
> related SMC/HVC calls and trigger SDEI events; the lower privileged software
> implements an SDEI client to request SDEI services and handle SDEI events.

Hi; I read through these patches last week, but I didn't reply
then because although there are some aspects to the design that
I don't like, I don't have a clear idea of what a better approach
to the problems it's trying to solve would be. However I didn't
want to go home for the end of the year without providing at
least some response. So I'm going to lay out the parts I have
issues with and perhaps somebody else will have a good idea.

The first part that I dislike here is that this is implementing
an entire ABI which in real hardware is provided by firmware. I
think that QEMU's design works best when QEMU provides emulation of
hardware or hardware-like facilities, which guest code (either
in the kernel, or firmware/bios running in the guest) can then
make use of. Once we start getting into implementing firmware
interfaces directly in QEMU this rapidly becomes a large amount
of work and code, and it's unclear where it should stop. Should
we implement also the equivalent of firmware for omap boards?
For imx* boards? For the raspberry pi? For xilinx boards?
Are we going to end up reimplementing more of ARM Trusted Firmware
functionality inside QEMU? The code to implement firmware-equivalent
ABIs in all these boards would I think quickly become a large part
of the codebase.

My second concern is that to do the things it wants to do,
the implementation here does some pretty invasive things:
 * intercepting interrupt lines which ought to just be
   emulated hardware signals between devices and the GIC
 * capturing register values of other CPUs, and arbitrarily
   stopping those other CPUs and making them run other code
   at a later point in time
I'm really uncomfortable with what's just an 'emulated firmware'
interface for one specific board model doing this kind of thing.

Finally, the stated rationale for the patchset ("we'd like an
emulated NMI equivalent") doesn't really feel to me like it's
strong enough to counterbalance the amount of code here and
the degree to which it's moving us into a swamp I'd prefer
it if we could stay out of.

I'd be much happier with a design where QEMU provides simple
facilities to the guest and the guest firmware and kernel
deal with making use of them. I appreciate that it's not
clear how that would work though, given that in real hardware
this works by the firmware running at EL3 and KVM not
providing a mechanism that allows guest code that runs at
a higher (effective or emulated) privilege level than the
guest kernel...

thanks
-- PMM

