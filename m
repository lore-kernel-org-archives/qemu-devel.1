Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06481C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 06:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C041B20775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 06:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJWE9g/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C041B20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1johbr-0005iF-0U
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 02:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1johbJ-0005GX-5K
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 02:12:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23714
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1johbG-0006t0-Du
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 02:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593151952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2Ra74MdDsptcg0uIbycq+dpIde6EGiLoR7oLi1mZx0=;
 b=SJWE9g/Cr+fDDlHpw7nEoDkn2GzYiUm1LnL49RKW2yEUqZM/4PKSTXG0TXhi6RdaipyjLn
 3LW7d6ItrB4SeMj6pwFUoywveJJMUp+i6m3AWNKDCysY4s9O4kV+A6ukn9fokoDHW/lHpQ
 Tv9OWA5Mp/eDwMgy16K+QGMwMeRWrEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-d8A8sWUDNdSsHqLH5Z1oZw-1; Fri, 26 Jun 2020 02:12:29 -0400
X-MC-Unique: d8A8sWUDNdSsHqLH5Z1oZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22BC1464;
 Fri, 26 Jun 2020 06:12:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 347A460CD1;
 Fri, 26 Jun 2020 06:12:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AEE3511384D4; Fri, 26 Jun 2020 08:12:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Sai Pavan Boddu <saipava@xilinx.com>
Subject: Re: [PATCH v2 3/3] usb/hcd-xhci: Split pci wrapper for xhci base model
References: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1593008176-9629-4-git-send-email-sai.pavan.boddu@xilinx.com>
 <87y2obzhsc.fsf@dusky.pond.sub.org>
 <BY5PR02MB67723A0D247E4D2BC60A0710CA920@BY5PR02MB6772.namprd02.prod.outlook.com>
Date: Fri, 26 Jun 2020 08:12:20 +0200
In-Reply-To: <BY5PR02MB67723A0D247E4D2BC60A0710CA920@BY5PR02MB6772.namprd02.prod.outlook.com>
 (Sai Pavan Boddu's message of "Thu, 25 Jun 2020 18:08:38 +0000")
Message-ID: <871rm2tkxn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:55:55
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
 =?utf-8?Q?'Marc-Andr=C3=A9?= Lureau' <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 'Philippe =?utf-8?Q?Mathieu-Daud=C3=A9'?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sai Pavan Boddu <saipava@xilinx.com> writes:

> Hi Markus,
>
>> -----Original Message-----
>> From: Markus Armbruster <armbru@redhat.com>
>> Sent: Thursday, June 25, 2020 1:42 PM
>> To: Sai Pavan Boddu <saipava@xilinx.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Thomas Huth <thuth@redhat.com>; Eduardo
>> Habkost <ehabkost@redhat.com>; qemu-devel@nongnu.org; Alistair Francis
>> <alistair.francis@wdc.com>; 'Marc-Andr=C3=A9 Lureau'
>> <marcandre.lureau@redhat.com>; Ying Fang <fangying1@huawei.com>;
>> Paolo Bonzini <pbonzini@redhat.com>; 'Philippe Mathieu-Daud=C3=A9'
>> <philmd@redhat.com>
>> Subject: Re: [PATCH v2 3/3] usb/hcd-xhci: Split pci wrapper for xhci bas=
e
>> model
>>=20
>> Sai Pavan Boddu <sai.pavan.boddu@xilinx.com> writes:
>>=20
>> > This patch sets the base to use xhci as sysbus model, for which pci
>> > specific hooks are moved to hcd-xhci-pci.c. As a part of this
>> > requirment msi/msix interrupts handling is moved under XHCIPCIState,
>> > and XHCIState is  non qom object, make use of 'container_of' calls to
>> > retrive XHCIPciState. Made required changes for qemu-xhci-nec.
>> >
>> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>>=20
>> I can't see a "sysbus model".  What I can see is
>>=20
>>          TYPE_DEVICE
>>               |
>>        TYPE_PCI_DEVICE
>>               |
>>         TYPE_XHCI_PCI (renamed from TYPE_XHCI)
>>           /       \
>> TYPE_QEMU_XHCI TYPE_NEC_XHCI
>>=20
>> All but the two leaves are abstract.
>>=20
>> Do you intend to add a "sysbus model" in a future patch?
> [Sai Pavan Boddu]  Yes. I would be sending it along with that a device wh=
ich would be using it. (i.e for zynqmp soc )
> Let me know, if its good to include hcd-xhci-sysbus.c here ?

I'm not sure this series is worthwhile this future patch.  Up to the
maintainer.

Here's a clean way to provide different bus connectors (say PCI and
sysbus) for the same core device:

Make the core device a TYPE_DEVICE.

For each desired bus, have a bus-specific device that contains a core
device.  Use object_initialize_child() for the component.

Example: core device TYPE_SERIAL, PCI device TYPE_PCI_SERIAL, ISA device
TYPE_ISA_SERIAL, sysbus devices TYPE_SERIAL_IO. TYPE_SERIAL_MM.


