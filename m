Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36F4C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C3721527
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccTG2RZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C3721527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzW8-00087b-UW
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kVzBq-0005Ud-Ta
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kVzBn-0003O1-TJ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603467669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PcJFFMS9JMpYYzfwu7abHe1MvZKgD5AjjoCZONizOWs=;
 b=ccTG2RZQI/cMoZWXgJBxqEuW/Cruz1AC+uKE7OYfFmorZkwp1cgH9ZUI5nPQzILjip0uq2
 goTxYz7ptiN+8Ze9W1TzVFVt9Fms/hIPpVe7U9yDrK9cBHlyBYpejB+XNnnT4G+grSYCWh
 U820tLdvFrwiq5QPcGuqEowQNfnDte4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-SipzwcLvNWW7CJcjCQJ3Pg-1; Fri, 23 Oct 2020 11:41:05 -0400
X-MC-Unique: SipzwcLvNWW7CJcjCQJ3Pg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A66E1020900;
 Fri, 23 Oct 2020 15:41:04 +0000 (UTC)
Received: from redhat.com (ovpn-113-117.ams2.redhat.com [10.36.113.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC5C6282CA;
 Fri, 23 Oct 2020 15:41:01 +0000 (UTC)
Date: Fri, 23 Oct 2020 11:40:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] vhost: Don't special case vq->used_phys in
 vhost_get_log_size()
Message-ID: <20201023114003-mutt-send-email-mst@kernel.org>
References: <160208823418.29027.15172801181796272300.stgit@bahia.lan>
 <30e455d0-ac84-0be4-f1bb-5b7a98b1b66b@redhat.com>
 <20201023131006.3bdb98bf@bahia.lan>
MIME-Version: 1.0
In-Reply-To: <20201023131006.3bdb98bf@bahia.lan>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 01:10:06PM +0200, Greg Kurz wrote:
> On Sat, 10 Oct 2020 11:30:28 +0800
> Jason Wang <jasowang@redhat.com> wrote:
> 
> > 
> > On 2020/10/8 上午12:30, Greg Kurz wrote:
> > > The first loop in vhost_get_log_size() computes the size of the dirty log
> > > bitmap so that it allows to track changes in the entire guest memory, in
> > > terms of GPA.
> > >
> > > When not using a vIOMMU, the address of the vring's used structure,
> > > vq->used_phys, is a GPA. It is thus already covered by the first loop.
> > >
> > > When using a vIOMMU, vq->used_phys is a GIOVA that will be translated
> > > to an HVA when the vhost backend needs to update the used structure. It
> > > will log the corresponding GPAs into the bitmap but it certainly won't
> > > log the GIOVA.
> > >
> > > So in any case, vq->used_phys shouldn't be explicitly used to size the
> > > bitmap. Drop the second loop.
> > >
> > > This fixes a crash of the source when migrating a guest using in-kernel
> > > vhost-net and iommu_platform=on on POWER, because DMA regions are put
> > > over 0x800000000000000ULL. The resulting insanely huge log size causes
> > > g_malloc0() to abort.
> > >
> > > BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1879349
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >
> > > This supersedes "vhost: Ignore vrings in dirty log when using a vIOMMU"
> > >
> > > http://patchwork.ozlabs.org/project/qemu-devel/patch/160105498386.68108.2145229309875282336.stgit@bahia.lan/
> > > ---
> > >   hw/virtio/vhost.c |   10 ----------
> > >   1 file changed, 10 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index 011951625442..c02b658b597f 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -172,16 +172,6 @@ static uint64_t vhost_get_log_size(struct vhost_dev *dev)
> > >                                          reg->memory_size);
> > >           log_size = MAX(log_size, last / VHOST_LOG_CHUNK + 1);
> > >       }
> > > -    for (i = 0; i < dev->nvqs; ++i) {
> > > -        struct vhost_virtqueue *vq = dev->vqs + i;
> > > -
> > > -        if (!vq->used_phys && !vq->used_size) {
> > > -            continue;
> > > -        }
> > > -
> > > -        uint64_t last = vq->used_phys + vq->used_size - 1;
> > > -        log_size = MAX(log_size, last / VHOST_LOG_CHUNK + 1);
> > > -    }
> > >       return log_size;
> > >   }
> > >   
> > 
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > 
> 
> Ping ?

tagged, thanks!

-- 
MST


