Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1B3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582FA20718
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWn11BEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582FA20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuzOR-0002ju-J9
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 08:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iuzNs-0002Gh-Pw
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iuzNr-0003L6-Pu
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:52:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33902
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iuzNr-0003K2-Ml
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579873946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2MbeD4UnVuga+mofxHFVDXOBd56n8t/+z4vMgB1rBLM=;
 b=hWn11BEYmMce1qW7vVN1n5zXx1x9oaMxLxSph5bvYTSFFm4raa6cWOgZIvAQxpmda0PqkT
 wVEdJJp/LPmXzOPhirXYn2k/ngRV8UMtK/mJB2XuROzAi96mJLf18Whcz1Cd35odd11svX
 J7InlMDgiazKlI/wOfU4rovTE2mZwak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-pWw8BV48Mq6zMeyVhbtpxA-1; Fri, 24 Jan 2020 08:52:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71CC4477;
 Fri, 24 Jan 2020 13:52:23 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C9515E240;
 Fri, 24 Jan 2020 13:52:14 +0000 (UTC)
Date: Fri, 24 Jan 2020 14:52:13 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)
Message-ID: <20200124135212.GF4732@dhcp-200-226.str.redhat.com>
References: <B07CB62A-7860-4385-A6A4-4ECA211DBE42@nutanix.com>
 <9F93582E-139B-45B2-8630-FDD331F09DEF@kamp.de>
 <c00fc076-3a46-7a52-a539-66751fb2943a@redhat.com>
 <6C861A00-A30A-4CED-85F7-412A13760C4B@nutanix.com>
 <20200124133919.GD4732@dhcp-200-226.str.redhat.com>
 <d6a7238c-1da2-6447-5eb6-8e0b729f239c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d6a7238c-1da2-6447-5eb6-8e0b729f239c@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: pWw8BV48Mq6zMeyVhbtpxA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Lieven <pl@kamp.de>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.01.2020 um 14:42 hat Philippe Mathieu-Daud=E9 geschrieben:
> On 1/24/20 2:39 PM, Kevin Wolf wrote:
> > Am 24.01.2020 um 11:48 hat Felipe Franciosi geschrieben:
> > > On Jan 24, 2020, at 10:04 AM, Philippe Mathieu-Daud=E9 <philmd@redhat=
.com> wrote:
> > > > Also shouldn't we report some warning in case of such invalid
> > > > request? So the management side can look at the 'malicious iSCSI
> > > > server'?
> > >=20
> > > I think having the option to do so is a good idea. There are two case=
s
> > > I can think of that you run into a "malicious" storage server:
> > > 1) Someone hacked your storage server
> > > 2) Your control plane allows your compute to connect to a user
> > > provided storage service
> > >=20
> > > Thinking as an admin, if I only allow storage servers I provide, then
> > > I want to see such warnings. If I let people point the VMM to dodgy
> > > servers, then I probably don't want the log spam.
> >=20
> > For this reason, we generally don't log things for failed I/O requests.
> > If we wanted to introduce it, we'd better find a way to do so
> > consistently everywhere and not just in a single place with a one-off
> > option.
>=20
> I'm just suggesting to use error_report().

If you do this unconditionally with an untrusted server, you allow it to
DoS you by filling up your disk with error logs.

Kevin


