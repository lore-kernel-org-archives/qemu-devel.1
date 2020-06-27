Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC46C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 06:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342EF20857
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 06:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewcLjCp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342EF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jp4ju-00083d-Aw
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 02:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp4iy-0007XA-Om
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 02:54:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32954
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp4ix-0002aw-3o
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 02:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593240842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7NCaCnSMuD/ozCGA/Pw8qXfTMVMvH3ntJxxWCbUxYqY=;
 b=ewcLjCp1PHw18KCSccwSOYOuQlPqkvw5SI/g9T5Al2czal2RTT88UWOkACo62pU3Vx0PZC
 +SYv9SXEsvHCwBA0AiFb5p7udnyb6IdMrt5YuapP8hN8ofCXO6Z1peynChQERJtv3V/EML
 vszIeD0xAESd/PjBkLLc8zbjz1f8Psg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-Rp_cpTsXMry1T92deyNapg-1; Sat, 27 Jun 2020 02:54:00 -0400
X-MC-Unique: Rp_cpTsXMry1T92deyNapg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C36A804002;
 Sat, 27 Jun 2020 06:53:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8EB9121A2F;
 Sat, 27 Jun 2020 06:53:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2623011384A6; Sat, 27 Jun 2020 08:53:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Sai Pavan Boddu <saipava@xilinx.com>
Subject: Re: [PATCH v2 3/3] usb/hcd-xhci: Split pci wrapper for xhci base model
References: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1593008176-9629-4-git-send-email-sai.pavan.boddu@xilinx.com>
 <87y2obzhsc.fsf@dusky.pond.sub.org>
 <BY5PR02MB67723A0D247E4D2BC60A0710CA920@BY5PR02MB6772.namprd02.prod.outlook.com>
 <871rm2tkxn.fsf@dusky.pond.sub.org>
 <BY5PR02MB6772B9C9031FD35A9FA8A969CA930@BY5PR02MB6772.namprd02.prod.outlook.com>
Date: Sat, 27 Jun 2020 08:53:48 +0200
In-Reply-To: <BY5PR02MB6772B9C9031FD35A9FA8A969CA930@BY5PR02MB6772.namprd02.prod.outlook.com>
 (Sai Pavan Boddu's message of "Fri, 26 Jun 2020 10:19:15 +0000")
Message-ID: <87366ht2wz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?utf-8?Q?'Marc-Andr=C3=A9?= Lureau' <marcandre.lureau@redhat.com>,
 'Philippe =?utf-8?Q?Mathieu-Daud=C3=A9'?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sai Pavan Boddu <saipava@xilinx.com> writes:

> HI Markus,
>
>> -----Original Message-----
>> From: Markus Armbruster <armbru@redhat.com>
>> Sent: Friday, June 26, 2020 11:42 AM
>> To: Sai Pavan Boddu <saipava@xilinx.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>; Thomas Huth
>> <thuth@redhat.com>; Eduardo Habkost <ehabkost@redhat.com>; qemu-
>> devel@nongnu.org; Alistair Francis <alistair.francis@wdc.com>; Gerd
>> Hoffmann <kraxel@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
>> Ying Fang <fangying1@huawei.com>; 'Marc-Andr=C3=A9 Lureau'
>> <marcandre.lureau@redhat.com>; 'Philippe Mathieu-Daud=C3=A9'
>> <philmd@redhat.com>
>> Subject: Re: [PATCH v2 3/3] usb/hcd-xhci: Split pci wrapper for xhci bas=
e
>> model
>>=20
>> Sai Pavan Boddu <saipava@xilinx.com> writes:
>>=20
>> > Hi Markus,
>> >
>> >> -----Original Message-----
>> >> From: Markus Armbruster <armbru@redhat.com>
>> >> Sent: Thursday, June 25, 2020 1:42 PM
>> >> To: Sai Pavan Boddu <saipava@xilinx.com>
>> >> Cc: Gerd Hoffmann <kraxel@redhat.com>; Peter Maydell
>> >> <peter.maydell@linaro.org>; Thomas Huth <thuth@redhat.com>;
>> Eduardo
>> >> Habkost <ehabkost@redhat.com>; qemu-devel@nongnu.org; Alistair
>> >> Francis <alistair.francis@wdc.com>; 'Marc-Andr=C3=A9 Lureau'
>> >> <marcandre.lureau@redhat.com>; Ying Fang <fangying1@huawei.com>;
>> >> Paolo Bonzini <pbonzini@redhat.com>; 'Philippe Mathieu-Daud=C3=A9'
>> >> <philmd@redhat.com>
>> >> Subject: Re: [PATCH v2 3/3] usb/hcd-xhci: Split pci wrapper for xhci
>> >> base model
>> >>
>> >> Sai Pavan Boddu <sai.pavan.boddu@xilinx.com> writes:
>> >>
>> >> > This patch sets the base to use xhci as sysbus model, for which pci
>> >> > specific hooks are moved to hcd-xhci-pci.c. As a part of this
>> >> > requirment msi/msix interrupts handling is moved under
>> >> > XHCIPCIState, and XHCIState is  non qom object, make use of
>> >> > 'container_of' calls to retrive XHCIPciState. Made required changes=
 for
>> qemu-xhci-nec.
>> >> >
>> >> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>> >>
>> >> I can't see a "sysbus model".  What I can see is
>> >>
>> >>          TYPE_DEVICE
>> >>               |
>> >>        TYPE_PCI_DEVICE
>> >>               |
>> >>         TYPE_XHCI_PCI (renamed from TYPE_XHCI)
>> >>           /       \
>> >> TYPE_QEMU_XHCI TYPE_NEC_XHCI
>> >>
>> >> All but the two leaves are abstract.
>> >>
>> >> Do you intend to add a "sysbus model" in a future patch?
>> > [Sai Pavan Boddu]  Yes. I would be sending it along with that a device
>> > which would be using it. (i.e for zynqmp soc ) Let me know, if its goo=
d to
>> include hcd-xhci-sysbus.c here ?
>>=20
>> I'm not sure this series is worthwhile this future patch.  Up to the mai=
ntainer.
>>=20
>> Here's a clean way to provide different bus connectors (say PCI and
>> sysbus) for the same core device:
>>=20
>> Make the core device a TYPE_DEVICE.
>>=20
>> For each desired bus, have a bus-specific device that contains a core de=
vice.
>> Use object_initialize_child() for the component.
> [Sai Pavan Boddu] This was my V1 implementation.
> Changed it to non-qom structure after some feedback from @Gred. Felt like=
 XHCIState will not be used standalone.

I'll gladly defer to Gerd's judgement here.


