Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11573C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13FF207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJb85ccY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13FF207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxOC-00044c-3Y
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jaxLU-0008Ta-53
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:11:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35125
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jaxLS-0003nb-Tl
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589875884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VP+5+GqEWImza08PFWiMDDK0D0GKJ8upld51JPYLFKA=;
 b=cJb85ccYLa0z5vHlyEOLrQItXR72hgOI16aiZo75DMj8dPEt/R2pmfCe3i2u+ldrEHcbN6
 8am3QDQ6hc4lQtDoNwIUF0xBiefsZyggJjd+e2V5taufvHzeXx0ZpYJypz16sGTwyhwuRz
 Xc0fowQ4mE36yEY0RCyxJO+5PZVySWQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-EVkq-hGLPP-g5HCEAYw6XA-1; Tue, 19 May 2020 04:11:20 -0400
X-MC-Unique: EVkq-hGLPP-g5HCEAYw6XA-1
Received: by mail-wm1-f72.google.com with SMTP id v23so661956wmj.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 01:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VP+5+GqEWImza08PFWiMDDK0D0GKJ8upld51JPYLFKA=;
 b=ggpv/K7W8sQc9adAGTEc9M8ZpKsZdubJ1gB76blCZgtnwzqthdvzLGlJXVvRjrE5iB
 KQ8ZGkU1WaTxX6lqnjAh2cs0/m1nwuvHya2wABBdv9U2kXRf7OQ+X/TtxgDXbsbgEM4n
 TXAxH6Og/oWHa+RH1N+rTmT5S7RFATM84cEzObMQLnWpc84ZQPtk973pr5cxgZqE9fHk
 bWwsoUeYxZ8BJqNNAV5V8eVP2JSIwYkbIJPlQ10DKrhNetXsy3EZQUpnRSoS6eP/8hg2
 PmFUzhIYAdjfIhpYDFSGcDlCA9UiMeF5YXOXWhzVAaiixeLkYysaSUA119CZhKGtt8av
 b1bw==
X-Gm-Message-State: AOAM532KmHbd2FoVxDryE67Y4D7lsokrrv315r8b8sYtDWuQvfRZuE24
 0aCevHv1Lt1BWD+2cv6C50Q7BchEBC1R9Y8TnEaFQHtp8KbBu+Og/WHfzZtu9jtQWnJTb1e+v8/
 q5KfcPPpIcCkyd6U=
X-Received: by 2002:adf:f907:: with SMTP id b7mr24950069wrr.203.1589875879117; 
 Tue, 19 May 2020 01:11:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqEkKU+yFcn94SRpMgrRaRgAm8n+N9A8msVghxJS+F0T53bCxtWownX3G0wl1G6uyb4sdLvA==
X-Received: by 2002:adf:f907:: with SMTP id b7mr24950049wrr.203.1589875878863; 
 Tue, 19 May 2020 01:11:18 -0700 (PDT)
Received: from steredhat (host108-207-dynamic.49-79-r.retail.telecomitalia.it.
 [79.49.207.108])
 by smtp.gmail.com with ESMTPSA id x10sm1136336wrn.54.2020.05.19.01.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 01:11:18 -0700 (PDT)
Date: Tue, 19 May 2020 10:11:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jonathan Marler <johnnymarler@gmail.com>
Subject: Re: [PATCH] linux-user/mmap.c: fix integer underflow in target_mremap
Message-ID: <20200519081115.xlvm7y4k63anfsmc@steredhat>
References: <20200502161225.14346-1-johnnymarler@gmail.com>
 <CACKT+Ao+hRRuSarAcWy0PDzV8u5CF9KQq07dgVsLmQddSTfj6Q@mail.gmail.com>
 <CACKT+ApwXFEK3tu5=ZpOZrGNYLXcO6w9rv7QUEDrJKBkCQ8wGw@mail.gmail.com>
 <CACKT+AoOJGtBE+9wwo8Pkp2=1WCA-3m7i80rhNa9yxc24FH+7A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACKT+AoOJGtBE+9wwo8Pkp2=1WCA-3m7i80rhNa9yxc24FH+7A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jonathan,
thanks for the patch!

CCing Riku and Laurent.

On Mon, May 18, 2020 at 12:13:41PM -0600, Jonathan Marler wrote:
> Been a few more days.  Not sure how often I should be pinging.  If this is
> too much to ping every few days let me know.

Is not too much, but next time is better to CC the maintainers.
You can use 'scripts/get_maintainer.pl' to get the list of maintainers
and reviewers.

Please take a look at https://wiki.qemu.org/Contribute/SubmitAPatch

> 
> On Fri, May 15, 2020 at 7:36 AM Jonathan Marler <johnnymarler@gmail.com>
> wrote:
> 
> > Been a couple weeks, checking to see if anyone has looked at this.
> >
> > On Sat, May 2, 2020 at 5:43 PM Jonathan Marler <johnnymarler@gmail.com>
> > wrote:
> >
> >> FYI, I applied this patch to the qemu build that zig uses to run
> >> non-native tests (
> >> https://github.com/ziglang/qemu-static/blob/master/patch/mremap-underflow.diff
> >> )
> >>
> >> After applying it, my new code that calls mremap now passes,
> >> whereas before the fix I was getting a segfault.
> >>
> >> On Sat, May 2, 2020 at 10:12 AM Jonathan Marler <johnnymarler@gmail.com>
> >> wrote:
> >>
> >>> Fixes: https://bugs.launchpad.net/bugs/1876373

should be "Buglink: https://bugs.launchpad.net/bugs/1876373"

> >>>
> >>> This code path in mmap occurs when a page size is decreased with
> >>> mremap.  When a section of pages is shrunk, qemu calls mmap_reserve on the
> >>> pages that were released.  However, it has the diff operation reversed,
> >>> subtracting the larger old_size from the smaller new_size.  Instead, it
> >>> should be subtracting the smaller new_size from the larger old_size.  You
> >>> can also see in the previous line of the change that this mmap_reserve call
> >>> only occurs when old_size > new_size.

Please break the lines of the commit message (max 76 charactes per line):
https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message

Thanks,
Stefano

> >>>
> >>> Signed-off-by: Jonathan Marler <johnnymarler@gmail.com>
> >>> ---
> >>>  linux-user/mmap.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> >>> index e378033797..caab62909e 100644
> >>> --- a/linux-user/mmap.c
> >>> +++ b/linux-user/mmap.c
> >>> @@ -708,7 +708,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong
> >>> old_size,
> >>>          if (prot == 0) {
> >>>              host_addr = mremap(g2h(old_addr), old_size, new_size,
> >>> flags);
> >>>              if (host_addr != MAP_FAILED && reserved_va && old_size >
> >>> new_size) {
> >>> -                mmap_reserve(old_addr + old_size, new_size - old_size);
> >>> +                mmap_reserve(old_addr + old_size, old_size - new_size);
> >>>              }
> >>>          } else {
> >>>              errno = ENOMEM;
> >>> --
> >>> 2.23.1
> >>>
> >>>


