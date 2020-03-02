Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78B7C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A327B217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1H+FSHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A327B217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8nBG-0004dl-TF
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 10:40:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j8nAb-00042h-MP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j8nAa-0007g7-LX
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:39:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55187
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j8nAa-0007fx-IG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583163588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QYMJe/MFc/S2NejK1TN23Qm3FDpllO6QY6wZcPmoYWo=;
 b=Y1H+FSHD6bsj1Nb74ynDR+IwJ3i9wD0XmJ40vKh6zJNR4OY5gGFigc9SvT7DDrOb9MgvJu
 MVUvatEMRreN80vtJIbLjML686KwXbduYwE3LAF/RnBe79DiueYlTwGcF15dNDDfrONA6r
 W9OYpZIfnHiwaLYs+0WlSg993k2OjyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-_wBzrDycOxm527NRNdCZIA-1; Mon, 02 Mar 2020 10:39:44 -0500
X-MC-Unique: _wBzrDycOxm527NRNdCZIA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C620D8010EB;
 Mon,  2 Mar 2020 15:39:42 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-7.ams2.redhat.com [10.36.117.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D74855DA75;
 Mon,  2 Mar 2020 15:39:40 +0000 (UTC)
Date: Mon, 2 Mar 2020 16:39:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 0/2] allow to set 'drive' property on a realized block
 device
Message-ID: <20200302153939.GE4965@linux.fritz.box>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
 <20200302133837.GC4965@linux.fritz.box>
 <20b9cc1f-8fbe-99fc-bbdb-5605b1c186a9@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20b9cc1f-8fbe-99fc-bbdb-5605b1c186a9@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: vsementsov@virtuozzo.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.03.2020 um 14:55 hat Denis Plotnikov geschrieben:
>=20
>=20
> On 02.03.2020 16:38, Kevin Wolf wrote:
> > Am 10.11.2019 um 20:03 hat Denis Plotnikov geschrieben:
> > > This allows to replace the file on a block device and is useful
> > > to workaround the cases (migration) when the VM image is placed on
> > > some shared storage with exclusive file opening model but the image
> > > should be open form more than one app.
> > >=20
> > > The previous version of approaching the workaround was based on the
> > > "blockdev-change-medium" command modification but had some flaws:
> > >    * semantics: blockdev-change-medium is aimed to be used with remov=
able devices
> > >      only
> > >    * interface: it can't accept all possible combination of parameter=
s for
> > >      the "drive" replacement (creation).
> > >=20
> > > More details here: http://patchwork.ozlabs.org/patch/1179329/
> > >=20
> > > The current series suggests another approach:
> > > 1. blockdev-add
> > > 2. qom-set disk.drive =3D the blockdev added (this is what the series=
 adds)
> > Are you still planning to send another version?
> >=20
> > Kevin
> Not in the near future :) There is an unresolved problem with
> bitmap-migration is case of block dev replacement.
> Still don't know how to do it in the proper way.

I seem to remember that in some discussion a while ago we came to the
conclusion that we need a way for the managemnt tool to provide a
mapping from source node-names to destination node-names.

Or is the problem you mean unrelated to identifying the node to which a
bitmap should belong?

Kevin


