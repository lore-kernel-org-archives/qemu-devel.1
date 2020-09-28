Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B425C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 21:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4EB2083B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 21:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+SzHWxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4EB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN0S3-0003f9-Kp
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 17:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN0R3-0003EE-3R
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 17:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN0Qz-0007PS-O8
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 17:11:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601327503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dlbCz1WTAOUOv6o/Ret4EQCu/3QZIM6x5XexXRZLz0U=;
 b=i+SzHWxjwqdsIcQHzepbfUWF/W0/10jvCj58unukEGrGCwBaubwcmjzIJRzyfkncS6KjzU
 n8QUjnr81U7bGMFDppYF0iR6V/yAM5qok2GA5ryIRa+A2w1W6qdgw41Qa5zRgA4Tcdi6Z3
 yPTsNJUO4apwQEH+ClNJ4BqUGJrO5bQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-RmLqU1dcMtW_cCYTtNym6w-1; Mon, 28 Sep 2020 17:11:39 -0400
X-MC-Unique: RmLqU1dcMtW_cCYTtNym6w-1
Received: by mail-wr1-f72.google.com with SMTP id 33so861277wrk.12
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 14:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=dlbCz1WTAOUOv6o/Ret4EQCu/3QZIM6x5XexXRZLz0U=;
 b=Cb3EbaS9TOY6uaEjduAW1J0EiZ9iun1RJS7vaQqJ4+hbMitJcOD4Sz8umIdHFMsV2D
 +ja8cZZvu5foyP40lKZw3SRxFbuuhPKV8O08XJ06oVrWXgDyjifU/fMI+8/VxUfAvEOb
 Y9FjVdZZCdCD4EMCXWcjwXrcFj0ZDynymz9OF+1eXFv2ybSqSeImBomsTnCeXt6PQca2
 kAQC2e1wR7vkffj2aaMJR/1FS6P81/PYG8n6Yj6r9dfpR6Gd5resAWBKs9l/f14VvHpV
 +D0RSYgR06EKK3h9avAuNjuw0La8aFlQeIdVYJcTW+jXVIQEiHreXiHi+LYcTm8LNfB9
 7hxw==
X-Gm-Message-State: AOAM532/CnJjII3wPFsqk/j6M4rqWn65yMrlHd/JY32AeyCiBZBOeQLk
 eY2mvCoUE6ZewNKLXmr3Hml/1aVcco0E+hxiyXp30+bVToUB6tAwozC/GWjnxp+nManTuVVDjAL
 9fUHoJXI6qSbS31k=
X-Received: by 2002:adf:f504:: with SMTP id q4mr345225wro.353.1601327498371;
 Mon, 28 Sep 2020 14:11:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1fdaI84xyTkAnCo5859ZwZ479q0RB7tIjyHfnSUYWtrkyNZNf3kzSGcvgRHT6LkpsdJx2Jg==
X-Received: by 2002:adf:f504:: with SMTP id q4mr345212wro.353.1601327498163;
 Mon, 28 Sep 2020 14:11:38 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id f16sm3028680wrp.47.2020.09.28.14.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 14:11:37 -0700 (PDT)
Date: Mon, 28 Sep 2020 17:11:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Subject: Re: [PATCH] vhost-user: save features of multiqueues if chardev is
 closed
Message-ID: <20200928171110-mutt-send-email-mst@kernel.org>
References: <46CBC206-E0CA-4249-81CD-10F75DA30441@tencent.com>
 <31d9f70a-f4b8-bc83-aa5d-c71e2b31e3f5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <31d9f70a-f4b8-bc83-aa5d-c71e2b31e3f5@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
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
Cc: Jason Wang <jasowang@redhat.com>,
 "xtay.haibin@gmail.com" <xtay.haibin@gmail.com>,
 =?utf-8?B?aGFpYmluemhhbmco5byg5rW35paMKQ==?= <haibinzhang@tencent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 23, 2020 at 11:44:41AM +0200, Adrian Moreno wrote:
> Thanks Haibin,
> 
> 
> On 9/22/20 5:27 AM, haibinzhang(张海斌) wrote:
> > Fore-commit(c6beefd674) only saves features of queue0,
> > this makes wrong features of other queues in multiqueues
> > situation.
> > For examples:
> >   qemu-system-aarch64 ... \
> >   -chardev socket,id=charnet0,path=/var/run/vhost_sock \
> >   -netdev vhost-user,chardev=charnet0,queues=2,id=hostnet0 \
> >   ...
> > There are two queues in nic assocated with one chardev.
> > When chardev is reconnected, it is necessary to save and
> > restore features of all queues.
> > 
> > Signed-of-by: Haibin Zhang <haibinzhang@tencent.com>
> > 
> 
> 
> Indeed, this fixes the issue of vhost-user reconnection on multiqueue that I've
> also reproduced, thanks for posting it.
> 
> However, I'd like to ask some questions to the experts:
> - Why do we need a feature negotiation per queue-pair on vhost-user?
> - Maybe I'm missing something but, isn't the problem that vhost-user device is
> reusing vhost_net layer (which forces nqueues = 2)?
> - Won't we have the same issue with vdpa?

queued this for now. Jason, what are your thoughts on the questions?

> ---
> >  net/vhost-user.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/vhost-user.c b/net/vhost-user.c
> > index 17532daaf3..ffbd94d944 100644
> > --- a/net/vhost-user.c
> > +++ b/net/vhost-user.c
> > @@ -226,7 +226,7 @@ static void chr_closed_bh(void *opaque)
> >      NetClientState *ncs[MAX_QUEUE_NUM];
> >      NetVhostUserState *s;
> >      Error *err = NULL;
> > -    int queues;
> > +    int queues, i;
> >  
> >      queues = qemu_find_net_clients_except(name, ncs,
> >                                            NET_CLIENT_DRIVER_NIC,
> > @@ -235,8 +235,12 @@ static void chr_closed_bh(void *opaque)
> >  
> >      s = DO_UPCAST(NetVhostUserState, nc, ncs[0]);
> >  
> > -    if (s->vhost_net) {
> > -        s->acked_features = vhost_net_get_acked_features(s->vhost_net);
> > +    for (i = queues -1; i >= 0; i--) {
> > +        s = DO_UPCAST(NetVhostUserState, nc, ncs[i]);
> > +
> > +        if (s->vhost_net) {
> > +            s->acked_features = vhost_net_get_acked_features(s->vhost_net);
> > +        }
> >      }
> >  
> >      qmp_set_link(name, false, &err);
> > 
> 
> Thanks
> -- 
> Adrián Moreno


