Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6C2C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 05:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3604E21775
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 05:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxBS12N3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3604E21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUl0V-0005Vg-At
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 01:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUkzn-0003Nw-R8
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jUkzm-0004Et-DR
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:47:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59755
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUkzl-0004EZ-TL
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588398444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YmqIadLU7xFa40KlmxmvWlPqbfaLd1zR64KZ1eZE5Q=;
 b=BxBS12N3vcaPWRVRRMUZ7lXGVbLaPqgUdoN2X0T9eJHIClharAsSAsXC9QYIMxO/dBP5e6
 dxSoMX9tPvysfyBHD+SpSO+Nreaf53lGvXBXJbPI+u18+7jiUGcCgOAxqsmYjGizwmMrZS
 z+kVwnUr4F9XaftxmscKrXvPNOQbZRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-ML5WbolXNMOO3D8Nrbm5GA-1; Sat, 02 May 2020 01:47:22 -0400
X-MC-Unique: ML5WbolXNMOO3D8Nrbm5GA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76D4C107ACCD;
 Sat,  2 May 2020 05:47:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FA632B4D7;
 Sat,  2 May 2020 05:47:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D91CF11358BC; Sat,  2 May 2020 07:47:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: Configuring onboard devices
References: <87mu6uia5i.fsf@dusky.pond.sub.org>
 <20200429155719.GL1495129@redhat.com>
 <87k11xh2kq.fsf@dusky.pond.sub.org>
 <CAFEAcA9-oxkMD-kJ1z12d4K1S_Jaz7Wj6_38Ah7ChSaBfQNkkA@mail.gmail.com>
 <87tv11e1en.fsf_-_@dusky.pond.sub.org>
 <51a4e9ea-eca3-6c1d-a753-86c5810ac094@ilande.co.uk>
 <874kt1dpw7.fsf@dusky.pond.sub.org>
 <c1fa0770-a07f-e5bc-9db8-6af0576c365f@ilande.co.uk>
 <877dxxc862.fsf@dusky.pond.sub.org>
 <0b745eed-841e-8879-c320-3166e2a46953@ilande.co.uk>
Date: Sat, 02 May 2020 07:47:16 +0200
In-Reply-To: <0b745eed-841e-8879-c320-3166e2a46953@ilande.co.uk> (Mark
 Cave-Ayland's message of "Thu, 30 Apr 2020 17:56:04 +0100")
Message-ID: <87imhe6g7v.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 01:06:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 30/04/2020 16:20, Markus Armbruster wrote:
>
>>> Ah I see now, these aliases are for individual properties rather than o=
bjects. What I
>>> was trying to ask was if it were possible to have something like this:
>>>
>>> /machine (SS-5-machine)
>>>   /builtin
>>>     /nic0 -> link to "lance" device
>>>
>>> Here nic0 is an alias "published" by the maintainer of the SS-5 machine=
 which is
>>> configured in the machine init() function using object_property_add_lin=
k() or a
>>> suitable wrapper. Users can then configure these builtin devices from t=
he command
>>> line using your -machine nic0.netdev=3Dmy-netdev-id syntax or similar.
>>=20
>> Got it now, thanks!
>>=20
>>> Having the default devices under /builtin or other known QOM path would=
 enable
>>> builtin devices to be easily enumerated programatically and/or from the=
 command line
>>> as required.
>>=20
>> There are three standard containers under /machine/:
>>=20
>> * /machine/peripheral/
>>=20
>>   Devices with a user-specified ID go here, as /machine/peripheral/ID.
>>   User-specified means -device or device_add.
>>=20
>>   /machine/peripheral/ID is effectively a stable interface.  It's just
>>   underdocumented (undocumented?).
>>=20
>>   To be useful, the stuff below ID/ needed to be stable and documented,
>>   too.
>>=20
>> * /machine/peripheral-anon/
>>=20
>>   Same, but user elected not to give an ID.
>>   /machine/peripheral-anon/device[N], where N counts up from zero in
>>   creation order.
>>=20
>>   N is obviously not stable, but this is a problem of the user's making.
>>   If you want to refer to a device, give it an ID.
>>=20
>> * /machine/unattached/
>>=20
>>   The orphanage.  When a device has no parent when its realized, it gets
>>   put here, as /machine/unattached/device[N], where N counts up from
>>   zero in realization order.
>>=20
>>   N is obviously not stable, and this time we can't blame the
>>   victim^Wuser.  You can search for devices of a certain type.
>>   Sometimes that's good enough.
>>=20
>>   All the onboard devices are here, and much more.  We've fathered a lot
>>   of unloved red-headed children, it seems...
>>=20
>>   Some of the "much more" is due to sloppy modelling, i.e. neglecting to
>>   set the proper parent.
>>=20
>>   I figure we could put onboard devices in a nicer place, with nicer
>>   names.  Need a convention for the place and the names, then make board
>>   code conform to it.
>
> That's good, it seems that this is already fairly close to how it works f=
or -device
> at the moment.
>
> I don't think that it is possible to come up a single place for on-board =
devices to
> live directly though. Going back to one of my first examples: wiring up a=
 chardev to
> a serial port on the macio device. To me it makes sense for that to exist=
 in QOM
> under /machine/pci-bus/mac-io/escc. In contrast an in-built NIC could liv=
e under
> /machine/pci-bus/in-built/nic, and placing one or both of these devices d=
irectly
> under /machine/foo doesn't feel intuitive.

I'm not familiar with this machine.  You make me suspect the serial
thingy is a component of a larger device.

Properly modelled, a composite device has its components as children.
These appear below their parent in the QOM composition tree.

Example: a "serial-isa" device has a "serial" component.  When the
former is at /machine/unattached/device[28]/, the latter is at
/machine/unattached/device[28]/serial/.

I guess that's what you want for macio's serial port.

Counter-example: a "isa-super-io" device has compoenents of type
"isa-parallel", "isa-serial", "isa-fdc", "i8042", "isa-ide".
Nevertheless, these appear next to their parent in /machine/unattached/.
I'm still too much of a QOM ignoramus to explain why that's so.  Paolo,
can you?

> AFAIK as per your ARM virt example I believe it is only possible to regis=
ter an alias
> for a property rather than for an Object? The ultimate aim would be for
> object_resolve_path("/machine/builtin/nic0") and
> object_resolve_path("/machine/pci-bus/in-built/nic") to return the same O=
bject, and
> for the aliases on built-in devices to be children of /machine/builtin to=
 allow easy
> iteration and introspection.

Paolo, could link properties achieve that?

Mark, I guess you want the alias / link from builtin/nic0 to the actual
place to simplify configuration: the user then needs to know less about
the board.  Correct?


