Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60718C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2A3206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUizy0hK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2A3206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdDO-0000b1-Fn
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 10:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kNdAM-0005PK-Sg
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:33:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kNdAH-0002Ic-K3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:33:10 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601476384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v63GnPIUgaVaBNhYbb3kTHc8QbGwK8C0y29dLzJ6+Mo=;
 b=WUizy0hKAy59VdzqmigHdcq8hOgKx1CQMQGCcdR3AiW+hokh6POqrmcPDdHvyeh7wZrnCz
 ww+SV/yzBRcu3VHIEMpPUOCeehKybWBbRBGOD3hmyiUCgqGBCQkpODLsubi9P3jwHESEdk
 +yRI5gwA6yq7hWp+v0KwpTMioi7tGSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-2IC2iQOPORuVaFMhfBGiSg-1; Wed, 30 Sep 2020 10:33:02 -0400
X-MC-Unique: 2IC2iQOPORuVaFMhfBGiSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69F308030BE;
 Wed, 30 Sep 2020 14:33:01 +0000 (UTC)
Received: from starship (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AFE160C07;
 Wed, 30 Sep 2020 14:32:56 +0000 (UTC)
Message-ID: <0d124b6991e607e496da4afa39027320e617aa0e.camel@redhat.com>
Subject: Re: [PATCH 08/10] scsi/scsi_bus: Add scsi_device_get
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Date: Wed, 30 Sep 2020 17:32:55 +0300
In-Reply-To: <20200925172604.2142227-9-pbonzini@redhat.com>
References: <20200925172604.2142227-1-pbonzini@redhat.com>
 <20200925172604.2142227-9-pbonzini@redhat.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-09-25 at 13:26 -0400, Paolo Bonzini wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Add scsi_device_get which finds the scsi device
> and takes a reference to it.
> 
> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Message-Id: <20200913160259.32145-8-mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> 	Compared to Maxim's patch, I am avoiding the extra argument
> 	to do_scsi_device_find by moving the RCU_READ_LOCK_GUARD()
> 	out of do_scsi_device_find itself.
Which is a good idea, although my mindset was like, I got a device,
lets just grab a ref to it before it disappears and then do
whatever I want. The extra argument was ugly no doubt though.

Best regards,
	Maxim Levitsky

> 
>  hw/scsi/scsi-bus.c     | 11 +++++++++++
>  include/hw/scsi/scsi.h |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index 7599113efe..eda8cb7e70 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -73,6 +73,17 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
>      return do_scsi_device_find(bus, channel, id, lun, false);
>  }
>  
> +SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int id, int lun)
> +{
> +    SCSIDevice *d;
> +    RCU_READ_LOCK_GUARD();
> +    d = do_scsi_device_find(bus, channel, id, lun, false);
> +    if (d) {
> +        object_ref(d);
> +    }
> +    return d;
> +}
> +
>  static void scsi_device_realize(SCSIDevice *s, Error **errp)
>  {
>      SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(s);
> diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> index 7a55cdbd74..09fa5c9d2a 100644
> --- a/include/hw/scsi/scsi.h
> +++ b/include/hw/scsi/scsi.h
> @@ -190,6 +190,7 @@ int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed);
>  int scsi_SG_IO_FROM_DEV(BlockBackend *blk, uint8_t *cmd, uint8_t cmd_size,
>                          uint8_t *buf, uint8_t buf_size);
>  SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int target, int lun);
> +SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int target, int lun);
>  
>  /* scsi-generic.c. */
>  extern const SCSIReqOps scsi_generic_req_ops;



