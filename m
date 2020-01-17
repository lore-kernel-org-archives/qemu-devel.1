Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44008C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9CE206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeCKVmGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9CE206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isQcF-0004K5-56
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 07:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1isQbM-0003a5-L3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1isQbJ-0006it-98
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:19:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47647
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1isQbJ-0006hy-3h
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579263584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kmpp6IaUgIlgO3axl4Nc/Kkub+NfrL3AQNREn+Pk+XE=;
 b=BeCKVmGQN7M0cC8u3ht7D+pR7rhg5vVwjI2PnSjmytv7Gj10ilXsl86yzv3wPZPPqOl3yg
 h23THj+UdckBRwIBvkCtXWbfcDYQ9YBBq9o5YbkyhoOyRTFFqxLdVzQmOPVm9MF9pE12T9
 fFMfGnYDnchdyELTwUzDGOcaj/IoTlk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-rU-0ZEV9PVepPWsS6bI18Q-1; Fri, 17 Jan 2020 07:19:40 -0500
Received: by mail-qt1-f200.google.com with SMTP id z11so5916277qts.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 04:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=pzvhp7Z+zyG59Ba3kmGkNgEyTIsCpnrdorbo2lBj3aU=;
 b=pVe4gcGDpMSkS66fR8UOa64Ca8dV0rUBWqEABRgL1bprwu4g9txFo3xjzaja/NlxdL
 1HZ/q1SH+C0aEaRtvIHdk2mfoWPTD717mnTq+89RhkU9ExFPxLBCcCwFjDIEKN+XAUdR
 VLq8CAhfk8KdiSFxh6ZVb0WTGkN4X2uH3qVGGuDDObZhqRkoJgaQIgm8jYTd7S5C/h3A
 aMNY0FW25U0maDi15CKKNnHP2zWEDTiNdJhI1xVH6bk51O26uXaSh/X1O49RaIdINLES
 1bRZ8OxkNaeTm9mxp6RvYl/MW8mWyJu0K85FBEuI+Vm2lH0WJbyD98Hp/3rYA1d31wBN
 TrdQ==
X-Gm-Message-State: APjAAAXgSmY9TP30OWl85THxiw1kKQs7iAdZSSqasSZndrOYBcNa5bTn
 o2961XBTSIS0orBzIWh4XrqGlaoDnwXrNotAsxbMsRkzXnmGMWJlydS70ePKDmi48W4bElrfAZF
 ClTwXqVrsxQsIARs=
X-Received: by 2002:ad4:4912:: with SMTP id bh18mr7562349qvb.50.1579263579522; 
 Fri, 17 Jan 2020 04:19:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3X1CEnhP7WNjUNxceqM1oHfXx1p8+EWk9AfLQpSy38XG0Znumc0s0eaGYfLewFfDI8KH+nQ==
X-Received: by 2002:ad4:4912:: with SMTP id bh18mr7562319qvb.50.1579263579257; 
 Fri, 17 Jan 2020 04:19:39 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
 by smtp.gmail.com with ESMTPSA id g16sm11686127qkk.61.2020.01.17.04.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 04:19:38 -0800 (PST)
Date: Fri, 17 Jan 2020 07:19:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v22 9/9] MAINTAINERS: Add ACPI/HEST/GHES entries
Message-ID: <20200117071928-mutt-send-email-mst@kernel.org>
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-10-git-send-email-gengdongjiu@huawei.com>
 <CAFEAcA-mLgD8rQ211ep44nd8oxTKSnxc7YmY+nPtADpKZk5asA@mail.gmail.com>
 <1c45a8b4-1ea4-ddfd-cce3-c42699d2b3b9@redhat.com>
 <CAFEAcA_QO1t10EJySQ5tbOHNuXgzQnJrN28n7fmZt_7aP=hvzA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_QO1t10EJySQ5tbOHNuXgzQnJrN28n7fmZt_7aP=hvzA@mail.gmail.com>
X-MC-Unique: rU-0ZEV9PVepPWsS6bI18Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 kvm-devel <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Dongjiu Geng <gengdongjiu@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zheng Xiang <zhengxiang9@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 17, 2020 at 11:09:07AM +0000, Peter Maydell wrote:
> On Fri, 17 Jan 2020 at 07:22, Philippe Mathieu-Daud=E9 <philmd@redhat.com=
> wrote:
> >
> > Hi Peter,
> >
> > On 1/16/20 5:46 PM, Peter Maydell wrote:
> > > On Wed, 8 Jan 2020 at 11:32, Dongjiu Geng <gengdongjiu@huawei.com> wr=
ote:
> > >>
> > >> I and Xiang are willing to review the APEI-related patches and
> > >> volunteer as the reviewers for the HEST/GHES part.
> > >>
> > >> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> > >> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> > >> ---
> > >>   MAINTAINERS | 9 +++++++++
> > >>   1 file changed, 9 insertions(+)
> > >>
> > >> diff --git a/MAINTAINERS b/MAINTAINERS
> > >> index 387879a..5af70a5 100644
> > >> --- a/MAINTAINERS
> > >> +++ b/MAINTAINERS
> > >> @@ -1423,6 +1423,15 @@ F: tests/bios-tables-test.c
> > >>   F: tests/acpi-utils.[hc]
> > >>   F: tests/data/acpi/
> > >>
> > >> +ACPI/HEST/GHES
> > >> +R: Dongjiu Geng <gengdongjiu@huawei.com>
> > >> +R: Xiang Zheng <zhengxiang9@huawei.com>
> > >> +L: qemu-arm@nongnu.org
> > >> +S: Maintained
> > >> +F: hw/acpi/ghes.c
> > >> +F: include/hw/acpi/ghes.h
> > >> +F: docs/specs/acpi_hest_ghes.rst
> > >> +
> > >>   ppc4xx
> > >>   M: David Gibson <david@gibson.dropbear.id.au>
> > >>   L: qemu-ppc@nongnu.org
> > >> --
> > >
> > > Michael, Igor: since this new MAINTAINERS section is
> > > moving files out of the 'ACPI/SMBIOS' section that you're
> > > currently responsible for, do you want to provide an
> > > acked-by: that you think this division of files makes sense?
> >
> > The files are not 'moved out', Michael and Igor are still the
> > maintainers of the supported ACPI/SMBIOS subsystem:
>=20
> Does get_maintainer.pl print the answers for all matching
> sections, rather than just the most specific, then?
>=20
> In any case, I'd still like an acked-by from them.
>=20
> thanks
> -- PMM

Acked-by: Michael S. Tsirkin <mst@redhat.com>


