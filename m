Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9E7C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168712072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWbn8HDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168712072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoe4-00081s-2Z
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDocW-0006TP-1V
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:45:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39096
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDocT-0001f9-Hp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599137136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jthmIaUgEtIapQCaA4bR4lRIdoGcsA31SsEo0vpAn8E=;
 b=bWbn8HDcygaVdHztAmQa1ibP2+7Wxg24wyLNsiXf26audpyvleyy2EHUJI8MCd/M9E/NZS
 OSktkC+4WU1ZxWjE8E3fp/Ud28MbW4j/oKVqdnBy4exwmKPi2/ToAMeD2GRZ6Jk2xiC90v
 LUuFf5p6Iuzeb20ttzef7NFTag3u+c4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-pKLM1PhfPVSEXF0dqkRQtg-1; Thu, 03 Sep 2020 08:45:33 -0400
X-MC-Unique: pKLM1PhfPVSEXF0dqkRQtg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08D8D801FD5;
 Thu,  3 Sep 2020 12:45:32 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-183.ams2.redhat.com [10.36.114.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14C91385;
 Thu,  3 Sep 2020 12:45:30 +0000 (UTC)
Date: Thu, 3 Sep 2020 14:45:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 00/12] monitor: Optionally run handlers in coroutines
Message-ID: <20200903124529.GC8835@linux.fritz.box>
References: <20200528153742.274164-1-kwolf@redhat.com>
 <87d046d5k1.fsf@dusky.pond.sub.org>
 <87y2mtpbrf.fsf@dusky.pond.sub.org>
 <87ft7zm8yr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87ft7zm8yr.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.09.2020 um 12:49 hat Markus Armbruster geschrieben:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Markus Armbruster <armbru@redhat.com> writes:
> >
> >> I let this series slide to get my Error API rework done, along with much
> >> else.  My sincere apologies!
> >>
> >> Unsurprisingly, it needs a rebase now.  I suggest to let me review it as
> >> is first.
> >
> > I'm done with v6.  Summary:
> >
> > * A few trivial things to correct here and there.
> >
> > * A few ideas to improve things in relatively minor ways.
> >
> > * PATCH 03 looks "why bother" to me until PATCH 09 makes me suspect you
> >   did the former to enable the latter.  If you had captured that in your
> >   commit message back then, like you did for the similar PATCH 05, I
> >   wouldn't be scratching my head now :)
> >
> > * I dislike PATCH 06, and would like to explore an alternative idea.
> >
> > * PATCH 08 makes hairy monitor code even hairier, but I don't have
> >   better ideas.
> >
> > * I don't feel comfortable as a sole reviewer of the AIO magic in PATCH
> >   10-12.  Let's ask Stefan for an eye-over.
> >
> > I'd like to proceed as follows.  You rebase, and address "easy" review
> > comments (you decide what's easy).  Post as v7, cc'ing Stefan for the
> > AIO magic and David Gilbert for HMP.  While they review (hopefully), I
> > explore a replacement for PATCH 06.  And then we touch bases and decide
> > how to get this thing wrapped.
> 
> I explored:
> 
>     Subject: Ways to do per-coroutine properties (was: [PATCH v6 06/12] monitor: Make current monitor a per-coroutine property)
>     Date: Fri, 07 Aug 2020 15:09:19 +0200 (3 weeks, 5 days, 21 hours ago)
>     Message-ID: <87a6z6wqkg.fsf_-_@dusky.pond.sub.org>
> 
> May I have v7?  Feel free to keep your PATCH 06.  If I decide to replace
> it, I can do it myself, possibly on top.

It's one of the next things on my list. I can't promise anything more
specific, though.

Kevin


