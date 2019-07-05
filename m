Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB509C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3181218CA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3181218CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjOrK-0007UY-Vx
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 10:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45291)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <georg.kotheimer@kernkonzept.com>) id 1hjOq7-0006Ua-M2
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <georg.kotheimer@kernkonzept.com>) id 1hjOq5-00034q-IC
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:05:26 -0400
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]:52459
 helo=mx.kernkonzept.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <georg.kotheimer@kernkonzept.com>)
 id 1hjOq4-00019Q-CA; Fri, 05 Jul 2019 10:05:24 -0400
Received: from [95.90.166.246] (helo=tweek.localnet)
 by mx.kernkonzept.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) id 1hjOpe-0003QJ-7W; Fri, 05 Jul 2019 16:04:58 +0200
From: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Date: Fri, 05 Jul 2019 16:04:57 +0200
Message-ID: <3120585.xbh9iPihlS@tweek>
In-Reply-To: <345cc679-deac-ce52-664b-0ac5883671ca@linaro.org>
References: <20190703142617.21073-1-georg.kotheimer@kernkonzept.com>
 <345cc679-deac-ce52-664b-0ac5883671ca@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:1c1c:b490::2
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Select FPU gdb xml file based on
 the supported extensions
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
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> While this appears reasonable, I wonder if RVF w/o RVD actually works?
>
> Examining the two get/set functions, they always transfer 64 bits for the fpu
> registers.

Wouldn't that implicate that FPU debugging has never been working properly on
RV32, as prior to my changes the FPU registers on RV32 were always 32 bits
wide? Nope, it does work (tested with a build not containing my changes), but
for all the wrong reasons. The get/set functions should be modified so that
they take the actual size of the floating point registers into account.


> In addition, there's a suspicious use of sizeof(target_ulong) when transferring
> the fpu related csr registers, which definitely shouldn't work with the shared
> files above.  If the xml file is correct, this should always be uint32_t.

Good catch. According to the RISC-V ISA specification the fcsr is always 32
bit wide.

I did a little bit of investigation and found the following contradiction in
the gdb xml files. The registers fflags/frm/fcsr are listed in general csr
file as well as in the fpu file. For RV64 the bitsize of the two definitions
differs.

gdb-xml/riscv-32bit-csr.xml:
   <reg name="fflags" bitsize="32"/>
   <reg name="frm" bitsize="32"/>
   <reg name="fcsr" bitsize="32"/>

gdb-xml/riscv-64bit-csr.xml:
   <reg name="fflags" bitsize="64"/>
   <reg name="frm" bitsize="64"/>
   <reg name="fcsr" bitsize="64"/>

gdb-xml/riscv-fpu-f.xml: (former riscv-32bit-fpu.xml)
   <reg name="fflags" bitsize="32" type="int" regnum="66"/>
   <reg name="frm" bitsize="32" type="int" regnum="67"/>
   <reg name="fcsr" bitsize="32" type="int" regnum="68"/>

gdb-xml/riscv-fpu-d.xml: (former riscv-64bit-fpu.xml)
   <reg name="fflags" bitsize="32" type="int" regnum="66"/>
   <reg name="frm" bitsize="32" type="int" regnum="67"/>
   <reg name="fcsr" bitsize="32" type="int" regnum="68"/>

I don't know if this is on purpose, but my guess would be that fflags/frm/fcsr
don't belong into riscv-32/64bit-csr.xml, and the bitsize should be 32
regardless of the architecture's bitness.



