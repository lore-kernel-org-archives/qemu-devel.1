Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58A5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC1C2087F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTPQs2Cf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC1C2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw77E-000361-N2
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 11:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iw76A-0002Ut-DX
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iw769-0004gk-7Y
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:18:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34143
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iw769-0004gD-3f
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580141928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3z5F/5L1XRLqZjLqch4jwuA6WwN4doiOZyvEJx6eFzw=;
 b=bTPQs2Cfgkq8ESJuDpbJ82kKmwZ8dJssQQaN1Ong0uThC1so89AE5y3rXxzl/ujxctQm+E
 td87hpJwrb6VNpEyLRwZ6jeF+ZBdo0+RdydclvRS08fdizd/0fRzHw7OS2i8i16C95apaN
 GF7nRhOGEySj2OAXjpc8Ki5OccNOqpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-RmCOp7YxMNud-erLdsZHJA-1; Mon, 27 Jan 2020 11:18:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40CD3DBF3;
 Mon, 27 Jan 2020 16:18:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-84.ams2.redhat.com
 [10.36.116.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C53A811FA;
 Mon, 27 Jan 2020 16:18:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 90B881747D; Mon, 27 Jan 2020 17:18:32 +0100 (CET)
Date: Mon, 27 Jan 2020 17:18:32 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200127161832.pp2u4lx23hiuudr6@sirius.home.kraxel.org>
References: <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org>
 <f24ff946-2c37-d7c7-ff18-d67e22aa438e@redhat.com>
 <20200127083513.hgl5ydgpn4mkuho5@sirius.home.kraxel.org>
 <20200127121311.GB5669@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200127121311.GB5669@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: RmCOp7YxMNud-erLdsZHJA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi,

> > We already have qapi schema for -blockdev + -display + -audiodev +
> > -chardev, creating a configuration struct which supports these
> > shouldn't be that much effort.  Then move over QemuOpts one by one.
>=20
> chardev-add uses a QAPI type that has too deep nesting to be user
> friendly.

Yea, right, it is relatively old and doesn't use stuff like base types
which didn't exist back then ...

> > Once config file support is complete enough we should be able to offloa=
d
> > backward compatibility command line parsing to some script which
> > transforms the cli into a config file.  Which is probably better than
> > trying to add -writeconfig to qemu as we don't have to do the string
> > processing in C then.
>=20
> If we get a launcher script anyway, I would argue that the system
> emulator binary written in C should only support JSON (like it already
> does) and the script can easily translate from YAML to JSON.

That makes sense indeed.

cheers,
  Gerd


