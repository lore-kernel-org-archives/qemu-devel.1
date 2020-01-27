Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E64C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA7A2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xs0jb6p5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA7A2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw0jp-00075L-1f
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 04:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iw0j2-0006EM-Ld
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iw0j1-0004uR-HJ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:30:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33825
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iw0j1-0004u9-Df
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580117430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8qQEoVc90IvNK0heKBo9u7gbCx2sjaWXLgrPyrdNag=;
 b=Xs0jb6p5ooof0bexv0vTyaSqgSvqR2NSWYa7lvRopsLEBmKvzyYKDfyM2o0qxTpzBmVv1a
 vZ0Ps5U3ftlPAMuJ7oxJdFB8q0Z3BsQgLsI0FpE2dD98RPwDgX4Xo8Gszrq21a2bM9mtGj
 JVXwbjvyH9pRuz8ZGhelGampVKamgMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-qFRf-g7hPhyg4O4-V6ko8w-1; Mon, 27 Jan 2020 04:30:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 416C8113784E;
 Mon, 27 Jan 2020 09:30:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1305863D3;
 Mon, 27 Jan 2020 09:30:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 31C071138600; Mon, 27 Jan 2020 10:30:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
 <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <CABgObfZUNcDza=yMG5i4SvYs0WHwRCW_yCNkHeKsYjYAhoLZuA@mail.gmail.com>
Date: Mon, 27 Jan 2020 10:30:16 +0100
In-Reply-To: <CABgObfZUNcDza=yMG5i4SvYs0WHwRCW_yCNkHeKsYjYAhoLZuA@mail.gmail.com>
 (Paolo Bonzini's message of "Sat, 25 Jan 2020 18:18:43 +0100")
Message-ID: <87y2ttqmaf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qFRf-g7hPhyg4O4-V6ko8w-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il mer 15 gen 2020, 10:21 Markus Armbruster <armbru@redhat.com> ha scritt=
o:
>
>> > We don=E2=80=99t want the QAPI to let arbitrary fields of a QOM object
>> > be modified, do we?
>>
>> We already do: QMP command qom-set.  If it breaks your guest, you get to
>> keep the pieces.
>>
>
> That's not true. We chose not to make that a "recommended" interface, and
> instead we add new commands. However that's mostly to avoid tying our han=
ds
> and not making too much of QOM part of the API. But I would be very
> surprised if a guest could be broken with qom-set.
>
> This was definitely not the case when QOM was introduced in a half-baked
> state, but let's not indulge in self-flagellation more than it's actually
> necessary.

Nobody thinks of qom-set when adding a QOM property.

qom-set runs a setter function that can do anything.  Is that safe at
any point of time?  Depends.

Fortunately, most setters merely write to some object instance variable.

Often, the object's code reads the instance variable only in realize(),
and never writes to it.  qom-set is safe then, but not terribly useful.

More interesting are the ones that are read and written throughout the
object's life cycle.  Is qom-set safe at any point of time?  Depends.

Your belief qom-set can't break a guest in practice is reassuring.

However, the point I was trying to make with "you get to keep the
pieces" is precisely that we're "not making too much of QOM part of the
API".

An additional point I'd like to repeat now: which parts of QOM are is
pretty much anybody's guess.


