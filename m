Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71449C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5376223EA
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoZzg66M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5376223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkZ7-0003KT-OV
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kGkWl-0001lI-HO
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:59:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33544
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kGkWj-0000Qh-A1
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599836387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bUVJjcl1c/DCfV/bcjBuAt/Mg7FtgSHFyN5Xn3HBmuE=;
 b=eoZzg66MrXEVTq3k5JjzewSGDtrwhXCJGQcdaTQptSdooHuraYraL8zwr0RbHOHOPETMGH
 D6hOVO9mkOh3nAwlAOLKbymeqB2dQY5PyhhrIUyz6tCsa8HHZHXppK80fnqgh/Znkt86Ai
 X5xYO/JLDtOq4p3tvIHLCmQzcounBmE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-E3WZ4G3kNPG2BvlNDM8EcQ-1; Fri, 11 Sep 2020 10:59:46 -0400
X-MC-Unique: E3WZ4G3kNPG2BvlNDM8EcQ-1
Received: by mail-wr1-f69.google.com with SMTP id a12so3602269wrg.13
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 07:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bUVJjcl1c/DCfV/bcjBuAt/Mg7FtgSHFyN5Xn3HBmuE=;
 b=PMq3uBKsYE2w+29eHq2YHsHv+/wSpd+NrXpoTo8L2LDYzA2oAA9sI6s7x+K9A30ynW
 TMTtwX4MhsFxYDtGFHXKNRoLGQEtR2+hT1kKwvpfMmxcUHMQv7PK0V5C9HsAdAy2RPyZ
 BPxK1jrlJhPH5oURQxflcj3K5wkLWXyQhmuY7huNkFupf+pFAfO+eQHySR/DXCO7a5km
 856+mGx77iqWb6rgLqtybanqGhVjvurVHjsaEZLQg2vVqeCaFBGb4Z0d+iBxHxhuzPTY
 effR/HhG++r0T0r1LluBj+KfT/ofmLFfACVva5qOVS7WYnFSfLU+wMMMA5c2ssN4jFd6
 gOyA==
X-Gm-Message-State: AOAM533fqiWVqSuvXXSazR8eM73RbSz8xBXQ6OGMJUqns5TAmJKB08lw
 sQgO6EXF7ZzZvLPv4+T8K6VkZM7zxvhiOc1oATcOfBDtibpmP6+TTupX5OogjEN4j3QMHFzmq36
 rw/FwYSNRCphNBPc=
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr2718379wmk.165.1599836385084; 
 Fri, 11 Sep 2020 07:59:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+Gmx9+EYkf6Y7tkqmA8xaXHEczNFlFDdwcecOsOue8mqWPynjW094UKqsA+P+RJipor0JKQ==
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr2718362wmk.165.1599836384795; 
 Fri, 11 Sep 2020 07:59:44 -0700 (PDT)
Received: from redhat.com ([176.230.64.162])
 by smtp.gmail.com with ESMTPSA id u66sm4979981wmg.44.2020.09.11.07.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 07:59:44 -0700 (PDT)
Date: Fri, 11 Sep 2020 10:59:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v1 2/3] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Message-ID: <20200911105931-mutt-send-email-mst@kernel.org>
References: <20200905103520.12626-1-ani@anisinha.ca>
 <20200905103520.12626-3-ani@anisinha.ca>
 <448ada27-1a94-44ed-89fa-001a70213ad7@Spark>
MIME-Version: 1.0
In-Reply-To: <448ada27-1a94-44ed-89fa-001a70213ad7@Spark>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 09:43:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 jusual@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 10:34:20PM +0530, Ani Sinha wrote:
> On Sep 5, 2020, 16:05 +0530, Ani Sinha <ani@anisinha.ca>, wrote:
> 
>     This change adds a new unit test for the global flag
> 
>     'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged
>     pci
> 
>     bridges in i440fx. The flag can be used to turn off acpi based hotplug
>     support
> 
>     for all the slots of the pci bus.
> 
> 
> 
>     Tested on the upstream qemu master branch on top of tag v5.1.0
> 
> 
> Can someone please review this? 
> 
> 
> 
>     Signed-off-by: Ani Sinha <ani@anisinha.ca>
> 
> 
> 
> 
I queues this.

>     ---
> 
>     tests/qtest/bios-tables-test.c | 15 +++++++++++++++
> 
>     1 file changed, 15 insertions(+)
> 
> 
> 
>     diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/
>     bios-tables-test.c
> 
>     index a2c0070306..e52a36e775 100644
> 
>     --- a/tests/qtest/bios-tables-test.c
> 
>     +++ b/tests/qtest/bios-tables-test.c
> 
>     @@ -723,6 +723,20 @@ static void test_acpi_piix4_root_hotplug(void)
> 
>     free_test_data(&data);
> 
>     }
> 
> 
> 
>     +static void test_acpi_piix4_bridge_hotplug(void)
> 
>     +{
> 
>     + test_data data;
> 
>     +
> 
>     + memset(&data, 0, sizeof(data));
> 
>     + data.machine = MACHINE_PC;
> 
>     + data.variant = ".hpbridge";
> 
>     + data.required_struct_types = base_required_struct_types;
> 
>     + data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
> 
>     + test_acpi_one("-global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off
>     "
> 
>     + "-device pci-bridge,chassis_nr=1", &data);
> 
>     + free_test_data(&data);
> 
>     +}
> 
>     +
> 
>     static void test_acpi_q35_tcg(void)
> 
>     {
> 
>     test_data data;
> 
>     @@ -1117,6 +1131,7 @@ int main(int argc, char *argv[])
> 
>     qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
> 
>     qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
> 
>     qtest_add_func("acpi/piix4/hotplug", test_acpi_piix4_root_hotplug);
> 
>     + qtest_add_func("acpi/piix4/brhotplug", test_acpi_piix4_bridge_hotplug);
> 
>     qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> 
>     qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
> 
>     qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
> 
>     --
> 
>     2.17.1
> 
> 
> 


