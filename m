Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A45C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384012076A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVYT4bJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384012076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQshM-0005hS-DW
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 09:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jQsYW-00019N-Ip
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jQsYR-00034S-Pj
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:03:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52842
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jQsYR-00031Y-9Z
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587474189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiL1gvWmNe67InoDmmjUD0KEQwrxgISySTFxbtW1GOQ=;
 b=MVYT4bJYFORZZz6KuFn61sMAtoVtOzy86o3I+/BWHwIVV1Y9kF7r/dDhT++v6mlG4fPjDW
 qyAbGI4ImgodDQRF3mI7j0qU+zNevUE3zm02zEF5yqb7zg1GxMMx3YnYoyDLv68Py9jPK6
 90opCzSYx06pV6s2j12d1iGxLBOjwBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-tIO59JKKN_K94JkmQXWTxg-1; Tue, 21 Apr 2020 09:03:02 -0400
X-MC-Unique: tIO59JKKN_K94JkmQXWTxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53FEB8017F3;
 Tue, 21 Apr 2020 13:03:01 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-115-52.ams2.redhat.com
 [10.36.115.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 483955DA7C;
 Tue, 21 Apr 2020 13:02:56 +0000 (UTC)
Subject: Re: [edk2-discuss] Load Option passing. Either bugs or my confusion.
To: Gerd Hoffmann <kraxel@redhat.com>
References: <623b1855-285c-cce3-c806-c17e5fd217ea@redhat.com>
 <5211.1586899245384995995@groups.io>
 <a972450d-8834-ae87-e4e3-5263a41d1735@redhat.com>
 <20200420141303.dxjqgvmzglrjtsly@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9aed493a-2187-cacd-5631-54fb9973509c@redhat.com>
Date: Tue, 21 Apr 2020 15:02:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200420141303.dxjqgvmzglrjtsly@sirius.home.kraxel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Hou Qiming <hqm03ster@gmail.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 qemu devel list <qemu-devel@nongnu.org>, discuss@edk2.groups.io,
 valerij zaporogeci <vlrzprgts@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/20/20 16:13, Gerd Hoffmann wrote:
>   Hi,
>
>> So I would say that the symptom you see is a QEMU v4.1.0 regression.
>> The QemuRamfbGraphicsOutputSetMode() function in the OVMF ramfb
>> driver certainly needs the QemuFwCfgWriteBytes() call to work, for
>> changing the resolution.
>
> Oh?  QemuRamfbGraphicsOutputSetMode() can be called multiple times?
> How does that happen?

QemuRamfbGraphicsOutputSetMode() is the "SetMode" member function of the
EFI_GRAPHICS_OUTPUT_PROTOCOL instance that QemuRamfbDxe produces.

This is a standard protocol; UEFI drivers and applications are free to
locate it and to use it.

(1) When you launch OVMF, you get the splash screen in a particular
resolution. This resolution:
- is configured by OvmfPkg/PlatformDxe,
- is inherited by an OS boot loader,
- is reconfigurable with OvmfPkg/PlatformDxe, for the next boot, via the
  Setup TUI,
- defaults to 800x600 (taking effect when no particular choice is
  configured).

(2) UiApp -- the Setup TUI itself -- uses its own resolution. Under
OVMF, this resolution is fixed 640x480. When UiApp is entered,
ultimately a call is made to QemuRamfbGraphicsOutputSetMode() -- i.e., a
GOP.SetMode() member function -- for setting this 640x480 resolution.

Using the following command:

  qemu-system-x86_64 \
    -nodefaults \
    -boot menu=on,splash-time=5000 \
    -enable-kvm \
    -device ramfb \
    -drive if=pflash,readonly,format=raw,file=$PREFIX/share/qemu/edk2-x86_64-code.fd \
    -drive if=pflash,snapshot,format=raw,file=$PREFIX/share/qemu/edk2-i386-vars.fd \
    -debugcon file:ovmf.log \
    -global isa-debugcon.iobase=0x402

when you first see the progress bar, the graphical resolution (1) is
800x600. Accordingly, QEMU prints to stderr:

> ramfb_fw_cfg_write: 800x600 @ 0x6702000

Once you hit ESC to interrupt the progress bar and to enter the Setup
TUI, UiApp switches to resolution (2), 640x480. QEMU prints:

> ramfb_fw_cfg_write: 640x480 @ 0x6702000
> ramfb_fw_cfg_write: resolution locked, change rejected

And you get garbage in the Setup window.

Thanks,
Laszlo


