Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18EEC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC572083B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDKeYUjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC572083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMsAv-0008K5-RR
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 08:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMs9n-0007TT-Lf
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMs9l-0003kZ-Mg
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:21:27 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601295684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wF5ZJQ9iAoLM0FvsDdf+Of7366TyacIP0Z61xSfrZew=;
 b=GDKeYUjPYYVkZZ8dFWiT22RBU8C1C/p0vVMC/iKKh0bEUfCF3U41UbO9w9cFqIjygMa1V+
 1hxSwyTod/8sGHct3wvTmTDIDBCuYk4idpWATIr2G7pGBFdBJS8+M8H+l+hjjOi6XbJifv
 wZsthoP7tbWXbreZd/n7gv8db7rmscY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-R4bft1ujMhqdl8jq77a0OQ-1; Mon, 28 Sep 2020 08:21:22 -0400
X-MC-Unique: R4bft1ujMhqdl8jq77a0OQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B037101962E;
 Mon, 28 Sep 2020 12:21:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7D9660DA0;
 Mon, 28 Sep 2020 12:21:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7DF46113865F; Mon, 28 Sep 2020 14:21:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 07/13] monitor: Make current monitor a per-coroutine
 property
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-8-kwolf@redhat.com>
 <874ko0o0jv.fsf@dusky.pond.sub.org>
 <20200925152307.GF5731@linux.fritz.box>
 <87sgb2l4wb.fsf@dusky.pond.sub.org>
 <20200928104214.GE5451@linux.fritz.box>
Date: Mon, 28 Sep 2020 14:21:16 +0200
In-Reply-To: <20200928104214.GE5451@linux.fritz.box> (Kevin Wolf's message of
 "Mon, 28 Sep 2020 12:42:14 +0200")
Message-ID: <878scugkhv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 28.09.2020 um 09:47 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > Am 14.09.2020 um 17:11 hat Markus Armbruster geschrieben:
>> >> Kevin Wolf <kwolf@redhat.com> writes:
>> >> 
>> >> > This way, a monitor command handler will still be able to access the
>> >> > current monitor, but when it yields, all other code code will correctly
>> >> > get NULL from monitor_cur().
>> >> >
>> >> > This uses a hash table to map the coroutine pointer to the current
>> >> > monitor of that coroutine.  Outside of coroutine context, we associate
>> >> > the current monitor with the leader coroutine of the current thread.
>> >> 
>> >> In qemu-system-FOO, the hash table can have only these entries:
>> >> 
>> >> * (OOB) One mapping @mon_iothread's thread leader to a QMP monitor, while
>> >>   executing a QMP command out-of-band.
>> >> 
>> >> * (QMP-CO) One mapping @qmp_dispatcher_co (a coroutine in the main
>> >>   thread) to a QMP monitor, while executing a QMP command in-band and in
>> >>   coroutine context.
>> >> 
>> >> * (QMP) One mapping the main thread's leader to a QMP monitor, while
>> >>   executing a QMP command in-band and out of coroutine context, in a
>> >>   bottom half.
>> >> 
>> >> * (HMP) One mapping the main thread's leader to an HMP monitor, while
>> >>   executing an HMP command out of coroutine context.
>> >> 
>> >> * (HMP-CO) One mapping a transient coroutine in the main thread to an
>> >>   HMP monitor, while executing an HMP command in coroutine context.
>> >> 
>> >> In-band execution is one command after the other.
>> >> 
>> >> Therefore, at most one monitor command can be executing in-band at any
>> >> time.
>> >> 
>> >> Therefore, the hash table has at most *two* entries: one (OOB), and one
>> >> of the other four.
>> >> 
>> >> Can you shoot any holes into my argument?
>> >
>> > I think with human-monitor-command, you can have three mappings:
>> >
>> > 1. The main thread's leader (it is a non-coroutine QMP command) to the
>> >    QMP monitor
>> 
>> This is (QMP).
>> 
>> > 2. With a coroutine HMP command, one mapping from the transient HMP
>> >    coroutine to the transient HMP monitor (with a non-coroutine HMP
>> >    command, we'd instead temporarily change the mapping from 1.)
>> 
>> This is (HMP-CO).
>> 
>> > 3. The OOB entry
>> 
>> This is (OOB).
>> 
>> To get 1. (QMP) and 2, (HMP-CO) at the same time, the in-band,
>> non-coroutine QMP command needs to execute interleaved with the in-band,
>> coroutine HMP command.
>> 
>> Such an interleaving contradicts "In-band execution is one command after
>> the other", which is a fundamental assumption in-band commands may make.
>> If the assumption is invalid, we got a problem.  Is it?
>
> Interleaving, or rather executing another command in the middle of its
> implementation is the very purpose of human-monitor-command (which is
> what I was talking about, so "the in-band non-coroutine QMP command" is
> a very specific one).

Got it now, thanks.

> It's the only command I can think of that is exceptional in this way
> and would lead to three mappings.
>
> Kevin


