Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CB4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210DE21739
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ie1FENdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210DE21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw54F-0004tD-BW
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 09:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iw53P-0003Wh-Nx
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iw53N-00060o-Vq
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:07:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42361
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iw53N-0005zs-SH
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580134069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxYGgwU0W7M5J7b+eX0Sdfakaya9E5OipIl4dVTcl2Q=;
 b=Ie1FENdqH54c+FLLo35neUtxrLYhuYAfJovcqM6vTdeW6surGiMsdyWqWVNyyaW8zUo5VE
 CuZO/MLj6L3UboAG4WzNtp5UDlkLmzbKjSdAlPMuoENya9MfWCxaor1OSmaGhfhRpAhoxK
 jwpaO5+RnVRQB8vh8OK7sD4GPY2nUiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-Jf5UeA54PE67VcT1t5DD8g-1; Mon, 27 Jan 2020 09:07:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EA5D93F03;
 Mon, 27 Jan 2020 14:07:45 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 398AA5C21A;
 Mon, 27 Jan 2020 14:07:44 +0000 (UTC)
Date: Mon, 27 Jan 2020 15:07:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 8/9] monitor: move hmp_info_block* to blockdev-hmp-cmds.c
Message-ID: <20200127140742.GC5669@linux.fritz.box>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-9-mlevitsk@redhat.com>
 <87blsxkahl.fsf@dusky.pond.sub.org>
 <f3b90836b28bcc59876fb3692a8344bd13d01d1d.camel@redhat.com>
 <878sltowh4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <878sltowh4.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Jf5UeA54PE67VcT1t5DD8g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 27.01.2020 um 14:33 hat Markus Armbruster geschrieben:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
>=20
> > On Wed, 2019-11-27 at 09:08 +0100, Markus Armbruster wrote:
> >> I think it makes sense to collect *all* block HMP stuff here.
> >>=20
> >> Left in monitor/hmp-cmds.c: hmp_eject(), hmp_nbd_server_start(), ...
> >>=20
> >> I guess hmp_change() has to stay there, because it's both block and ui=
.
> >>=20
> >> Left in blockdev.c: hmp_drive_add_node().
> >
> > Thank you very much. I added these and bunch more to my patchset.
> >
> >>=20
> >> Quick grep for possible files to check:
> >>=20
> >> $ git-grep -l 'monitor[a-z_-]*.h' | xargs grep -l 'block[a-z_-]*\.h'
> >> MAINTAINERS
> >> blockdev-hmp-cmds.c
> >>=20
> >
> >> blockdev.c
> > hmp_drive_add_node is there and I moved it too.
> >
> >
> >> cpus.c
> > Nothing suspicious
> >
> >> dump/dump.c
> > qmp_dump_guest_memory is only monitor reference there I think
> >
> >> hw/display/qxl.c
> > No way that is related to the block layer
> >
> >> hw/scsi/vhost-scsi.c
> > All right, the monitor_fd_param is an interesting thing.
> > Not related to block though.
> >
> >> hw/usb/dev-storage.c
> > All right, this for no reason includes monitor/monitor.h,
> > added patch to remove this because why not.
> >
> >> include/monitor/monitor.h
> > Nothing suspicious
> >
> >> migration/migration.c
> > Nothing suspicious
> >
> >> monitor/hmp-cmds.c
> > Added hmp_qemu_io
> >
> > Maybe I need to add hmp_delvm too?
> > savevm/delvm do old style snapshots
> > which are stored to the first block device
>=20
> One foot in the block subsystem, the other foot in the migration
> subsystem.  I'm not sure where this should go.  Kevin?

Moving it to block is not an obvious improvement, so I think I'd leave
it alone.

Kevin


