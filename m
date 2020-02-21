Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CDBC35640
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1E3207FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSRP7T8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1E3207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j54lt-0000am-4D
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 04:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j54l1-0008T0-FL
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j54kz-0000Dc-Gg
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:38:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38705
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j54kz-0000Cc-8Y
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582277880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Majml2clhq6dP7RmdsC9KLuFlEqWFevxeckEcdp3v00=;
 b=iSRP7T8ZIR48HLsRHf7jRRM/XdpuTA31uc0cfkdnqPoE6YWd3Y9+jPt4S0Meql4NVPd4He
 2t2iT2FomfusU5QjbZaz723R9hTxtUeDM/pnEMk+Q6HPaImGLtO2nBpwlIuhelq0umzXXn
 sCR/PVQxHuvOumPgcLrln/O8oxp6Gx0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-QDqJIeKNN5WmIdpGGHH-Kw-1; Fri, 21 Feb 2020 04:37:55 -0500
Received: by mail-wm1-f71.google.com with SMTP id f207so344287wme.6
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 01:37:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Majml2clhq6dP7RmdsC9KLuFlEqWFevxeckEcdp3v00=;
 b=AbdtoFFqFK+xyni0YxrEMmycPyy42BF8j/iXP47V+1cUTd0LJ9W2FlYDlkY5CP+sdM
 MgFipwJbSEnrM4ozcKmDuXmi8Z7+NvX42tkmW9Un5KPd+9plsqGmb080JwZv+Nmo9s1T
 /39rkpNquzG1cqsHxw6KirQBgadqX9wenNYt4czdZjkVWzAmOCZbug8KM4VCqmJ5o6NJ
 mWJGf5ZuIJJ13j5KYnJZZWD93/XDmULbrGRo0RX1VX9YCrP7qmrltqIYIcKR4zdM0Pxd
 g+WgChrAV/NzpRsVlkhwGMPyAYB40vayDnQwKHXAfAkRTqk+QM4H3btSunfvi0ZjcbbJ
 aiOg==
X-Gm-Message-State: APjAAAW6DSncGS+4gu3sQVpDTj2DBkarW7BucmjklwG6W1URzEQqkeMU
 0RllGrjq+qK6prTimP7vlwuj1TGtDIKFylILUkFwaRveIU1C2wB0IkGVtGQK9OXMKhIgf2r11q6
 ZEZlrxhuZ82AwvT4=
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr2764398wml.83.1582277873653; 
 Fri, 21 Feb 2020 01:37:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/Mw85Kze1wOuVGVtL5+AxfYnXwvl+v4ozCU0Z0s4EMXOR/QS0MhcrFbTGukbbxAdGi4EtaA==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr2764344wml.83.1582277873167; 
 Fri, 21 Feb 2020 01:37:53 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id r7sm1000635wmh.45.2020.02.21.01.37.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 01:37:52 -0800 (PST)
Subject: Re: [PATCH] hw/char/pl011: Enable TxFIFO and async transmission
To: qemu-devel@nongnu.org, gshan@redhat.com
References: <158226649422.712.7285415168506294704@a1bbccc8075a>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5d569175-55de-b182-a338-cc04ba9b0afd@redhat.com>
Date: Fri, 21 Feb 2020 10:37:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158226649422.712.7285415168506294704@a1bbccc8075a>
Content-Language: en-US
X-MC-Unique: QDqJIeKNN5WmIdpGGHH-Kw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, maz@kernel.org, qemu-arm@nongnu.org,
 shan.gavin@gmail.com, marcandre.lureau@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Igor & Drew.

On 2/21/20 7:28 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200221044908.266883-1-gshan@redhat.com/
 >
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
[...]
   TEST    check-qtest-aarch64: tests/qtest/bios-tables-test
> **
> ERROR:/tmp/qemu-test/src/tests/qtest/acpi-utils.c:145:acpi_find_rsdp_address_uefi: code should not be reached
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/acpi-utils.c:145:acpi_find_rsdp_address_uefi: code should not be reached
> make: *** [check-qtest-aarch64] Error 1

The virt machine is not happy, busy-looping?

$ QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64 \
   tests/qtest/bios-tables-test
/aarch64/acpi/virt: ^C


