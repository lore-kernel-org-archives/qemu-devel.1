Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B49BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0F020728
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVdG29T2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0F020728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYEWf-0002VI-Sl
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 16:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYEV3-000144-Bo
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:26:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYEV0-0003Cb-JR
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604003177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wSRp9CYq0Yc02X6EvDj9qoadP4GodKVIJRXTzPFBwWQ=;
 b=UVdG29T2lFMMGGoF9iby9rbXWd9oetqGJbrvFAYcNBfg6/etV/wvT3XEK51GJCP2GYuiyv
 hGvhEhtiCAY72fSl3DyJURKB9MR8VfURm0s6H5mD2iOcT+3qiPlipB8YsWjnoBL/ceE6xV
 4QybhyrUVwN3y7IzPrPqF6zVJ6F7hbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-KK9EVt8SNHmiKiH2MUD76A-1; Thu, 29 Oct 2020 16:26:15 -0400
X-MC-Unique: KK9EVt8SNHmiKiH2MUD76A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83D1A106B201;
 Thu, 29 Oct 2020 20:26:14 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06CFA55767;
 Thu, 29 Oct 2020 20:26:13 +0000 (UTC)
Date: Thu, 29 Oct 2020 16:26:12 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH] util/cutils: Silent Coverity array overrun warning in
 freq_to_str()
Message-ID: <20201029202612.GK5733@habkost.net>
References: <20201029185506.1241912-1-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20201029185506.1241912-1-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Luc Michel <luc@lmichel.fr>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 29, 2020 at 07:55:06PM +0100, Philippe Mathieu-Daudé wrote:
> The biggest input value freq_to_str() can accept is UINT64_MAX,
> which is ~18.446 EHz, less than 1000 EHz.
> Add an assertion to help Coverity.
> 
> This silents CID 1435957:  Memory - illegal accesses (OVERRUN):
> 
> >>> Overrunning array "suffixes" of 7 8-byte elements at element
>     index 7 (byte offset 63) using index "idx" (which evaluates to 7).
> 
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  util/cutils.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/util/cutils.c b/util/cutils.c
> index c395974fab4..69c0ad7f888 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -891,6 +891,7 @@ char *freq_to_str(uint64_t freq_hz)
>      double freq = freq_hz;
>      size_t idx = 0;
>  
> +    assert(freq <= UINT64_MAX); /* Max 64-bit value is less than 1000 EHz */

If Coverity is really able to conclude that this assert really
ensures idx will never be out of bounds, I will be very
impressed.

>      while (freq >= 1000.0 && idx < ARRAY_SIZE(suffixes)) {

I don't understand why the (idx < ARRAY_SIZE(suffix)) expression
above exists, if the code in this function will only work
correctly if the expression never becomes false.

It sounds simpler and more obvious to fix the boundary check.
In other words:

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
diff --git a/util/cutils.c b/util/cutils.c
index c395974fab..0d9261e1e5 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -891,7 +891,7 @@ char *freq_to_str(uint64_t freq_hz)
     double freq = freq_hz;
     size_t idx = 0;
 
-    while (freq >= 1000.0 && idx < ARRAY_SIZE(suffixes)) {
+    while (freq >= 1000.0 && idx < ARRAY_SIZE(suffixes) - 1) {
         freq /= 1000.0;
         idx++;
     }


-- 
Eduardo


