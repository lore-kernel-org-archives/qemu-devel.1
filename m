Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91305C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5389E2065E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/fTu8fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5389E2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDR03-0003XN-C6
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 07:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDQzH-0002WA-Re
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:31:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28173
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDQzF-0004Dt-PB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599046292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DDEiepCj/UIQqIKd8aQSFSpdo72N3X/++9jpaSMMNd0=;
 b=K/fTu8fcqu+uKwX5591cLkXavaPchg6yzXJXmb+AzBHCN6Zna3UVXw0+us6O08uTEwF7g7
 7UGwGg9pnUGtWgP/Mv5lVZ58Xm5FSx/CStcPh1AJX8jh7wllakjsGzs6q5o5fiYqzgdzUc
 23TkysG98EglcuGxR1gRtxxzrl1sy88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-rV-tSs0iO068DeOp2qZ6hA-1; Wed, 02 Sep 2020 07:31:29 -0400
X-MC-Unique: rV-tSs0iO068DeOp2qZ6hA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B9E3801AE2;
 Wed,  2 Sep 2020 11:31:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04D3A19C66;
 Wed,  2 Sep 2020 11:31:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A7D4113C418; Wed,  2 Sep 2020 13:31:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: usb-wacom-tablet failing to register
References: <CAOf5uwkxAVNs_=TtVwUiEKyp+UZO_bT26sdCneR679Q5hZ_J2A@mail.gmail.com>
 <CAOf5uw=_tT1h612vnsHjCSRWhQg3_rFWeh9cic86sgKX8ZGubg@mail.gmail.com>
 <CAOf5uw=uiL2vVJQYaGcKU_SvVFDd-_h6QuaSZ9abZZQuZKEaUw@mail.gmail.com>
Date: Wed, 02 Sep 2020 13:31:23 +0200
In-Reply-To: <CAOf5uw=uiL2vVJQYaGcKU_SvVFDd-_h6QuaSZ9abZZQuZKEaUw@mail.gmail.com>
 (Michael Nazzareno Trimarchi's message of "Sat, 8 Aug 2020 18:06:16
 +0200")
Message-ID: <87h7sgjtys.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michael Nazzareno Trimarchi <michael@amarulasolutions.com> writes:

> Hi Markus
>
> I have seen that you are a committer there so what I have seen that

I know precious little about USB, and nothing about this particular
device.  I'm cc'ing our USB maintainer Gerd.

> This request is not implement
>  switch (request) {
>     case InterfaceRequest | USB_REQ_GET_DESCRIPTOR:
>
> When linux probe it fail here
>
> ret = hid_get_class_descriptor(dev, interface->desc.bInterfaceNumber,
>>                         HID_DT_REPORT, rdesc, rsize);
>
> I think that I miss something in documentation
>
> Running 5.8.0-rc3 and qemu 4.2.0
>
> Michael
>
> On Sat, Aug 8, 2020 at 4:59 PM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>>
>> Hi
>>
>> What I have seen is that the parse fail to execute
>> hid ll_driver parse fai for
>>
>>  ret = hid_get_class_descriptor(dev, interface->desc.bInterfaceNumber,
>>                         HID_DT_REPORT, rdesc, rsize);
>>
>> Now this is not implemented in hw/dev-wacom.c . What am I missing?
>>
>> #!/bin/sh
>> IMAGE_DIR="${0%/*}/"
>>
>> if [ "${1}" = "serial-only" ]; then
>>     EXTRA_ARGS='-nographic'
>> else
>>     EXTRA_ARGS='-serial stdio'
>> fi
>>
>> export PATH="/home/michael/work/amarula/buildroot/output/host/bin:${PATH}"
>> exec   qemu-system-i386 -M pc -kernel ${IMAGE_DIR}/bzImage -usb
>> -device usb-wacom-tablet -drive
>> file=${IMAGE_DIR}/rootfs.ext2,if=virtio,format=raw -append "rootwait
>> root=/dev/vda console=tty1 console=ttyS0"  -net nic,model=virtio -net
>> use
>> r  ${EXTRA_ARGS}
>>
>> This is how I run it
>>
>> Michael
>>
>> On Sat, Jul 11, 2020 at 4:38 PM Michael Nazzareno Trimarchi
>> <michael@amarulasolutions.com> wrote:
>> >
>> > Hi all
>> >
>> > On my 4.17.0-rc1 linux kernel i386 running on qemu, I can't register
>> > the wacom driver emulation
>> > QEMU emulator version 4.2.0 (Debian 1:4.2-3ubuntu6.3)
>> > Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
>> >
>> > [    0.395368] ata2.00: configured for MWDMA2
>> > [    0.397049] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM
>> >   2.5+ PQ: 0 ANSI: 5
>> > [    0.584135] usb 2-1: new full-speed USB device number 2 using xhci_hcd
>> > [    0.734449] usb 2-1: New USB device found, idVendor=056a,
>> > idProduct=0000, bcdDevice=42.10
>> > [    0.734461] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>> > [    0.734466] usb 2-1: Product: Wacom PenPartner
>> > [    0.734470] usb 2-1: Manufacturer: QEMU
>> > [    0.734474] usb 2-1: SerialNumber: 1-0000:00:04.0-1
>> > [    0.737347] usbhid 2-1:1.0: can't add hid device: -32
>> > [    0.737366] usbhid: probe of 2-1:1.0 failed with error -32
>> >
>> > I get back an error. Any suggestions?
>> >
>> > Michael
>>
>>
>>
>> --
>> Michael Nazzareno Trimarchi
>> Amarula Solutions BV
>> COO Co-Founder
>> Cruquiuskade 47 Amsterdam 1018 AM NL
>> T. +31(0)851119172
>> M. +39(0)3479132170
>> [`as] https://www.amarulasolutions.com


