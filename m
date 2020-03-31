Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F03C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE29C20838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+Trhs4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE29C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFc1-00022a-UH
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJFbA-0001Z4-P5
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJFb9-0003DL-MX
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:02:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42219
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJFb9-0003Cz-Ia
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585656147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8b3OCcKTdClt1+Sl59nn500irZxsM7wqYKrT2dAhaE0=;
 b=S+Trhs4nHGQm7VxNQc2FWo/IhfTPr3NFhPDwSPm5v52aeAI9LO9R6kA90excv/1rqzor8Q
 g7EwEQ7UpA0/V/qrfEDAOY95V3fBS+mfz+7+AlF7pBRSDBfOTJp7pIuMKQn013Jt/s1Goc
 Iofy0zWQK0kmLeik+tYK8K+5ZgFfu98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-1lvPYgmIPzSBdSaqbOXqqw-1; Tue, 31 Mar 2020 08:02:23 -0400
X-MC-Unique: 1lvPYgmIPzSBdSaqbOXqqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DCA613FD;
 Tue, 31 Mar 2020 12:02:22 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-236.ams2.redhat.com [10.36.114.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B2FA100EBBD;
 Tue, 31 Mar 2020 12:02:21 +0000 (UTC)
Date: Tue, 31 Mar 2020 14:02:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: deprecation of in-tree builds
Message-ID: <20200331120220.GA7030@linux.fritz.box>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com>
 <20200330143759.GD6139@linux.fritz.box>
 <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 31.03.2020 um 09:48 hat Paolo Bonzini geschrieben:
> On 30/03/20 16:37, Kevin Wolf wrote:
> > If manually dealing with separate build directories is inconvenient
> > today, it will still be inconvenient with Meson, so this would mean
> > introducing the automatic directly creation together with the other
> > changes to enable Meson. Which is fine by me, as long as it is really
> > done when the external directory becomes mandatory, so that people won'=
t
> > have to switch back and forth between directories.
>=20
> Serious question: why is automatic directly creation more convenient for
> developers?  Even if "./configure" generates a "build" directory for
> you, you would still have to invoke the QEMU binary as
> "build/x86_64-softmmu/qemu-system-x86_64".  That is less convenient than
> doing "mkdir build" in the first place.

Mainly because it allows me to start everything (most importantly: my
editor, git and make) from the same directory.

I guess the automatic directory creation is the less important part
compared to a Makefile in the source tree that calls the Makefile in the
build directory, because creation the directory is a one-time thing, but
I call make all the time.

Creating it automatically is nice especially for those who build QEMU
for the first time and expect that the ./configure; make; make install
sequence they are used to just works.

Prefixing build/ when using the binaries is a change, too, but I guess
tab completion means that it's not much worse than prefixing ./

> I can see why it's more convenient for packaging, as they just invoke
> "make" and "make install", but as far as developers are concerned it
> seems to add complexity for little or no gain.

I often use the same terminal for building/testing and git, or sometimes
even a second editor for source code.

Kevin


