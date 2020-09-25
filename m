Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8C1C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF40B2076D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEHVWJrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF40B2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnus-0000Yi-NX
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLntd-00086u-TV
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLntc-0007SA-6s
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:36:21 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601040979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xV0f8rWfCSVkB9ygWYO9T3DRi1uN9qWUNPxI6C5JTi8=;
 b=jEHVWJrR4XUliqwxZSa/Au495s1Y02o4I6RPYtcAh0jMBjr5grKAVK8n2YS79wPj14cDMd
 iMORWHWRzcVsd8n9pJIpOrXL+Ydzb3PmQfDVMHuMv6LVAw45TYjQGD5TDrU3s+Ow6kRRpt
 T5A34wEohcHg48qkWup0QcpEnrSGe3s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-2fXJ0LqENSmyYn21mWCHww-1; Fri, 25 Sep 2020 09:36:15 -0400
X-MC-Unique: 2fXJ0LqENSmyYn21mWCHww-1
Received: by mail-wm1-f72.google.com with SMTP id s24so849163wmh.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 06:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xV0f8rWfCSVkB9ygWYO9T3DRi1uN9qWUNPxI6C5JTi8=;
 b=pjHRxDnFMXcSnzQ63WVXGccuZ3l//qUtsaLM0z8h8abopNvc8eTPMoepyUb1VBdmm9
 ngainmSYMknvM+hcQfgG9CBlDUxPBYtsGRGNcU0tfa2tOxja8I8kS2+2dOdJvAC/GbWU
 Te8LTxAxsxJ0IBc1i7NJZT02eL5fhE+f00XCXYMF+75fHbCcbZEwSxqhtnTM3KONP94x
 LfDgVq3484IH276EXHOjwVNPKxfDqxz8kX0N8nXukwzWfJ5T8wLYj0M01DCkg7OZkuYs
 VufND4Sn3Nr/BeBq8Nr0aWyEl3UbvWYTpUwvq3+Y6IJTqHeFDtUiRkbmyP1pDyGo+wbY
 +JeQ==
X-Gm-Message-State: AOAM533CxEnvrbEo9ihfTaqqZdrDGgo+juJNfu97rK9bfZKCLbYRcoOM
 FpQANmz4NyJm1U/hzwdH0ZZL5tea+EwGNSsqQi710BUC/CxKL+2BHs+PHZofmoAbLHgdF56bZic
 c74yWdVKfOh3cwBU=
X-Received: by 2002:adf:e7c8:: with SMTP id e8mr4816525wrn.358.1601040973687; 
 Fri, 25 Sep 2020 06:36:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaoLQ5ttO3KskLnk7XtTaYC1ukm1h48HPVbnusnBWpLBuYuK4d//0lQfyNFT6x239ZQBTNzQ==
X-Received: by 2002:adf:e7c8:: with SMTP id e8mr4816495wrn.358.1601040973347; 
 Fri, 25 Sep 2020 06:36:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id a5sm3032946wrp.37.2020.09.25.06.36.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 06:36:12 -0700 (PDT)
Subject: Re: [PATCH v5 1/9] scsi/scsi_bus: switch search direction in
 scsi_device_find
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200913160259.32145-1-mlevitsk@redhat.com>
 <20200913160259.32145-2-mlevitsk@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe635b2e-fb7f-12e3-d228-2e626abe7474@redhat.com>
Date: Fri, 25 Sep 2020 15:36:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200913160259.32145-2-mlevitsk@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/09/20 18:02, Maxim Levitsky wrote:
> This change will allow us to convert the bus children list to RCU,
> while not changing the logic of this function
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/scsi/scsi-bus.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index df65cc2223..f8adfbc2a5 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -1572,7 +1572,7 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
>      BusChild *kid;
>      SCSIDevice *target_dev = NULL;
>  
> -    QTAILQ_FOREACH_REVERSE(kid, &bus->qbus.children, sibling) {
> +    QTAILQ_FOREACH(kid, &bus->qbus.children, sibling) {
>          DeviceState *qdev = kid->child;
>          SCSIDevice *dev = SCSI_DEVICE(qdev);
>  
> @@ -1580,7 +1580,15 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
>              if (dev->lun == lun) {
>                  return dev;
>              }
> -            target_dev = dev;
> +
> +            /*
> +             * If we don't find exact match (channel/bus/lun),
> +             * we will return the first device which matches channel/bus
> +             */
> +
> +            if (!target_dev) {
> +                target_dev = dev;
> +            }
>          }
>      }
>      return target_dev;
> 

I think this breaks the detection of duplicate LUNs.  I'll play with it
and let you know.

Paolo


