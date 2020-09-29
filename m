Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B041CC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC8D2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNZq7pMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC8D2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAXs-00071w-0b
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNA2o-0002RM-Bd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNA2m-0002mG-Jj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:27:26 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u6pyar2N03gtCooOiIcecmfZjBirGq+YWT4nlBwyZdo=;
 b=JNZq7pMb5JH5rNE8tlQiPNiByvoe4DFSQqy1btuOsNr4KEzZsKxdcavTjO6pNT4g2RtqgE
 DgTnuL8+gj1dhTHcJjmXVLTU2VDCDBN2ixTGrKankk51MjZqVXjlaHwtjEbqBoao4RzHY8
 YUPBc63+/bAjXPywnG4zLpV/nKxipUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-q-7cLgwvPlmJE_KoU7IXvA-1; Tue, 29 Sep 2020 03:27:18 -0400
X-MC-Unique: q-7cLgwvPlmJE_KoU7IXvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B02C91084D65;
 Tue, 29 Sep 2020 07:27:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FFC05D9CA;
 Tue, 29 Sep 2020 07:27:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6A0ED1750A; Tue, 29 Sep 2020 09:27:13 +0200 (CEST)
Date: Tue, 29 Sep 2020 09:27:13 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Guoqing Zhang <zhangguoqing.kernel@bytedance.com>
Subject: Re: [PATCH] virtio-gpu-3d: fix abnormal display after a warm reboot
Message-ID: <20200929072713.qng45362rrcdk2ke@sirius.home.kraxel.org>
References: <20200918111632.37354-1-zhangguoqing.kernel@bytedance.com>
 <CAP+YVmQMQ-zk59bdR5Wz4h-2QmOygS_DGnMOYwwLstVwcdWq2g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP+YVmQMQ-zk59bdR5Wz4h-2QmOygS_DGnMOYwwLstVwcdWq2g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Qi Liu <liuqi.16@bytedance.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 27, 2020 at 08:17:10PM +0800, Guoqing Zhang wrote:
> hello Gerd and Michael   Michael S. Tsirkin
> 
> ping

Queued up now (not much activity for vga/ui these days ...).

> 
> http://patchwork.ozlabs.org/project/qemu-devel/list/?series=202680
> 
> On Fri, Sep 18, 2020 at 7:16 PM Guoqing Zhang <
> zhangguoqing.kernel@bytedance.com> wrote:
> 
> > When resetting virtio-gpu, virgl_renderer_reset() should be
> > called to ensure that the virglrenderer status is correct.
> >
> > Signed-off-by: Guoqing Zhang <zhangguoqing.kernel@bytedance.com>
> > Reviewed-by: Qi Liu<liuqi.16@bytedance.com>
> > ---
> >  hw/display/virtio-gpu-3d.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> > index 96621576c2..1bd33d7aed 100644
> > --- a/hw/display/virtio-gpu-3d.c
> > +++ b/hw/display/virtio-gpu-3d.c
> > @@ -595,7 +595,7 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
> >  {
> >      int i;
> >
> > -    /* virgl_renderer_reset() ??? */
> > +    virgl_renderer_reset();
> >      for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
> >          if (i != 0) {
> >              dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
> > --
> > 2.24.3 (Apple Git-128)
> >
> >


