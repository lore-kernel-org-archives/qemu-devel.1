Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39087C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 08:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F373020707
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 08:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUJUi5w6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F373020707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixRNl-0003FK-5p
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 03:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ixRMj-0002fN-Al
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 03:09:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ixRMi-0007TG-0z
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 03:09:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32792
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ixRMh-0007Su-U9
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 03:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580458163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yClRdQKmckDNZu4U0nJwi9u0XzrjNGwdpKr59+rw2c0=;
 b=JUJUi5w6NVTkI2H6GCfnkyHsMiZVGyN305cAw0RwDKoO3YZDmLr7NN60pu+bYz6ZIkFzlu
 tNqGrzlt+1PK0ueMm2kjVKo9gCQ61t3h8CP7s2MkjcEFrY5vVc9GNQZl9zcQw7oRMG0sCh
 fRNm9106bpnSq7sRs/FAacBn6BI2JaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-KXP3Y83pMeKIAbInicQm5A-1; Fri, 31 Jan 2020 03:09:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2031A8017CC;
 Fri, 31 Jan 2020 08:09:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 227961001B05;
 Fri, 31 Jan 2020 08:09:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AC38F1138404; Fri, 31 Jan 2020 09:09:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org>
 <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <87sgk3x2im.fsf@dusky.pond.sub.org>
 <20200127115606.GA5669@linux.fritz.box>
 <1c65b678-7bb4-a4cc-5fa6-03d6d27cf381@redhat.com>
 <20200128102855.GA6431@linux.fritz.box>
 <87mua7bvwf.fsf@dusky.pond.sub.org>
 <20200128125409.GF6431@linux.fritz.box>
 <878sloi0fp.fsf@dusky.pond.sub.org>
 <e52f0561-5094-cacc-846e-086bad840f56@redhat.com>
Date: Fri, 31 Jan 2020 09:09:10 +0100
In-Reply-To: <e52f0561-5094-cacc-846e-086bad840f56@redhat.com> (Paolo
 Bonzini's message of "Fri, 31 Jan 2020 08:48:03 +0100")
Message-ID: <878slof3o9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: KXP3Y83pMeKIAbInicQm5A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 31/01/20 07:50, Markus Armbruster wrote:
>>>> Consider chardev-add.  Example:
>>>>
>>>>     {"execute": "chardev-add",
>>>>      "arguments": {"id": "bar",
>>>>                    "backend": {"type": "file",
>>>>                                "data": {"out": "/tmp/bar.log"}}}}
>>>>
>>>> The arguments as dotted keys:
>>>>
>>>>     id=3Dbar,backend.type=3Dfile,backend.data.out=3D/tmp/bar.log
>>>>
>>>> Observe there's quite some of nesting.  While that's somewhat cumberso=
me
>>>> in JSON, it's a lot worse with dotted keys, because there nesting mean=
s
>>>> repeated key prefixes.  I could give much worse examples, actually.
>>> This is true, but even without the repeated keys (e.g. in a syntax that
>>> would use brackets), it would still be unnecessarily verbose and
>>> probably hard to remember:
>>>
>>>     id=3Dbar,backend=3D{type=3Dfile,data=3D{out=3D/tmp/bar.log}}
>> No argument.  It's unnecessarily verbose in JSON, too.
>>=20
>
> I think we should be able to switch chardevs to -object/object_add these
> days.  Not right now, but it may be possible.

Intriguing idea.  Would avoid the ugliness of chardev-add-2.

>                                                Introducing a warning
> when chardev and object ids conflict would be a start.

Yes.

Perhaps even any kind instead of just chardev and object IDs.


