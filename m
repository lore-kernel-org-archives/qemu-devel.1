Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80286C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47182206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gizeU+8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47182206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj1Cb-0001Mk-CY
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jj1BU-0000Jy-Nj
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:54:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56709
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jj1BT-000672-Jf
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591797266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=anUyflsR+TMhpMTyhc/1MKI6IhEIVEu7swPJeEv9jlI=;
 b=gizeU+8VVqv+9bxkAjsNmJR38/bnv2aoeWspGhhIdg9r6G70P5aaT9mcX7bMNYQh9PyAqI
 E0+39ChyqPbIkVViDQ1vPoXltY6q/wq+CFMMqXbX/icJHEnd1AVjCJC8GvzhpXfnWnYmLp
 Pu3WhTTGeVEb0YBf88gtPvaU/CvG3HQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-ApZqOZcTM32Zc8-3iKvgbQ-1; Wed, 10 Jun 2020 09:54:25 -0400
X-MC-Unique: ApZqOZcTM32Zc8-3iKvgbQ-1
Received: by mail-wm1-f69.google.com with SMTP id y15so421183wmi.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 06:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=anUyflsR+TMhpMTyhc/1MKI6IhEIVEu7swPJeEv9jlI=;
 b=fwL2Y7FFjiC8M8SU5P+54kpBOfE+/so0N9ThDCybo6vhhWwlInrVVllZvEr6pJVzXw
 IyYyNhkCmGYIxjMkwExaVhy2HxZp00HEN88oHaCu9fAUqZglzGUvvwvLbr4gRVIkZry3
 4UHiihbsX12Sf/SOaZtNd3C7vgNyLAr5+V0vqAl4dryQ6kZAboOpRez3PkdjliTcVLfK
 PfiuEOsKizzTTUUIpUq1rx6JHppdhi7+91CuPR4mrYezCxYeDPvfsS7QxA3KPu+O+OW3
 XGUcFBQoj0E5B7Ja7jUyntkY7fAYz0BIAB6hNOjqi6tSPPlc7QDVpzN8eAKwbgJcmAlg
 66/Q==
X-Gm-Message-State: AOAM530jefaghV+ZdwP97MeXBgWw0YoSevgMVTxcmDzYAEtByq5fF3hx
 l7Jfgcnq+GDmpkJimkKMg7cqpFebZir5ixBxJ72d0QevxJA84a6oJTswBhCOYoRX6WuqTo4mj5i
 p96MFWkDpWv8sga8=
X-Received: by 2002:a05:600c:2294:: with SMTP id
 20mr3507439wmf.51.1591797263728; 
 Wed, 10 Jun 2020 06:54:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIeOKroTuCrzfyqZffldu8z1pAqZk3l/2GmUhXTmPR88bgwr11Rp5utt2BMe5CvJXvtElmjw==
X-Received: by 2002:a05:600c:2294:: with SMTP id
 20mr3507407wmf.51.1591797263305; 
 Wed, 10 Jun 2020 06:54:23 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
 by smtp.gmail.com with ESMTPSA id v28sm9163995wra.77.2020.06.10.06.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 06:54:22 -0700 (PDT)
Date: Wed, 10 Jun 2020 09:54:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] memory: Revert "memory: accept mismatching sizes in
 memory_region_access_valid"
Message-ID: <20200610095306-mutt-send-email-mst@kernel.org>
References: <20200610134731.1514409-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610134731.1514409-1-mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 10, 2020 at 09:47:52AM -0400, Michael S. Tsirkin wrote:
> Memory API documentation documents valid .min_access_size and .max_access_size
> fields and explains that any access outside these boundaries is blocked.
> 
> This is what devices seem to assume.
> 
> However this is not what the implementation does: it simply
> ignores the boundaries unless there's an "accepts" callback.
> 
> Naturally, this breaks a bunch of devices.
> 
> Revert to the documented behaviour.
> 
> Devices that want to allow any access can just drop the valid field,
> or add the impl field to have accesses converted to appropriate
> length.
> 
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Actually, I rechecked and couldn't find this tag in my inbox.
So maybe this should have been:
Cc: Richard Henderson <rth@twiddle.net>
Or maybe I lost that email.

Richard could you ack this explicitly pls to avoid confusion?

> Fixes: CVE-2020-13754
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1842363
> Fixes: a014ed07bd5a ("memory: accept mismatching sizes in memory_region_access_valid")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  memory.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index 91ceaf9fcf..3e9388fb74 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1352,35 +1352,24 @@ bool memory_region_access_valid(MemoryRegion *mr,
>                                  bool is_write,
>                                  MemTxAttrs attrs)
>  {
> -    int access_size_min, access_size_max;
> -    int access_size, i;
> +    if (mr->ops->valid.accepts
> +        && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
> +        return false;
> +    }
>  
>      if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
>          return false;
>      }
>  
> -    if (!mr->ops->valid.accepts) {
> +    /* Treat zero as compatibility all valid */
> +    if (!mr->ops->valid.max_access_size) {
>          return true;
>      }
>  
> -    access_size_min = mr->ops->valid.min_access_size;
> -    if (!mr->ops->valid.min_access_size) {
> -        access_size_min = 1;
> +    if (size > mr->ops->valid.max_access_size
> +        || size < mr->ops->valid.min_access_size) {
> +        return false;
>      }
> -
> -    access_size_max = mr->ops->valid.max_access_size;
> -    if (!mr->ops->valid.max_access_size) {
> -        access_size_max = 4;
> -    }
> -
> -    access_size = MAX(MIN(size, access_size_max), access_size_min);
> -    for (i = 0; i < size; i += access_size) {
> -        if (!mr->ops->valid.accepts(mr->opaque, addr + i, access_size,
> -                                    is_write, attrs)) {
> -            return false;
> -        }
> -    }
> -
>      return true;
>  }
>  
> -- 
> MST


