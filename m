Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E5EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 07:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E467B2072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 07:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F37YyYFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E467B2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k13KM-0000s1-5p
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 03:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k13Jn-0000R9-BC
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 03:49:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24381
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k13Jl-0000QG-Pn
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 03:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596095372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QqscqWplf+W2/n0RZZPglnWKfpP9w/FqQaGDPyQE454=;
 b=F37YyYFdWJKzthom5MLtMmtRG+UOBo6dZXxUPkd0IXdWYWl3k7dORrQnnYg992XHbfEcot
 ajl5fqa1uFC4WxfFIX7xodZlTgHx8kc14zkPCIKAn49qyROAJvTv5SNHg/J4TTaLqxGjxr
 5rf/jx4BvOK6RiC/KkHpy1j6YvFYBCk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-deJv5C7qPuqA6mvFlyPa1w-1; Thu, 30 Jul 2020 03:49:31 -0400
X-MC-Unique: deJv5C7qPuqA6mvFlyPa1w-1
Received: by mail-wr1-f72.google.com with SMTP id z12so7626312wrl.16
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 00:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QqscqWplf+W2/n0RZZPglnWKfpP9w/FqQaGDPyQE454=;
 b=lso6lsrKTvPHybOPm5uTfz3Th7ilxK3AOPBB2MVWPFQTtNaaPZXNjpuTCGL69MREbz
 NUzjiuL2SQZNlgBY0b18pCXFptjQ3wpoFv7hpTfM4lQvVuRVl5ls5ZY4vcXvtDbmCyTE
 89WMXiP7jQqjlfuvGjF6lRPdoGDXdoPv+9ohWJ+ffaQqUiuBxFPZu5DT86H6S3Dh+ZkI
 fdPdE+j6fdoofDr+1ho49qGQG87/MLDIlmAuMrmoLZaY2DFHbD7LbJxAtuZSRpM0HdJa
 ZrZuAuL2bQvt19fCR8SPr/vs+H/6HMQmxEr0wzHOaQzL7As2xclCf3PNeZDSLzM+8SaC
 9H5g==
X-Gm-Message-State: AOAM530KPPhLP8MtWatDvm6pOajMZvkiVO+uh+dbA0NXydpk6aUwLuUY
 ykZF8R3VZ4QrFNTV3Pae+jWk0Uw7+zgPTMMpbsMmb3OmimQScwsdv7oYKNCcmg1Mvjzkq2QZZ6+
 0HAnylAU9n/abBsQ=
X-Received: by 2002:a5d:4710:: with SMTP id y16mr34206412wrq.189.1596095369941; 
 Thu, 30 Jul 2020 00:49:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFMnqMFMqkgDoezCWpUh7l2VCDxaGLDLrKO2C6V4gftQqtsxbAcPby9dRUU2aRgiSqomRvtA==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr34206391wrq.189.1596095369735; 
 Thu, 30 Jul 2020 00:49:29 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id a10sm8595685wrx.15.2020.07.30.00.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 00:49:29 -0700 (PDT)
Date: Thu, 30 Jul 2020 09:49:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bruce Rogers <brogers@suse.com>
Subject: Re: [PATCH] virtio-mem: Work around format specifier mismatch for
 RISC-V
Message-ID: <20200730074926.dbxnhdxwvwugksnd@steredhat.lan>
References: <20200730005438.138369-1-brogers@suse.com>
MIME-Version: 1.0
In-Reply-To: <20200730005438.138369-1-brogers@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 29, 2020 at 06:54:38PM -0600, Bruce Rogers wrote:
> This likely affects other, less popular host architectures as well.
> Less common host architectures under linux get QEMU_VMALLOC_ALIGN (from
> which VIRTIO_MEM_MIN_BLOCK_SIZE is derived) define to a variable of
> type uintptr, which isn't compatible with the format specifier used to
> print a user message. Since this particular usage of the underlying data
> seems unique, the simple fix is to just cast it to the corresponding
> format specifier.
> 
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  hw/virtio/virtio-mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index c12e9f79b0..fd01ffd83e 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -754,7 +754,7 @@ static void virtio_mem_set_block_size(Object *obj, Visitor *v, const char *name,
>  
>      if (value < VIRTIO_MEM_MIN_BLOCK_SIZE) {
>          error_setg(errp, "'%s' property has to be at least 0x%" PRIx32, name,
> -                   VIRTIO_MEM_MIN_BLOCK_SIZE);
> +                   (unsigned int)VIRTIO_MEM_MIN_BLOCK_SIZE);

Since we use PRIx32, could be better to cast VIRTIO_MEM_MIN_BLOCK_SIZE
to uint32_t?

Thanks,
Stefano

>          return;
>      } else if (!is_power_of_2(value)) {
>          error_setg(errp, "'%s' property has to be a power of two", name);
> -- 
> 2.27.0
> 
> 


