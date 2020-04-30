Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0CEC83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2532D206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWqGutiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2532D206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUA4o-0004rk-7e
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:22:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU9wy-0008CO-Si
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU9uz-00063k-Rk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:14:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23802
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jU9uz-0005rQ-9S
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588255920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCYgu2Tytgiflw4L7xnoTHld9xJTsTsMcJN/BMkErh8=;
 b=CWqGutiqLyZfDMkESR/TjAZFizXHR6vG3C2UZww41gAblS9KmcWNMi6y234iqvRrPnTDCw
 Q2cysBhLiv+7B910DRY9M2TNS6q42qxXLjepk9AVWP9sDXm/4x1fc3u/DoV8RjBpwdraId
 3+mDIXFzmHmmQbQkyeQ9HEjpClf6VhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-pNP7fNH3M8y3pF6Li5vZoQ-1; Thu, 30 Apr 2020 10:11:57 -0400
X-MC-Unique: pNP7fNH3M8y3pF6Li5vZoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89161107ACF2;
 Thu, 30 Apr 2020 14:11:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A24E25C1B0;
 Thu, 30 Apr 2020 14:11:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2D40811358BC; Thu, 30 Apr 2020 16:11:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: Configuring onboard devices
References: <87mu6uia5i.fsf@dusky.pond.sub.org>
 <20200429155719.GL1495129@redhat.com>
 <87k11xh2kq.fsf@dusky.pond.sub.org>
 <CAFEAcA9-oxkMD-kJ1z12d4K1S_Jaz7Wj6_38Ah7ChSaBfQNkkA@mail.gmail.com>
 <87tv11e1en.fsf_-_@dusky.pond.sub.org>
 <51a4e9ea-eca3-6c1d-a753-86c5810ac094@ilande.co.uk>
Date: Thu, 30 Apr 2020 16:11:52 +0200
In-Reply-To: <51a4e9ea-eca3-6c1d-a753-86c5810ac094@ilande.co.uk> (Mark
 Cave-Ayland's message of "Thu, 30 Apr 2020 11:29:05 +0100")
Message-ID: <874kt1dpw7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 30/04/2020 11:03, Markus Armbruster wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>=20
>>> On Thu, 30 Apr 2020 at 08:09, Markus Armbruster <armbru@redhat.com> wro=
te:
>>>> Our means to configure onboard devices are weak.  We sidestepped this
>>>> for isa-fdc by taking it off the board, and thus make -device work.
>>>
>>> This seems to be a general dynamic: the x86 pc machine works
>>> via -device options (or is changed so it can work that way);
>>> and then people propose dropping/deprecating/etc the config
>>> options that work with onboard devices, without providing
>>> clear solutions/instructions on how the command line needs
>>> to change/etc for the mass of boards which are not the x86
>>> pc machine and which do have a lot of onboard devices which
>>> can't be handled via -device.
>>>
>>> So my gut reaction to the "we should deprecate -global"
>>> suggestions in this thread was a bit "here we go again"...
>>> What works for x86 or even "what is sufficient for libvirt"
>>> doesn't necessarily cover all the cases.
>>=20
>> Such shortsighted proposals have been made, but don't think it's what
>> we're doing here.
>>=20
>> You're 100% right in that we do need to configure onboard devices.
>> -global is a terrible way to do it, though: it applies to *all* devices
>> of a kind.  What if the board has more than one?  What if the can add
>> more?
>>=20
>> Taking onboard devices off the board can occasionally sidestep the
>> issue.  For isa-fdc, we genuinely *wanted* to take the damn thing off,
>> because all it did for most users was provide them with VENOM.  Not
>> needing -global for it anymore was just a nice bonus.
>>=20
>> Taking onboard devices off just to reduce the device configuration
>> problem to a solved one, namely -device, may be tempting (it was to me),
>> but it's too intrusive to be practical at scale.
>>=20
>> Adding machine properties that alias onboard device properties is less
>> intrusive.  The ones I added were still a lot of work.
>>=20
>> Configuring onboard devices via machine properties restricts property
>> access to the ones we added to the machine.  This differs from pluggable
>> devices, where users can access all properties.
>>=20
>> Any better ideas for letting users configure onboard devices?
>
> Is it possible to let machine owners add alias properties to the machine =
object
> referencing in-built devices? I could then instantiate my on-board nic in=
 the machine
> init() function, and then use object_property_add_alias() to add a "nic0"=
 alias on
> the machine that can be used to wire it up to a netdev using the command =
line.

Have a look at hw/arm/virt.c's virt_flash_create(), from commit
e0561e60f1 "hw/arm/virt: Support firmware configuration with -blockdev".
It adds machine properties "pflash0" and "pflash1" as aliases for the
onboard flash memory devices' property "drive".

Does this answer your question?


