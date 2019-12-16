Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025E5C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25D920665
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1LY5RAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25D920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igsUH-0004a9-0v
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1igsS8-0002Sl-It
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1igsS7-0006Qx-E2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:38:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36480
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1igsS7-0006Po-Al
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576510710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKF1VPA//YCb4GQUOSefG70vW/4gad0yxKO9JMA1ygE=;
 b=I1LY5RAWbGSQMPnNpjGilJt90nkX4StmSlqPTD+58hlNFvDnZqAQLaq8bgAl79fldDF5ir
 XTp35bfZZ+u5G4MvD8iGJUTs4CFQPn1rtzcSi94Aley8kaf1+a+3xoeUCjWfPHn7qZJ2wR
 4lTskg11Ci39mruQOczUEEc+rFqSCho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-iN8NKdK3PpedT4K3e-PWnA-1; Mon, 16 Dec 2019 10:38:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13A8B18557C6;
 Mon, 16 Dec 2019 15:38:27 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-54.ams2.redhat.com [10.36.117.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5012C5C1B0;
 Mon, 16 Dec 2019 15:38:25 +0000 (UTC)
Date: Mon, 16 Dec 2019 16:38:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 2/2] block: allow to set 'drive' property on a
 realized block device
Message-ID: <20191216153823.GD6610@linux.fritz.box>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
 <20191110190310.19799-3-dplotnikov@virtuozzo.com>
 <c19343f9-73b2-89a4-2b7d-b101a0b20016@virtuozzo.com>
 <c38c1301-a28f-baf1-d441-ae8c7205feb1@virtuozzo.com>
 <20191213103246.GB3428@localhost.localdomain>
 <e982f384-0d94-7519-8cb1-48208025217a@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <e982f384-0d94-7519-8cb1-48208025217a@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: iN8NKdK3PpedT4K3e-PWnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 16.12.2019 um 15:51 hat Denis Plotnikov geschrieben:
> On 13.12.2019 13:32, Kevin Wolf wrote:
> > Am 18.11.2019 um 11:50 hat Denis Plotnikov geschrieben:
> >> Another problem here, is that the "size" of the device dev may not mat=
ch
> >> after setting a drive.
> >> So, we should update it after the drive setting.
> >> It was found, that it could be done by calling
> >> BlockDevOps.bdrv_parent_cb_resize.
> >>
> >> But I have some concerns about doing it so. In the case of virtio scsi
> >> disk we have the following callstack
> >>
> >>   =A0=A0=A0 bdrv_parent_cb_resize calls() ->
> >>   =A0 =A0=A0=A0=A0=A0 scsi_device_report_change(dev, SENSE_CODE(CAPACI=
TY_CHANGED)) ->
> >>   =A0 =A0 =A0 =A0 =A0 =A0 virtio_scsi_change ->
> >>   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 virtio_scsi_push_event=
(s, dev, VIRTIO_SCSI_T_PARAM_CHANGE,
> >>   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sense.asc |
> >> (sense.ascq << 8));
> > I think the safest option for now (and which should solve the case you
> > want to address) is checking whether old and new size match and
> > returning an error otherwise.
> >
> >> virtio_scsi_change=A0 pushes the event to the guest to make the guest
> >> ask for size refreshing.  If I'm not mistaken, here we can get a race
> >> condition when some another request is processed with an unchanged
> >> size and then the size changing request is processed.
> > I think this is actually a problem even without resizing: We need to
> > quiesce the device between removing the old root and inserting the new
> > one. They way to achieve this is probably by splitting blk_drain() into
> > a blk_drain_begin()/end() and then draining the BlockBackend here while
> > we're working on it.
> >
> > Kevin
> Why don't we use bdrv_drained_begin/end directly? This is what
> blk_drain does.
> If we want to split blk_drain we must keep track if blk's brdv isn't
> change otherwise we can end up with drain_begin one and drain end
> another bdrv if we do remove/insert in between.

Hmm, true, we would have to keep track of draining at the BlockBackend
level and consider it in blk_remove_bs() and blk_insert_bs(). Maybe
that's not worth it.

If we use bdrv_drained_begin/end directly, I think we need to drain both
the old and the new root node during the process.

> Another thing is should we really care about this if we have VM
> stopped and the sizes matched?

How do we know that the VM is stopped? And why would we require this?
Your patch doesn't implement or at least check this, and it seems a bit
impractical for example when all you want is inserting a filter node.

Kevin


