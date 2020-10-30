Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27FCC55179
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C84820720
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7iFBde5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C84820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYQjO-0005VG-3c
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 05:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYQip-00054u-Lg
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYQin-00050w-3q
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604050159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/mcPPAzs9QXIBJeUvPMjqCXZtmWucFmmuhl6lIiATZ0=;
 b=E7iFBde5ga1aEuvdbvPRfhLnuIAgp9MEfHsT7TKCF+Awh7a40B/F7oJ/m4yGmMEs3Ms0RF
 MUyTBCqcsAxQOV9ce5kYwu8Xe1FCihsjnrLLzf6FR2toJNLRmxvS+/g3guq48rWy2wxn8Z
 fXWZw04wh/k0layNNXPnJkeOx3XlVTE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-9h57Dip4O3qyNUn_DXWeuw-1; Fri, 30 Oct 2020 05:29:16 -0400
X-MC-Unique: 9h57Dip4O3qyNUn_DXWeuw-1
Received: by mail-wm1-f69.google.com with SMTP id l12so445661wme.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 02:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/mcPPAzs9QXIBJeUvPMjqCXZtmWucFmmuhl6lIiATZ0=;
 b=BCWVAcshcOPztku/Ee+grPdtSx2P6aE8Nwas4WPmW0YF8gmYH0sctOwkn1u6aYWpsw
 4VGobhB6ZDsKfAQij+0ygshRhh2WPQ95qKKDuvu6wrrcZDuqfiWI7pS0na8gFyIvseFu
 Sl+j6Wxa9eMs7E1l9uSl8fgDJoIg4lyHxNaDsEz/TrgsnDwz24Mptjo/SXGRNTxIArXR
 GA5EExbeacZ7Wb0CzQr8sYEqR5+6qzamJE34f24r5JdlzvADDxaUYyn7PmVxCnpq3uSG
 rDI8tWSSb6F3B+fMOBMQ9qMxFpkpgXwEjD0KjqP8FXmUuaWudJjq41oFviy3fyp6OxDp
 lWAQ==
X-Gm-Message-State: AOAM530LuKUyDSIYZDdyKtv6l6xUjOzCUbgl0rpsocOImY2R21t6CsKa
 0oclUfcBw02sG9fBdLEFQqcQ8/9btg8+Z3GUiPc8mAQA9xUTcO6E2iGHOlrMZzH4yoUmAL9tWlA
 GYIQVFsGDQv8IdTo=
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr1551931wmj.89.1604050154787; 
 Fri, 30 Oct 2020 02:29:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRnelP4Evg5LZTL+zFoLN+oLoRdkT6wIv9MBHzeMpeCpKpXfyUPZ1iufISmNwQzbbHi548rw==
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr1551909wmj.89.1604050154572; 
 Fri, 30 Oct 2020 02:29:14 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id t5sm11122073wrb.21.2020.10.30.02.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 02:29:13 -0700 (PDT)
Date: Fri, 30 Oct 2020 05:29:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH] hw/9pfs: virtio-9p: Ensure config space is a multiple of
 4 bytes
Message-ID: <20201030051920-mutt-send-email-mst@kernel.org>
References: <1603959941-9689-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1603959941-9689-1-git-send-email-bmeng.cn@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 29, 2020 at 04:25:41PM +0800, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> At present the virtio device config space access is handled by the
> virtio_config_readX() and virtio_config_writeX() APIs. They perform
> a sanity check on the result of address plus size against the config
> space size before the access occurs.
> 
> For unaligned access, the last converted naturally aligned access
> will fail the sanity check on 9pfs. For example, with a mount_tag
> `p9fs`, if guest software tries to read the mount_tag via a 4 byte
> read at the mount_tag offset which is not 4 byte aligned, the read
> result will be `p9\377\377`, which is wrong.
> 
> This changes the size of device config space to be a multiple of 4
> bytes so that correct result can be returned in all circumstances.
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>



The patch is ok, but I'd like to clarify the commit log.

If I understand correctly, what happens is:
- tag is set to a value that is not a multiple of 4 bytes
- guest attempts to read the last 4 bytes of the tag
- access returns -1


What I find confusing in the above description:
- reference to unaligned access - I don't think these
  are legal or allowed by QEMU
- reference to `p9\377\377` - I think returned value will be -1

thanks!

> ---
> 
>  hw/9pfs/virtio-9p-device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 14371a7..e6a1432 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -201,6 +201,7 @@ static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
>      V9fsVirtioState *v = VIRTIO_9P(dev);
>      V9fsState *s = &v->state;
>      FsDriverEntry *fse = get_fsdev_fsentry(s->fsconf.fsdev_id);
> +    size_t config_size;
>  
>      if (qtest_enabled() && fse) {
>          fse->export_flags |= V9FS_NO_PERF_WARN;
> @@ -211,7 +212,8 @@ static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
>      }
>  
>      v->config_size = sizeof(struct virtio_9p_config) + strlen(s->fsconf.tag);
> -    virtio_init(vdev, "virtio-9p", VIRTIO_ID_9P, v->config_size);
> +    config_size = ROUND_UP(v->config_size, 4);
> +    virtio_init(vdev, "virtio-9p", VIRTIO_ID_9P, config_size);
>      v->vq = virtio_add_queue(vdev, MAX_REQ, handle_9p_output);
>  }
>  
> -- 
> 2.7.4


