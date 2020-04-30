Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B863DC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8537420731
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emuyDsvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8537420731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUB5V-0001HF-IP
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 11:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jUB2f-00069E-PZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jUAzI-00079v-51
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:24:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49108
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUAzH-00075f-Ik
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588260030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGTCzf8W1nJGIJ2uBeK3E1bPOEIARTXkjExvDTW58kQ=;
 b=emuyDsvEwcec8e4nGoNruUZwMw2+Llc5ZOBHoB1o+bXHkGAzXCJHF2b5CVNmBFjYpZFfyC
 kIT69hZa2Bkwd7qV039baHL83zmHks5Zrjyz8/X/RQw+Yi7xLEIvzEIpMXEqr+f7iC48ES
 CeMfU/lcf2AAALZIDySCIjY6H0osyxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-cTDrBbqXMRuJJ_MLGFhT1w-1; Thu, 30 Apr 2020 11:20:28 -0400
X-MC-Unique: cTDrBbqXMRuJJ_MLGFhT1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F838107ACF2;
 Thu, 30 Apr 2020 15:20:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83F9D60CD0;
 Thu, 30 Apr 2020 15:20:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B6B3911358BC; Thu, 30 Apr 2020 17:20:05 +0200 (CEST)
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
Date: Thu, 30 Apr 2020 17:20:05 +0200
In-Reply-To: <c1fa0770-a07f-e5bc-9db8-6af0576c365f@ilande.co.uk> (Mark
 Cave-Ayland's message of "Thu, 30 Apr 2020 15:32:31 +0100")
Message-ID: <877dxxc862.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

> On 30/04/2020 15:11, Markus Armbruster wrote:
>
>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>>=20
>>> On 30/04/2020 11:03, Markus Armbruster wrote:
>>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>>
>>>>> On Thu, 30 Apr 2020 at 08:09, Markus Armbruster <armbru@redhat.com> w=
rote:
>>>>>> Our means to configure onboard devices are weak.  We sidestepped thi=
s
>>>>>> for isa-fdc by taking it off the board, and thus make -device work.
>>>>>
>>>>> This seems to be a general dynamic: the x86 pc machine works
>>>>> via -device options (or is changed so it can work that way);
>>>>> and then people propose dropping/deprecating/etc the config
>>>>> options that work with onboard devices, without providing
>>>>> clear solutions/instructions on how the command line needs
>>>>> to change/etc for the mass of boards which are not the x86
>>>>> pc machine and which do have a lot of onboard devices which
>>>>> can't be handled via -device.
>>>>>
>>>>> So my gut reaction to the "we should deprecate -global"
>>>>> suggestions in this thread was a bit "here we go again"...
>>>>> What works for x86 or even "what is sufficient for libvirt"
>>>>> doesn't necessarily cover all the cases.
>>>>
>>>> Such shortsighted proposals have been made, but don't think it's what
>>>> we're doing here.
>>>>
>>>> You're 100% right in that we do need to configure onboard devices.
>>>> -global is a terrible way to do it, though: it applies to *all* device=
s
>>>> of a kind.  What if the board has more than one?  What if the can add
>>>> more?
>>>>
>>>> Taking onboard devices off the board can occasionally sidestep the
>>>> issue.  For isa-fdc, we genuinely *wanted* to take the damn thing off,
>>>> because all it did for most users was provide them with VENOM.  Not
>>>> needing -global for it anymore was just a nice bonus.
>>>>
>>>> Taking onboard devices off just to reduce the device configuration
>>>> problem to a solved one, namely -device, may be tempting (it was to me=
),
>>>> but it's too intrusive to be practical at scale.
>>>>
>>>> Adding machine properties that alias onboard device properties is less
>>>> intrusive.  The ones I added were still a lot of work.
>>>>
>>>> Configuring onboard devices via machine properties restricts property
>>>> access to the ones we added to the machine.  This differs from pluggab=
le
>>>> devices, where users can access all properties.
>>>>
>>>> Any better ideas for letting users configure onboard devices?
>>>
>>> Is it possible to let machine owners add alias properties to the machin=
e object
>>> referencing in-built devices? I could then instantiate my on-board nic =
in the machine
>>> init() function, and then use object_property_add_alias() to add a "nic=
0" alias on
>>> the machine that can be used to wire it up to a netdev using the comman=
d line.
>>=20
>> Have a look at hw/arm/virt.c's virt_flash_create(), from commit
>> e0561e60f1 "hw/arm/virt: Support firmware configuration with -blockdev".
>> It adds machine properties "pflash0" and "pflash1" as aliases for the
>> onboard flash memory devices' property "drive".
>>=20
>> Does this answer your question?
>
> Ah I see now, these aliases are for individual properties rather than obj=
ects. What I
> was trying to ask was if it were possible to have something like this:
>
> /machine (SS-5-machine)
>   /builtin
>     /nic0 -> link to "lance" device
>
> Here nic0 is an alias "published" by the maintainer of the SS-5 machine w=
hich is
> configured in the machine init() function using object_property_add_link(=
) or a
> suitable wrapper. Users can then configure these builtin devices from the=
 command
> line using your -machine nic0.netdev=3Dmy-netdev-id syntax or similar.

Got it now, thanks!

> Having the default devices under /builtin or other known QOM path would e=
nable
> builtin devices to be easily enumerated programatically and/or from the c=
ommand line
> as required.

There are three standard containers under /machine/:

* /machine/peripheral/

  Devices with a user-specified ID go here, as /machine/peripheral/ID.
  User-specified means -device or device_add.

  /machine/peripheral/ID is effectively a stable interface.  It's just
  underdocumented (undocumented?).

  To be useful, the stuff below ID/ needed to be stable and documented,
  too.

* /machine/peripheral-anon/

  Same, but user elected not to give an ID.
  /machine/peripheral-anon/device[N], where N counts up from zero in
  creation order.

  N is obviously not stable, but this is a problem of the user's making.
  If you want to refer to a device, give it an ID.

* /machine/unattached/

  The orphanage.  When a device has no parent when its realized, it gets
  put here, as /machine/unattached/device[N], where N counts up from
  zero in realization order.

  N is obviously not stable, and this time we can't blame the
  victim^Wuser.  You can search for devices of a certain type.
  Sometimes that's good enough.

  All the onboard devices are here, and much more.  We've fathered a lot
  of unloved red-headed children, it seems...

  Some of the "much more" is due to sloppy modelling, i.e. neglecting to
  set the proper parent.

  I figure we could put onboard devices in a nicer place, with nicer
  names.  Need a convention for the place and the names, then make board
  code conform to it.


