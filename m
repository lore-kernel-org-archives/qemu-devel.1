Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ED2C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6304B206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VyuxBYCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6304B206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFN6-0007Ir-A8
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iAFKm-0005h2-BQ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iAFKl-00060A-5Q
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:24:04 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iAFKk-0005zp-Vd
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:24:03 -0400
Received: by mail-oi1-x243.google.com with SMTP id k20so3221978oih.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=84lIvWS/UBsMxXislbD2ODOZlrUK175JaQEXmaCSesM=;
 b=VyuxBYCJ2KNwV12/uG4HZD/u5uLeUGxkr74DYW9oM9d0oDr0wSnqaVN1cActBVuytv
 vz+KFySUqUs0D49dzeWULto7cLPiqN6m3x+/Gc0kHuMUWjgaao+HHYhMzLFzWNMhpQNF
 i7+plUpRbQmWPNacm4W0QjL03DAOVqJ6hA/XIm8Wn7rnc4x+lnhSUhazZX562L/T5L3z
 P8UHrp5ArgxwzMvW445P8qGOc9prH/y/qtsYrBhvbLXKmYdkaioRZWp5yb3x2meUiZOz
 HDMYAAg2LKVFibJqI2DkqthQvWVo932rNHwXBv/o0bqjSM+Al9loNKJ7PeMAst1Pr+/A
 TEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=84lIvWS/UBsMxXislbD2ODOZlrUK175JaQEXmaCSesM=;
 b=XV/dhf7W3myMNmn9yVxwkqOSsaHdNv5CrD4/jYQHx2tbeIUDybOBH9Ei5a0B5axAel
 C/w5U007tejhe4Z9cb9Y0ey+74TilmpoGYPfbIwKuXZ0XZNBFmWipG8uAyj6ueqjpjGT
 Oo1hrQd+ZCE2/q06mcHsy+q8fK+rKrawIfZlASIcfhVvev6JnVBSfUuSmr9qjU4GRTK9
 Lb6cN1NbzrF/x4gPNAiNKsqR8Jwhd/0hMFb+ZpM5Q+T0mnkf88+ej+3FgkK8OFBnBYcg
 uHrCG25CEBpOCzR2Oz0v6TtV6BEIMaLGoKQbCfObkODjcVI6/wvNMe4k43+g91nRLqNY
 TakA==
X-Gm-Message-State: APjAAAVjGRtDgweo0c+Sa/GTbWTixMEceNvstiEOftonDYWiQR3ycMd9
 eO11JN9uFIDYtp3/WRkSkiI6g1i1lA/7oGaD+vKNDw==
X-Google-Smtp-Source: APXvYqwyPxWLUKO1tEIUKnFXksxAJ4JtJsyNq890bLSs9rFI8AUMc4IpUs4wpI+vn5nNkm3WT33L6V0ZvQKlOfI3fhg=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr4288531oih.170.1568733841674; 
 Tue, 17 Sep 2019 08:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190904085629.13872-1-shameerali.kolothum.thodi@huawei.com>
 <20190904085629.13872-11-shameerali.kolothum.thodi@huawei.com>
 <CAFEAcA8sEhgOXnj-DGo04pSnpTObO+EeC94yrdGEikKq0=2QeA@mail.gmail.com>
 <20190911155015.3627b072@redhat.com>
 <20190911095332-mutt-send-email-mst@kernel.org>
 <20190917111100-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190917111100-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2019 16:23:49 +0100
Message-ID: <CAFEAcA8S0SE9MtjwmErAfjLACbc8p3sXFPeFLwfOW9czTwDM9g@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v10 10/11] tests: add dummy ACPI
 tables for arm/virt board
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, Xu Wei <xuwei5@hisilicon.com>,
 Eric Auger <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 sebastien.boeuf@intel.com, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019 at 16:11, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Sep 11, 2019 at 09:55:34AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 11, 2019 at 03:50:15PM +0200, Igor Mammedov wrote:
> > > On Wed, 11 Sep 2019 13:57:06 +0100
> > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > > > Do the tests pass with this patch and without the
> > > > patch that adds the tests? (That is, can we keep the
> > > > two patches separate without breaking bisection, or
> > > > do we need to squash them together?)
> > > >
> > > > I'll leave it to somebody who understands the ACPI
> > > > tests stuff to answer whether there's a better way to
> > > I'd squash this patch into 11/11 test case,
> >
> >
> > Pls don't - the way to add this is to add the files in question to
> > tests/bios-tables-test-allowed-diff.h.
> >
> > Maintainer will create a separate commit updating
> > the binaries and removing them from the whitelist.

Who is "maintainer" in this part of the process? Why
can't the submitter just create the patches and send them?

> > This way things like rebase work seemlessly.
>
>
> OK?
>
> Can you post v11 like this? I'll ack then.

thanks
-- PMM

