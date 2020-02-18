Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147BCC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72F122B48
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9mY7EWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72F122B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j45m7-0002hj-1j
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 11:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j45lP-00024q-6t
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:30:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j45lO-0004kR-47
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:30:23 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j45lN-0004jn-S2
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:30:22 -0500
Received: by mail-pl1-x642.google.com with SMTP id a6so8288245plm.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 08:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=FSBRnHkDhESpfXu5T/AAuV8F4kl8OaSEbJecFDTEXwc=;
 b=j9mY7EWW9YaLxTHp1r3ufS/Ifmpj4++trpikOhHq2pWYrP0ySW4TE4Ni8Zo4XEN/x8
 YNpI8Sx5RJZHrB75lUx/OKLp2syirVFK0ykF9kLl3FEE6XIctjOktATrMsXFDAK9dxvu
 67uTfqCajaltbnTo759Kih18rQJ5q75eZ7EiqtGMGrbapiIlc8rjypWR18UXZ0zNuERn
 uGvhmxID/87vCsNO0rrtQpI/CJNEPC0Pn5l2ABA3WlrSehjVugLGMgjN3NVD3zFJS80r
 Ov3QbsiT6RBeyfa7IMCdwqR94UM3JaqM3Q3FxCi/yBoVIXy+b+v2VJo0aufZlEomNwA7
 p0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=FSBRnHkDhESpfXu5T/AAuV8F4kl8OaSEbJecFDTEXwc=;
 b=LLQ1F/RlbhZ4KQhrCYxYKPsbv9hjpScW8n/5vCnlFTnhJOaYEnY4+bNON0bkCAVw/d
 33m4asph4fWYfgydE73ndj6RzMaKgcmq6be6AaVG3T4DndqulEknfK4RJNR2LRUNXyZn
 i+No8leU2HnHiNlqogSicuyr4To0w8RSi5roUZXOcPo9NCoTd8FQRMAGFS+1XMJoFr71
 LiomHHm5GgMhflU2/PsOD+9ltMgMKkWpIaPhHsJGpFEYmr3KrMBhtEvqQmsDwDybElx0
 DzaVXKsRkEHa4jpsZSQhqwE0+kgbSdgwFLNHfM+K7Ao69ZUXH7H3SKlwr1A8kYujGmTn
 WL8w==
X-Gm-Message-State: APjAAAUBN81PQOKiEAdjb1AZmNhuiDfLhQVlGJA65kOuBq6RsdR6b4LS
 ksAsDyP5xT0d0NtdUsE3+qfP6w==
X-Google-Smtp-Source: APXvYqwpIAWr0tCMbDUeTC8UWy4EL19x0dtL2pC2woTitzEypNSY18jaJDwZvQ64qEQ/xDlwa96DEA==
X-Received: by 2002:a17:902:6948:: with SMTP id
 k8mr21210695plt.223.1582043420326; 
 Tue, 18 Feb 2020 08:30:20 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id z19sm4695607pfn.49.2020.02.18.08.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 08:30:19 -0800 (PST)
Date: Tue, 18 Feb 2020 08:30:19 -0800 (PST)
X-Google-Original-Date: Tue, 18 Feb 2020 08:30:17 PST (-0800)
Subject: Re: [PATCH] riscv: virt: Allow PCI address 0
In-Reply-To: <CAEUhbmXK7rmgkjP1XtQArtSiFQMH3tazWnRnF8MJDMMi0x-EFQ@mail.gmail.com>
CC: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-e4ef76de-db35-4811-a6b2-e5c381767d61@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 02 Feb 2020 07:41:25 PST (-0800), bmeng.cn@gmail.com wrote:
> Hi Palmer,
>
> On Sat, Nov 23, 2019 at 6:41 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>>
>> On Fri, 22 Nov 2019 07:27:52 PST (-0800), bmeng.cn@gmail.com wrote:
>> > When testing e1000 with the virt machine, e1000's I/O space cannot
>> > be accessed. Debugging shows that the I/O BAR (BAR1) is correctly
>> > written with address 0 plus I/O enable bit, but QEMU's "info pci"
>> > shows that:
>> >
>> >   Bus  0, device   1, function 0:
>> >     Ethernet controller: PCI device 8086:100e
>> >   ...
>> >       BAR1: I/O at 0xffffffffffffffff [0x003e].
>> >   ...
>> >
>> > It turns out we should set pci_allow_0_address to true to allow 0
>> > PCI address, otherwise pci_bar_address() treats such address as
>> > PCI_BAR_UNMAPPED.
>> >
>> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>> > ---
>> >
>> >  hw/riscv/virt.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> > index 23f340d..411bef5 100644
>> > --- a/hw/riscv/virt.c
>> > +++ b/hw/riscv/virt.c
>> > @@ -603,6 +603,7 @@ static void riscv_virt_machine_class_init(ObjectClass *oc, void *data)
>> >      mc->init = riscv_virt_board_init;
>> >      mc->max_cpus = 8;
>> >      mc->default_cpu_type = VIRT_CPU;
>> > +    mc->pci_allow_0_address = true;
>> >  }
>> >
>> >  static const TypeInfo riscv_virt_machine_typeinfo = {
>>
>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> I've put this on for-next, as I don't think this is 4.2 material.
>
> Looks you missed picking up this one :(

Sorry about that, it's back on for-master.

