Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1652EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FE82072E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmr9UeB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FE82072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5H4-0000Ww-39
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kb5FW-0007jN-0F
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:10:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kb5FU-00031s-Dd
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604682603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pCc2OHwduMCbNswptc9B/atjIkhqIhKb8LFY7rv/A8Q=;
 b=gmr9UeB3hAJpsGmbABUDDDa6QnD1PsTOM41rZ1SOpSXu5kigxezePn4OKoxsUdPTzUBSKt
 D0jtvo1eeAPiwpUYDyX243bNhovImC4KDSctWlAmihQOY/+Yh6+tUjhrglsSp0kGjAodjn
 5g6CDsvtFBi+AI3WhiudkOGGz0vWZwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-t5aAyBMzOzqdm32kVbB9uQ-1; Fri, 06 Nov 2020 12:09:58 -0500
X-MC-Unique: t5aAyBMzOzqdm32kVbB9uQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15795101962D;
 Fri,  6 Nov 2020 17:09:57 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-115-95.ams2.redhat.com
 [10.36.115.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D39C06EF75;
 Fri,  6 Nov 2020 17:09:54 +0000 (UTC)
Subject: Re: Question on UEFI ACPI tables setup and probing on arm64
To: Ying Fang <fangying1@huawei.com>, Igor Mammedov <imammedo@redhat.com>
References: <ee3b7fdf-f6ba-cafc-5b44-42b0bcda01c5@huawei.com>
 <20201103133913.1fee3337@redhat.com>
 <a79383a6-92d4-5b10-d143-414543caab70@redhat.com>
 <5310d14d-8dbe-ba97-fdf1-4f3f10f91f3a@huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <813efc59-2ce4-e2be-894f-e48ca66ce603@redhat.com>
Date: Fri, 6 Nov 2020 18:09:53 +0100
MIME-Version: 1.0
In-Reply-To: <5310d14d-8dbe-ba97-fdf1-4f3f10f91f3a@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 06:30:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Drew Jones <drjones@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 "wangzhigang17@huawei.com" <wangzhigang17@huawei.com>,
 "Ard Biesheuvel \(ARM address\)" <ard.biesheuvel@arm.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/05/20 05:30, Ying Fang wrote:

> I see it in Qemu the *loader_start* is fixed at 1 GiB on the
> physical address space which points to the DRAM base. In ArmVirtQemu.dsc
> PcdDeviceTreeInitialBaseAddress is set 0x40000000 with correspondence.
> 
> Here I also see the discussion about DRAM base for ArmVirtQemu.
> https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg03127.html
> 
> I am still not sure how UEFI knows that it is running on a ArmVirtQemu
> machine type.

It doesn't know. It remains a convention.

This part is not auto-detected; the constants in QEMU and edk2 are
independently open-coded, their values were synchronized by human effort
initially.

The user or the management layer have to make sure they boot a UEFI
firmware binary on the machine type that is compatible with the machine
type.

There is some meta-data to help with that:

> Does UEFI derive it from the fdt *compatible* property ?

Please see the schema "docs/interop/firmware.json" in the QEMU tree; in
particular the @FirmwareTarget element.

For an actual example: QEMU bundles some edk2 firmware binaries (purely
as a convenience, not for production), and those are accompanied by
matching descriptor files. See
"pc-bios/descriptors/60-edk2-aarch64.json". (It is a template that's
fixed up during QEMU installation, but that's tangential here.)

    "targets": [
        {
            "architecture": "aarch64",
            "machines": [
                "virt-*"
            ]
        }
    ],

Thanks
Laszlo


