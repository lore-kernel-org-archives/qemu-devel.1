Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA7FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C826A21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoSuZRkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C826A21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihfIW-0002Ll-OS
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:47:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ihfHM-0001gH-UE
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ihfHI-0007dm-Oe
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:46:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46009
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ihfHG-0007Wd-Fr
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576698393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/uBaimqfTZer1Dr3pJBeTkBAx5CCUDIvnjAf+ypzYQ=;
 b=MoSuZRkTYP+UMY9ZNsAAlKUeTfcyyHPQbZxu8i70UBR6tQTPqDogfJ0wnCngpZdahiGNw4
 FShxpsd7lNEWFebaeEqjvdnjPBoFOCRM1rDapMIE4nEbI3Gy1il2CWXEeR02YEoVneCzvD
 MNymAtW0vb5CUMTzvnvG+CVkRop8loc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-eSiXI99jOtK28hZTbsKF5Q-1; Wed, 18 Dec 2019 14:46:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67B211800D42;
 Wed, 18 Dec 2019 19:46:30 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64C865DA75;
 Wed, 18 Dec 2019 19:46:28 +0000 (UTC)
Date: Wed, 18 Dec 2019 19:46:25 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>, thuth@redhat.com
Subject: Re: [PATCH 0/4] colo: Introduce resource agent and high-level test
Message-ID: <20191218194625.GV3707@work-vm>
References: <cover.1574356137.git.lukasstraub2@web.de>
 <20191122094646.GA2785@work-vm> <20191127221134.2b439e00@luklap>
 <20191218102711.19e321ac@luklap>
MIME-Version: 1.0
In-Reply-To: <20191218102711.19e321ac@luklap>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: eSiXI99jOtK28hZTbsKF5Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, "Zhang, Chen" <chen.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Lukas Straub (lukasstraub2@web.de) wrote:
> On Wed, 27 Nov 2019 22:11:34 +0100
> Lukas Straub <lukasstraub2@web.de> wrote:
>=20
> > On Fri, 22 Nov 2019 09:46:46 +0000
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >
> > > * Lukas Straub (lukasstraub2@web.de) wrote:
> > > > Hello Everyone,
> > > > These patches introduce a resource agent for use with the Pacemaker=
 CRM and a
> > > > high-level test utilizing it for testing qemu COLO.
> > > >
> > > > The resource agent manages qemu COLO including continuous replicati=
on.
> > > >
> > > > Currently the second test case (where the peer qemu is frozen) fail=
s on primary
> > > > failover, because qemu hangs while removing the replication related=
 block nodes.
> > > > Note that this also happens in real world test when cutting power t=
o the peer
> > > > host, so this needs to be fixed.
> > >
> > > Do you understand why that happens? Is this it's trying to finish a
> > > read/write to the dead partner?
> > >
> > > Dave
> >
> > I haven't looked into it too closely yet, but it's often hanging in bdr=
v_flush()
> > while removing the replication blockdev and of course thats probably be=
cause the
> > nbd client waits for a reply. So I tried with the workaround below, whi=
ch will
> > actively kill the TCP connection and with it the test passes, though I =
haven't
> > tested it in real world yet.
> >
>=20
> In the real cluster, sometimes qemu even hangs while connecting to qmp (a=
fter remote
> poweroff). But I currently don't have the time to look into it.

That doesn't surprise me too much; QMP is mostly handled in the main
thread, as are a lot of other things; hanging in COLO has been my
assumption for a while because of that.  However, there's a way to fix
it.

A while ago, Peter Xu added a feature called 'out of band' to QMP; you
can open a QMP connection, set the OOB feature, and then commands that
are marked as OOB are executed off the main thread on  that connection.

At the moment we've just got the one real OOB command, 'migrate-recover'
which is used for recovering postcopy from a similar failure to the COLO
case.

To fix this you'd have to convert colo-lost-heartbeat to be an OOB
command; note it's not that trivial, because you have to make sure the
code that's run as part of the OOB command doesn't take any locks that
could block on something in the main thread; so it can set flags, start
new threads, perhaps call shutdown() on a socket; but it takes some
thinking about.


> Still a failing test is better than no test. Could we mark this test as k=
nown-bad and
> fix this issue later? How should I mark it as known-bad? By tag? Or warn =
in the log?

Not sure of that; cc'ing Maybe thuth knows?

Dave

> Regards,
> Lukas Straub
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


