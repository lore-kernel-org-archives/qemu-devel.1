Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA84CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8737724683
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hT8fSA5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8737724683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwQDJ-0006mR-Od
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 07:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iwQCQ-0005eA-DA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iwQCP-0007NR-BH
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:42:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20458
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iwQCP-0007Mo-7O
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580215352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3LNXo/P1tslkGGzdvUraKYgojvfunIgvq2zwRf59p/8=;
 b=hT8fSA5G0cAlmlnTlt20GmeJZpiJ4yivy2OSo5Gs2CcYGxZq72wtf6e2YnDt3Q20QmTcyX
 5QeFw5TAEScEbtiHYTJbvdT5KowXonaTGi/nl3wm2hxGcXBgrv9Z70PfxyPejdzmJKVDkp
 Y0zb1MJcX6yR3KS9lU9vaVaHNOHb26Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-iRMAZuHPMKuo0MXQKbwuOA-1; Tue, 28 Jan 2020 07:42:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 740A8107ACC5;
 Tue, 28 Jan 2020 12:42:29 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-106.ams2.redhat.com [10.36.117.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 398588E9F5;
 Tue, 28 Jan 2020 12:42:21 +0000 (UTC)
Date: Tue, 28 Jan 2020 13:42:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)
Message-ID: <20200128124220.GE6431@linux.fritz.box>
References: <20200123124357.124019-1-felipe@nutanix.com>
 <20200123165955.GB5021@linux.fritz.box>
 <bfb7c669-19dc-5693-8afe-1f70b61c48f3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <bfb7c669-19dc-5693-8afe-1f70b61c48f3@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: iRMAZuHPMKuo0MXQKbwuOA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Jon Maloy <jmaloy@redhat.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.01.2020 um 13:30 hat Philippe Mathieu-Daud=E9 geschrieben:
> Hi guys,
>=20
> (Cc'ing Jon)
>=20
> On 1/23/20 5:59 PM, Kevin Wolf wrote:
> > Am 23.01.2020 um 13:44 hat Felipe Franciosi geschrieben:
> > > When querying an iSCSI server for the provisioning status of blocks (=
via
> > > GET LBA STATUS), Qemu only validates that the response descriptor zer=
o's
> > > LBA matches the one requested. Given the SCSI spec allows servers to
> > > respond with the status of blocks beyond the end of the LUN, Qemu may
> > > have its heap corrupted by clearing/setting too many bits at the end =
of
> > > its allocmap for the LUN.
> > >=20
> > > A malicious guest in control of the iSCSI server could carefully prog=
ram
> > > Qemu's heap (by selectively setting the bitmap) and then smash it.
> > >=20
> > > This limits the number of bits that iscsi_co_block_status() will try =
to
> > > update in the allocmap so it can't overflow the bitmap.
> > >=20
> > > Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> > > Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
> > > Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> >=20
> > Thanks, applied to the block branch.
>=20
> We are trying to reproduce this, do you already have some code that
> triggered this issue?

I don't, maybe Felipe has a reproducer that would crash QEMU.

> I am new to the block API, I noticed the block/blkdebug.c file with
> 'blkdebug' option, is it helpful to reproduce this issue via HMP?
>=20
> Any suggestion what would be the easier/quicker way to test this?

On the QEMU side, you just need to connect to an iscsi backend. The
malicious response must come from the server, which is not part of QEMU.
So no, blkdebug won't help you.

> Looking for iotests examples I see tests/qemu-iotests/147 providing a
> BuiltinNBD class. Is it the recommended way to go, to mock a iSCSI server=
?

That BuiltinNBD class doesn't implement an NBD server, but it just
starts the built-in NBD server in QEMU and runs some tests against it.
QEMU doesn't have a built-in iscsi server.

Kevin


