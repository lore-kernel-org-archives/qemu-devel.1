Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CBEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8218920776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnuSrOep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8218920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeg6e-00016j-Mh
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jeg5x-0000Ef-EE
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:34:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60243
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jeg5v-0008TA-Qw
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590762883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUVIe/NHQit/VrQ2/P/zdE2NeSykLQpVrW1fvOOq7tM=;
 b=NnuSrOepSugBoNsKt0wIgzaf7AmWLcU9jvShN/JdF96t0q4kJDb2PIDQlibhjSGyZF+bxR
 T9OIEH3Qvf1PNABiF0OAacQRFkGbJOpda8Y8erri2J6eqbWDYxBjApVAKiID8aJUVOfH5R
 GpzDSiuOn8aSWDP5lgltDiic8F3gMwY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-o2Xx-MkfOue06CoHjgo5gg-1; Fri, 29 May 2020 10:34:42 -0400
X-MC-Unique: o2Xx-MkfOue06CoHjgo5gg-1
Received: by mail-qk1-f199.google.com with SMTP id y64so2063129qkc.19
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 07:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VUVIe/NHQit/VrQ2/P/zdE2NeSykLQpVrW1fvOOq7tM=;
 b=YGDR38C9Zlt7XjDtT/zdrWtlmk7EcNC6saZTx+Pm9ud208ifUFeXX3j0/Gwt+lm9uI
 0OZa/Jdis3pH17ZCg4T2u5fHUgomm2vM6FWmjcW+89VWv4n/+cFt4NmksRRi74Oxg9VV
 vh5zO0M0vb7aGI/BJvr+NZtQyEVrxRPpvmiNWP9LD23MfwtBktnYs7yklaxTvPPKZj9V
 S0p5b5ZHmpaDgZKm8jUzaeSobJs49YujotvMFqYHGrcg8Xiv3G/kRtg/ZwG6N2wybTLn
 9/k4RsT4AQzXJy71patKxBx7fHIm/EThvlmTXGG3pc4lGq3c7jNyIMUblSJbAUPnTJT6
 L0YA==
X-Gm-Message-State: AOAM533SZ/blXY+foSGXOTe88yrID/jXix9eWG8BuVh4d8cfHsiwfAGI
 KwFjRJK5PqyjLmQXYswAr41cf5SwNENpjkJjODXO0NkEIrIuIE9f4I19XcHbG0c705wIjlHFNHe
 YSAdch1gOUV0WB+s=
X-Received: by 2002:a0c:b492:: with SMTP id c18mr8797137qve.139.1590762881687; 
 Fri, 29 May 2020 07:34:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTfsrcSXxnR3g/KrcTT4/BtMcnl0qYSzWRpknsZ5jDm86uBhnAncVDQ2veniajerzTxJEHzw==
X-Received: by 2002:a0c:b492:: with SMTP id c18mr8797033qve.139.1590762880523; 
 Fri, 29 May 2020 07:34:40 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id g64sm7711674qtd.39.2020.05.29.07.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 07:34:39 -0700 (PDT)
Date: Fri, 29 May 2020 10:34:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] memory: Make 'info mtree' not display disabled regions
 by default
Message-ID: <20200529143436.GA1374520@xz-x1>
References: <20200529125325.11916-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200529125325.11916-1-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 02:53:25PM +0200, Philippe Mathieu-Daudé wrote:
> @@ -2920,35 +2916,46 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>              ml->mr = mr->alias;
>              QTAILQ_INSERT_TAIL(alias_print_queue, ml, mrqueue);
>          }
> -        qemu_printf(TARGET_FMT_plx "-" TARGET_FMT_plx
> -                    " (prio %d, %s%s): alias %s @%s " TARGET_FMT_plx
> -                    "-" TARGET_FMT_plx "%s",
> -                    cur_start, cur_end,
> -                    mr->priority,
> -                    mr->nonvolatile ? "nv-" : "",
> -                    memory_region_type((MemoryRegion *)mr),
> -                    memory_region_name(mr),
> -                    memory_region_name(mr->alias),
> -                    mr->alias_offset,
> -                    mr->alias_offset + MR_SIZE(mr->size),
> -                    mr->enabled ? "" : " [disabled]");
> -        if (owner) {
> -            mtree_print_mr_owner(mr);
> +        if (mr->enabled || display_disabled) {
> +            for (i = 0; i < level; i++) {
> +                qemu_printf(MTREE_INDENT);
> +            }
> +            qemu_printf(TARGET_FMT_plx "-" TARGET_FMT_plx
> +                        " (prio %d, %s%s): alias %s @%s " TARGET_FMT_plx
> +                        "-" TARGET_FMT_plx "%s",
> +                        cur_start, cur_end,
> +                        mr->priority,
> +                        mr->nonvolatile ? "nv-" : "",
> +                        memory_region_type((MemoryRegion *)mr),
> +                        memory_region_name(mr),
> +                        memory_region_name(mr->alias),
> +                        mr->alias_offset,
> +                        mr->alias_offset + MR_SIZE(mr->size),
> +                        mr->enabled ? "" : " [disabled]");
> +            if (owner) {
> +                mtree_print_mr_owner(mr);
> +            }

It'll not only change the default output for "info mtree", but also "-o" too
because disabled regions won't be dumped any more.  Not sure whether it's
expected - just raise this question up, because I mostly only use "-f"..

Thanks,

-- 
Peter Xu


