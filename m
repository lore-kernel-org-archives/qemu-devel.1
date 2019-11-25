Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ED3C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4FDB20674
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjAI8P0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FDB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGes-0003LT-0j
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iZGUS-0001NE-75
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iZGUQ-000404-Sn
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:41:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43175
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iZGUQ-0003zu-N0
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574696485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQaWVzVZ1B0SYZALfmP07G1f0YhKQp+DvqYddSJHQww=;
 b=WjAI8P0nb8B69L59in4GOLdvyRN5/hX7lggU/DDMU1c9ncORkE82ePIsXgRI28wm9BFuz/
 UAkO3iajLjMTx5RpeBdn8arM/hYgaCGHPgku4HU4NCuZ4CRzIYai/wtMuuCrxsDNoNFvvy
 03uf6qWQxMMOVBrGzQHGkEFElbcKgUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-uBBMN1BjOb2SWP8XoIAJUw-1; Mon, 25 Nov 2019 10:41:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 689F18C7B88
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 15:41:23 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FAFF60872
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 15:41:23 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 4F4014BB65;
 Mon, 25 Nov 2019 15:41:23 +0000 (UTC)
Date: Mon, 25 Nov 2019 10:41:22 -0500 (EST)
From: Cleber Rosa <crosa@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <576589940.13717697.1574696482968.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191125141553.kb6y2zx2qlley27p@sirius.home.kraxel.org>
References: <9b3b2ff0-a3bb-c7ba-d7ce-d178e8fbd5d8@redhat.com>
 <20191125135802.GH4438@habkost.net>
 <20191125141553.kb6y2zx2qlley27p@sirius.home.kraxel.org>
Subject: Re: Avocado notes from KVM forum 2019
MIME-Version: 1.0
X-Originating-IP: [10.10.120.170, 10.4.195.26]
Thread-Topic: Avocado notes from KVM forum 2019
Thread-Index: ni5m7z/lf5Q8hLLshQd3zofGRiFSPA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: uBBMN1BjOb2SWP8XoIAJUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: avocado-devel@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Gerd Hoffmann" <kraxel@redhat.com>
> To: "Eduardo Habkost" <ehabkost@redhat.com>
> Cc: avocado-devel@redhat.com, "Philippe Mathieu-Daud=C3=A9" <philmd@redha=
t.com>, "qemu-devel" <qemu-devel@nongnu.org>,
> "Wainer dos Santos Moschetta" <wainersm@redhat.com>, "Cleber Rosa" <crosa=
@redhat.com>
> Sent: Monday, November 25, 2019 9:15:53 AM
> Subject: Re: Avocado notes from KVM forum 2019
>=20
> > > 1) Working offline
> > >=20
> > > Various people complained Avocado requires online access, and they wo=
uld
> > > like to use it offline.
> > >=20
> > >   Maintainer workflow example is:
> > >=20
> > >   - run avocado
> > >   - hack QEMU, build
> > >   - git pull
> > >   - build
> > >   - hack QEMU
> > >   (go offline)
> > >   - hack QEMU
> > >   - build
> > >   - run avocado <- FAILS
> > >=20
> >=20
> > Ouch.  This shouldn't happen even with no explicit --offline
> > option.  Failure to download artifacts shouldn't make tests
> > report failure.
>=20
> Related (and already discussed in the past):  There should be a separate
> "downloads artifacts", especially for larger ones which easily fail to
> download on slower internet links due to hitting the test timeout while
> downloading ...
>=20

Hi Gerd,

We listened to you :) and that's an Avocado 73.0 feature (released Friday,
very first bullet point item):

  https://avocado-framework.readthedocs.io/en/73.0/releases/73_0.html

It doesn't cover all use cases, but works as expected for QEMU.  I'm just
waiting the end of the code freeze to bump the Avocado version and have
that in by default.

Thanks!
- Cleber.

> cheers,
>   Gerd
>=20
>=20
>=20


