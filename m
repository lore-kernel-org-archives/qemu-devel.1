Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF29C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 08:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA682468E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 08:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaYT77Z8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA682468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8gAI-0001ah-BK
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 03:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j8g9g-00012J-Of
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 03:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j8g9f-0002Yt-CI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 03:10:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54159
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j8g9f-0002YY-9T
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 03:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583136622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4N/drmfpyRS8Wa6+Eqq9VTNshGJJRoPnEinQjfFia0=;
 b=VaYT77Z8K+hHgwO14i3+S9KsL5BWUu7wSc9pSJacLD+h1Dk35thwoKBBrQTaW9QWiAeftR
 rALIZv9LKSQ6n3wUInytgAXeua4GZHo+p0muGJ17F2BGa3I+ir8D/ysgV/0yx8fHw36DMK
 VFIw8urUBKCzNDFGItXLhkrz5N2nlJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-7Ye3fl5ZMci9hTlcTDh6nw-1; Mon, 02 Mar 2020 03:10:19 -0500
X-MC-Unique: 7Ye3fl5ZMci9hTlcTDh6nw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEB0A8010F5;
 Mon,  2 Mar 2020 08:10:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD09360BF3;
 Mon,  2 Mar 2020 08:10:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1059511386A6; Mon,  2 Mar 2020 09:10:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 1/2] ide: Make room for flags in PCIIDEState and add one
 for legacy IRQ routing
References: <cover.1583017348.git.balaton@eik.bme.hu>
 <775825dba26f6b36ab067f253e4ab5dc3a3d15dc.1583017348.git.balaton@eik.bme.hu>
 <d85cd8c6-99a3-8430-41cc-486aad1ad8de@ilande.co.uk>
 <alpine.BSF.2.22.395.2003011619100.95594@zero.eik.bme.hu>
Date: Mon, 02 Mar 2020 09:10:14 +0100
In-Reply-To: <alpine.BSF.2.22.395.2003011619100.95594@zero.eik.bme.hu>
 (BALATON Zoltan's message of "Sun, 1 Mar 2020 16:27:50 +0100 (CET)")
Message-ID: <87pndvch3t.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-block@nongnu.org, philmd@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Sun, 1 Mar 2020, Mark Cave-Ayland wrote:
>> On 29/02/2020 23:02, BALATON Zoltan wrote:
>>> We'll need a flag for implementing some device specific behaviour in
>>> via-ide but we already have a currently CMD646 specific field that can
>>> be repurposed for this and leave room for furhter flags if needed in
>>> the future. This patch changes the "secondary" field to "flags" and
>>> define the flags for CMD646 and via-ide and change CMD646 and its
>>> users accordingly.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>  hw/alpha/dp264.c     |  2 +-
>>>  hw/ide/cmd646.c      | 12 ++++++------
>>>  hw/sparc64/sun4u.c   |  9 ++-------
>>>  include/hw/ide.h     |  4 ++--
>>>  include/hw/ide/pci.h |  7 ++++++-
>>>  5 files changed, 17 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
[...]
>>> @@ -317,20 +317,20 @@ static void pci_cmd646_ide_exitfn(PCIDevice *dev)
>>>      }
>>>  }
>>>
>>> -void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table,
>>> -                         int secondary_ide_enabled)
>>> +void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn,
>>> +                         bool secondary_ide_enabled)
>>>  {
>>>      PCIDevice *dev;
>>>
>>> -    dev =3D pci_create(bus, -1, "cmd646-ide");
>>> -    qdev_prop_set_uint32(&dev->qdev, "secondary", secondary_ide_enable=
d);
>>> +    dev =3D pci_create(bus, devfn, "cmd646-ide");
>>> +    qdev_prop_set_bit(&dev->qdev, "secondary", secondary_ide_enabled);
>>>      qdev_init_nofail(&dev->qdev);
>>>
>>>      pci_ide_create_devs(dev, hd_table);
>>>  }
>>
>> Note that legacy init functions such as pci_cmd646_ide_init() should be =
removed where
>> possible, and in fact I posted a patch last week to completely remove it=
. This is
>> because using qdev directly allows each board to wire up the device as r=
equired,
>> rather than pushing it down into a set of init functions with different =
defaults.
>>
>> Given that you're working in this area, I'd highly recommend doing the s=
ame for
>> via_ide_init() too.
>
> I could do that, however these ide init functions seem to exist for
> piix, cmd646 and via-ide so that pci_ide_create_devs function is kept
> local to hw/ide. Nothing else called that func apart from sun4u so
> I've chosen this way to keep consistency (also keeps property type at
> one place instead of needing to change each board that sets
> property). If the consensus is that getting rid of these init funcs
> even if that means pci_ide_create_devs will not be local to ide any
> more I can go that way but would like to hear opinion of ide
> maintainer as well.

I think Mark's point is that modelling a device and wiring up a device
model are separate things, and the latter belongs to the board.

pci_cmd646_ide_init() is a helper for boards.  Similar helpers exist
elsewhere.

In the oldest stratum of qdev code, such helpers were static inline
functions in the device model's .h.  That way, they're kind of separate
from the device model proper, in the .c, and kind of in the board code
where they belong, via inlining.  I've always considered that a terrible
idea; it's "kind of" as in "not really".  Over time, practice moved
first to putting the helpers into .c, then to open-coding the wiring
where it belongs: in the boards.

A few helper functions have survived, e.g. in hw/lm32/milkymist-hw.h,
and the IDE helpers we're discussing here.

Of course, when the code to wire up certain devices gets overly
repetitive, factoring out common code into helpers can make sense.  But
where to put them?  I can't see an obvious home for common board
helpers.  We tend to put these wiring helpers into a device model's .c
code for want of a better place.  Tolerable, I think.


