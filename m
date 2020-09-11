Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2176C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1324B2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlP8nAm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1324B2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGdV5-0006A8-CR
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 03:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGdU8-0004yH-Ny
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 03:28:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGdU7-0001il-3j
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 03:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599809318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHiQFD3vupbkNfCoZoJphbTkUL+RRIYm7TfbINdW/ro=;
 b=NlP8nAm26DDbV+10ko1EiDZYdKkU95oipUXrk3ZHIXph00qBXv2dPIcEAGemH1/XprD0Kc
 S1hAI2bfTmMJaoXJ2RKKVAa0M/PF9k6uOAhkcegsr/5nxB/wrEr8C2ZjN/zSE58ULQR8h3
 gGd3/mihW/mtiI+QfK4S1MPd0/bhQfU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-M4vw0KiQM1-TvAradN3R9A-1; Fri, 11 Sep 2020 03:28:36 -0400
X-MC-Unique: M4vw0KiQM1-TvAradN3R9A-1
Received: by mail-ej1-f70.google.com with SMTP id w27so4168246ejb.12
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 00:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JHiQFD3vupbkNfCoZoJphbTkUL+RRIYm7TfbINdW/ro=;
 b=QOcLxBGNGoCPvh95fb45Ozuw2AnGhsh/dNVQ5qMr3ri9F3jaXEciGxPFmGSeue3+l8
 0rSt3RPg7R5ds07WOViVtpg0B9K5wdAIKRdRiWUgfRLEmfCiZKNJxtTxFzg35x9S77bs
 yza2rkzVLMsX31zE52FWkB3xUbh6wOvBmJLqOJ0N8+rNcnopHrD2XcljqZaaP7jSrrxD
 +I4+La+uvjm7tdCQxmeg9u6aKpYMY2c+i8kIgAnfR4Q6jabOLDC8D92KqFcWhMyuj/wo
 MtMFjBvpTz7VyYU47zBGnvCW0Ww2GXOMPjaHZ//KBjuiPlysFap7fUCeNe0IkQ6Qdo5q
 VGrg==
X-Gm-Message-State: AOAM531UVPUMMVlCL2J+BoYoqf21Ud5+oWPOPjKEQKNNLRd8CLNjOpZH
 Epfx8bkpIMCcKSv78wgAiusVklzvazy0iIwKkVf9EC2i+mBtu4Ein0K5juXxa/AWbv0KLy29ASy
 tIZ3KXrDZZ57bzZ8=
X-Received: by 2002:a05:6402:48a:: with SMTP id
 k10mr689728edv.22.1599809315428; 
 Fri, 11 Sep 2020 00:28:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJza8f0yx04MoOIRTr+QFfy5v71HO/nOCisyuoK5dyFG5uH4B/d9YBDbmug7x0U24mq2ASm0kw==
X-Received: by 2002:a05:6402:48a:: with SMTP id
 k10mr689714edv.22.1599809315254; 
 Fri, 11 Sep 2020 00:28:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6689:90a2:a29f:8336?
 ([2001:b07:6468:f312:6689:90a2:a29f:8336])
 by smtp.gmail.com with ESMTPSA id o93sm970877edd.75.2020.09.11.00.28.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 00:28:34 -0700 (PDT)
Subject: Re: [PATCH 3/6] hw/dma/xilinx_axidma: Rename StreamSlave as StreamSink
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200910070131.435543-1-philmd@redhat.com>
 <20200910070131.435543-4-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71dad67c-a36e-8cd1-1f47-7a9bba1c74b0@redhat.com>
Date: Fri, 11 Sep 2020 09:28:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910070131.435543-4-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 23:26:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Joel Stanley <joel@jms.id.au>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/20 09:01, Philippe Mathieu-Daudé wrote:
> In order to use inclusive terminology, rename 'slave stream'
> as 'sink stream'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/dma/xilinx_axidma.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index cf12a852ea1..19e14a2997e 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -46,11 +46,11 @@
>       OBJECT_CHECK(XilinxAXIDMA, (obj), TYPE_XILINX_AXI_DMA)
>  
>  #define XILINX_AXI_DMA_DATA_STREAM(obj) \
> -     OBJECT_CHECK(XilinxAXIDMAStreamSlave, (obj),\
> +     OBJECT_CHECK(XilinxAXIDMAStreamSink, (obj),\
>       TYPE_XILINX_AXI_DMA_DATA_STREAM)
>  
>  #define XILINX_AXI_DMA_CONTROL_STREAM(obj) \
> -     OBJECT_CHECK(XilinxAXIDMAStreamSlave, (obj),\
> +     OBJECT_CHECK(XilinxAXIDMAStreamSink, (obj),\
>       TYPE_XILINX_AXI_DMA_CONTROL_STREAM)
>  
>  #define R_DMACR             (0x00 / 4)
> @@ -63,7 +63,7 @@
>  #define CONTROL_PAYLOAD_SIZE (CONTROL_PAYLOAD_WORDS * (sizeof(uint32_t)))
>  
>  typedef struct XilinxAXIDMA XilinxAXIDMA;
> -typedef struct XilinxAXIDMAStreamSlave XilinxAXIDMAStreamSlave;
> +typedef struct XilinxAXIDMAStreamSink XilinxAXIDMAStreamSink;
>  
>  enum {
>      DMACR_RUNSTOP = 1,
> @@ -118,7 +118,7 @@ struct Stream {
>      unsigned char txbuf[16 * 1024];
>  };
>  
> -struct XilinxAXIDMAStreamSlave {
> +struct XilinxAXIDMAStreamSink {
>      Object parent;
>  
>      struct XilinxAXIDMA *dma;
> @@ -133,8 +133,8 @@ struct XilinxAXIDMA {
>      uint32_t freqhz;
>      StreamSink *tx_data_dev;
>      StreamSink *tx_control_dev;
> -    XilinxAXIDMAStreamSlave rx_data_dev;
> -    XilinxAXIDMAStreamSlave rx_control_dev;
> +    XilinxAXIDMAStreamSink rx_data_dev;
> +    XilinxAXIDMAStreamSink rx_control_dev;
>  
>      struct Stream streams[2];
>  
> @@ -390,7 +390,7 @@ static size_t
>  xilinx_axidma_control_stream_push(StreamSink *obj, unsigned char *buf,
>                                    size_t len, bool eop)
>  {
> -    XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(obj);
> +    XilinxAXIDMAStreamSink *cs = XILINX_AXI_DMA_CONTROL_STREAM(obj);
>      struct Stream *s = &cs->dma->streams[1];
>  
>      if (len != CONTROL_PAYLOAD_SIZE) {
> @@ -407,7 +407,7 @@ xilinx_axidma_data_stream_can_push(StreamSink *obj,
>                                     StreamCanPushNotifyFn notify,
>                                     void *notify_opaque)
>  {
> -    XilinxAXIDMAStreamSlave *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
> +    XilinxAXIDMAStreamSink *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
>      struct Stream *s = &ds->dma->streams[1];
>  
>      if (!stream_running(s) || stream_idle(s)) {
> @@ -423,7 +423,7 @@ static size_t
>  xilinx_axidma_data_stream_push(StreamSink *obj, unsigned char *buf, size_t len,
>                                 bool eop)
>  {
> -    XilinxAXIDMAStreamSlave *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
> +    XilinxAXIDMAStreamSink *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
>      struct Stream *s = &ds->dma->streams[1];
>      size_t ret;
>  
> @@ -534,8 +534,8 @@ static const MemoryRegionOps axidma_ops = {
>  static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
>  {
>      XilinxAXIDMA *s = XILINX_AXI_DMA(dev);
> -    XilinxAXIDMAStreamSlave *ds = XILINX_AXI_DMA_DATA_STREAM(&s->rx_data_dev);
> -    XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(
> +    XilinxAXIDMAStreamSink *ds = XILINX_AXI_DMA_DATA_STREAM(&s->rx_data_dev);
> +    XilinxAXIDMAStreamSink *cs = XILINX_AXI_DMA_CONTROL_STREAM(
>                                                              &s->rx_control_dev);
>      int i;
>  
> @@ -634,7 +634,7 @@ static const TypeInfo axidma_info = {
>  static const TypeInfo xilinx_axidma_data_stream_info = {
>      .name          = TYPE_XILINX_AXI_DMA_DATA_STREAM,
>      .parent        = TYPE_OBJECT,
> -    .instance_size = sizeof(struct XilinxAXIDMAStreamSlave),
> +    .instance_size = sizeof(struct XilinxAXIDMAStreamSink),
>      .class_init    = xilinx_axidma_stream_class_init,
>      .class_data    = &xilinx_axidma_data_stream_class,
>      .interfaces = (InterfaceInfo[]) {
> @@ -646,7 +646,7 @@ static const TypeInfo xilinx_axidma_data_stream_info = {
>  static const TypeInfo xilinx_axidma_control_stream_info = {
>      .name          = TYPE_XILINX_AXI_DMA_CONTROL_STREAM,
>      .parent        = TYPE_OBJECT,
> -    .instance_size = sizeof(struct XilinxAXIDMAStreamSlave),
> +    .instance_size = sizeof(struct XilinxAXIDMAStreamSink),
>      .class_init    = xilinx_axidma_stream_class_init,
>      .class_data    = &xilinx_axidma_control_stream_class,
>      .interfaces = (InterfaceInfo[]) {
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


