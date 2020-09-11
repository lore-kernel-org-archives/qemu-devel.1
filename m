Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85F3C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A14421D91
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNV2LkEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A14421D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGdYZ-0001Od-Jw
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 03:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kGdXd-0000G2-7S; Fri, 11 Sep 2020 03:32:17 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:43328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kGdXb-0002FL-Qe; Fri, 11 Sep 2020 03:32:16 -0400
Received: by mail-lf1-x143.google.com with SMTP id y2so4953487lfy.10;
 Fri, 11 Sep 2020 00:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=LHK4F2MqWd5dXKy2V+64wHdCsq3BPH6G32kaFVS1Kgg=;
 b=UNV2LkEjubfC/T5nSdh5SJQEeFEi+/GuTRy/PdeUmphzfexU206EnRai71uF2gRuaA
 IzvGp1pSIwarpiPgMDh1q8s8jH8rE0hyo3KMsCt68m0uRFNYIKpoTBbEs+gG0gA1Bm7B
 coX9xzWLNnjUtL1klXrTbpYVZBlCrFnSqCFCnQiY+Xc6vz8amBpGd+V0uQ7LeF256iPo
 7Hn/qLsgr/Y6sCDJgMyfj5L4Hr5+WwWHkIYK8YUs1TehOZDpoDM/ly3ZvJfFcfSp5Z2V
 j65gPkHQWFVCq0S2N6MvkqyLUCq5UIoz+tuVlXjfqd3LGBdwxpVhi3UEsx2FrffvdZVn
 ENNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=LHK4F2MqWd5dXKy2V+64wHdCsq3BPH6G32kaFVS1Kgg=;
 b=l59QQQN7U2u3vqrR0YfXgcpnmhHU0wMwYO44VRtFO6j8O09ErdVtprsaqH2F6Ca6Td
 gb/la7Cp2aY/8hQaWlZOioHXoRNj6n4jJ01+4UrFlRaYwjVSOqb69P6/WaZgUO+IfwNk
 QI9YhLEfF9SncOZA7U7arhKk2tj1rvC+DZEVfBGz4jpPCV+J0hcC5ImOOe4uIkc6HxSa
 Ronkyl2Bm7vMOrGeoH0W2uWdFJlwdac1fVEG5cmz57QfIVoCG+/8Qs33/wFwzEQOCHrS
 qtLo0d0oBThR5QriDryTjz163F2f5fL+AXTFjttNEBgIEizH1czBlP9V2bM4iIhTraxR
 K2MQ==
X-Gm-Message-State: AOAM533HZHVOTyljZ51K95vLdDC3AIs+5oO3K/THWBuZ4anLdPlQhO0e
 OjGOyaS6zmHRxY5RaaKvg7o=
X-Google-Smtp-Source: ABdhPJxyeuqUgihgOc4fwupdHuaN5J/O1r9PTCdHVhBWU7k75LyYISClw14MKQIX4EKOUkT1VwT9LQ==
X-Received: by 2002:a19:ca48:: with SMTP id h8mr297019lfj.173.1599809532525;
 Fri, 11 Sep 2020 00:32:12 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id j4sm362441ljc.116.2020.09.11.00.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 00:32:11 -0700 (PDT)
Date: Fri, 11 Sep 2020 09:32:11 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/6] hw/net/xilinx_axienet: Rename StreamSlave as
 StreamSink
Message-ID: <20200911073211.GE2954729@toto>
References: <20200910070131.435543-1-philmd@redhat.com>
 <20200910070131.435543-5-philmd@redhat.com>
 <9214b56d-59e7-1229-bf01-b6dca0445014@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9214b56d-59e7-1229-bf01-b6dca0445014@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x143.google.com
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

On Fri, Sep 11, 2020 at 09:28:38AM +0200, Paolo Bonzini wrote:
> On 10/09/20 09:01, Philippe Mathieu-Daudé wrote:
> > In order to use inclusive terminology, rename 'slave stream'
> > as 'sink stream'.
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > ---
> >  hw/net/xilinx_axienet.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> > index 0c4ac727207..4e48535f373 100644
> > --- a/hw/net/xilinx_axienet.c
> > +++ b/hw/net/xilinx_axienet.c
> > @@ -46,11 +46,11 @@
> >       OBJECT_CHECK(XilinxAXIEnet, (obj), TYPE_XILINX_AXI_ENET)
> >  
> >  #define XILINX_AXI_ENET_DATA_STREAM(obj) \
> > -     OBJECT_CHECK(XilinxAXIEnetStreamSlave, (obj),\
> > +     OBJECT_CHECK(XilinxAXIEnetStreamSink, (obj),\
> >       TYPE_XILINX_AXI_ENET_DATA_STREAM)
> >  
> >  #define XILINX_AXI_ENET_CONTROL_STREAM(obj) \
> > -     OBJECT_CHECK(XilinxAXIEnetStreamSlave, (obj),\
> > +     OBJECT_CHECK(XilinxAXIEnetStreamSink, (obj),\
> >       TYPE_XILINX_AXI_ENET_CONTROL_STREAM)
> >  
> >  /* Advertisement control register. */
> > @@ -310,10 +310,10 @@ struct TEMAC  {
> >      void *parent;
> >  };
> >  
> > -typedef struct XilinxAXIEnetStreamSlave XilinxAXIEnetStreamSlave;
> > +typedef struct XilinxAXIEnetStreamSink XilinxAXIEnetStreamSink;
> >  typedef struct XilinxAXIEnet XilinxAXIEnet;
> >  
> > -struct XilinxAXIEnetStreamSlave {
> > +struct XilinxAXIEnetStreamSink {
> >      Object parent;
> >  
> >      struct XilinxAXIEnet *enet;
> > @@ -325,8 +325,8 @@ struct XilinxAXIEnet {
> >      qemu_irq irq;
> >      StreamSink *tx_data_dev;
> >      StreamSink *tx_control_dev;
> > -    XilinxAXIEnetStreamSlave rx_data_dev;
> > -    XilinxAXIEnetStreamSlave rx_control_dev;
> > +    XilinxAXIEnetStreamSink rx_data_dev;
> > +    XilinxAXIEnetStreamSink rx_control_dev;
> >      NICState *nic;
> >      NICConf conf;
> >  
> > @@ -859,7 +859,7 @@ xilinx_axienet_control_stream_push(StreamSink *obj, uint8_t *buf, size_t len,
> >                                     bool eop)
> >  {
> >      int i;
> > -    XilinxAXIEnetStreamSlave *cs = XILINX_AXI_ENET_CONTROL_STREAM(obj);
> > +    XilinxAXIEnetStreamSink *cs = XILINX_AXI_ENET_CONTROL_STREAM(obj);
> >      XilinxAXIEnet *s = cs->enet;
> >  
> >      assert(eop);
> > @@ -880,7 +880,7 @@ static size_t
> >  xilinx_axienet_data_stream_push(StreamSink *obj, uint8_t *buf, size_t size,
> >                                  bool eop)
> >  {
> > -    XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(obj);
> > +    XilinxAXIEnetStreamSink *ds = XILINX_AXI_ENET_DATA_STREAM(obj);
> >      XilinxAXIEnet *s = ds->enet;
> >  
> >      /* TX enable ?  */
> > @@ -954,8 +954,8 @@ static NetClientInfo net_xilinx_enet_info = {
> >  static void xilinx_enet_realize(DeviceState *dev, Error **errp)
> >  {
> >      XilinxAXIEnet *s = XILINX_AXI_ENET(dev);
> > -    XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(&s->rx_data_dev);
> > -    XilinxAXIEnetStreamSlave *cs = XILINX_AXI_ENET_CONTROL_STREAM(
> > +    XilinxAXIEnetStreamSink *ds = XILINX_AXI_ENET_DATA_STREAM(&s->rx_data_dev);
> > +    XilinxAXIEnetStreamSink *cs = XILINX_AXI_ENET_CONTROL_STREAM(
> >                                                              &s->rx_control_dev);
> >  
> >      object_property_add_link(OBJECT(ds), "enet", "xlnx.axi-ethernet",
> > @@ -1046,7 +1046,7 @@ static const TypeInfo xilinx_enet_info = {
> >  static const TypeInfo xilinx_enet_data_stream_info = {
> >      .name          = TYPE_XILINX_AXI_ENET_DATA_STREAM,
> >      .parent        = TYPE_OBJECT,
> > -    .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
> > +    .instance_size = sizeof(struct XilinxAXIEnetStreamSink),
> >      .class_init    = xilinx_enet_data_stream_class_init,
> >      .interfaces = (InterfaceInfo[]) {
> >              { TYPE_STREAM_SINK },
> > @@ -1057,7 +1057,7 @@ static const TypeInfo xilinx_enet_data_stream_info = {
> >  static const TypeInfo xilinx_enet_control_stream_info = {
> >      .name          = TYPE_XILINX_AXI_ENET_CONTROL_STREAM,
> >      .parent        = TYPE_OBJECT,
> > -    .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
> > +    .instance_size = sizeof(struct XilinxAXIEnetStreamSink),
> >      .class_init    = xilinx_enet_control_stream_class_init,
> >      .interfaces = (InterfaceInfo[]) {
> >              { TYPE_STREAM_SINK },
> > 
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


