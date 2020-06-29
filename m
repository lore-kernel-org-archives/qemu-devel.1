Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82374C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F0B2559E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGkEqEg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F0B2559E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwx9-0001dl-IE
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jpwvN-0000Is-R6
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:46:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47369
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jpwvK-00007I-KX
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593449185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2ydEmJtS74dkGgWip283hz9yt3By0IcMIvsD9bpTDg=;
 b=IGkEqEg5bqEuSpKLCEMfcxoCcLfe3xIevsigd857bbej5aEhyqCvZFBKDJsKu2O/HtS943
 Yvt7hGVtHTKzy6Uqf6MS7Vq0Z7qWiUiQKX+0JbfQzYFP4ogiSwUKQYOOXqN5P+CjJsfmTi
 XDlmfEnxButNtnmYbzUjYwCHUkF6Y4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-cmLMNBy-PYq7UppDLNz0Ug-1; Mon, 29 Jun 2020 12:46:23 -0400
X-MC-Unique: cmLMNBy-PYq7UppDLNz0Ug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CECD80183C;
 Mon, 29 Jun 2020 16:46:22 +0000 (UTC)
Received: from work-vm (ovpn-114-210.ams2.redhat.com [10.36.114.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C37F60BF3;
 Mon, 29 Jun 2020 16:46:20 +0000 (UTC)
Date: Mon, 29 Jun 2020 17:46:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: Properly quitting qemu immediately after failing migration
Message-ID: <20200629164618.GL2908@work-vm>
References: <0dce6c63-4b83-8b1a-6d00-07235f637997@redhat.com>
 <20200629154104.GK2908@work-vm>
 <fb611d49-4fd9-ef1a-1383-1d15137f658d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fb611d49-4fd9-ef1a-1383-1d15137f658d@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:37:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Max Reitz (mreitz@redhat.com) wrote:
> On 29.06.20 17:41, Dr. David Alan Gilbert wrote:
> > * Max Reitz (mreitz@redhat.com) wrote:
> >> Hi,
> >>
> >> In an iotest, I’m trying to quit qemu immediately after a migration has
> >> failed.  Unfortunately, that doesn’t seem to be possible in a clean way:
> >> migrate_fd_cleanup() runs only at some point after the migration state
> >> is already “failed”, so if I just wait for that “failed” state and
> >> immediately quit, some cleanup functions may not have been run yet.
> > 
> > Yeh this is hard; I always take the end of migrate_fd_cleanup to be the
> > real end.
> 
> Yes, unfortunately I don’t seem to have a way to look for that end. :(
> 
> > It always happens on the main thread I think (it's done as a bh in some
> > cases).
> > 
> >> This is a problem with dirty bitmap migration at least, because it
> >> increases the refcount on all block devices that are to be migrated, so
> >> if we don’t call the cleanup function before quitting, the refcount will
> >> stay elevated and bdrv_close_all() will hit an assertion because those
> >> block devices are still around after blk_remove_all_bs() and
> >> blockdev_close_all_bdrv_states().
> >>
> >> In practice this particular issue might not be that big of a problem,
> >> because it just means qemu aborts when the user intended to let it quit
> >> anyway.  But on one hand I could imagine that there are other clean-up
> >> paths that should definitely run before qemu quits (although I don’t
> >> know), and on the other, it’s a problem for my test.
> > 
> > 'quit' varies - there are a lot of incoming failures that just assert;
> > very few of them cause a clean exit (I think there are more clean ones
> > after Peter's work on restartable postcopy a year or two ago).
> 
> Well, my problem is about the source side, where there is still a VM
> running that I would expect to be in a sane state even after a failed
> migration.

Oh! Source side; the source side I worry much more about; if the
destination implodes after a failed migration I'm not too worried - but
the source side *shall not* fail.

> > I do see the end of migrate_fd_cleanup calls the notifier list; but it's
> > not clear to me that it's alwyas going to see the first transition to
> > 'failed' at that point.
> 
> What exactly do you mean?  It appears to me that both query-status and
> the MIGRATION events signal the failed state before migrate_fd_cleanup()
> is invoked.

OK, I was getting confused between event sending and the notifiers; the
event happens a bit before.  The state gets set to failed and then we
call fd_cleanup in most cases; the state is what query-status is keyed
off, and is also what causes the event to be sent.

> If you mean I could add a notifier to that list to do something™, I’m
> not sure what exactly it is I’d so.

Yeh, that's why the notifiers are there....
However, if you need to do some cleanup at the end of a migration, then
I think adding a call inside migrate_fd_cleanup is perfectly fine.

>  My test can’t do it, because it’s
> an iotest, and even if it could, I suppose I’d want to wait until even
> after all notifiers have been invoked (which isn’t guaranteed if I’d add
> a notifier myself).
> 
> >> I tried working around the problem for my test by waiting on “Unable to
> >> write” appearing on stderr, because that indicates that
> >> migrate_fd_cleanup()’s error_report_err() has been reached.  But on one
> >> hand, that isn’t really nice, and on the other, it doesn’t even work
> >> when the failure is on the source side (because then there is no
> >> s->error for migrate_fd_cleanup() to report).
> >>
> >> In all, I’m asking:
> >> (1) Is there a nice solution for me now to delay quitting qemu until the
> >> failed migration has been fully resolved, including the clean-up?
> > 
> > In vl.c, I added a call to migration_shutdown in qemu_cleanup - although
> > that seems to be mostly about cleaning up the *outgoing* side; you could
> > add some incoming cleanup there.
> 
> So you mean waiting until migrate_fd_cleanup() has run?  Maybe I’ll try
> that tomorrow, although I’d hoped I could get this done without having
> to modify the code base...  (I.e., I’d hoped there would be some
> QMP-queriable flag somewhere that could tell me whether the
> migrate_fd_cleanup() has run)

Please be a little careful around there; i.e. try as far as possible not
to hang on dead block devices.

> >> (2) Isn’t it a problem if qemu crashes when you issue “quit” via QMP at
> >> the wrong time?  Like, maybe lingering subprocesses when using “exec”?
> > 
> > Yeh that should be cleaner, but isn't.
> 
> :(

Randomly quitting is safer than it used to be (again that qemu_cleanup
code is what should make it so).

Dave

> OK then.  Thanks for your insights!
> 
> Max
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


