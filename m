Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D86C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B87C2085B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="jHpR74pH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B87C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUwM4-0007JU-7S
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 14:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUwKq-00065A-20
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:26:12 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:34147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUwKk-00081K-2c
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=e+CIc2v4/Vs4xJvUgyrLhQ0a/Arqx4WEKf9XRXT2dOk=; b=jHpR74pHU2g5oSkUWZU8jDgDRI
 Ng454wsLjNg6fPsPrUhT8/rgrp+WLA89OqlqAHDSm2/4u1CCUvf+HzPxieHnNxXe3YLO4/7oxgbE6
 /dJxXwNpgRqdYFvVCaH0Omx4N9AvlUTCr0+Ulpv4/3gCPW9Iqb08WxG95x99Vtq8CMEkUP9VWW5Gj
 ItvuyOD+L/iuiPsSRKwwrP9X9oq8wN00KuiaCS0FTtGmPUgOfK03I3ULfm59+KQ/25+NjsJMkI6wd
 6V4jZK1S0KQjwyxIJ8uRl/q+avYFEd2DQPH0uWOo0hcQ57sRh90fvMFnlpJy6kj94uXQ1LNyXLqJf
 NfSpzTqw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/8] tests/9pfs: simplify fs_mkdir()
Date: Tue, 20 Oct 2020 20:26:00 +0200
Message-ID: <2301577.3xkuHIIkH7@silver>
In-Reply-To: <20201020200309.20f8e85d@bahia.lan>
References: <cover.1603149434.git.qemu_oss@crudebyte.com>
 <2130426.d1XtYRms3g@silver> <20201020200309.20f8e85d@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:54:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dienstag, 20. Oktober 2020 20:03:09 CEST Greg Kurz wrote:
> On Tue, 20 Oct 2020 15:43:21 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Dienstag, 20. Oktober 2020 15:35:36 CEST Greg Kurz wrote:
> > > On Tue, 20 Oct 2020 01:13:23 +0200
> > > 
> > > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > > Split out walking a directory path to a separate new utility function
> > > > fs_walk_fid() and use that function in fs_mkdir().
> > > > 
> > > > The code difference saved this way is not much, but we'll use that new
> > > > fs_walk_fid() function in the upcoming patches, so it will avoid quite
> > > > some code duplication after all.
> > > > 
> > > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > > ---
> > > > 
> > > >  tests/qtest/virtio-9p-test.c | 23 ++++++++++++++++++-----
> > > >  1 file changed, 18 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/tests/qtest/virtio-9p-test.c
> > > > b/tests/qtest/virtio-9p-test.c
> > > > index c15908f27b..dc724bbb1e 100644
> > > > --- a/tests/qtest/virtio-9p-test.c
> > > > +++ b/tests/qtest/virtio-9p-test.c
> > > > @@ -967,13 +967,12 @@ static void fs_flush_ignored(void *obj, void
> > > > *data,
> > > > QGuestAllocator *t_alloc)>
> > > > 
> > > >      g_free(wnames[0]);
> > > >  
> > > >  }
> > > > 
> > > > -static void fs_mkdir(void *obj, void *data, QGuestAllocator *t_alloc,
> > > > -                     const char *path, const char *cname)
> > > > +/* utility function: walk to requested dir and return fid for that
> > > > dir */
> > > > +static uint32_t fs_walk_fid(void *obj, void *data, QGuestAllocator
> > > > *t_alloc, +                            const char *path)
> > > > 
> > > >  {
> > > 
> > > Since fs_walk_fid() is a helper function, ie. not passed to
> > > qos_add_test(),
> > > any reason to keep the "void *obj, void *data, QGuestAllocator *t_alloc"
> > > based signature ? data and t_alloc aren't used at all and it seems that
> > > the
> > > function should rather take a QVirtio9P * directly instead of casting
> > > from
> > > a void *.
> > > 
> > > Something like:
> > > 
> > > static uint32_t fs_walk_fid(QVirtio9P *v9p, const char *path)
> > > {
> > > ...
> > > }
> > > 
> > > 
> > > Same remark applies to fs_mkdir() which isn't a top level test function
> > > either BTW (sorry for not having spotted this earlier).
> > 
> > Good point. Typical case of being copy & waste induced. I'll change that.
> 
> Since this also affects other patches in this series and this might
> have a substantial impact, I'll wait for v2 to review if you don't
> mind.

Sure!

There is probably no need to hurry anyway; since these are just test case 
changes, I think it will also be fine if I send the PR during freeze.

You never had any issue with 9p hard links, right? I'm still investigating 
this in parallel. I already can rule out QEMU's sandbox (seccomp) feature, 
even after having disabled the latter that mentioned box is failing any 
link()/linkat() calls. Maybe it's a SELinux issue ...

Best regards,
Christian Schoenebeck



