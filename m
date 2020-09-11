Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C499CC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E532078D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQZH1FWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E532078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGdWa-0007cj-5s
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 03:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGdUD-00056e-Ml
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 03:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGdUA-0001j7-H7
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 03:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599809321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/UD7ECwp4WuKH9NLuZzUXFZF2DqwUuCPjbSxMoZcruU=;
 b=BQZH1FWZcZg+nM2EaVNiW/D8eTC3wdhcRyLNgO0Czj8JhgF2ip3I8MN0Bhq9ReN2qoZzZC
 qfGtxlZq16qj5WGwrcbVokdMpBZ1Ni7jNstBHvkonhP8Q41U0gyt1ZTysda1Wrxl4PA9Cs
 zhlWBiWEyG+LSCQSbLdsDyfwo1m+7Ac=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-dgMGACbEOeOzxRpGHQ8IXg-1; Fri, 11 Sep 2020 03:28:40 -0400
X-MC-Unique: dgMGACbEOeOzxRpGHQ8IXg-1
Received: by mail-ed1-f72.google.com with SMTP id m88so3915375ede.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 00:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/UD7ECwp4WuKH9NLuZzUXFZF2DqwUuCPjbSxMoZcruU=;
 b=XBB70mSLJmvPJtlfLG2hfIA9Prqq5SuDPhTZZCJ5yQBkp3Hrzq21I4ZkfBoET4/w/5
 4L/gaqZecyrlkJnq+oxkiE8z5pgdo5oDuyPfklyyQ5EWurks4ct9NZXosk7kKZPNWdh5
 JmwnENIs/cGj8gL1jeWZUAGzNXKzfzE0+rGcPkdvX4M6zFeur+ZKrW/IMKvktiJat0M3
 8FlgZag7NzKMueAsI/DYrcZJ7r09/xwy8yU5kVfm5372uX2Z2PNAotH9ZjGYVihfnhfP
 LASbe0aQ016kBHuSCrw9cIFqfbzVcW60F4mybeaSvZgrNz8MhEY8Q+SoLsGKWIWBnUz2
 5PEQ==
X-Gm-Message-State: AOAM533d8M1KslcGKWrI8R4flN107shmUKzCpy4CGY2Fo4NH4XPnqPc+
 M/RtpbRCgMOmCQLCV6bSU3SXtbGhKaSj9pdJVKB5MnMJeEN0tRR6llPJAQNXu5mhwv4DpGSJmeM
 NsG7+pB6tmpYMQvw=
X-Received: by 2002:a17:906:3755:: with SMTP id
 e21mr758719ejc.39.1599809318738; 
 Fri, 11 Sep 2020 00:28:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhw0+AphNUR8XWpzNszy2xpzq+VafpJOf0gykSCDf8EMJ2JEc2iVCtKmLEonOq0RmFlJulWA==
X-Received: by 2002:a17:906:3755:: with SMTP id
 e21mr758688ejc.39.1599809318522; 
 Fri, 11 Sep 2020 00:28:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6689:90a2:a29f:8336?
 ([2001:b07:6468:f312:6689:90a2:a29f:8336])
 by smtp.gmail.com with ESMTPSA id f13sm947456edn.73.2020.09.11.00.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 00:28:37 -0700 (PDT)
Subject: Re: [PATCH 4/6] hw/net/xilinx_axienet: Rename StreamSlave as
 StreamSink
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200910070131.435543-1-philmd@redhat.com>
 <20200910070131.435543-5-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9214b56d-59e7-1229-bf01-b6dca0445014@redhat.com>
Date: Fri, 11 Sep 2020 09:28:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910070131.435543-5-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:12:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
>  hw/net/xilinx_axienet.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 0c4ac727207..4e48535f373 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -46,11 +46,11 @@
>       OBJECT_CHECK(XilinxAXIEnet, (obj), TYPE_XILINX_AXI_ENET)
>  
>  #define XILINX_AXI_ENET_DATA_STREAM(obj) \
> -     OBJECT_CHECK(XilinxAXIEnetStreamSlave, (obj),\
> +     OBJECT_CHECK(XilinxAXIEnetStreamSink, (obj),\
>       TYPE_XILINX_AXI_ENET_DATA_STREAM)
>  
>  #define XILINX_AXI_ENET_CONTROL_STREAM(obj) \
> -     OBJECT_CHECK(XilinxAXIEnetStreamSlave, (obj),\
> +     OBJECT_CHECK(XilinxAXIEnetStreamSink, (obj),\
>       TYPE_XILINX_AXI_ENET_CONTROL_STREAM)
>  
>  /* Advertisement control register. */
> @@ -310,10 +310,10 @@ struct TEMAC  {
>      void *parent;
>  };
>  
> -typedef struct XilinxAXIEnetStreamSlave XilinxAXIEnetStreamSlave;
> +typedef struct XilinxAXIEnetStreamSink XilinxAXIEnetStreamSink;
>  typedef struct XilinxAXIEnet XilinxAXIEnet;
>  
> -struct XilinxAXIEnetStreamSlave {
> +struct XilinxAXIEnetStreamSink {
>      Object parent;
>  
>      struct XilinxAXIEnet *enet;
> @@ -325,8 +325,8 @@ struct XilinxAXIEnet {
>      qemu_irq irq;
>      StreamSink *tx_data_dev;
>      StreamSink *tx_control_dev;
> -    XilinxAXIEnetStreamSlave rx_data_dev;
> -    XilinxAXIEnetStreamSlave rx_control_dev;
> +    XilinxAXIEnetStreamSink rx_data_dev;
> +    XilinxAXIEnetStreamSink rx_control_dev;
>      NICState *nic;
>      NICConf conf;
>  
> @@ -859,7 +859,7 @@ xilinx_axienet_control_stream_push(StreamSink *obj, uint8_t *buf, size_t len,
>                                     bool eop)
>  {
>      int i;
> -    XilinxAXIEnetStreamSlave *cs = XILINX_AXI_ENET_CONTROL_STREAM(obj);
> +    XilinxAXIEnetStreamSink *cs = XILINX_AXI_ENET_CONTROL_STREAM(obj);
>      XilinxAXIEnet *s = cs->enet;
>  
>      assert(eop);
> @@ -880,7 +880,7 @@ static size_t
>  xilinx_axienet_data_stream_push(StreamSink *obj, uint8_t *buf, size_t size,
>                                  bool eop)
>  {
> -    XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(obj);
> +    XilinxAXIEnetStreamSink *ds = XILINX_AXI_ENET_DATA_STREAM(obj);
>      XilinxAXIEnet *s = ds->enet;
>  
>      /* TX enable ?  */
> @@ -954,8 +954,8 @@ static NetClientInfo net_xilinx_enet_info = {
>  static void xilinx_enet_realize(DeviceState *dev, Error **errp)
>  {
>      XilinxAXIEnet *s = XILINX_AXI_ENET(dev);
> -    XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(&s->rx_data_dev);
> -    XilinxAXIEnetStreamSlave *cs = XILINX_AXI_ENET_CONTROL_STREAM(
> +    XilinxAXIEnetStreamSink *ds = XILINX_AXI_ENET_DATA_STREAM(&s->rx_data_dev);
> +    XilinxAXIEnetStreamSink *cs = XILINX_AXI_ENET_CONTROL_STREAM(
>                                                              &s->rx_control_dev);
>  
>      object_property_add_link(OBJECT(ds), "enet", "xlnx.axi-ethernet",
> @@ -1046,7 +1046,7 @@ static const TypeInfo xilinx_enet_info = {
>  static const TypeInfo xilinx_enet_data_stream_info = {
>      .name          = TYPE_XILINX_AXI_ENET_DATA_STREAM,
>      .parent        = TYPE_OBJECT,
> -    .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
> +    .instance_size = sizeof(struct XilinxAXIEnetStreamSink),
>      .class_init    = xilinx_enet_data_stream_class_init,
>      .interfaces = (InterfaceInfo[]) {
>              { TYPE_STREAM_SINK },
> @@ -1057,7 +1057,7 @@ static const TypeInfo xilinx_enet_data_stream_info = {
>  static const TypeInfo xilinx_enet_control_stream_info = {
>      .name          = TYPE_XILINX_AXI_ENET_CONTROL_STREAM,
>      .parent        = TYPE_OBJECT,
> -    .instance_size = sizeof(struct XilinxAXIEnetStreamSlave),
> +    .instance_size = sizeof(struct XilinxAXIEnetStreamSink),
>      .class_init    = xilinx_enet_control_stream_class_init,
>      .interfaces = (InterfaceInfo[]) {
>              { TYPE_STREAM_SINK },
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


