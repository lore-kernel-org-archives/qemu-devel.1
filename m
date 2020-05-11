Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E276EC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A750420708
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHTjqDDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A750420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6l1-0003GT-TS
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jY6Uo-0005cg-Ol
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:21:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jY6Un-0003el-Tw
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589196076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dIY0Er8B/+oSqb6apF+PO1IJuqj/HGhncW69+AkzyXQ=;
 b=bHTjqDDNc3YB4fJEoFhFXbiT9abw6VNfK8vy6M990KZZpU2XpD3YfgbMgDAgqWo+VTt35Z
 NEGg2QIs0PQu+s6pbsEZzgh7PazyZ9uv1fGJTtxzfEaIqINOgb0sb6uYLppL94g0wlw2ew
 6zowFVpXa6R3zitW4K0/h8XYmG0hLjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-dd09lHBjOk2_4v2a1uGMgg-1; Mon, 11 May 2020 07:21:14 -0400
X-MC-Unique: dd09lHBjOk2_4v2a1uGMgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8FC91899520;
 Mon, 11 May 2020 11:21:13 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D83A38E;
 Mon, 11 May 2020 11:21:05 +0000 (UTC)
Message-ID: <1defe422710a6dbf2cd678b7a43bcca5caca2345.camel@redhat.com>
Subject: Re: [PATCH 4/4] virtio-scsi: don't touch scsi devices that are not
 yet realized
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Date: Mon, 11 May 2020 14:21:04 +0300
In-Reply-To: <c2d18ca0-3ba1-542c-f821-f06e1b1f4988@redhat.com>
References: <20200416203624.32366-1-mlevitsk@redhat.com>
 <20200416203624.32366-5-mlevitsk@redhat.com>
 <c2d18ca0-3ba1-542c-f821-f06e1b1f4988@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 01:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-05-04 at 13:24 +0200, Paolo Bonzini wrote:
> On 16/04/20 22:36, Maxim Levitsky wrote:
> > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1812399
> > 
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  hw/scsi/virtio-scsi.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > index b0f4a35f81..e360b4e03e 100644
> > --- a/hw/scsi/virtio-scsi.c
> > +++ b/hw/scsi/virtio-scsi.c
> > @@ -35,13 +35,29 @@ static inline int virtio_scsi_get_lun(uint8_t *lun)
> >  
> >  static inline SCSIDevice *virtio_scsi_device_find(VirtIOSCSI *s, uint8_t *lun)
> >  {
> > +    SCSIDevice *device = NULL;
> > +
> >      if (lun[0] != 1) {
> >          return NULL;
> >      }
> >      if (lun[2] != 0 && !(lun[2] >= 0x40 && lun[2] < 0x80)) {
> >          return NULL;
> >      }
> > -    return scsi_device_find(&s->bus, 0, lun[1], virtio_scsi_get_lun(lun));
> > +
> > +    device = scsi_device_find(&s->bus, 0, lun[1], virtio_scsi_get_lun(lun));
> > +
> > +    /* This function might run on the IO thread and we might race against
> > +     * main thread hot-plugging the device.
> > +     *
> > +     * We assume that as soon as .realized is set to true we can let
> > +     * the user access the device.
> > +     */
> 
> Likewise this needs to be load-acquire.

Done.

Best regards,
	Maxim Levitsky
> 
> Paolo
> 
> > +    if (!device || !atomic_read(&device->qdev.realized)) {
> > +        return NULL;
> > +    }
> > +
> > +    return device;
> >  }
> >  
> >  void virtio_scsi_init_req(VirtIOSCSI *s, VirtQueue *vq, VirtIOSCSIReq *req)
> > 
> 
> 



