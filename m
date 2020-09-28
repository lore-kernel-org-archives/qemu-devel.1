Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D669DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173322075A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrIXOG2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173322075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMqcg-0007Fy-3z
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kMqby-0006QC-On
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kMqbw-0006CQ-OE
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:42:26 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601289743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v0X7vSvNxXeBXTHcC1rQ4ded5Y8jHTSaXxF7/lALPtk=;
 b=hrIXOG2q0w8wlc8u94/qLP2mPHwcRhux3D+kp815QgKwBFxw1Dy9wVBs5ExSSX7GC60cVL
 WumrIooodLAFZlhjhg59tQ5lsvLCBWW5f7WjbwWPttZQuGZLRfsZesaM5DKWAbOlts+q8U
 qaLQKJAtJAiiQHuyo+u0zrAGhqZ0d7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-d4n_AqgHMuSVm2Bp-SsaSg-1; Mon, 28 Sep 2020 06:42:21 -0400
X-MC-Unique: d4n_AqgHMuSVm2Bp-SsaSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76FB58027E1;
 Mon, 28 Sep 2020 10:42:20 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-193.ams2.redhat.com [10.36.114.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF98B5D9CA;
 Mon, 28 Sep 2020 10:42:15 +0000 (UTC)
Date: Mon, 28 Sep 2020 12:42:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v7 07/13] monitor: Make current monitor a per-coroutine
 property
Message-ID: <20200928104214.GE5451@linux.fritz.box>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-8-kwolf@redhat.com>
 <874ko0o0jv.fsf@dusky.pond.sub.org>
 <20200925152307.GF5731@linux.fritz.box>
 <87sgb2l4wb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87sgb2l4wb.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-block@nongnu.org, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.09.2020 um 09:47 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 14.09.2020 um 17:11 hat Markus Armbruster geschrieben:
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >> 
> >> > This way, a monitor command handler will still be able to access the
> >> > current monitor, but when it yields, all other code code will correctly
> >> > get NULL from monitor_cur().
> >> >
> >> > This uses a hash table to map the coroutine pointer to the current
> >> > monitor of that coroutine.  Outside of coroutine context, we associate
> >> > the current monitor with the leader coroutine of the current thread.
> >> 
> >> In qemu-system-FOO, the hash table can have only these entries:
> >> 
> >> * (OOB) One mapping @mon_iothread's thread leader to a QMP monitor, while
> >>   executing a QMP command out-of-band.
> >> 
> >> * (QMP-CO) One mapping @qmp_dispatcher_co (a coroutine in the main
> >>   thread) to a QMP monitor, while executing a QMP command in-band and in
> >>   coroutine context.
> >> 
> >> * (QMP) One mapping the main thread's leader to a QMP monitor, while
> >>   executing a QMP command in-band and out of coroutine context, in a
> >>   bottom half.
> >> 
> >> * (HMP) One mapping the main thread's leader to an HMP monitor, while
> >>   executing an HMP command out of coroutine context.
> >> 
> >> * (HMP-CO) One mapping a transient coroutine in the main thread to an
> >>   HMP monitor, while executing an HMP command in coroutine context.
> >> 
> >> In-band execution is one command after the other.
> >> 
> >> Therefore, at most one monitor command can be executing in-band at any
> >> time.
> >> 
> >> Therefore, the hash table has at most *two* entries: one (OOB), and one
> >> of the other four.
> >> 
> >> Can you shoot any holes into my argument?
> >
> > I think with human-monitor-command, you can have three mappings:
> >
> > 1. The main thread's leader (it is a non-coroutine QMP command) to the
> >    QMP monitor
> 
> This is (QMP).
> 
> > 2. With a coroutine HMP command, one mapping from the transient HMP
> >    coroutine to the transient HMP monitor (with a non-coroutine HMP
> >    command, we'd instead temporarily change the mapping from 1.)
> 
> This is (HMP-CO).
> 
> > 3. The OOB entry
> 
> This is (OOB).
> 
> To get 1. (QMP) and 2, (HMP-CO) at the same time, the in-band,
> non-coroutine QMP command needs to execute interleaved with the in-band,
> coroutine HMP command.
> 
> Such an interleaving contradicts "In-band execution is one command after
> the other", which is a fundamental assumption in-band commands may make.
> If the assumption is invalid, we got a problem.  Is it?

Interleaving, or rather executing another command in the middle of its
implementation is the very purpose of human-monitor-command (which is
what I was talking about, so "the in-band non-coroutine QMP command" is
a very specific one).

It's the only command I can think of that is exceptional in this way
and would lead to three mappings.

Kevin


