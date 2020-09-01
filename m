Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAABC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49D7207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="pHgnABE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49D7207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD88f-0001gu-Rr
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kD7xH-0007aS-VK
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:12:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kD7xG-0005D7-DI
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:12:15 -0400
Received: by mail-wr1-x444.google.com with SMTP id z4so1961672wrr.4
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uzLQFTfRBp7D6MBY2hNfNLudmIWmiENPpCX6/O2TcFo=;
 b=pHgnABE3kxdzSlNZr3m/9rHL8yUddzkmgUowfleTq0oE+Z+N6RoKdJrNqlophBwFom
 oS6PrQ0QQG8n8iiFmPuYoGZWMQw/AImmBJ3GWXGo/4KgbrzeEzbIx8dYUmmtaT2Z2hFc
 5639IjAzTb4Z8qw/K1F2lB+tSQMeONyHT9Ndph+9Ird9gEN8FUyepGo2tmb69y6UnFuN
 ztHhvKcPAYNdUYYToiJEvbegZybcrHmQLREUnBMUiwDVYWiqDQaT2mAEjcIsIo+LiRJH
 y9OuFhmNq32vBngvHtK0t7PRIxEY/fMWoHJEARYlIaMQjt6rwwSYW4ngQxXPHxxOpRig
 /EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uzLQFTfRBp7D6MBY2hNfNLudmIWmiENPpCX6/O2TcFo=;
 b=ah9TU/wxNPRWDbIU0XCqbQPOXNvK+7LOvjpi+m7UNQsIuMQ286LcO3odvYkW7XFbfJ
 OiXeYKHEDUMr4LrHQS73JS5wL9S3AtXUa7CAhAngDUkO/dM5D2FwHBhg9fLGBvLxR7GN
 rnIEl+Hjvq9lU1/7mm7rsjmj+UJcXeGCdpCa0kGAG6/dFPfIn53+urrcWZ1PtubY9BHM
 TUXmE/pJ7UlvFJyHlnZdbCnfIZS7NkhewSgMVY7qlsOoBfiK6dDCVepvO+0KbVGdjNJ6
 JNttpqtQkr6GGegyDzEFzgWQ5yv0bOQDZAq7hack/UyGq+f8fJaLyV5KzDum5g60Hix0
 0rmw==
X-Gm-Message-State: AOAM531Z1AapbI5Y02IfsZDXKFh4F7GPUY3Wn4U7j0WrjhzVAdXJr8OG
 FGIgLdpxTHdU0NWcFpO1qDHu2ktJQPwC54Tfux6Dxw==
X-Google-Smtp-Source: ABdhPJy5jlefPqkC/z6CBNrKoFFgZry18N8y64ZkUFzQ2ecuiXc/D5kyoTw67QtL9FOq/lsaHyIqQ2d53/T2jNKRxWY=
X-Received: by 2002:adf:a48d:: with SMTP id g13mr2401549wrb.212.1598973132356; 
 Tue, 01 Sep 2020 08:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200830095915.14402-1-ani@anisinha.ca>
 <20200830095915.14402-3-ani@anisinha.ca>
 <20200901155141.0a6d93f6@imammedo-mac>
In-Reply-To: <20200901155141.0a6d93f6@imammedo-mac>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 1 Sep 2020 20:42:00 +0530
Message-ID: <CAARzgwxgB7XUHEnvXB0mYG8U47y8NU-TN5XKvB30unBQBUyXuw@mail.gmail.com>
Subject: Re: [PATCH 2/3] tests/acpi: add a new unit test to test hotplug
 off/on feature on the root pci bus
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 1, 2020 at 7:21 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Sun, 30 Aug 2020 15:29:13 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
>
> > Ability to turn hotplug off on the pci root bus for i440fx was added in commit:
> > 3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus")
> >
> > This change adds a unit test in order to test this feature.
> >
> > This change has been tested against upstream qemu master branch on top of tag v5.1.0.
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  tests/qtest/bios-tables-test.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > index d49b3988ec..8f7d87c0f6 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -709,6 +709,19 @@ static void test_acpi_piix4_tcg_bridge(void)
> >      free_test_data(&data);
> >  }
> >
> > +static void test_acpi_piix4_root_hotplug(void)
> > +{
> > +    test_data data;
> > +
> > +    memset(&data, 0, sizeof(data));
> > +    data.machine = MACHINE_PC;
> > +    data.variant = ".roothp";
> > +    data.required_struct_types = base_required_struct_types;
> > +    data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
> > +    test_acpi_one("-global PIIX4_PM.acpi-root-pci-hotplug=off", &data);
>
> I'd include here bridge config as well (test_acpi_piix4_tcg_bridge)
> so that ASL diff could show whether bridge was or wasn't affected.

Patch series v2 just sent.

>
> > +    free_test_data(&data);
> > +}
> > +
> >  static void test_acpi_q35_tcg(void)
> >  {
> >      test_data data;
> > @@ -1102,6 +1115,7 @@ int main(int argc, char *argv[])
> >          qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
> >          qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
> >          qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
> > +        qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
> >          qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> >          qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
> >          qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
>

