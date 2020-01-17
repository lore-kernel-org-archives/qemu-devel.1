Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25B5C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADCB720730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/hObo2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCB720730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPZv-00068F-U0
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 06:14:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isPVA-0008Qu-PL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isPV9-0004Q0-Lo
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:09:20 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44393)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isPV9-0004PR-Gb
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:09:19 -0500
Received: by mail-ot1-x342.google.com with SMTP id h9so22153271otj.11
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 03:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gbXB0P9QCutfJwh5bxSt0gaR/2MQOgUW3YIPDErTpMs=;
 b=i/hObo2Coyw6R1RMzadNOZCcC7uqZBLv1tLHojzXwWVXlWPg+lHfFAI3SjUrXNVGim
 mJcvP8AhEsxcr10M0xVv5oz5X5aeohzpyQUiOSKQH09p58UclcGBmqjw/BMU0ib5GmBR
 Gk9ytDH+R1SxqVrtsl53fW9GeRFbfrPxN0Bfs9tYuTRkNwfi+hXTAk1sv//ISPzmzRJB
 mR3TzsTH7nY0pc8TbkP0t/M9dusljyONZG+hWSyve2mcj1WWXfEYzusZQQ1a5uLxgW2G
 UfHU99CjEap0U7FxFGEj38TEv5DzS4Qp1dvTHkCuhNUrl9HLAuNGM7vX9stXAtGtrPdp
 eZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gbXB0P9QCutfJwh5bxSt0gaR/2MQOgUW3YIPDErTpMs=;
 b=tBH68KDA5NMe6EQIfpSaXv836Sapu9v+ntfGmzmMuEe1WXQI/xxrqKzrorGya2rvag
 coE8gVuCim9ktAyxDYuQhcUimMor3e+yPLW2+0GG7DvaSadqAtxpi/UN7TI2x1NdZqaI
 h9pMi9/7r3U/dr63DbQ7wv3/kZBZqHuVR+b5MtOGugCfxxCo4T2N4QlpBYj3t7SH1Cjv
 dbHnQkzlVVOSToi6jXJK4kNE2PsyqP2DsKuwMrFWwgI8XRNowN0Lt7jvsw6AztZ58gqY
 K8QzfMcCLET6KcL1An4mA4qbjJXrvf998dm1yWieSliKOBXFD93B4vxGo2uQy5n6AM3x
 GU4g==
X-Gm-Message-State: APjAAAVDX5UbZkWUz7+9nn43LzS02ziXDtJuojW+JHIbCnP3jkkaILta
 bApvjN8IrXZtdyDm78Cwz/7pJ/VF+zgzRq9i2S+B3A==
X-Google-Smtp-Source: APXvYqxV3TQAndl+llmiRHs5DARwMKS8Wj7YHgw6RIQUStary+feOw7gbTbEz/h6MXfQdxPZzAvqjR0as5c6J5wLsec=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr5710541otd.91.1579259358567; 
 Fri, 17 Jan 2020 03:09:18 -0800 (PST)
MIME-Version: 1.0
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-10-git-send-email-gengdongjiu@huawei.com>
 <CAFEAcA-mLgD8rQ211ep44nd8oxTKSnxc7YmY+nPtADpKZk5asA@mail.gmail.com>
 <1c45a8b4-1ea4-ddfd-cce3-c42699d2b3b9@redhat.com>
In-Reply-To: <1c45a8b4-1ea4-ddfd-cce3-c42699d2b3b9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 11:09:07 +0000
Message-ID: <CAFEAcA_QO1t10EJySQ5tbOHNuXgzQnJrN28n7fmZt_7aP=hvzA@mail.gmail.com>
Subject: Re: [PATCH v22 9/9] MAINTAINERS: Add ACPI/HEST/GHES entries
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Linuxarm <linuxarm@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Dongjiu Geng <gengdongjiu@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Zheng Xiang <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>, "xuwei \(O\)" <xuwei5@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 at 07:22, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> On 1/16/20 5:46 PM, Peter Maydell wrote:
> > On Wed, 8 Jan 2020 at 11:32, Dongjiu Geng <gengdongjiu@huawei.com> wrot=
e:
> >>
> >> I and Xiang are willing to review the APEI-related patches and
> >> volunteer as the reviewers for the HEST/GHES part.
> >>
> >> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> >> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> >> ---
> >>   MAINTAINERS | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 387879a..5af70a5 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -1423,6 +1423,15 @@ F: tests/bios-tables-test.c
> >>   F: tests/acpi-utils.[hc]
> >>   F: tests/data/acpi/
> >>
> >> +ACPI/HEST/GHES
> >> +R: Dongjiu Geng <gengdongjiu@huawei.com>
> >> +R: Xiang Zheng <zhengxiang9@huawei.com>
> >> +L: qemu-arm@nongnu.org
> >> +S: Maintained
> >> +F: hw/acpi/ghes.c
> >> +F: include/hw/acpi/ghes.h
> >> +F: docs/specs/acpi_hest_ghes.rst
> >> +
> >>   ppc4xx
> >>   M: David Gibson <david@gibson.dropbear.id.au>
> >>   L: qemu-ppc@nongnu.org
> >> --
> >
> > Michael, Igor: since this new MAINTAINERS section is
> > moving files out of the 'ACPI/SMBIOS' section that you're
> > currently responsible for, do you want to provide an
> > acked-by: that you think this division of files makes sense?
>
> The files are not 'moved out', Michael and Igor are still the
> maintainers of the supported ACPI/SMBIOS subsystem:

Does get_maintainer.pl print the answers for all matching
sections, rather than just the most specific, then?

In any case, I'd still like an acked-by from them.

thanks
-- PMM

