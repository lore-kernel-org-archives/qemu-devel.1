Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D60AC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 08:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB53220673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 08:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT0rXfpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB53220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipT2Z-0007kh-2v
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 03:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ipT1u-0007Ir-DR
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 03:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ipT1r-0000am-KD
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 03:18:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29820
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ipT1r-0000Vw-Dd
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 03:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578557934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=KrfZVOjlfr4M5VwuVryAtmxjht3yRqdUvRTFMvRp/F0=;
 b=XT0rXfpkVaQX1tYWxcnN/3eXPvaQ8ZXsbeDZPRyjIjRI2/gh9ilw1Ey1RLir6fjoH1CbtL
 ysysbI7Pqx6GhiwWVxMsztctwDq5OL1WMFWicbhoAZjkBmvrzFdd/KI6MdMEGu+oVvl0et
 J7P/3IvGEuvXe/tiyLo1MVfoxrHqtkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-XvifIU_UNkWRz0d1_hGDkg-1; Thu, 09 Jan 2020 03:18:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DFF9477;
 Thu,  9 Jan 2020 08:18:50 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-32.ams2.redhat.com [10.36.117.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68FDF60E1C;
 Thu,  9 Jan 2020 08:18:49 +0000 (UTC)
Subject: Re: [PATCH 2/4] vl: Free accel_list in configure_accelerators
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200109021710.1219-1-richard.henderson@linaro.org>
 <20200109021710.1219-3-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <58c44c67-4b1b-dfef-c4a0-f47b33f4283b@redhat.com>
Date: Thu, 9 Jan 2020 09:18:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200109021710.1219-3-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: XvifIU_UNkWRz0d1_hGDkg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/01/2020 03.17, Richard Henderson wrote:
> We allocate the list with g_strsplit, so free it too.
> This freeing was lost during one of the rearrangements.
> 
> Fixes: 6f6e1698a68c
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  vl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/vl.c b/vl.c
> index be79b03c1a..c9329fe699 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2748,7 +2748,6 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>  static void configure_accelerators(const char *progname)
>  {
>      const char *accel;
> -    char **accel_list, **tmp;
>      bool init_failed = false;
>  
>      qemu_opts_foreach(qemu_find_opts("icount"),
> @@ -2756,6 +2755,8 @@ static void configure_accelerators(const char *progname)
>  
>      accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
>      if (QTAILQ_EMPTY(&qemu_accel_opts.head)) {
> +        char **accel_list, **tmp;
> +
>          if (accel == NULL) {
>              /* Select the default accelerator */
>              if (!accel_find("tcg") && !accel_find("kvm")) {
> @@ -2787,6 +2788,7 @@ static void configure_accelerators(const char *progname)
>                  error_report("invalid accelerator %s", *tmp);
>              }
>          }
> +        g_strfreev(accel_list);
>      } else {
>          if (accel != NULL) {
>              error_report("The -accel and \"-machine accel=\" options are incompatible");
> 

FYI, a fix for this is already part of Laurent's "Trivial branch
patches" PULL request from yesterday.

 Thomas


