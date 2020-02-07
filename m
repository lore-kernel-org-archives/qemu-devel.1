Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFCFC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A8421741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gm6Po/Kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A8421741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j08Nb-0006Fh-4U
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 13:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j08My-00056F-GP
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 13:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j08Mx-0007P3-0n
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 13:28:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41664
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j08Mw-0007NI-TU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 13:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581100126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQhwXmj9Gqm+GiFGnv1xmKjtX43OyPFoUjX13mLgzqg=;
 b=gm6Po/KtDfNFUyn/eiBTtExGSUx8l/v5gOPrNnzBpnPXRHNvHRQ4MzdwYm5mvnP+HNMFqk
 sClbVkxeihb9T3pimutHlQj3NevB/cmjAZxUiRfJahzyYEhGnA2/Kkp6BsxQRxv6S5h5ko
 IMg/gT3cYDQn7LKn4+T0kODaEri0W+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-EhXVFKseMJqJmc7AcSFn4g-1; Fri, 07 Feb 2020 13:28:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A058419251A2;
 Fri,  7 Feb 2020 18:28:41 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFB2260BEC;
 Fri,  7 Feb 2020 18:28:37 +0000 (UTC)
Date: Fri, 7 Feb 2020 18:28:35 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v4 00/11] RFC: [for 5.0]: HMP monitor handlers refactoring
Message-ID: <20200207182835.GQ3302@work-vm>
References: <20200130123448.21093-1-mlevitsk@redhat.com>
 <20200203195758.GQ2822@work-vm>
 <94ba85dcc5213d386a55706a7bdbb507cfe64d8f.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <94ba85dcc5213d386a55706a7bdbb507cfe64d8f.camel@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: EhXVFKseMJqJmc7AcSFn4g-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Maxim Levitsky (mlevitsk@redhat.com) wrote:
> On Mon, 2020-02-03 at 19:57 +0000, Dr. David Alan Gilbert wrote:
> > * Maxim Levitsky (mlevitsk@redhat.com) wrote:
> > > This patch series is bunch of cleanups to the hmp monitor code.
> > > It mostly moves the blockdev related hmp handlers to its own file,
> > > and does some minor refactoring.
> > >=20
> > > No functional changes expected.
> >=20
> > You've still got the title marked as RFC - are you actually ready for
> > this log?
>=20
> I forgot to update this to be honest, I don't consider this an RFC,
> especially since I dropped for now the patches that might cause
> issues. This is now just a nice refactoring.

OK, so if we can get some block people to say they're happy, then
I'd be happy to take this through HMP or they can take it through block.

Dave

> Best regards,
> =09Maxim Levitsky
>=20
> >=20
> > Dave
> >=20
> > >=20
> > > Changes from V1:
> > >    * move the handlers to block/monitor/block-hmp-cmds.c
> > >    * tiny cleanup for the commit messages
> > >=20
> > > Changes from V2:
> > >    * Moved all the function prototypes to new header (blockdev-hmp-cm=
ds.h)
> > >    * Set the license of blockdev-hmp-cmds.c to GPLv2+
> > >    * Moved hmp_snapshot_* functions to blockdev-hmp-cmds.c
> > >    * Moved hmp_drive_add_node to blockdev-hmp-cmds.c
> > >      (this change needed some new exports, thus in separate new patch=
)
> > >    * Moved hmp_qemu_io and hmp_eject to blockdev-hmp-cmds.c
> > >    * Added 'error:' prefix to vreport, and updated the iotests
> > >      This is invasive change, but really feels like the right one
> > >    * Added minor refactoring patch that drops an unused #include
> > >=20
> > > Changes from V3:
> > >    * Dropped the error prefix patches for now due to fact that it see=
ms
> > >      that libvirt doesn't need that after all. Oh well...
> > >      I'll send them in a separate series.
> > >=20
> > >    * Hopefully correctly merged the copyright info the new files
> > >      Both files are GPLv2 now (due to code from hmp.h/hmp-cmds.c)
> > >=20
> > >    * Addressed review feedback
> > >    * Renamed the added header to block-hmp-cmds.h
> > >=20
> > >    * Got rid of checkpatch.pl warnings in the moved code
> > >      (cosmetic code changes only)
> > >=20
> > >    * I kept the reviewed-by tags, since the changes I did are minor.
> > >      I hope that this is right thing to do.
> > >=20
> > > Best regards,
> > > =09Maxim Levitsky
> > >=20
> > > Maxim Levitsky (11):
> > >   usb/dev-storage: remove unused include
> > >   monitor/hmp: uninline add_init_drive
> > >   monitor/hmp: rename device-hotplug.c to block/monitor/block-hmp-cmd=
s.c
> > >   monitor/hmp: move hmp_drive_del and hmp_commit to block-hmp-cmds.c
> > >   monitor/hmp: move hmp_drive_mirror and hmp_drive_backup to
> > >     block-hmp-cmds.c Moved code was added after 2012-01-13, thus unde=
r
> > >     GPLv2+
> > >   monitor/hmp: move hmp_block_job* to block-hmp-cmds.c
> > >   monitor/hmp: move hmp_snapshot_* to block-hmp-cmds.c
> > >     hmp_snapshot_blkdev is from GPLv2 version of the hmp-cmds.c thus
> > >     have to change the licence to GPLv2
> > >   monitor/hmp: move hmp_nbd_server* to block-hmp-cmds.c
> > >   monitor/hmp: move remaining hmp_block* functions to block-hmp-cmds.=
c
> > >   monitor/hmp: move hmp_info_block* to block-hmp-cmds.c
> > >   monitor/hmp: Move hmp_drive_add_node to block-hmp-cmds.c
> > >=20
> > >  MAINTAINERS                    |    1 +
> > >  Makefile.objs                  |    2 +-
> > >  block/Makefile.objs            |    1 +
> > >  block/monitor/Makefile.objs    |    1 +
> > >  block/monitor/block-hmp-cmds.c | 1002 ++++++++++++++++++++++++++++++=
++
> > >  blockdev.c                     |  137 +----
> > >  device-hotplug.c               |   91 ---
> > >  hw/usb/dev-storage.c           |    1 -
> > >  include/block/block-hmp-cmds.h |   54 ++
> > >  include/block/block_int.h      |    5 +-
> > >  include/monitor/hmp.h          |   24 -
> > >  include/sysemu/blockdev.h      |    4 -
> > >  include/sysemu/sysemu.h        |    3 -
> > >  monitor/hmp-cmds.c             |  769 ------------------------
> > >  monitor/misc.c                 |    1 +
> > >  15 files changed, 1072 insertions(+), 1024 deletions(-)
> > >  create mode 100644 block/monitor/Makefile.objs
> > >  create mode 100644 block/monitor/block-hmp-cmds.c
> > >  delete mode 100644 device-hotplug.c
> > >  create mode 100644 include/block/block-hmp-cmds.h
> > >=20
> > > --=20
> > > 2.17.2
> > >=20
> >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


