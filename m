Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE941C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792E120658
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXc+aRLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792E120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3z5k-0008LP-NH
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j3z51-0007tf-JL
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j3z50-0004fa-2v
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:22:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26918
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j3z4z-0004dZ-Vq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582017726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ly2XmwKScgjqRifOVrveR1gnuiL44Jl9/z5Qa19WMbI=;
 b=UXc+aRLZwiI7zSzrOGo9tWIFcc1J8GZKNEP5r0D0oVhag49fFCGR18DNX/juwZ4uTefTye
 A/sJXsqM8oK5vK7YDVxD5ULVpTyVonGlk8tZhO7Fq/dgJXY8BL/C+kXtpQOJqT7NAxDC46
 LOEgP+2DKqwFcW9rIYTiMPwMx2HxKiQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-P20g__toMXurkEZcWuRyqw-1; Tue, 18 Feb 2020 04:22:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5983413E4;
 Tue, 18 Feb 2020 09:22:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2263817DC8;
 Tue, 18 Feb 2020 09:21:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9564311385C9; Tue, 18 Feb 2020 10:21:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] hw/ipmi/bmc: Delay timer_new_ns() from init to
 realize to avoid memleaks
References: <20200215154706.19837-1-philmd@redhat.com>
 <20200215154706.19837-2-philmd@redhat.com>
 <CAFEAcA9cZHWziyk6VzfaxrqjCNNOmnmSkB=uuGJMp0TL521mAQ@mail.gmail.com>
 <8c4570e1-cd9b-9d33-2756-5c223df282ee@redhat.com>
 <CAFEAcA-hyEVPeT1wakaft6m3_WD9XG3eYFAwJJgoHRAZ1nntag@mail.gmail.com>
 <e530629d-c029-1d7c-b5b7-cdbbeb397a4d@redhat.com>
 <CAFEAcA-KzWv=_kZUPNE6yyUSA36XY+q91ihJ_xh4euJ9RsyaLA@mail.gmail.com>
Date: Tue, 18 Feb 2020 10:21:54 +0100
In-Reply-To: <CAFEAcA-KzWv=_kZUPNE6yyUSA36XY+q91ihJ_xh4euJ9RsyaLA@mail.gmail.com>
 (Peter Maydell's message of "Mon, 17 Feb 2020 16:32:39 +0000")
Message-ID: <871rqsi72l.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: P20g__toMXurkEZcWuRyqw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 17 Feb 2020 at 16:15, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>> Per this comment in qdev.c, unrealize() is the expected default:
>>
>>      /* by default all devices were considered as hotpluggable,
>>       * so with intent to check it in generic qdev_unplug() /
>>       * device_set_realized() functions make every device
>>       * hotpluggable. Devices that shouldn't be hotpluggable,
>>       * should override it in their class_init()
>>       */
>>      dc->hotpluggable =3D true;

Please note that "hot-pluggable" is *not* required for "need unrealize()
to work", at least in theory.  Cold plug exists, and cold unplug could
exist.

> This comment sounds like it's documenting what was the
> previous default ("were considered") and making a minimal
> change to avoid breaking existing code where a device
> does want to be hotpluggable but isn't explicitly saying so.

Commit 1a37eca107, six years ago:

    qdev: add "hotpluggable" property to Device
   =20
    Currently it's possible to make PCIDevice not hotpluggable
    by using no_hotplug field of PCIDeviceClass. However it
    limits this only to PCI devices and prevents from
    generalizing hotplug code.
   =20
    So add similar field to DeviceClass so it could be reused
    with other Devices and would allow to replace PCI specific
    hotplug callbacks with generic implementation. Following
    patches will replace PCIDeviceClass.no_hotplug with this
    new property.
   =20
    In addition expose field as "hotpluggable" readonly property,
    to make it possible to read its value via QOM interface.
   =20
    Make DeviceClass hotpluggable by default as it was assumed
    before.

> I forget how exactly it works (the mechanism has changed
> several times) but in practice a sysbus device is generally
> not hotpluggable, and that's what most devices are.

A device's "hot-pluggability" comes into play only when both bus and
machine support hot-plug.  And before we even get there, the device
needs to be "pluggable", i.e. dc->user_creatable.

Bus types supporting hot plug include PCI, SCSI, USB, virtio-serial-bus.
Grep for qbus_set_hotplug_handler().


