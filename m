Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91F3C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4004A20855
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="rP0lEEgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4004A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkec-0001Jr-8M
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGkdS-0008Vc-M7
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:06:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGkdQ-0002Qt-N9
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:06:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id w5so11808379wrp.8
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 08:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=npdYPn+cwnqwItvjTsSiNKZyjiKbiUavqiNYOCY7bHA=;
 b=rP0lEEgAWdlc8nhkGCaQybRLoWpyjSS6YYESGz2VV85Or9wLicLNdRv+1BAizRAiiX
 J6OKoZ20XxVoKixaZzM3muHNChx4IEFQT0RL/QuWbW9MRfkZ2WF5Xd4nGFtCfZ0vPL8a
 6vCxHAphnvDvrtvTnJQU1dYFogKQRf3I4qGDnO1i+IFIXBQhgBcSxdqoRJ++/fxt7KuV
 rb9vkw3qsxcX6NoWg7oBQh539EFWpz3WZ93Nl/0bVd0zMRcxzmY+VGT80XCE2bL49wk9
 OZSbIbATUitJJy8WMwMKZ9Pd2RqhcwWfZUaY+GmxhrtEzSFcOXpbvBNka6QEo5eu8xnK
 lz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=npdYPn+cwnqwItvjTsSiNKZyjiKbiUavqiNYOCY7bHA=;
 b=kXqYmZYRAaOhfnuACn/FzBHt+KzL77UDV9N1WuQ3HiUuj2HRF+FJUdv8kxvRna+Hfj
 6Ft8c+slnyZeiF5b4yFm6l14ZNiOcB68Az3cvFc0S0Hy7QYNqQW8WhbxBQwg3Yv3uiVa
 mtKTtERZihOLTYABV9sUDNXXuDuUHl7/OPhNu1vS3HFJeVBtYKM4p6dNpb/nyezHBkty
 RJyp4AEj8FW8dUnbDHWQr316CJ9PmC6DmCYhNPULcwcOq62wvUSb4wKetM2PNFyb5EWl
 W8tYgOFTzicRl/14QKa9faO/fPHvgs8goOdy1Kf5FGdFN1z+LCygOfHxiOfZ/QjKuu/W
 ySTw==
X-Gm-Message-State: AOAM532tSLyyVQtyyC5TJh902rTg/N2UpPW5bhpsCCdeFCr3/jFtQ+M5
 7zqRMzPx1BjMSWYmnRtFCI4ycpE5fLnc6YEe03xegg==
X-Google-Smtp-Source: ABdhPJwWnXlsHCSI6xJSrMdW2ETnB2BKr1YJDuz4tz+jUgryX4MmfHtQZSPbuj++zfNq8p240eSC1BH9oVuCxfMCj+M=
X-Received: by 2002:adf:bb44:: with SMTP id x4mr2493873wrg.76.1599836802252;
 Fri, 11 Sep 2020 08:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200905103520.12626-1-ani@anisinha.ca>
 <20200905103520.12626-3-ani@anisinha.ca>
 <448ada27-1a94-44ed-89fa-001a70213ad7@Spark>
 <20200911105931-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200911105931-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Fri, 11 Sep 2020 20:36:30 +0530
Message-ID: <CAARzgwwGWznB5dcS_BmT7zgHFxM05+f6_nr04DrFQrCjAiM5LQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::442;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x442.google.com
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
 Julia Suvorova <jusual@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 11, 2020 at 8:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 10, 2020 at 10:34:20PM +0530, Ani Sinha wrote:
> > On Sep 5, 2020, 16:05 +0530, Ani Sinha <ani@anisinha.ca>, wrote:
> >
> >     This change adds a new unit test for the global flag
> >
> >     'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged
> >     pci
> >
> >     bridges in i440fx. The flag can be used to turn off acpi based hotplug
> >     support
> >
> >     for all the slots of the pci bus.
> >
> >
> >
> >     Tested on the upstream qemu master branch on top of tag v5.1.0
> >
> >
> > Can someone please review this?
> >
> >
> >
> >     Signed-off-by: Ani Sinha <ani@anisinha.ca>
> >
> >
> >
> >
> I queues this.

cool. When is the next pull Michael?

>
> >     ---
> >
> >     tests/qtest/bios-tables-test.c | 15 +++++++++++++++
> >
> >     1 file changed, 15 insertions(+)
> >
> >
> >
> >     diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/
> >     bios-tables-test.c
> >
> >     index a2c0070306..e52a36e775 100644
> >
> >     --- a/tests/qtest/bios-tables-test.c
> >
> >     +++ b/tests/qtest/bios-tables-test.c
> >
> >     @@ -723,6 +723,20 @@ static void test_acpi_piix4_root_hotplug(void)
> >
> >     free_test_data(&data);
> >
> >     }
> >
> >
> >
> >     +static void test_acpi_piix4_bridge_hotplug(void)
> >
> >     +{
> >
> >     + test_data data;
> >
> >     +
> >
> >     + memset(&data, 0, sizeof(data));
> >
> >     + data.machine = MACHINE_PC;
> >
> >     + data.variant = ".hpbridge";
> >
> >     + data.required_struct_types = base_required_struct_types;
> >
> >     + data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
> >
> >     + test_acpi_one("-global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off
> >     "
> >
> >     + "-device pci-bridge,chassis_nr=1", &data);
> >
> >     + free_test_data(&data);
> >
> >     +}
> >
> >     +
> >
> >     static void test_acpi_q35_tcg(void)
> >
> >     {
> >
> >     test_data data;
> >
> >     @@ -1117,6 +1131,7 @@ int main(int argc, char *argv[])
> >
> >     qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
> >
> >     qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
> >
> >     qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
> >
> >     + qtest_add_func("acpi/piix4/brhotplug", test_acpi_piix4_bridge_hotplug);
> >
> >     qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> >
> >     qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
> >
> >     qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
> >
> >     --
> >
> >     2.17.1
> >
> >
> >
>

