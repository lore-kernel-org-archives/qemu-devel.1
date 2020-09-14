Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E61C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A70208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+OqfV+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A70208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqmP-0004uq-Qk
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHq9k-0005xT-Cx
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHq9i-0001Cr-60
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600096349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dd3GXnEjgoAnUmz/ncsCBQVJXy51bVIMrRUnXganD7A=;
 b=Y+OqfV+wTtw4CylWSwWQQf/fEWEXHnmuXUsbs5XltcbgQEZColvjL3607ZaGr/FRFJ49Sd
 IyLfxWKqDbFhrD86UXwaqCUs64W50Pv5on83P7O3jrle5qvy5MiSNcPgFUymEW5cOz3Be/
 gm0PILn3kSyli5Vyitp2pSs008RurtA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330--jChKDb7MV-B_UA6cdsx5Q-1; Mon, 14 Sep 2020 11:11:54 -0400
X-MC-Unique: -jChKDb7MV-B_UA6cdsx5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6730A873115;
 Mon, 14 Sep 2020 15:11:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D7F260DA0;
 Mon, 14 Sep 2020 15:11:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A62D4113864A; Mon, 14 Sep 2020 17:11:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 07/13] monitor: Make current monitor a per-coroutine
 property
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-8-kwolf@redhat.com>
Date: Mon, 14 Sep 2020 17:11:48 +0200
In-Reply-To: <20200909151149.490589-8-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 9 Sep 2020 17:11:43 +0200")
Message-ID: <874ko0o0jv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> This way, a monitor command handler will still be able to access the
> current monitor, but when it yields, all other code code will correctly
> get NULL from monitor_cur().
>
> This uses a hash table to map the coroutine pointer to the current
> monitor of that coroutine.  Outside of coroutine context, we associate
> the current monitor with the leader coroutine of the current thread.

In qemu-system-FOO, the hash table can have only these entries:

* (OOB) One mapping @mon_iothread's thread leader to a QMP monitor, while
  executing a QMP command out-of-band.

* (QMP-CO) One mapping @qmp_dispatcher_co (a coroutine in the main
  thread) to a QMP monitor, while executing a QMP command in-band and in
  coroutine context.

* (QMP) One mapping the main thread's leader to a QMP monitor, while
  executing a QMP command in-band and out of coroutine context, in a
  bottom half.

* (HMP) One mapping the main thread's leader to an HMP monitor, while
  executing an HMP command out of coroutine context.

* (HMP-CO) One mapping a transient coroutine in the main thread to an
  HMP monitor, while executing an HMP command in coroutine context.

In-band execution is one command after the other.

Therefore, at most one monitor command can be executing in-band at any
time.

Therefore, the hash table has at most *two* entries: one (OOB), and one
of the other four.

Can you shoot any holes into my argument?

I suspect there's a simpler solution struggling to get out.  But this
solution works, so in it goes.  Should the simpler one succeed at
getting out, it can go in on top.  If not, I'll probably add even more
comments to remind myself of these facts.

> Approaches to implement some form of coroutine local storage directly in
> the coroutine core code have been considered and discarded because they
> didn't end up being much more generic than the hash table and their
> performance impact on coroutines not using coroutine local storage was
> unclear. As the block layer uses a coroutine per I/O request, this is a
> fast path and we have to be careful. It's safest to just stay out of
> this path with code only used by the monitor.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>


