Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B779C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8062921D42
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzfphqWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8062921D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2u5-0004vD-Cv
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX2sa-0003SO-9j
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX2sX-0001M7-Lq
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603720180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVjcLJDNQp/gB469hTD/g7S6yLqLLQ+kJxuse/ILLIA=;
 b=RzfphqWb/fY789KlttNkDbwZHXPZEuSY1Tiq3bYyFLGQKOBucKpzrDjIssTPXpe7Bv12A/
 0RZlHI7VygPLC2ZSwsNZDRteu3zningw54qvslN8ziS+75QzV44NQ01qFtpmbSxM6TYG6s
 nJ/4KFKZqwFg3eKN/kp5iOfTaGETVSk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-zyv9xCM1NJmJc2YUa5tQVQ-1; Mon, 26 Oct 2020 09:49:38 -0400
X-MC-Unique: zyv9xCM1NJmJc2YUa5tQVQ-1
Received: by mail-ej1-f69.google.com with SMTP id z9so4982304ejg.10
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 06:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KVjcLJDNQp/gB469hTD/g7S6yLqLLQ+kJxuse/ILLIA=;
 b=A58EoiJyaXJfDXk92nOEikR9ugls71OtkYnkCUfp0MgEuDhC57AJJkyjNnUOKrTjMU
 mh5z8QLvzOLNGl/YplQwar3blxE9hwlHNXn0tvLIqcnOp/cGTYw2U7YlEN3bGgQcteYj
 ZrJrUGSvPlerLYdjSF85gTgd+Lh54Xlhn44UvQ8ZnT81a49xy2/COp9EnIqDTPboydyP
 ifLrb/nNrWiWHDd/BNekypcowYXd3pZXCoJHN2WS505URhetDyp4hYb9dKejyDBItaHn
 zdqg63qMTXnVVzPASoFFmoOqAVBQMUQioagyhvpGQMWOjlZ5DeNEuNM65JRRJu4xXnPL
 PpXQ==
X-Gm-Message-State: AOAM532YYsGhx28Cno1c3AZSRSb72XLiaDNMB7tp0Z6+QDqr95JbE0Ma
 xinJjL0lT9xMlTR6HvV0pwVrowQIGi9N679A1K87QfrxKWgrKxYFApwtSSICGUjhMorpkeOzRQZ
 mdIgFi9L3zH64MJY=
X-Received: by 2002:a05:6402:1e9:: with SMTP id
 i9mr16362196edy.317.1603720177220; 
 Mon, 26 Oct 2020 06:49:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynJefKXUCyYSJK5m4ipAOOm5WTfJ3MZRD6YDLlOHhBUqaJXuf2brzTnXH+hFEcxjrWevnqUA==
X-Received: by 2002:a05:6402:1e9:: with SMTP id
 i9mr16362148edy.317.1603720176841; 
 Mon, 26 Oct 2020 06:49:36 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id s12sm5245075edu.28.2020.10.26.06.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 06:49:36 -0700 (PDT)
Subject: Re: [PATCH 4/4] spapr: Improve spapr_reallocate_hpt() error reporting
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
 <160371605460.305923.5890143959901241157.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b67330f6-797c-f088-b6fa-7e81075e2245@redhat.com>
Date: Mon, 26 Oct 2020 14:49:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160371605460.305923.5890143959901241157.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 1:40 PM, Greg Kurz wrote:
> spapr_reallocate_hpt() has three users, two of which pass &error_fatal
> and the third one, htab_load(), passes &local_err, uses it to detect
> failures and simply propagates -EINVAL up to vmstate_load(), which will
> cause QEMU to exit. It is thus confusing that spapr_reallocate_hpt()
> doesn't return right away when an error is detected in some cases. Also,
> the comment suggesting that the caller is welcome to try to carry on
> seems like a remnant in this respect.
> 
> This can be improved:
> - change spapr_reallocate_hpt() to always report a negative errno on
>    failure, either as reported by KVM or -ENOSPC if the HPT is smaller
>    than what was asked,
> - use that to detect failures in htab_load() which is preferred over
>    checking &local_err,
> - propagate this negative errno to vmstate_load() because it is more
>    accurate than propagating -EINVAL for all possible errors.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
...

> -void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
> -                          Error **errp)
> +int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **errp)
>   {
>       ERRP_GUARD();
>       long rc;
> @@ -1496,7 +1495,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
>   
>       if (rc == -EOPNOTSUPP) {
>           error_setg(errp, "HPT not supported in nested guests");
> -        return;
> +        return -EOPNOTSUPP;
>       }
>   
>       if (rc < 0) {
> @@ -1504,8 +1503,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
>           error_setg_errno(errp, errno, "Failed to allocate KVM HPT of order %d",
>                            shift);
>           error_append_hint(errp, "Try smaller maxmem?\n");
> -        /* This is almost certainly fatal, but if the caller really
> -         * wants to carry on with shift == 0, it's welcome to try */
> +        return -errno;

Maybe returning here should be in a previous patch.
Otherwise patch looks good.

>       } else if (rc > 0) {
>           /* kernel-side HPT allocated */
>           if (rc != shift) {
> @@ -1513,6 +1511,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
>                          "Requested order %d HPT, but kernel allocated order %ld",
>                          shift, rc);
>               error_append_hint(errp, "Try smaller maxmem?\n");
> +            return -ENOSPC;
>           }
>   
>           spapr->htab_shift = shift;
> @@ -1533,6 +1532,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
>       /* We're setting up a hash table, so that means we're not radix */
>       spapr->patb_entry = 0;
>       spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
> +    return 0;
>   }
>   
>   void spapr_setup_hpt(SpaprMachineState *spapr)
> @@ -2286,11 +2286,13 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
>       }
>   
>       if (section_hdr) {
> +        int ret;
> +
>           /* First section gives the htab size */
> -        spapr_reallocate_hpt(spapr, section_hdr, &local_err);
> -        if (local_err) {
> +        ret = spapr_reallocate_hpt(spapr, section_hdr, &local_err);
> +        if (ret < 0) {
>               error_report_err(local_err);
> -            return -EINVAL;
> +            return ret;
>           }
>           return 0;
>       }
...


