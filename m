Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AEAC33C9B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068122073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVfMtYRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068122073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iot3d-0003yj-JD
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1iot2f-0002qz-Px
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1iot2e-0005PH-8d
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:53:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21264
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1iot2e-0005Ou-40
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578419599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Agm6cHpXBZSF9FASiNHmNNt/eL7QtD3NEQPTlhpHRZk=;
 b=jVfMtYRFJ7hXTNUQjKEvWVKwWqxnFDkA+IzWFPU1KJ5S9gaMvZsyTtKOGbgNFoEswV3UQo
 qIUpakHQZCw8/DNv7S5DoBUH9jbQcxiRlvfXzt0J5SvqHMB+I9lTTYkeRyGPx218t9prD/
 C9FDjrzIDlD4jOoGrpDY0OlrMNJLsQA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-SUliREoOMPePZdMQBoSphw-1; Tue, 07 Jan 2020 12:53:18 -0500
Received: by mail-wr1-f70.google.com with SMTP id c17so258876wrp.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 09:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=3Pv4Ui5Z1GHqGX5/OYb3Y5a+vVsllIK07MhUGf4v77s=;
 b=r2BquLmBB0uZu4YKvDfx/VFaZ+rQR/mKd1uarJ+sJqpcH6iDPv2PA/GzyuSdCw5BgM
 UHxQhRuxpFYf96WtU13hh6GQ/hwSKKjj3XGyR/B/A4H0h2E7FNzQqr55W0kk4L1SWp2N
 yL1+SEc10QSJsSgclLxFwHwDA1FpcgQz/dEFIesS/fPHy7As6LC9xR+8NhqbKqQ4IocQ
 FMfXzSyKdYbhyB2DG+fEqga7OcH0+zqB5j7YIWaBPgjFDTezdP83GGmtBt3wRmB+HkQ1
 KBs+E7fyp8ubpyKZoC03lwdHifDfnkVMn6izuWuL9daN0LYFpCkXSs2Gd4s6FDiLQWeW
 cVkQ==
X-Gm-Message-State: APjAAAXK0QHEoxzFV/7U9pwvsiy161QUwxoaNh8Xm6WQWSpC8G+U+8BF
 nQmqk5fRvw6DfEaMpOoNxYLUn/tMH0HmFWp99mPvjg+AerKZcTKCMZOtCyZJEDaxDQwHIZpQIIc
 qWg9f6C+S+rHZVs8=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr214369wrj.325.1578419596966; 
 Tue, 07 Jan 2020 09:53:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzTZdpxAArzUn4K4oOihVX7lpHYd3JUsdPdbEHSvX4MmMfa12GO/Ajf9laMAuv5e3OxziRRXQ==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr214333wrj.325.1578419596655; 
 Tue, 07 Jan 2020 09:53:16 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:8d4b:4003:dcb:4c70?
 ([2a01:e0a:466:71c0:8d4b:4003:dcb:4c70])
 by smtp.gmail.com with ESMTPSA id v83sm422831wmg.16.2020.01.07.09.53.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jan 2020 09:53:15 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Making QEMU easier for management tools and applications
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <20200107125745.GJ4076@linux.fritz.box>
Date: Tue, 7 Jan 2020 18:53:13 +0100
Message-Id: <AE6AD21A-0DAD-4589-BAC0-C203B6F8A0D9@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <c445ecbe-1559-462a-31c2-f44f60e60a8b@redhat.com>
 <20200107093655.GF4076@linux.fritz.box>
 <d18b8c0f-3054-dd63-0d10-dda6d0655175@redhat.com>
 <20200107125745.GJ4076@linux.fritz.box>
To: Kevin Wolf <kwolf@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: SUliREoOMPePZdMQBoSphw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michal Privoznik <mprivozn@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 7 Jan 2020, at 13:57, Kevin Wolf <kwolf@redhat.com> wrote:
>=20
> Am 07.01.2020 um 11:55 hat Michal Privoznik geschrieben:
>> On 1/7/20 10:36 AM, Kevin Wolf wrote:
>>> The easy way out would be tying libvirt to a specific QEMU version. And
>>> I'm only half joking.
>>>=20
>>> If libvirt didn't exist yet and we needed a management library for QEMU=
,
>>> what we would build now would probably not look much like libvirt looks
>>> today. We wouldn't try to have basic support for every hypervisor out
>>> there, but integrate it much closer with QEMU and avoid much of the
>>> backwards compatibility requirements that the interface between QEMU an=
d
>>> libvirt has (which requires us to deal with compatibility twice for
>>> everything).
>>=20
>> By doing this, you would force your consumers to implement compatibility
>> layer each on their own. Freshly finished blockdev is a beautiful exampl=
e -
>> OpenStack, oVirt and whatnot - they all are/can use blockdev without eve=
n
>> noticing, because the API provided by libvirt is stable and provides
>> abstraction, i.e. you don't need to change anything in your domain XML t=
o
>> use blockdev.
>=20
> Yes and no.
>=20
> You could still keep using the same abstraction that libvirt has always
> used while doing this. What my imaginary newly written management
> library would do differently isn't necessarily the interface between
> libvirt and applications, but getting rid of backwards compatibility
> requirements in the interface between QEMU and libvirt.
>=20
> But of course, blockdev isn't even a feature per se. It's getting the
> abstraction right so that it's actually abstract enough to represent
> everything. As long as libvirt keeps using an abstraction that is based
> on simplistic setups, it won't be able to expose the full feature set of
> QEMU. This is less than satisfying. In the long run, libvirt will have
> to extend its abstraction to make full use of new features either way.
>=20
>> Of course, you can apply the argument one more time and have mgmt
>> application tied to a specific version of qemu. But even that is not
>> good enough, because with backports version is just meaningless
>> number.
>=20
> I think this would be too much indeed.
>=20
>>> Maybe it would even be part of the QEMU repository, allowing a single
>>> patch series to implement a new feature in the system emulator and
>>> expose it in the API immediately instead of waiting for the next QEMU
>>> release before libvirt can even think about implementing support for it=
.
>>=20
>> Thing is, it's not just qmp that a mgmt application has to master, it's =
also
>> process managing (and with growing number of helper binaries this is not=
 as
>> trivial as fork() + exec()). This would need to be the bare minimum your=
 API
>> layer has to provide to be consumable by anybody.
>> But then you have some advanced subsystems to take care of (CGroups,
>> SELinux, etc.) which are used heavily by OpenStack. oVirt and friends.
>=20
> Someone has to do this anyway. Note that here I'm still talking about
> the hypothetical case where no libvirt existed yet.
>=20
> If we cared only about OpenStack, oVirt and friends, this would still
> all be QEMU-based, so not a big problem to have it tied to QEMU.
>=20
> I'm not sure what this looks like in practice in libvirt: Are these
> components shared between multiple hypervisor interfaces or is it only
> for QEMU anyway?
>=20
> If multiple hypervisors make use of it, how crazy would it be to imagine
> reversing which project consumes which? Instead of having the libvirt
> core consume the hypervisor-specific sublibraries, could a QEMU-specific
> part live closer to QEMU and consume the libvirt core as an external
> library?
>=20
> I guess much of what I write in this thread is pure heresy. :-)
> Maybe most of it isn't even useful. But maybe there is an idea or two in
> it that are worth having a closer look at.

Well, I don=E2=80=99t know if it is heresy, but at least as far as sandboxi=
ng / jailing
is concerned, I suggested something similar in earlier iterations of
the discussion. My way to say that I am part of your heresy, I guess.

>=20
>>> So should libvirt move in that direction? Do people actually still make
>>> much use of its multi-hypervisor nature, or would it make sense to spli=
t
>>> it into separate libraries for each hypervisor that can be much tighter
>>> integrated with (a specific version of) the respective hypervisor?
>>=20
>> Truth to be told, I don't think libvirt is held back by its attempts to
>> provide hypervisor agnostic APIs. Sure, it leads to some weirdness (e.g.
>> different naming in libvirt and qemu), but as a libvirt developer I don'=
t
>> remember feeling blocked by this multi-hypervisor nature (not to mention
>> that this has saved us couple of times).
>=20
> I would imagine so, because the problem doesn't become visible in the
> daily work, but only in the bigger picture: The other hypervisors are
> what prevent libvirt from being more tightly intergrated with QEMU.
>=20
> This means that there is a boundary between QEMU and libvirt that makes
> it really slow to get new features to the user. And both QEMU and
> libvirt waste a lot of time for maintaining backwards compatibility in
> things that wouldn't necessarily have to be stable interfaces if the
> management library were developed in lockstep with QEMU.
>=20
>> Also, it would be not correct to think that a feature is implemented for=
 all
>> hypervisors in libvirt. I mean, when implementing a feature I usually
>> implement it only for qemu driver and don't even look at other drivers
>> (unless I'm doing a change in a core that causes build failures). On the
>> other hand, I do sometimes review patches posted by developers from othe=
r
>> companies which have interest in different hypervisors (e.g. there is a =
SUSE
>> guy working on LXC driver, and another SUSE guy working on libxenlight
>> (basically Xen)), so I do spend some time not working on qemu driver, bu=
t
>> I'd say it's negligible.
>=20
> Time spent on non-QEMU isn't really my concern. Time spent maintaining
> stable interface between QEMU and libvirt, and time spent waiting for
> QEMU releases before libvirt development starts are my concern.
>=20
> Kevin


