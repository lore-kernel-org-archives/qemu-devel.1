Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9792C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F46820735
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Uv3TJtOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F46820735
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWf06-00011N-EU
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 07:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jWezO-0000Zb-10
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:46:54 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:48439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jWezN-0002Dy-4q
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=e1M1gaMGT7Tww+/9aypkYlb1WdzIMrti+7K/K9ecWvs=; b=Uv3TJtOrrDMKmtHL2rAM0G00rF
 eek6+wZs2SVuxavdmCkIhKM7KSXyUmbGkcMdNIT4i06K2eC95HxNs0ddHU7EE+Ps62o4qZhcCCVP9
 3d6wR5/UcWcHVlFS+exPgm8s5hTo7ibjQoq0bQIJAQjBRXRFW2aZcgGD96dtQYegkBgq13sqKASag
 7hf4kd3IDK8EdZHGB71+xXtSC7GHalUe/0vv//5KonN5qnXoQcG7YTTgLJjDZ9iM2FyP6BtJ1tNB0
 RtdTQlH7PDxzK3hzPI+LoH4I0o8JQhDVsGjnG6DvEpJ5DTTDGEX6dHrVk82vb8/XBqI+6Yheh5+OF
 4dBXehTJcIRKB/Cwi7wyXEuD+HFQZ9fpEBet75E82CWCwAPV9b/vfCF9zX63i1BDHO8WFLZpgeiue
 dybhUAlFwqL9a/vHSZtFqXQGN7RA6wTbxWu3tsX47WhJwBgtM7gz+9JozwTssYmmowt4etE1/grIS
 egd+XFbWrttOSJ28kxXVswdljv+hAAqkWX93y90ddDMD0Ywa2qVFF6bRKelRJiaTfDtNmBzGEZt/D
 Hq+OQnQLvvJ+PDSUxf/yEYLBC5Zj3jL5X1m8VqtJdX2PUs0atPtb+/u2+aVA+v0l/WFb0bT4JIbfa
 QH0T88riADr98Vtjo8KBLT0sC2V9YJ6TevhP1qpRQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: Fix potential deadlock of QEMU mainloop
Date: Thu, 07 May 2020 13:46:50 +0200
Message-ID: <3205025.KiTILEyK6o@silver>
In-Reply-To: <20200506195415.4cc48810@bahia.lan>
References: <158826201391.1344781.9403916162733181811.stgit@bahia.lan>
 <3204505.kZXhZKLjgj@silver> <20200506195415.4cc48810@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 07:37:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Mittwoch, 6. Mai 2020 19:54:15 CEST Greg Kurz wrote:
> On Wed, 06 May 2020 15:36:16 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Mittwoch, 6. Mai 2020 15:05:23 CEST Christian Schoenebeck wrote:
> > > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > > index 9e046f7acb51..ac84ae804496 100644
> > > > --- a/hw/9pfs/9p.c
> > > > +++ b/hw/9pfs/9p.c
> > > > @@ -2170,7 +2170,7 @@ static int coroutine_fn
> > > > v9fs_do_readdir_with_stat(V9fsPDU *pdu, int32_t count = 0;
> > > > 
> > > >      struct stat stbuf;
> > > >      off_t saved_dir_pos;
> > > > 
> > > > -    struct dirent *dent;
> > > > +    struct dirent dent;
> > 
> > One more: since this dirent structure is now on the stack, it should
> > better be initialized for safety reasons.
> 
> I don't think so, for two reasons:
> - I can't think of an initializer that would make sense for a dirent

The same as it would (implied - usually, e.g. with gmalloc0()) if you were 
allocating it on heap: by initializing it with all zeroes, e.g. just:

	struct dirent dent = {};

> - if a future change introduces a branch where dent could be used
>   uninitialized, I'd rather give a chance to the compiler to bark

The compiler would reliably bark on using it unitialized if you were about to 
access it directly within the same function. But that's not the case here. 
dirent is passed by reference to a function which will be altering it. Such 
stacked relations usually require more sophisticated diagnostics, like e.g. 
exeuting the LLVM sanitizer.

Best regards,
Christian Schoenebeck



