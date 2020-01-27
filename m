Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518C6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF7B214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObalJ3F4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF7B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw30f-0000QB-C7
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 06:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iw303-0008RW-HV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iw302-0008KM-3Y
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:56:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60999
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iw301-0008K7-QA
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580126172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXtLu6tNTYnVbDY0pNesqp5p6Ys5Z4M7dK4Psle82os=;
 b=ObalJ3F4rvsubX2bHFSnEOvJ6l3+D7MHSiq2uuM1BnPYF4NPbP802RW1CM8+a4guC+wWiM
 5PSkqUPp9SEU4hzRwar3sqeTNMz1pPepxQ5ch4F2GRXSr8h5PdOT3kngZIJUCU1WJ54nQO
 Y+M899nOfv6DyE1FAYxO0Frea9KaP+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-frlDbaOQNNKqOlkpO-WPbA-1; Mon, 27 Jan 2020 06:56:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13B2A184BBD8;
 Mon, 27 Jan 2020 11:56:10 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C78F85735;
 Mon, 27 Jan 2020 11:56:07 +0000 (UTC)
Date: Mon, 27 Jan 2020 12:56:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200127115606.GA5669@linux.fritz.box>
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
MIME-Version: 1.0
In-Reply-To: <87sgk3x2im.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: frlDbaOQNNKqOlkpO-WPbA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.01.2020 um 11:18 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 24.01.2020 um 11:27 hat Daniel P. Berrang=E9 geschrieben:
> >> This is finally something I'd consider to be on a par with the
> >> original QEMU syntax, before we added hierarchical data. You
> >> have the minimal possible amount of syntax here. No commas,
> >> no quotes, no curly brackets, etc.
> >
> > This seems to have the same problems as the QEMU command line (how do
> > you distinguish strings from ints, from bools, from null?).
>=20
> True: YAML provides only string scalars.
>=20
> TOML provides strings, integers, floats, booleans, and several flavors
> of time.  It lacks null.
>=20
> >                                                             It's
> > basically just a pretty-printed version of it with the consequence that
> > it needs to be stored in an external file and there is no reasonable wa=
y
> > to keep it in my shell history.
>=20
> There is a reasonable way to keep it in my file system, though.  I find
> that decidedly superior.

That depends a lot on your use case.

If you have a long-lived production VM that you always run with the same
configuration, then yes, having a config file for it in the file system
is what you probably want. Currently, for this case, people directly
using QEMU tend to write a script that contains the command line. I
think I do have such scripts somewhere, but their number is very small.

My common case is short-lived VMs with configurations that change very
often between QEMU invocations. Here the command line is decidedly
superior.

Requiring me to create a file in the file system each time and to
remember deleting it after I'm done feels about as convenient as a *nix
shell that doesn't accept parameters for commands on the command line,
but instead requires you to write a one-off script first and then run
that.

Kevin


