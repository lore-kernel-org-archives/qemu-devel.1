Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011DEC388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 17:47:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BEDF206D5
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 17:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fl6YE62C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEDF206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYuyN-00059N-CZ
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 13:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kYuxP-0004hq-GZ
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 13:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kYuxM-0006sB-Aj
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 13:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604166376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZgPfCLY4W3v4Yj3EhVOjrLtNMfqlAES7GdDvZrFW5sg=;
 b=Fl6YE62Cgi1xV3ZMBQmAO8Yv/iNw7fuoiQsI9UEL0hdzBLA1oZJsVVSqaJ1LWh+pi6Cz5x
 mcSxH4ej+1In4KXPPlyG2yYV1onj989F73PNBRFBDfhiwQAhVP0o+hi4jaHX2U1TFeJGtu
 wZsaT9ZY+nmN1WafJQlDs3wlgmVMokM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-3s0EpuR7Nh-tD3stu2jjDA-1; Sat, 31 Oct 2020 13:46:14 -0400
X-MC-Unique: 3s0EpuR7Nh-tD3stu2jjDA-1
Received: by mail-qv1-f71.google.com with SMTP id s8so5745390qvv.18
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 10:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZgPfCLY4W3v4Yj3EhVOjrLtNMfqlAES7GdDvZrFW5sg=;
 b=bVyfGWnJlXjP2Vzy4nbCbrQgiHSzmUmBuLFbB8BIX+lkzSVM2paYB4Bw6n7iYBsLvx
 Om/W+ssurntV+bj6i26hIXee6czuP9MITWkhYEav9V6/78M4l9DxD84QEk4Co9KFARfc
 9d5e4rNpZj/vdGBqmRBUt2l01/aOKzMm7E6798Iemk1Ju9fUzgSSahuFjfkFINr9Qi3c
 rq4Dg1sjOq8YuO/MQLoUOAo4SN7NWU0owTXhqf8aUxEzUriXWDcSNccNjB3BSoVIAs9S
 Z75i/vQw+2v9PeriFitS7nKu6JgVIiyT7AzEaynBmGmcFaQh3mQ5vGjJrWyuAu0mmfmQ
 9xxQ==
X-Gm-Message-State: AOAM531UCLZ/o1WGQ2IEXLMEl2vdj02gi2wYSYtDt8yyb/NJCmJN016m
 SqTQikZHwVZl9LBBX6p/fCTMCehp4z5w1hYdWtzy+8g3obozJTwT58Z7zGDbjoNfMg4UmbLZuLi
 U9iTdvCpcdHSeHi4=
X-Received: by 2002:ac8:7155:: with SMTP id h21mr7608100qtp.1.1604166374137;
 Sat, 31 Oct 2020 10:46:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpBgu9oxAQT0t96alsuNw7J2wXdGYp25hOWsKvUrsdUDrfBetfNjMFidWEoaZD3QAkc0WvwA==
X-Received: by 2002:ac8:7155:: with SMTP id h21mr7608083qtp.1.1604166373886;
 Sat, 31 Oct 2020 10:46:13 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id w25sm4319316qkj.85.2020.10.31.10.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2020 10:46:13 -0700 (PDT)
Date: Sat, 31 Oct 2020 13:46:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/16] migration queue
Message-ID: <20201031174611.GG6357@xz-x1>
References: <20201026161952.149188-1-dgilbert@redhat.com>
 <2333379.eghUmhzIt0@silver>
 <CAFEAcA-ZfZ6pLEMRj5_qhD2Lz7gQtaLaybDK+BxvJbqoDMmSfA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ZfZ6pLEMRj5_qhD2Lz7gQtaLaybDK+BxvJbqoDMmSfA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 13:46:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Bihong Yu <yubihong@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 31, 2020 at 05:26:28PM +0000, Peter Maydell wrote:
> On Sat, 31 Oct 2020 at 16:12, Christian Schoenebeck
> <qemu_oss@crudebyte.com> wrote:
> >
> > On Montag, 26. Oktober 2020 17:19:36 CET Dr. David Alan Gilbert (git) wrote:
> > > ----------------------------------------------------------------
> > > migration pull: 2020-10-26
> > >
> > > Another go at Peter's postcopy fixes
> > >
> > > Cleanups from Bihong Yu and Peter Maydell.
> > >
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > >
> >
> > May it be possible that this PR introduced a lockup of the qtests that I am
> > encountering in this week's upstream revisions?
> 
> If you try the patches Peter Xu attached to this thread
> does the lockup go away ?
> 
> https://lore.kernel.org/qemu-devel/20201030135350.GA588069@xz-x1/
> 
> (I'm also seeing intermittent hangs, for some reason almost always
> on s390x host.)

It would be good to know exactly which test hanged.  If it's migration-test
then it's very possible.

The race above patch(es) tried to fix should logically be reproducable on all
archs, not s390x only.

Thanks,

-- 
Peter Xu


