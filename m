Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7448EC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2126A227C3
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKNaYhWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2126A227C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFeLV-0005y2-8r
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFeKk-0005AM-OI
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:10:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55956
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFeKi-0004ic-LO
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599574251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5covbJKT75WZIzPtkv98IYTBTRKsJYuPhXwWzD+JnmA=;
 b=DKNaYhWh4x1Cq1RDUTRGbs8a4zHjh4wNhaSP0Zy//LKEAa0EVj+y7dAMCr1WBnzJPcw1YH
 LyBnYbAUagT6Yis463WhdxJcdxYq9tm7279UI9ICgrsHN4jR6hNki4uesn1T6xXY9kiFxQ
 oka9zCiCNjb7Z/b/5EvadYClu+8NfCQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-XSVCuwvRMbuenWefG2N2zw-1; Tue, 08 Sep 2020 10:10:50 -0400
X-MC-Unique: XSVCuwvRMbuenWefG2N2zw-1
Received: by mail-wm1-f70.google.com with SMTP id x6so505133wmi.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 07:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5covbJKT75WZIzPtkv98IYTBTRKsJYuPhXwWzD+JnmA=;
 b=Wsdm+KYyGQNTINbYZMFZHMhvHJmGD0LqLA3pxSLvN61PrG6BG8hbucbmETJGHG+2sn
 986uJU0WK7Q1WOE0GeQ7Ww/l5AkaqGWKI5Zw+1kqygrghFd2IbmhKZhGXSj3LjjSSc/I
 brSrHQV9whtkPbP0wyLyOAX2DK4PBvz128TMc+Yqa5inBqSumLzXY/0xGVvFAEBv/ZtU
 5d1d8T+ch07zvqT6NFIGAH96YzDkrsG/LhcU99h7lMISzIwEsaZDMWcXQlZpkrtIC6vI
 8ds5x3YWHObZGrpmkrEQTuSFjawx9f5bQjBqhazvt2xWwkC1aFiIzdrVZvynZiQJIDFz
 NrqQ==
X-Gm-Message-State: AOAM532Ng0uq1xNMvepValIeYXDAWnxQG3bLishwBH+mmPODv5QaN5WI
 +d2PnPj4pkHCIQVdMFYCRQtO+vOzTuGfRPuTnL3THIYw7RmA38gl8yOQ+ymdG3aY5YtaBQFXQR+
 pPLplWGuUGKy0k4M=
X-Received: by 2002:a05:6000:1282:: with SMTP id
 f2mr29139555wrx.251.1599574249053; 
 Tue, 08 Sep 2020 07:10:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOAFfUwGlxInB4jiGda8piR6tkAIGaZBEuFiOXwDZpMvTHv0es+2olATTRLFNKq8xCnfXYug==
X-Received: by 2002:a05:6000:1282:: with SMTP id
 f2mr29139535wrx.251.1599574248846; 
 Tue, 08 Sep 2020 07:10:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-218-236.inter.net.il. [80.230.218.236])
 by smtp.gmail.com with ESMTPSA id
 t6sm9279883wre.30.2020.09.08.07.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 07:10:47 -0700 (PDT)
Date: Tue, 8 Sep 2020 10:10:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH v2] virtio-mem: detach the element from the virtqueue
 when error occurs
Message-ID: <20200908101025-mutt-send-email-mst@kernel.org>
References: <20200816142245.17556-1-liq3ea@163.com>
 <CAKXe6SJjrTZ5cW3h227MUpPt8jsPimcrjiN8-WXSbVCZvdkCFg@mail.gmail.com>
 <CAKXe6SLt8r3bm0bGiGQ5sPoz-8xWrZkpnRFa1GEaT5_iRO1+Rg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKXe6SLt8r3bm0bGiGQ5sPoz-8xWrZkpnRFa1GEaT5_iRO1+Rg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For some reason I didn't receive the original email.
Sorry.
Queued now.

On Mon, Sep 07, 2020 at 09:36:40AM +0800, Li Qiang wrote:
> Ping!
> 
> Li Qiang <liq3ea@gmail.com> 于2020年8月28日周五 上午9:21写道：
> >
> > Kindly ping.
> >
> > Li Qiang <liq3ea@163.com> 于2020年8月16日周日 下午10:23写道：
> > >
> > > If error occurs while processing the virtio request we should call
> > > 'virtqueue_detach_element' to detach the element from the virtqueue
> > > before free the elem.
> > >
> > > Signed-off-by: Li Qiang <liq3ea@163.com>
> > > ---
> > > Change since v1:
> > > Change the subject
> > > Avoid using the goto label
> > >
> > >  hw/virtio/virtio-mem.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> > > index 7740fc613f..e6ffc781b3 100644
> > > --- a/hw/virtio/virtio-mem.c
> > > +++ b/hw/virtio/virtio-mem.c
> > > @@ -318,6 +318,7 @@ static void virtio_mem_handle_request(VirtIODevice *vdev, VirtQueue *vq)
> > >          if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req, len) < len) {
> > >              virtio_error(vdev, "virtio-mem protocol violation: invalid request"
> > >                           " size: %d", len);
> > > +            virtqueue_detach_element(vq, elem, 0);
> > >              g_free(elem);
> > >              return;
> > >          }
> > > @@ -327,6 +328,7 @@ static void virtio_mem_handle_request(VirtIODevice *vdev, VirtQueue *vq)
> > >              virtio_error(vdev, "virtio-mem protocol violation: not enough space"
> > >                           " for response: %zu",
> > >                           iov_size(elem->in_sg, elem->in_num));
> > > +            virtqueue_detach_element(vq, elem, 0);
> > >              g_free(elem);
> > >              return;
> > >          }
> > > @@ -348,6 +350,7 @@ static void virtio_mem_handle_request(VirtIODevice *vdev, VirtQueue *vq)
> > >          default:
> > >              virtio_error(vdev, "virtio-mem protocol violation: unknown request"
> > >                           " type: %d", type);
> > > +            virtqueue_detach_element(vq, elem, 0);
> > >              g_free(elem);
> > >              return;
> > >          }
> > > --
> > > 2.17.1
> > >
> > >
> 


