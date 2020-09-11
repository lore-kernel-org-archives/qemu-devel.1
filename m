Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED920C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C494214F1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9S5khHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C494214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGdZp-00032o-FP
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 03:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kGdXS-0008Uw-8e; Fri, 11 Sep 2020 03:32:06 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:38812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kGdXQ-0002CY-HO; Fri, 11 Sep 2020 03:32:05 -0400
Received: by mail-lf1-x144.google.com with SMTP id y11so4980131lfl.5;
 Fri, 11 Sep 2020 00:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=gLWFaOrTgYE9gb7vfvSK1qpEJDLObDW4x6A89Wj47sE=;
 b=J9S5khHysLs8NJ7BNlj7gJ8WBPGTPm34CVbBTUbMTeVEoOZC0IsmPxU+MQZUOk9i/V
 E8q/IKjL3Z5ny4GYADQ8eDp8Ui7hFaqdizplVDg28yJXb3Pfw3DBXHuDMDVGzDX54yfd
 F042DpuoH9om/VI+nSYQX/jdxWSqPLWhVUM1FwGtjl3w83km8KFct2KMWQ1tTNnrFZq2
 C40FIEU3Dn/R2pLdopymR1Ha22XrDpMBb9XdmYpc38DondqPxynGhYmjwgoAz580clGj
 4tqZUx1u2sK+9Q5Qp8wIupAWzwwUcT+VBcp2HqB48J7u1gp2XKQh0fsP26jUiQXDIZZ7
 N7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=gLWFaOrTgYE9gb7vfvSK1qpEJDLObDW4x6A89Wj47sE=;
 b=N2rdJ7G8xc0sis7X6MJSqs9Uamt25L3bG6/yewqWpGK7CO9SALVaAayT+gjB39wFie
 AaDzoeS8FTHMdNoR/361rqBGr+iPPpmK29Ku6UX8SFhALGDpqRDfQeYaoEfUSGIoJmMn
 HGCRkFJLGAmido+0Fs7Bdi19TAsxDSHB2BM8v7vruvn4hsnrpmMoUzvtmwyLsgEa04Im
 42yFvHJMZhy+q+kgprRgZlGasfgA1gMp2OHIrGKtYoFGqZMQ954k8Xqgk7WFbMNT2nYU
 syPzVwCzSVpKXETagP/O/GjFSw6rtEdRLqOWdW5niP7dr8jbow1Am24HYf5Mb45RgC11
 03gw==
X-Gm-Message-State: AOAM5311VyLuftpX6wpd5JwOenqyd7ZzOTgiR8fwT+iAP9r89U95907m
 g6uTLk/JJnjHbcCV+e4qJf7xW4CeFUtMEw==
X-Google-Smtp-Source: ABdhPJynaUdw0cL24VPHKuwLMvVQCWLtF4qVFNhOWznD/sR29cSv/Nil8HkSdxS5NbVPVXctVcFXRA==
X-Received: by 2002:a19:8247:: with SMTP id e68mr304829lfd.65.1599809518529;
 Fri, 11 Sep 2020 00:31:58 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id a12sm365545ljk.109.2020.09.11.00.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 00:31:58 -0700 (PDT)
Date: Fri, 11 Sep 2020 09:31:57 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/6] hw/dma/xilinx_axidma: Rename StreamSlave as StreamSink
Message-ID: <20200911073157.GD2954729@toto>
References: <20200910070131.435543-1-philmd@redhat.com>
 <20200910070131.435543-4-philmd@redhat.com>
 <71dad67c-a36e-8cd1-1f47-7a9bba1c74b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71dad67c-a36e-8cd1-1f47-7a9bba1c74b0@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=1.8, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 11, 2020 at 09:28:34AM +0200, Paolo Bonzini wrote:
> On 10/09/20 09:01, Philippe Mathieu-Daudé wrote:
> > In order to use inclusive terminology, rename 'slave stream'
> > as 'sink stream'.
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > ---
> >  hw/dma/xilinx_axidma.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> > index cf12a852ea1..19e14a2997e 100644
> > --- a/hw/dma/xilinx_axidma.c
> > +++ b/hw/dma/xilinx_axidma.c
> > @@ -46,11 +46,11 @@
> >       OBJECT_CHECK(XilinxAXIDMA, (obj), TYPE_XILINX_AXI_DMA)
> >  
> >  #define XILINX_AXI_DMA_DATA_STREAM(obj) \
> > -     OBJECT_CHECK(XilinxAXIDMAStreamSlave, (obj),\
> > +     OBJECT_CHECK(XilinxAXIDMAStreamSink, (obj),\
> >       TYPE_XILINX_AXI_DMA_DATA_STREAM)
> >  
> >  #define XILINX_AXI_DMA_CONTROL_STREAM(obj) \
> > -     OBJECT_CHECK(XilinxAXIDMAStreamSlave, (obj),\
> > +     OBJECT_CHECK(XilinxAXIDMAStreamSink, (obj),\
> >       TYPE_XILINX_AXI_DMA_CONTROL_STREAM)
> >  
> >  #define R_DMACR             (0x00 / 4)
> > @@ -63,7 +63,7 @@
> >  #define CONTROL_PAYLOAD_SIZE (CONTROL_PAYLOAD_WORDS * (sizeof(uint32_t)))
> >  
> >  typedef struct XilinxAXIDMA XilinxAXIDMA;
> > -typedef struct XilinxAXIDMAStreamSlave XilinxAXIDMAStreamSlave;
> > +typedef struct XilinxAXIDMAStreamSink XilinxAXIDMAStreamSink;
> >  
> >  enum {
> >      DMACR_RUNSTOP = 1,
> > @@ -118,7 +118,7 @@ struct Stream {
> >      unsigned char txbuf[16 * 1024];
> >  };
> >  
> > -struct XilinxAXIDMAStreamSlave {
> > +struct XilinxAXIDMAStreamSink {
> >      Object parent;
> >  
> >      struct XilinxAXIDMA *dma;
> > @@ -133,8 +133,8 @@ struct XilinxAXIDMA {
> >      uint32_t freqhz;
> >      StreamSink *tx_data_dev;
> >      StreamSink *tx_control_dev;
> > -    XilinxAXIDMAStreamSlave rx_data_dev;
> > -    XilinxAXIDMAStreamSlave rx_control_dev;
> > +    XilinxAXIDMAStreamSink rx_data_dev;
> > +    XilinxAXIDMAStreamSink rx_control_dev;
> >  
> >      struct Stream streams[2];
> >  
> > @@ -390,7 +390,7 @@ static size_t
> >  xilinx_axidma_control_stream_push(StreamSink *obj, unsigned char *buf,
> >                                    size_t len, bool eop)
> >  {
> > -    XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(obj);
> > +    XilinxAXIDMAStreamSink *cs = XILINX_AXI_DMA_CONTROL_STREAM(obj);
> >      struct Stream *s = &cs->dma->streams[1];
> >  
> >      if (len != CONTROL_PAYLOAD_SIZE) {
> > @@ -407,7 +407,7 @@ xilinx_axidma_data_stream_can_push(StreamSink *obj,
> >                                     StreamCanPushNotifyFn notify,
> >                                     void *notify_opaque)
> >  {
> > -    XilinxAXIDMAStreamSlave *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
> > +    XilinxAXIDMAStreamSink *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
> >      struct Stream *s = &ds->dma->streams[1];
> >  
> >      if (!stream_running(s) || stream_idle(s)) {
> > @@ -423,7 +423,7 @@ static size_t
> >  xilinx_axidma_data_stream_push(StreamSink *obj, unsigned char *buf, size_t len,
> >                                 bool eop)
> >  {
> > -    XilinxAXIDMAStreamSlave *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
> > +    XilinxAXIDMAStreamSink *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
> >      struct Stream *s = &ds->dma->streams[1];
> >      size_t ret;
> >  
> > @@ -534,8 +534,8 @@ static const MemoryRegionOps axidma_ops = {
> >  static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
> >  {
> >      XilinxAXIDMA *s = XILINX_AXI_DMA(dev);
> > -    XilinxAXIDMAStreamSlave *ds = XILINX_AXI_DMA_DATA_STREAM(&s->rx_data_dev);
> > -    XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(
> > +    XilinxAXIDMAStreamSink *ds = XILINX_AXI_DMA_DATA_STREAM(&s->rx_data_dev);
> > +    XilinxAXIDMAStreamSink *cs = XILINX_AXI_DMA_CONTROL_STREAM(
> >                                                              &s->rx_control_dev);
> >      int i;
> >  
> > @@ -634,7 +634,7 @@ static const TypeInfo axidma_info = {
> >  static const TypeInfo xilinx_axidma_data_stream_info = {
> >      .name          = TYPE_XILINX_AXI_DMA_DATA_STREAM,
> >      .parent        = TYPE_OBJECT,
> > -    .instance_size = sizeof(struct XilinxAXIDMAStreamSlave),
> > +    .instance_size = sizeof(struct XilinxAXIDMAStreamSink),
> >      .class_init    = xilinx_axidma_stream_class_init,
> >      .class_data    = &xilinx_axidma_data_stream_class,
> >      .interfaces = (InterfaceInfo[]) {
> > @@ -646,7 +646,7 @@ static const TypeInfo xilinx_axidma_data_stream_info = {
> >  static const TypeInfo xilinx_axidma_control_stream_info = {
> >      .name          = TYPE_XILINX_AXI_DMA_CONTROL_STREAM,
> >      .parent        = TYPE_OBJECT,
> > -    .instance_size = sizeof(struct XilinxAXIDMAStreamSlave),
> > +    .instance_size = sizeof(struct XilinxAXIDMAStreamSink),
> >      .class_init    = xilinx_axidma_stream_class_init,
> >      .class_data    = &xilinx_axidma_control_stream_class,
> >      .interfaces = (InterfaceInfo[]) {
> > 
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



