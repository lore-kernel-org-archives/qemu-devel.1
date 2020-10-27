Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685F5C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA1022265
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Af+wcAXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA1022265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOWP-00049f-ME
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kXO3I-0007Av-00
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 08:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kXO38-0002Nt-3U
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 08:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603801558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KwKmv0Fs1Z3sZ4MuU/pBZW1CNv+A6fv5z+URUF+Kets=;
 b=Af+wcAXaoEV/82pgUdKOZ/u3yFeU+q2gMh923/aoB3+ovxs/EvusMDZCjHmLkBJstLOsmY
 GOvsM3Lss31L3cInQGIpFvh+X3a8Ke0K3gBnBNHqS0zYgBhERfe1u3/zL5Bxat5YOE4n8b
 Gv2h+fj2opUNNNRyzmoFr4Ff9S75cYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-ePx1jBdPOGyNiu_Ve-ghJg-1; Tue, 27 Oct 2020 08:25:56 -0400
X-MC-Unique: ePx1jBdPOGyNiu_Ve-ghJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E923210E2181;
 Tue, 27 Oct 2020 12:25:55 +0000 (UTC)
Received: from redhat.com (ovpn-115-179.ams2.redhat.com [10.36.115.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA28A5C1BB;
 Tue, 27 Oct 2020 12:25:50 +0000 (UTC)
Date: Tue, 27 Oct 2020 08:25:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio: skip guest index check on device load
Message-ID: <20201027082337-mutt-send-email-mst@kernel.org>
References: <20201026151328.77611-1-felipe@nutanix.com>
 <20201027113049.GH79063@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201027113049.GH79063@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 11:30:49AM +0000, Stefan Hajnoczi wrote:
> On Mon, Oct 26, 2020 at 03:13:32PM +0000, Felipe Franciosi wrote:
> > QEMU must be careful when loading device state off migration streams to
> > prevent a malicious source from exploiting the emulator. Overdoing these
> > checks has the side effect of allowing a guest to "pin itself" in cloud
> > environments by messing with state which is entirely in its control.
> > 
> > Similarly to what f3081539 achieved in usb_device_post_load(), this
> > commit removes such a check from virtio_load(). Worth noting, the result
> > of a load without this check is the same as if a guest enables a VQ with
> > invalid indexes to begin with. That is, the virtual device is set in a
> > broken state (by the datapath handler) and must be reset.
> > 
> > Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> > ---
> >  hw/virtio/virtio.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 6f8f865aff..0561bdb857 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3136,8 +3136,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
> >      RCU_READ_LOCK_GUARD();
> >      for (i = 0; i < num; i++) {
> >          if (vdev->vq[i].vring.desc) {
> > -            uint16_t nheads;
> > -
> >              /*
> >               * VIRTIO-1 devices migrate desc, used, and avail ring addresses so
> >               * only the region cache needs to be set up.  Legacy devices need
> > @@ -3157,16 +3155,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
> >                  continue;
> >              }
> >  
> > -            nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
> > -            /* Check it isn't doing strange things with descriptor numbers. */
> > -            if (nheads > vdev->vq[i].vring.num) {
> > -                error_report("VQ %d size 0x%x Guest index 0x%x "
> > -                             "inconsistent with Host index 0x%x: delta 0x%x",
> > -                             i, vdev->vq[i].vring.num,
> > -                             vring_avail_idx(&vdev->vq[i]),
> > -                             vdev->vq[i].last_avail_idx, nheads);
> > -                return -1;
> > -            }
> 
> Michael, the commit that introduced this check seems to have been for
> debugging rather than to prevent a QEMU crash, so this removing the
> check may be safe:
> 
>   commit 258dc7c96bb4b7ca71d5bee811e73933310e168c
>   Author: Michael S. Tsirkin <mst@redhat.com>
>   Date:   Sun Oct 17 20:23:48 2010 +0200
> 
>       virtio: sanity-check available index
> 
>       Checking available index upon load instead of
>       only when vm is running makes is easier to
>       debug failures.

Agreed. Given this, let's keep the message around, just with
LOG_GUEST_ERROR ?


> Felipe: Did you audit the code to make sure the invalid avail_idx value
> and the fields it is propagated to (e.g. shadow_avail_idx) are always
> used in a safe way?



