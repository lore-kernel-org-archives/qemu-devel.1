Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338B6C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06268206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06268206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnHoJ-00053h-BE
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 03:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44649)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hnHoA-0004f9-8l
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hnHo9-0000Kg-CP
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:23:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hnHo9-0000KC-6Y
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:23:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so8656380pfg.10
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 00:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dMi4whsvT2OY549UXGIbZQemcGsizgGsQHNgNK3sIg4=;
 b=BMULx0Imq6qAwVOGUOHl5Mx5XKto2T/kla/8JA26xMu13xtaePas5f2wVHTEbA0T9F
 hE6RgDtALffDI2v5pp57XWQ/j0tf4Sufla846DXLCAWRunenOCMnmtWjlqz5xH/e0b8E
 CMnEByhzaliNl3gyzDqoun3FYRolGC4jnr+vF5qOsW1e0OaAhrDjq5/wa0jhWQMr8KJU
 LocmkOEi3PmUBo/zARlPR9N8cYy8DzIMOvwLSKjbRnnY0dvXZ7r90ajEGc5ZUUwxiPFt
 +BvJ9F7OP/AEho0C0CHz62DrGJx3HlJXO0Sqi4ML5qboWKKz/ex4dNiPM7t9/SR7kMuk
 Chzw==
X-Gm-Message-State: APjAAAXEWNHHT821umDzEB1JsMzrD/H6nTPtbBAJle/a9RIlrJGwdMbh
 Ij7Uka5o/zrPSz9eN7YGyX5IkQ==
X-Google-Smtp-Source: APXvYqw70xyNEFx/uN3grzpAPWffEUUGwtIPJgzzW7QzRfV81qD30FWICv5PsIAfUJXfTQk2tkLfpA==
X-Received: by 2002:a63:5903:: with SMTP id n3mr31496810pgb.369.1563261807252; 
 Tue, 16 Jul 2019 00:23:27 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z20sm31186485pfk.72.2019.07.16.00.23.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 00:23:26 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Tue, 16 Jul 2019 15:23:16 +0800
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190716072315.GA30980@xz-x1>
References: <1563261042-15974-1-git-send-email-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1563261042-15974-1-git-send-email-yan.y.zhao@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.193
Subject: Re: [Qemu-devel] [PATCH] migration: notify runstate immediately
 before vcpu stops
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
Cc: kevin.tian@intel.com, crosthwaite.peter@gmail.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 03:10:42PM +0800, Yan Zhao wrote:
> for some devices to do live migration, it is needed to do something
> immediately before vcpu stops. add a notification here.

Hi, Yan,

Could I ask for a more detailed commit message here?  E.g., what is
"some devices"?  And, what's the problem behind?

Thanks,

> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  cpus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/cpus.c b/cpus.c
> index b09b702..d5d4abe 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1068,6 +1068,7 @@ static int do_vm_stop(RunState state, bool send_stop)
>      int ret = 0;
>  
>      if (runstate_is_running()) {
> +        vm_state_notify(1, state);
>          cpu_disable_ticks();
>          pause_all_vcpus();
>          runstate_set(state);
> -- 
> 2.7.4
> 
> 

-- 
Peter Xu

