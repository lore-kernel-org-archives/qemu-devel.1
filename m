Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE78EC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F59F2223C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjZFvGuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F59F2223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZW81-00044U-BY
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kZW78-0003Jj-Af
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:26:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kZW76-00076A-NH
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604309215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wvGhxUsJqo06ipVi86w+zJhdXv1eFtqbOarLy6QAmdY=;
 b=IjZFvGuM4SZIjBjzzpPrHFn84nrGYN5Rt5e9nZRLyA1PaAisP1c64JRnxaS075nR/DjBkE
 Ss/J9qdGJZyfa6Rce44I3t1wIdz8PYF2PWblQTQpEqa9bWW0pU2YUgJXB8ZzKV2rTxoKti
 R0vuwXNhNilmELe3A5uhbme9wpi7VxE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-m2e2FvQrMLqzBQYxHomplA-1; Mon, 02 Nov 2020 04:26:54 -0500
X-MC-Unique: m2e2FvQrMLqzBQYxHomplA-1
Received: by mail-wm1-f71.google.com with SMTP id z7so3113641wme.8
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 01:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uR6TwZCpcZCZ+h7IM7HScu7o4n8bS7ER7TMaqeoMaI8=;
 b=FUaniDCai6OhfVEc5VpXMnjK5SMOwAGQ4pdBVhM9HkKKYnErILphzzX/7zclKNJgSE
 ta/cpdGkfcFJHz/6MAYwAQEFHs4HzfI5kg3P/FIVZklOXmIHAKASWv0kmur0uhlYn9N/
 z22JEILwLdX7TVtvw84nkWB7vqKrw1KLwCmaZVtmZ46dZDONMLZXA+6CmX8+gu7CozbP
 UFItVGyyVnak+kE2r6unmh4XEhkqYauFdEOEB8BWVlV2hkvcyUFHk+ko9dEk0iDRWTiJ
 w+vr6zWyJFglEeV0xj2xV72eCHsrxOZMwp5N7OBrhZPqzTp99EWQJPYxec7IunDvusHv
 n7bw==
X-Gm-Message-State: AOAM532GslWOvX36GD/ma8crazc9ArSKNraHHMxRRFqvqhdGUJrRAuLT
 yboZ51HLeNnjd3rVFnUxkbC9E9WT9JIFbX0C2FUBsIM1/gNp8tTI1L+Yp/7RddSsxjjko4tjHkh
 70W7KLMzrM1VsyGU=
X-Received: by 2002:a1c:2441:: with SMTP id k62mr17365984wmk.10.1604309212538; 
 Mon, 02 Nov 2020 01:26:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRe+IZVHLAqiWAsI4RD6usavgvek+w7lWv3Gk3n03ohF1RO5S4hcHH6Mbe3mIG8pi+4lcPxA==
X-Received: by 2002:a1c:2441:: with SMTP id k62mr17365963wmk.10.1604309212293; 
 Mon, 02 Nov 2020 01:26:52 -0800 (PST)
Received: from steredhat (host-79-22-200-33.retail.telecomitalia.it.
 [79.22.200.33])
 by smtp.gmail.com with ESMTPSA id e20sm14222599wme.35.2020.11.02.01.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 01:26:51 -0800 (PST)
Date: Mon, 2 Nov 2020 10:26:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2] hw/smbios: Fix leaked fd in save_opt_one() error
 path
Message-ID: <20201102092649.ciwhp4mpcs4dc6ri@steredhat>
References: <20201030152742.1553968-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030152742.1553968-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 04:27:42PM +0100, Philippe Mathieu-Daudé wrote:
>Fix the following Coverity issue (RESOURCE_LEAK):
>
>  CID 1432879: Resource leak
>
>    Handle variable fd going out of scope leaks the handle.
>
>Replace a close() call by qemu_close() since the handle is
>opened with qemu_open().
>
>Fixes: bb99f4772f5 ("hw/smbios: support loading OEM strings values from a file")
>Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>---
> hw/smbios/smbios.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
>index 8b30906e50a..6a3d39793bc 100644
>--- a/hw/smbios/smbios.c
>+++ b/hw/smbios/smbios.c
>@@ -988,16 +988,18 @@ static int save_opt_one(void *opaque,
>             if (ret < 0) {
>                 error_setg(errp, "Unable to read from %s: %s",
>                            value, strerror(errno));
>+                qemu_close(fd);
>                 return -1;
>             }
>             if (memchr(buf, '\0', ret)) {
>                 error_setg(errp, "NUL in OEM strings value in %s", value);
>+                qemu_close(fd);
>                 return -1;
>             }
>             g_byte_array_append(data, (guint8 *)buf, ret);
>         }
>
>-        close(fd);
>+        qemu_close(fd);
>
>         *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);
>         (*opt->dest)[*opt->ndest] = (char *)g_byte_array_free(data,  FALSE);
>-- 
>2.26.2
>
>


