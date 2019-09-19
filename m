Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377B2C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D9F21D56
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yCcvo0DJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D9F21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwjq-00085q-E7
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iAwRk-00034p-6e
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iAwRh-0007rT-Rl
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:26:07 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36455)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iAwRf-0007oJ-R0
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:26:04 -0400
Received: by mail-oi1-x242.google.com with SMTP id k20so2721235oih.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hmtA+x4AdVtvOO2BSWhLjM0XYkfRJORb4qO8gBWVHtY=;
 b=yCcvo0DJzBAoVAhGUhOJUtiN9+Z259EVxR0whCETfBFEEmi9RDdB4VopwOVrNm0s3z
 s9DtdfuS2458Dr60kBBOYtMtvOyk+j/V3NOD3JLCkDfd5xf++qRIUnWaCFidV6afCTP5
 7jRGptjHnzZYtY+e/r5qVOm5E/b8Jej1YWo9AKi5qxT4i6C7mkC0U24iLE04N2KOrEkP
 XOg5AWRnw8yLYyuX5MhepxSWvJ9VT4ROeZozks0UN51rFzGfvonRpi46KQa3EgRX4wjC
 Xj/lnRQuQbA/GPh0EgrJKpjF6AnnUhFf0XqaBuAxLkQdMm0GV8fw/ZXqN6EMPhyE4y0O
 tr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hmtA+x4AdVtvOO2BSWhLjM0XYkfRJORb4qO8gBWVHtY=;
 b=jps7JgwPYk8iX2RV5xxQSZ21/a1fvsEZQvBiaIL8WHAP70gSnjrEC3/Nc7RNAwr4If
 0l4i+Shg2OOdEu6DxL+8wsy2UNezE0SaCMUFcfxX3s/oi842Crlqz3mK0JVZKXjJ6lKI
 Sddc7FwFdKOpAxkvxDNkrXgSXXTSpBZrcs0J9A2DpT84uFD6yWApVyLH0Est7QeCV24K
 geIPGX/QvIZGKmEQUzdN5u6uqhKLe4nPA7xajJNA2NUdejV7d/0FYM1ccZRKe20O3TI8
 wRcBQ7BxiL2vhB/XcS57WzgluLdDfsA/Y8g7AnAAgvfYvfKC+OHknnbq25m47lxPURIw
 ZxCQ==
X-Gm-Message-State: APjAAAVzkk07VVfyXe+1U3HJjT5Pk7v5ZnEIPM5CHJSzCYn4nGZXG6Hu
 xljWjJZMFY5iY+qNjm0mGqh8eCIvYLpjuvLfxsLBOg==
X-Google-Smtp-Source: APXvYqx6ds8Gqm4QHdytrchiFfVqhwMnVbIIhqfYJVJmtolzn2WvhWgL9hnLN7pIVtUz4m66OjKl9p4RQRosq6MV0vQ=
X-Received: by 2002:aca:53d4:: with SMTP id h203mr1990335oib.146.1568899560540; 
 Thu, 19 Sep 2019 06:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190906083152.25716-1-zhengxiang9@huawei.com>
 <20190906083152.25716-3-zhengxiang9@huawei.com>
In-Reply-To: <20190906083152.25716-3-zhengxiang9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 14:25:49 +0100
Message-ID: <CAFEAcA_MGiatTVCEbnoy5D7S_j9H1DyPkqWMb8uBKL_oycyVDg@mail.gmail.com>
To: Xiang Zheng <zhengxiang9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v18 2/6] docs: APEI GHES generation and
 CPER record description
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, wanghaibin.wang@huawei.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Sep 2019 at 09:33, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>
> From: Dongjiu Geng <gengdongjiu@huawei.com>
>
> Add APEI/GHES detailed design document
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> ---
>  docs/specs/acpi_hest_ghes.txt | 88 +++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 docs/specs/acpi_hest_ghes.txt

Hi; new documentation in docs/specs should be in rst format and
listed in the contents page for the manual at docs/specs/index.rst,
please. Conversion from plain text should hopefully be fairly
straightforward.


I've also provided some minor typo/grammar fixes below.


> diff --git a/docs/specs/acpi_hest_ghes.txt b/docs/specs/acpi_hest_ghes.txt
> new file mode 100644
> index 0000000000..690d4b2bd0
> --- /dev/null
> +++ b/docs/specs/acpi_hest_ghes.txt
> @@ -0,0 +1,88 @@
> +APEI tables generating and CPER record
> +=============================
> +
> +Copyright (C) 2019 Huawei Corporation.
> +
> +Design Details:
> +-------------------
> +
> +       etc/acpi/tables                                 etc/hardware_errors
> +    ====================                      ==========================================
> ++ +--------------------------+            +-----------------------+
> +| | HEST                     |            |    address            |            +--------------+
> +| +--------------------------+            |    registers          |            | Error Status |
> +| | GHES1                    |            | +---------------------+            | Data Block 1 |
> +| +--------------------------+ +--------->| |error_block_address1 |----------->| +------------+
> +| | .................        | |          | +---------------------+            | |  CPER      |
> +| | error_status_address-----+-+ +------->| |error_block_address2 |--------+   | |  CPER      |
> +| | .................        |   |        | +---------------------+        |   | |  ....      |
> +| | read_ack_register--------+-+ |        | |    ..............   |        |   | |  CPER      |
> +| | read_ack_preserve        | | |        +-----------------------+        |   | +------------+
> +| | read_ack_write           | | | +----->| |error_block_addressN |------+ |   | Error Status |
> ++ +--------------------------+ | | |      | +---------------------+      | |   | Data Block 2 |
> +| | GHES2                    | +-+-+----->| |read_ack_register1   |      | +-->| +------------+
> ++ +--------------------------+   | |      | +---------------------+      |     | |  CPER      |
> +| | .................        |   | | +--->| |read_ack_register2   |      |     | |  CPER      |
> +| | error_status_address-----+---+ | |    | +---------------------+      |     | |  ....      |
> +| | .................        |     | |    | |  .............      |      |     | |  CPER      |
> +| | read_ack_register--------+-----+-+    | +---------------------+      |     +-+------------+
> +| | read_ack_preserve        |     |   +->| |read_ack_registerN   |      |     | |..........  |
> +| | read_ack_write           |     |   |  | +---------------------+      |     | +------------+
> ++ +--------------------------|     |   |                                 |     | Error Status |
> +| | ...............          |     |   |                                 |     | Data Block N |
> ++ +--------------------------+     |   |                                 +---->| +------------+
> +| | GHESN                    |     |   |                                       | |  CPER      |
> ++ +--------------------------+     |   |                                       | |  CPER      |
> +| | .................        |     |   |                                       | |  ....      |
> +| | error_status_address-----+-----+   |                                       | |  CPER      |
> +| | .................        |         |                                       +-+------------+
> +| | read_ack_register--------+---------+
> +| | read_ack_preserve        |
> +| | read_ack_write           |
> ++ +--------------------------+
> +
> +(1) QEMU generates the ACPI HEST table. This table goes in the current
> +    "etc/acpi/tables" fw_cfg blob. Each error source has different
> +    notification types.
> +
> +(2) A new fw_cfg blob called "etc/hardware_errors" is introduced. QEMU
> +    also need to populate this blob. The "etc/hardwre_errors" fw_cfg blob

"needs". "hardware_errors".

> +    contains an address registers table and an Error Status Data Block table.
> +
> +(3) The address registers table contains N Error Block Address entries
> +    and N Read Ack Register entries, the size for each entry is 8-byte.

". The size".

> +    The Error Status Data Block table contains N Error Status Data Block
> +    entries, the size for each entry is 4096(0x1000) bytes. The total size


". The size"

> +    for "etc/hardware_errors" fw_cfg blob is (N * 8 * 2 + N * 4096) bytes.

"for the"

> +    N is the kinds of hardware error sources.

Not sure what you had in mind here. Possibly either "N is the number of kinds of
hardware error sources" or "N is the number of hardware error sources" ?

> +
> +(4) QEMU generates the ACPI linker/loader script for the firmware, the

". The"

> +    firmware pre-allocates memory for "etc/acpi/tables", "etc/hardware_errors"
> +    and copies blobs content there.

"blob contents"

> +
> +(5) QEMU generates N ADD_POINTER commands, which patch address in the

"addresses"

> +    "error_status_address" fields of the HEST table with a pointer to the
> +    corresponding "address registers" in "etc/hardware_errors" blob.

"in the"

> +
> +(6) QEMU generates N ADD_POINTER commands, which patch address in the

"addresses"

> +    "read_ack_register" fields of the HEST table with a pointer to the
> +    corresponding "address registers" in "etc/hardware_errors" blob.

"in the"

> +
> +(7) QEMU generates N ADD_POINTER commands for the firmware, which patch
> +    address in the " error_block_address" fields with a pointer to the

"addresses". Stray extra space after open-quote.

> +    respective "Error Status Data Block" in "etc/hardware_errors" blob.

"in the"

> +
> +(8) QEMU defines a third and write-only fw_cfg blob which is called
> +    "etc/hardware_errors_addr". Through that blob, the firmware can send back
> +    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
> +    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER commands

"command"

> +    for the firmware, the firmware will write back the start address of

". The"

> +    "etc/hardware_errors" blob to fw_cfg file "etc/hardware_errors_addr".

"to the fw_cfg file"

> +
> +(9) When QEMU gets SIGBUS from the kernel, QEMU formats the CPER right into

"a SIGBUS"

> +    guest memory, and then injects whatever interrupt (or assert whatever GPIO

"or asserts"

> +    line) as a notification which is necessary for notifying the guest.
> +
> +(10) This notification (in virtual hardware) will be handled by guest kernel,

"the guest kernel"

> +    guest APEI driver will read the CPER which is recorded by QEMU and do the

"and the guest APEI driver"

> +    recovery.

thanks
-- PMM

