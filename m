Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464B2C2BA17
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 10:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08158206C3
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 10:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTuB8au7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08158206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKgGe-00066p-4E
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 06:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <natechancellor@gmail.com>) id 1jKd3L-0008Ma-GF
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 03:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <natechancellor@gmail.com>) id 1jKd3K-0001ug-7Q
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 03:17:15 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <natechancellor@gmail.com>)
 id 1jKd3H-0001rt-D1; Sat, 04 Apr 2020 03:17:11 -0400
Received: by mail-ot1-x342.google.com with SMTP id c9so9778454otl.12;
 Sat, 04 Apr 2020 00:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=ocAQZbJHFdTGhkYtuoMJ19OnRrOVnmlc/UOXXoN4tBU=;
 b=HTuB8au7If018Dci+O5VzlEo6SY6vsuB8aVDK2ldLdyDfhDWZ/mG3LzcQrmfE8vuR/
 7xPNMiELC5QYFBOfMkhWJ6pUvJiIy6ZNBb8n2eYqVjY2nIsImN8+JSOQWOEOus5k6auu
 EwhR3HjDf457g7JB8xWhO1XSIe647vWo7Jo8REAsbvrRu5CiznqCCvVMecoxmCp7080/
 rQfvZLHGCdxDF1o1s0lpU9h24pBtNrAHjBpvhLsATImhighpOq52C2VxafJMcZccA4Ey
 ZvygnpPGo1BDL3ocoVgsHd0oKIPb6DpxPLICkesg5z7s5UMPzysLYodttL8Z+ci66Nyd
 ANZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=ocAQZbJHFdTGhkYtuoMJ19OnRrOVnmlc/UOXXoN4tBU=;
 b=WZpw2eZp58lAZ9ZhbmmVOT1t/lUfnU+Z9d+eZyv9YT8IMYsAmR6rrgDpvUORtVaa2l
 iff49INfqRK1MjnO/Y9SVMxEvLDuyOmQho2F37zFg371MrxwwPvCFOg2rPChJlYpmJNf
 k+GR2L9EkgYtGMaDSEC8IssmS6q6OUNsKqVLF/Miu3BqClbVkMrbFFZfAe0fmBIf/YOx
 HdFKaZWNTHiejgnKEQ/FDllDJIjuVlvDq/XyV4lSjNgqPa+8uLGkvtAPOIjSXdRPKV8O
 2xj3Qr7UDtQg9XuMz/FXkUUijWiweWWeOnDHgd5ao6L/baDQZSDIHun7nNENnKSKXkq6
 /SyA==
X-Gm-Message-State: AGi0PubRlZxwIID017QA9pLXWWgBJVl73PXqAE58aZZ4Ic0qbFHMH5FC
 l2IvPvYwD6BxNc5MDYlWSmg=
X-Google-Smtp-Source: APiQypIsymx+7axl0/snwvyifsrA9bHiRy/1v3qk1IyysmnIP5osGcqqbXPtnbwQ77oqLwlOzzXfOg==
X-Received: by 2002:a05:6830:2428:: with SMTP id
 k8mr9833678ots.345.1585984629914; 
 Sat, 04 Apr 2020 00:17:09 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
 by smtp.gmail.com with ESMTPSA id g72sm2729480otg.79.2020.04.04.00.17.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 04 Apr 2020 00:17:09 -0700 (PDT)
Date: Sat, 4 Apr 2020 00:17:07 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2] ppc/pnv: Create BMC devices at machine init
Message-ID: <20200404071707.GA24708@ubuntu-m2-xlarge-x86>
References: <20191121162340.11049-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191121162340.11049-1-clg@kaod.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
X-Mailman-Approved-At: Sat, 04 Apr 2020 06:42:18 -0400
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
Cc: Corey Minyard <cminyard@mvista.com>, Oliver O'Halloran <oohall@gmail.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cédric,

On Thu, Nov 21, 2019 at 05:23:40PM +0100, Cédric Le Goater wrote:
> The BMC of the OpenPOWER systems monitors the machine state using
> sensors, controls the power and controls the access to the PNOR flash
> device containing the firmware image required to boot the host.
> 
> QEMU models the power cycle process, access to the sensors and access
> to the PNOR device. But, for these features to be available, the QEMU
> PowerNV machine needs two extras devices on the command line, an IPMI
> BT device for communication and a BMC backend device:
> 
>   -device ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10
> 
> The BMC properties are then defined accordingly in the device tree and
> OPAL self adapts. If a BMC device and an IPMI BT device are not
> available, OPAL does not try to communicate with the BMC in any
> manner. This is not how real systems behave.
> 
> To be closer to the default behavior, create an IPMI BMC simulator
> device and an IPMI BT device at machine initialization time. We loose
> the ability to define an external BMC device but there are benefits:
> 
>   - a better match with real systems,
>   - a better test coverage of the OPAL code,
>   - system powerdown and reset commands that work,
>   - a QEMU device tree compliant with the specifications (*).
> 
> (*) Still needs a MBOX device.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

I just started testing QEMU v5.0.0-rc1 against the little Linux booting
framework that I helped set up for ClangBuiltLinux and this commit has
caused some problems because we specify the exact same devices as you
note in the commit message:

https://github.com/ClangBuiltLinux/boot-utils/blob/5d9d3f626940a6a176c080717a367c1599f63680/boot-qemu.sh#L154-L155

$ timeout 3m unbuffer qemu-system-ppc64 -device ipmi-bmc-sim,id=bmc0 \
                                        -device isa-ipmi-bt,bmc=bmc0,irq=10 \
                                        -L images/ppc64le/ \
                                        -bios skiboot.lid \
                                        -machine powernv \
                                        -display none \
                                        -initrd images/ppc64le/rootfs.cpio \
                                        -kernel zImage.epapr \
                                        -m 2G \
                                        -serial mon:stdio
qemu-system-ppc64: error creating device tree: node: FDT_ERR_EXISTS

It seems to me like if the machine is silently creating these devices,
it should just warn that the user is trying to create a device that
already exists? If not, then I assume I will just need to hack up a
check for QEMU 5.0.0+ and just not add those devices? We use that script
with QEMU 3.1.0 in our CI and I use it locally with QEMU 4.2.0 so
universally getting rid of them doesn't seem logical.

Curious for your thoughts on what to do and cheers,
Nathan

