Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBDDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 07:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290F02083B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 07:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPryOp3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290F02083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k13Tb-0005hZ-CD
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 03:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k13T1-0005IP-Qq
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 03:59:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37502
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k13Sz-0002FM-JU
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 03:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596095944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9UeGGw6Hae3z4/CUxwL+tnpMSo+e87w4Ox+Kop66O0Q=;
 b=LPryOp3yAaD7qP1I++9fvsaRetL3zmcdu3jkLGvGm4+5Soii43Apnm0jwLbHHnPh1EYjHm
 z9YanN5sZ4755lsBHnbnec4frKrl4n2Yb73l4Z2B43jwSP8zXJf8JUY0kqIjDiSpjBDDiy
 rhhvjQ5KtQ6hM82FDKdXuPlvqch71Pg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-_m7A8FBONb6w-dCNhzJXbA-1; Thu, 30 Jul 2020 03:59:02 -0400
X-MC-Unique: _m7A8FBONb6w-dCNhzJXbA-1
Received: by mail-wr1-f72.google.com with SMTP id b13so4862986wrq.19
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 00:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9UeGGw6Hae3z4/CUxwL+tnpMSo+e87w4Ox+Kop66O0Q=;
 b=M+YSeb902po/L+RmQr+c4EGMuUxEHe6OY5P7yJFvRyn6wddvqcit0ukpSBRuYZ1UVx
 iRALvlMDM+HzyQTV+h+TKSMn5XbEZV23lRZ8HYlkoszpivvmtkAkzlJqeYCOrgSOOkkd
 VL6DvPmk1+TQNvZcnVxlo7Q0TfA76gieF8DrqE7gk4u8+JdHeW367pHKDde/wx6pDkQX
 7uQlXo/VvGYg95SWx8k5cPaeOK4qpCPmPO3Q/HEBxtsf+SjCPSlJ0C4XkcXHlYpL3juZ
 oJmoMn8OH/8hAGujK+5RtlXo4xZjIdPZjI2kJKZ3ywtAXzLCwiedcuulzoYW+K/YUcSb
 g22A==
X-Gm-Message-State: AOAM530fxHuRYNQisQguUfLKq+T5L7nOKh+CmG4MpGCUIll8AfIuwbxd
 Ge8PZrfohsrhP0kIKZtgDwJpM3pSRdenlGysd2IvWg5gkPAChl/7iI4OdA9J07Zqo5+JSd/cH57
 wNJ9PCJlPM9qbQVM=
X-Received: by 2002:a05:6000:142:: with SMTP id
 r2mr1738575wrx.103.1596095940862; 
 Thu, 30 Jul 2020 00:59:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziBCeZ7vO04SA6dKB9Wj8J07UuZWGMHak4gqwC7GeNKWJPnqXFeAd8r/u0seFIWlmxSQQHcQ==
X-Received: by 2002:a05:6000:142:: with SMTP id
 r2mr1738556wrx.103.1596095940582; 
 Thu, 30 Jul 2020 00:59:00 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id m126sm8142049wmf.3.2020.07.30.00.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 00:59:00 -0700 (PDT)
Date: Thu, 30 Jul 2020 09:58:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio-mem: Work around format specifier mismatch for
 RISC-V
Message-ID: <20200730075856.uzptjg3o6nhhkrs3@steredhat.lan>
References: <20200730005438.138369-1-brogers@suse.com>
 <20200730074926.dbxnhdxwvwugksnd@steredhat.lan>
 <8e1c42c8-9af9-5b86-d74f-eaa95392bd48@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8e1c42c8-9af9-5b86-d74f-eaa95392bd48@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org, Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 09:51:19AM +0200, David Hildenbrand wrote:
> On 30.07.20 09:49, Stefano Garzarella wrote:
> > On Wed, Jul 29, 2020 at 06:54:38PM -0600, Bruce Rogers wrote:
> >> This likely affects other, less popular host architectures as well.
> >> Less common host architectures under linux get QEMU_VMALLOC_ALIGN (from
> >> which VIRTIO_MEM_MIN_BLOCK_SIZE is derived) define to a variable of
> >> type uintptr, which isn't compatible with the format specifier used to
> >> print a user message. Since this particular usage of the underlying data
> >> seems unique, the simple fix is to just cast it to the corresponding
> >> format specifier.
> >>
> >> Signed-off-by: Bruce Rogers <brogers@suse.com>
> >> ---
> >>  hw/virtio/virtio-mem.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> >> index c12e9f79b0..fd01ffd83e 100644
> >> --- a/hw/virtio/virtio-mem.c
> >> +++ b/hw/virtio/virtio-mem.c
> >> @@ -754,7 +754,7 @@ static void virtio_mem_set_block_size(Object *obj, Visitor *v, const char *name,
> >>  
> >>      if (value < VIRTIO_MEM_MIN_BLOCK_SIZE) {
> >>          error_setg(errp, "'%s' property has to be at least 0x%" PRIx32, name,
> >> -                   VIRTIO_MEM_MIN_BLOCK_SIZE);
> >> +                   (unsigned int)VIRTIO_MEM_MIN_BLOCK_SIZE);
> > 
> > Since we use PRIx32, could be better to cast VIRTIO_MEM_MIN_BLOCK_SIZE
> > to uint32_t?
> 
> Yeah, I guess something like
> 
> -#define VIRTIO_MEM_MIN_BLOCK_SIZE QEMU_VMALLOC_ALIGN
> +#define VIRTIO_MEM_MIN_BLOCK_SIZE ((uint32_t)QEMU_VMALLOC_ALIGN)
> 
> would be cleaner

Yeah, it is cleaner.

Otherwise we could use PRIxPTR in the error message.

Thanks,
Stefano


