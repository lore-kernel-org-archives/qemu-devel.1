Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B95C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01E520721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I78ZfVMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01E520721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZDO-0002Bn-RR
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 07:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jVZCl-0001lL-63
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:24:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28685
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jVZCk-0004L9-DE
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588591449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/b1LOrKMZgwZXLajq8hx584XUARBCXR7aaxsxvcFgSs=;
 b=I78ZfVMkCyITs1R5UOBScmEBa6UUu3RAmggjFS1OloHHC7bZ/kuS+S7gLSJSBE2OjOBCKM
 TMf5v36mKbMFsIXTesd/uHZpjbak2Zw7rEYXaNzimm2Q7l46jDqcWJe4j74UI6xh2FmQuk
 3inSOXAaqUxZFq+rt4S+XpeUqgOuoks=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-pXp6qM-pO1mYpYXtRj_izQ-1; Mon, 04 May 2020 07:24:08 -0400
X-MC-Unique: pXp6qM-pO1mYpYXtRj_izQ-1
Received: by mail-wr1-f69.google.com with SMTP id f15so10641472wrj.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 04:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/b1LOrKMZgwZXLajq8hx584XUARBCXR7aaxsxvcFgSs=;
 b=VWiQ1ppXmbsfXxr8Ke8G7pDMUBaI/RxUNOZZgn1mUNyXr999wkRudq5RLno8BdDz+7
 9mMHu1qrntLQdUUMkDBz7Xa4iUBekhvh8em09UXemNevLVixRbrwTpG3ypAiCGLDYPbY
 87jCivLTAbqujfnKby+qiav+Fb3dKHNDTVvXmrIb9wV47gbxFBW+RsHI/0Bu6RiQpi5U
 H/FJPmDt68zAHsT35tKMYnfHpEJziE0ShSludr0QlXWLHwEP5Pm6yiBxhwT+8S8y7Jei
 RCqlmWePT12hhBrBApNFtPxWTUZnC6D4z4yvip2OtrqWdAISPHBBxsSoB7078RU0BRAO
 oA+g==
X-Gm-Message-State: AGi0PuZA1jiTFxPUWLUQYSQ8LoszPna3gdCbwbQClDFnBuNcNxnjL20F
 9T/Bh6sGmM5LRSEN7Ae0SbnSfVbuidlD/Jt6ZJCa32WSxPZVftFziOBuX0KUbgwKHiuRTJCOtaQ
 /yQmAU/fNEkzJN8k=
X-Received: by 2002:a5d:490f:: with SMTP id x15mr17765860wrq.37.1588591446331; 
 Mon, 04 May 2020 04:24:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypLQa3sSeOz197wlJ4EF/Hj4fpbUTGm3NRS/mSBZS7L0PB65KuUWbmF+wKRhe0Vfw1y0lR63lQ==
X-Received: by 2002:a5d:490f:: with SMTP id x15mr17765843wrq.37.1588591446069; 
 Mon, 04 May 2020 04:24:06 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
 by smtp.gmail.com with ESMTPSA id x18sm17209822wrs.11.2020.05.04.04.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 04:24:05 -0700 (PDT)
Subject: Re: [PATCH 4/4] virtio-scsi: don't touch scsi devices that are not
 yet realized
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200416203624.32366-1-mlevitsk@redhat.com>
 <20200416203624.32366-5-mlevitsk@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c2d18ca0-3ba1-542c-f821-f06e1b1f4988@redhat.com>
Date: Mon, 4 May 2020 13:24:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416203624.32366-5-mlevitsk@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/04/20 22:36, Maxim Levitsky wrote:
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1812399
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/scsi/virtio-scsi.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index b0f4a35f81..e360b4e03e 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -35,13 +35,29 @@ static inline int virtio_scsi_get_lun(uint8_t *lun)
>  
>  static inline SCSIDevice *virtio_scsi_device_find(VirtIOSCSI *s, uint8_t *lun)
>  {
> +    SCSIDevice *device = NULL;
> +
>      if (lun[0] != 1) {
>          return NULL;
>      }
>      if (lun[2] != 0 && !(lun[2] >= 0x40 && lun[2] < 0x80)) {
>          return NULL;
>      }
> -    return scsi_device_find(&s->bus, 0, lun[1], virtio_scsi_get_lun(lun));
> +
> +    device = scsi_device_find(&s->bus, 0, lun[1], virtio_scsi_get_lun(lun));
> +
> +    /* This function might run on the IO thread and we might race against
> +     * main thread hot-plugging the device.
> +     *
> +     * We assume that as soon as .realized is set to true we can let
> +     * the user access the device.
> +     */

Likewise this needs to be load-acquire.

Paolo

> +    if (!device || !atomic_read(&device->qdev.realized)) {
> +        return NULL;
> +    }
> +
> +    return device;
>  }
>  
>  void virtio_scsi_init_req(VirtIOSCSI *s, VirtQueue *vq, VirtIOSCSIReq *req)
> 


