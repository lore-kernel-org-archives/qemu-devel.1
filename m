Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D414C3E8AB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 12:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 147F22084D
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 12:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol3TNqP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147F22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGisI-0007QV-5c
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 08:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iGirV-0006z0-8s
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 08:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iGirU-0002ji-7i
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 08:08:37 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:38724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iGirU-0002jM-4A; Sat, 05 Oct 2019 08:08:36 -0400
Received: by mail-yb1-xb44.google.com with SMTP id x4so3042263ybr.5;
 Sat, 05 Oct 2019 05:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CDGg1+HUjwfIQhQbE7gNj8BSYDtqDSqlom25bWUyY8Y=;
 b=Ol3TNqP3hGPvGoe/yUfK59pB0kyv4KZJvsiqa8vRLrjJFtCN5T6PZvkrkvfpcEna65
 PQqvnx2ILVagljjhRdPWMiDhgua/2k5URutbnwHFJn7pvxUGPhsmKXn7tutMYgnnCLBw
 y0K6FBNvnsksi3pFxBsHk6i+M3r7gLf02BB8LCU8Hat5hRM3z10/YSFUng6VIuv7W61T
 aO3fEO6SVyPjfbMIFZy5fAZUnzktkEuAMH6tGIKY42SWuba/htctOYb6FtLMBf3NMVxV
 JFDTSv2AVciyCMWi6Wcw1CetfjNoUy+ylMcTyxSlrQhiiPn5iqvggsi1mWdp/+NGSW3M
 M1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CDGg1+HUjwfIQhQbE7gNj8BSYDtqDSqlom25bWUyY8Y=;
 b=TnHuqptDeASvIpHkg/xQR0XLhaqxL2eZuaDO2nk8W9dxU+mF8b40kNjke4OX5fIeRW
 qSg2mVB3r+561G9HOv2P60vs1VmJvw5gO49gM+TwTSOw6SsTmk7aIVaTqivOxDa70LPs
 nUNaKVZQJj3LiKlMlRjWJEHlTl91RHYi8RzquMo5eHNm+6U/w8xS9BUzggVGe8fgttaI
 XWRccDMbLhVVMS5lxVX9/sz2d20hJXj4eo6BZu2j8jf8+2bo/ozP3NgwT8zuGvptK2yk
 w7xghuPqR71bQ7Uoe09GPkhmUK6/N8E70zelzqyk3gFBorkkqcEcRmS0XZylbBRRqiyP
 bBBQ==
X-Gm-Message-State: APjAAAXhiSPiFQ6TNjXpFc11Fj9vfFacpbqdnsvcBM0cUgyWeoB8aWYX
 vgZ0gLSHE2TYMFxSx1fxfXea+Up2X3DXAhuUtWk=
X-Google-Smtp-Source: APXvYqykSmP6uBcb3jHCHOa9XjYLENBGHEcsKJTSFjseZE4rx1iIql6x2aXDiLmxL5qN7f/Zxv4xJ7cQie34f6B11Tg=
X-Received: by 2002:a05:6902:4f0:: with SMTP id
 w16mr5364899ybs.11.1570277314831; 
 Sat, 05 Oct 2019 05:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191004151614.81516-1-jonathan@fintelia.io>
In-Reply-To: <20191004151614.81516-1-jonathan@fintelia.io>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 5 Oct 2019 20:08:24 +0800
Message-ID: <CAEUhbmXBtTghDsVXitER5O7U2_UnzEOyPxVXAQ9_5X2t_WxvNw@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Expose "priv" register for GDB
To: Jonathan Behrens <jonathan@fintelia.io>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 4, 2019 at 11:18 PM Jonathan Behrens <jonathan@fintelia.io> wrote:
>
> This patch enables a debugger to read and write the current privilege level via
> a special "priv" register. When compiled with CONFIG_USER_ONLY the register is
> still visible but is hardwired to zero.
>
> Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
> ---
>  gdb-xml/riscv-32bit-cpu.xml |  1 +
>  gdb-xml/riscv-64bit-cpu.xml |  1 +
>  target/riscv/cpu.c          |  2 +-
>  target/riscv/gdbstub.c      | 14 ++++++++++++++
>  4 files changed, 17 insertions(+), 1 deletion(-)
> ---
> Changelog V2:
> - Use PRV_H and PRV_S instead of integer literals
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>

