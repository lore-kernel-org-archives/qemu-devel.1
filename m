Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392A3C2BB55
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C172076A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIgadg6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C172076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOjcr-0004eL-5R
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 11:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jOjbu-0003ix-4U
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1jOjbs-00048H-2y
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:05:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39743
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1jOjbr-00047r-UQ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586963150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JlKM9ajWSzF3P6aqVkPpHugIcNnh/KmfZskQVp5TCQM=;
 b=RIgadg6i51sY5MXS49F/eYAZHLmAqEev34x8zxNUPiusu/f1Ug8L3KBoRWGM3jIick+RCV
 AQDfbt4EVP8CJakVMXPD8oj55ygzALg+c4UCQxJDM73joEk+tlQ3gGzGqZOHfkUpKR05/a
 3sHcGGmVXNUu38ItlaTzD/yZg/W157I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-51BGrbO1MZWntTetEXcUvw-1; Wed, 15 Apr 2020 11:05:43 -0400
X-MC-Unique: 51BGrbO1MZWntTetEXcUvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 023EC18C35B5;
 Wed, 15 Apr 2020 15:05:42 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-155.ams2.redhat.com
 [10.36.112.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B7F5272C4;
 Wed, 15 Apr 2020 15:05:35 +0000 (UTC)
Subject: Re: [edk2-discuss] Load Option passing. Either bugs or my confusion.
To: valerij zaporogeci <vlrzprgts@gmail.com>, Hou Qiming <hqm03ster@gmail.com>
References: <623b1855-285c-cce3-c806-c17e5fd217ea@redhat.com>
 <5211.1586899245384995995@groups.io>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a972450d-8834-ae87-e4e3-5263a41d1735@redhat.com>
Date: Wed, 15 Apr 2020 17:05:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5211.1586899245384995995@groups.io>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: discuss@edk2.groups.io, edk2-devel-groups-io <devel@edk2.groups.io>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(CC Gerd, Qiming, Marcel, qemu-devel for ramfb:)

On 04/14/20 23:20, valerij zaporogeci wrote:

[snip]

> There is a Boot Manager UI display problem, I don't know if this is
> qemu problem, but with the ARM (both 32 and 64 bits, the qemu version
> is 4.2.0, the OVMF is fresh), and using "ramfb" device, the Boot
> Manager has troubles with drawing - it's interfase looks entirely
> broken, like this (I'll try to attach the screenshot). UEFI shell
> doesn't have this problem. switching to "serial" (which is -serial vc)
> doesn't produce it too. Only when ramfb is chosen, the Boot Manager UI
> gets smeared. But it takes input and presumable works properly, except
> displaying things. qemu writes these messages in the command prompt:
> ramfb_fw_cfg_write: 640x480 @ 0x4bd00000
> ramfb_fw_cfg_write: resolution locked, change rejected
> ramfb_fw_cfg_write: 800x600 @ 0x4bd00000
> ramfb_fw_cfg_write: resolution locked, change rejected

Gerd contributed the OVMF QemuRamfbDxe driver in edk2 commit
1d25ff51af5c ("OvmfPkg: add QemuRamfbDxe", 2018-06-14). Note the date:
June 2018.

The then-latest (released) QEMU version was v2.12.0, and v2.12.1 /
v3.0.0 were in the making.

At that time, the resolution change definitely worked -- note my
"Tested-by" on the edk2 commit message.


Running "git blame" on the QEMU source, I now find commit a9e0cb67b7f4
("hw/display/ramfb: lock guest resolution after it's set", 2019-05-24).

Again, note the date: May 2019 (and this commit was released with QEMU
v4.1.0).

So I would say that the symptom you see is a QEMU v4.1.0 regression. The
QemuRamfbGraphicsOutputSetMode() function in the OVMF ramfb driver
certainly needs the QemuFwCfgWriteBytes() call to work, for changing the
resolution.


Now, I'm not familiar with the reasons behind QEMU commit a9e0cb67b7f4.
It says it intends to "prevent[] a crash when the guest writes garbage
to the configuration space (e.g. when rebooting)".

But I don't understand why locking the resolution was necessary for
preventing "a crash":

(1) Registering a device reset handler in QEMU seems sufficient, so that
QEMU forget about the currently shared RAMFB area at platform reset.

(2) The crash in question is apparently not a *QEMU* crash -- which
might otherwise justify a heavy-handed approach. Instead, it is a
*guest* crash. See the references below:

(2a) http://mid.mail-archive.com/CABSdmrmU7FK90Bupq_ySowcc9Uk=8nQxNLHgzvDsNYdp_QLogA@mail.gmail.com
     https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg02299.html

(2b) https://github.com/intel/gvt-linux/issues/23#issuecomment-483651476

Therefore, I don't think that locking the resolution was justified!

Importantly:

- The QemuRamfbDxe driver allocates the framebuffer in *reserved*
memory, therefore any well-behaving OS will *never* touch the
framebuffer.

- The QemuRamfbDxe driver allocates the framebuffer memory only once,
namely for such a resolution that needs the largest amount of
framebuffer memory. Therefore, framebuffer re-allocations in the guest
driver -- and thereby guest RAM *re-mapping* in QEMU -- are *not*
necessary, upon resolution change.

The ramfb device reset handler in QEMU is justified (for unmapping /
forgetting the previously shared RAMFB area).

The resolution locking is *NOT* justified, and it breaks the OVMF
driver. I suggest backing out the resolution locking from QEMU.

Reference (2a) above indicates 'It could be a misguided attempt to
"resize ramfb" by the guest Intel driver'. If that is the case, then
please fix the Intel guest driver, without regressing the QEMU device
model.

I'm sad that the QEMU device model change was not regression-tested
against the *upstream* OVMF driver (which, by then, had been upstream
for almost a year).

Laszlo


