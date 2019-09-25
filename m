Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7D8C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 09:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483CB20673
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 09:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483CB20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD3CI-0004qx-Us
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 05:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iD3AO-0003iE-Nd
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 05:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iD3AN-0005f4-GN
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 05:00:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46319)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iD3AN-0005df-9f; Wed, 25 Sep 2019 05:00:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5436B30A7B83;
 Wed, 25 Sep 2019 09:00:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 177555B69A;
 Wed, 25 Sep 2019 09:00:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9F646113864E; Wed, 25 Sep 2019 11:00:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Subject: Re: [PATCH v1 5/6] riscv/virt: Add the PFlash CFI01 device
References: <cover.1568931866.git.alistair.francis@wdc.com>
 <0a5c141a26fada6d93d06e996a2f24e1b269ec50.1568931866.git.alistair.francis@wdc.com>
 <CAEUhbmVvDKQqQYE-riq=cvSrCe_NMoW_KDsLjh8CVHRUhJvk9A@mail.gmail.com>
 <CAKmqyKOofA3U+8kjMkzQ0sNd1=uwJHq3c9eaLZdoNCb7=e-PAw@mail.gmail.com>
 <CAFEAcA-uFPGf4BiDXH=Om3Df-xXrt7QwjzVF7E3kY4aMWMP4YQ@mail.gmail.com>
 <CAKmqyKP3T79qVUXftO=0hmhYbD9MKccdvsAcs=_4CQFoNmfucw@mail.gmail.com>
Date: Wed, 25 Sep 2019 11:00:50 +0200
In-Reply-To: <CAKmqyKP3T79qVUXftO=0hmhYbD9MKccdvsAcs=_4CQFoNmfucw@mail.gmail.com>
 (Alistair Francis's message of "Tue, 24 Sep 2019 17:54:39 -0700")
Message-ID: <87a7aszr5p.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 25 Sep 2019 09:00:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alistair Francis <alistair23@gmail.com> writes:

> On Mon, Sep 23, 2019 at 2:46 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Fri, 20 Sep 2019 at 23:23, Alistair Francis <alistair23@gmail.com> wrote:
>> > On Thu, Sep 19, 2019 at 10:15 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>> > > I don't think we should mirror what is used on ARM virt board to
>> > > create 2 flash for sifive_u. For ARM virt, there are 2 flashes because
>> > > they need distinguish secure and non-secure. For sifive_u, only one is
>> > > enough.
>> >
>> > I went back and forward about 1 or 2. Two seems more usable as maybe
>> > someone wants to include two pflash files? The Xilinx machine also has
>> > two so I'm kind of used to 2, but I'm not really fussed.
>>
>> One of the reasons for having 2 on the Arm board (we do this
>> even if we're not supporting secure vs non-secure) is that
>> then you can use one for a fixed read-only BIOS image (backed
>> by a file on the host filesystem shared between all VMs), and
>> one backed by a read-write per-VM file providing permanent
>> storage for BIOS environment variables. Notably UEFI likes to
>> work this way, but the idea applies in theory to other
>> boot loader or BIOSes I guess.
>
> This seems like a good reason to have two and there isn't really a
> disadvantage so I have kept it with two.

Good.

Implementing sector locking would be even better.  I'm not asking you to
do that work.

>> I would suggest also checking with Markus that your code
>> for instantiating the flash devices follows the current
>> recommendations so the backing storage can be configured
>> via -blockdev. (This is a fairly recent change from June or
>> so; current-in-master virt and sbsa boards provide an example
>> of doing the right thing, I think.)
>
> I have updated the code to more closely match the ARM virt machine, so
> I think I'm doing it correctly.

You might want to consider omitting legacy configuration options -drive
if=pflash and -bios for a simpler interface.

