Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C56C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7A720684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnXmyuR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7A720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwMSY-0001QL-Qh
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 05:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jwMRl-000107-He
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:14:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48487
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jwMRj-0001dk-63
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594977261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qipmyxsQwqLLfzEs4A1FGDlCk4TMXgdbhC4gAE7t/8s=;
 b=PnXmyuR35tRsaOF6+gFbmEDBMaS0O783/fAFlWCpbuESal1yJTyC+F8FI2IPEC2KZWvNB8
 Rb6U+73e1HwL5ltdISBgfwljOW438rJw3TD3nqFJ27SiAEQZ9ouOv8G86eZd+mcahSgGLp
 Kv2J4HTMk+1BGO3y4nljambMDb9SGwQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-tysa6zo3MjuXjw8o8L5CBg-1; Fri, 17 Jul 2020 05:14:20 -0400
X-MC-Unique: tysa6zo3MjuXjw8o8L5CBg-1
Received: by mail-wr1-f71.google.com with SMTP id a18so8347955wrm.14
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 02:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qipmyxsQwqLLfzEs4A1FGDlCk4TMXgdbhC4gAE7t/8s=;
 b=LYI/IW0jtQjZ8xpqyh0SoJ6LioDRy96prHnEtOQWATtSJsp2q8avn9mirO8k4Q6BeH
 Wq/lEi1C4wpHFo6X0l24G67+ZLEjNby6N2c5lpxGmYYf6aQMvcIDlwQlnp5Gaz1mgaSJ
 GumRiG4HNw1FaDb832IJgOhF87/DgsyuOKIIOioEnj2mGdrZvTRfWHJRvZ5yU8PVRDU2
 4uEqystFVM2cnihiP6Mf0Afrzzq81Hp/PjRTJGLe6IK7NV+v1PIGUlGKJhehBl17n8Wa
 n4N/8EQqBhzgDVvd3EWYyJUZxSuj3Tra11lk115dGYyGj7rSx2wB26pVp1bhi76KmGAb
 gx0A==
X-Gm-Message-State: AOAM533gJEuqLHYtmXTnAXjyJBHdaDDLdSHqMpzUJBLuRs1TtgXXPM5i
 L5+ZyenXoPFbW/8tOjg6TQoUmbYtWDO9rXGFpVuRQ7vNkDviSnqChWVN/l0C4YU1w+o0uAIzQuk
 rWMJ7CyYO2f7IbVM=
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr8631021wmn.6.1594977258908; 
 Fri, 17 Jul 2020 02:14:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIZ7bJYEz/2mcGAaJcrbvDidyPqvMJWs17qXduMQ6zfQCCKy8HYBMqZGcnHMzad+7oLsoxJg==
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr8630998wmn.6.1594977258650; 
 Fri, 17 Jul 2020 02:14:18 -0700 (PDT)
Received: from steredhat.lan ([5.171.231.144])
 by smtp.gmail.com with ESMTPSA id n17sm13180382wrs.2.2020.07.17.02.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 02:14:18 -0700 (PDT)
Date: Fri, 17 Jul 2020 11:14:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH] virtiofsd: Remove "norace" from cmdline help
Message-ID: <20200717091414.lhi4ho6xqol2tixi@steredhat.lan>
References: <20200716101442.48057-1-slp@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200716101442.48057-1-slp@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:33:03
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
Cc: Miklos Szeredi <mszeredi@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 12:14:42PM +0200, Sergio Lopez wrote:
> Commit 93bb3d8d4cda ("virtiofsd: remove symlink fallbacks") removed
> the implementation of the "norace" option, so remove it from the
> cmdline help too.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  tools/virtiofsd/helper.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 3105b6c23a..7bc5d7dc5a 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -159,8 +159,6 @@ void fuse_cmdline_help(void)
>             "    -o max_idle_threads        the maximum number of idle worker "
>             "threads\n"
>             "                               allowed (default: 10)\n"
> -           "    -o norace                  disable racy fallback\n"
> -           "                               default: false\n"
>             "    -o posix_lock|no_posix_lock\n"
>             "                               enable/disable remote posix lock\n"
>             "                               default: posix_lock\n"
> -- 
> 2.26.2
> 
> 

I noticed that 'norace' is also described in docs/tools/virtiofsd.rst,
so I think we need to remove it there too:

    diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
    index 824e713491..58666a4495 100644
    --- a/docs/tools/virtiofsd.rst
    +++ b/docs/tools/virtiofsd.rst
    @@ -63,9 +63,6 @@ Options
         Print only log messages matching LEVEL or more severe.  LEVEL is one of
         ``err``, ``warn``, ``info``, or ``debug``.  The default is ``info``.

    -  * norace -
    -    Disable racy fallback.  The default is false.
    -
       * posix_lock|no_posix_lock -
         Enable/disable remote POSIX locks.  The default is ``posix_lock``.


With that fixed:
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


