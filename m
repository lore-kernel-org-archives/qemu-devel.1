Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D62C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D18620702
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApzjNP5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D18620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3pb-0006xN-PD
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iw3op-0006V0-IR
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iw3oo-0007AC-4X
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:48:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58086
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iw3oo-00078w-0u
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580129320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S/vA4a1L8trwRZ4jl+POz2rMXlDBmWX0ZA+VBe9CNCc=;
 b=ApzjNP5+QgZ6fJnvK98eNc2DLYZsf4Sn3kwpTtRBFP4PPDQez8A5/3ki8GX185Fo191ZKe
 oYKan2vN6Vv6R7hEmawp4eQI44l4U8f0C56f3uQyGttQfTAWHRUG0viS7UWlsO4RbKWOn4
 iaLZC+pyjanInlQ2opV3thSGcXQfvNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-HfFbapWWNK6fzLmam9SH2Q-1; Mon, 27 Jan 2020 07:48:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 227D91005512;
 Mon, 27 Jan 2020 12:48:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3D668CCD4;
 Mon, 27 Jan 2020 12:48:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 725071138600; Mon, 27 Jan 2020 13:48:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org>
 <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <87sgk3x2im.fsf@dusky.pond.sub.org>
 <20200127101816.GD837450@redhat.com>
Date: Mon, 27 Jan 2020 13:48:21 +0100
In-Reply-To: <20200127101816.GD837450@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Mon, 27 Jan 2020 10:18:16 +0000")
Message-ID: <871rrlqd4a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: HfFbapWWNK6fzLmam9SH2Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?M?= =?utf-8?Q?arc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Sat, Jan 25, 2020 at 11:18:41AM +0100, Markus Armbruster wrote:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > Am 24.01.2020 um 11:27 hat Daniel P. Berrang=C3=A9 geschrieben:
>> >> So if we allowed YAML instead of JSON, now we get...
>> >>=20
>> >>   $ cat qemu.yaml
[...]
>> >> This is finally something I'd consider to be on a par with the
>> >> original QEMU syntax, before we added hierarchical data. You
>> >> have the minimal possible amount of syntax here. No commas,
>> >> no quotes, no curly brackets, etc.
>> >
>> > This seems to have the same problems as the QEMU command line (how do
>> > you distinguish strings from ints, from bools, from null?).
>>=20
>> True: YAML provides only string scalars.
>
> Actually, YAML provides  strings, integers, booleans & nulls, the same
> level of typing at JSON, but with added benefit of supporting comments
> officially:
>
>   https://rollout.io/blog/yaml-tutorial-everything-you-need-get-started/

You're right.  I read section 2.3 Scalars of the YAML spec[*], and
neglected to study sections 2.4. Tags and 10.3. Core Schema.


[*] https://yaml.org/spec/1.2/spec.html


