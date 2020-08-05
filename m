Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D104C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 04:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1262177B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 04:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SL6hxIrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1262177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3BKE-0006Ve-G0
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 00:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3BJN-0005hQ-LO
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 00:45:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3BJM-0005SB-1E
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 00:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596602755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ppbOb/vLxbQKVZtFQiPgV7O3U8IpzzUsW7nnoOkQPUY=;
 b=SL6hxIrPqLTgyAQKpo80MD8mO6rBLSLSXA7Wi3Ooy+edQ+jw8LJZoZsx0/CQKH6N6axw0n
 x+0UCCMLYn6pcD8X8Utdmiixt2MtGuE7JO2SQfXcU5LIG7N+mMcsdYfONJ3WpwwoEw5d0O
 GkysSpWC+XG4A0/FN8jxxlEy/B8WkTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-1BDr6HPIOlK_i4E053WPxw-1; Wed, 05 Aug 2020 00:45:53 -0400
X-MC-Unique: 1BDr6HPIOlK_i4E053WPxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BE1918C63C1;
 Wed,  5 Aug 2020 04:45:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2610C2B6D9;
 Wed,  5 Aug 2020 04:45:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B1F671141D60; Wed,  5 Aug 2020 06:45:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v6 02/12] monitor: Use getter/setter functions for cur_mon
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-3-kwolf@redhat.com>
 <87lfiubmu3.fsf@dusky.pond.sub.org>
Date: Wed, 05 Aug 2020 06:45:50 +0200
In-Reply-To: <87lfiubmu3.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Tue, 04 Aug 2020 14:46:28 +0200")
Message-ID: <87d0457la9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:09:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Kevin Wolf <kwolf@redhat.com> writes:
>
>> cur_mon really needs to be coroutine-local as soon as we move monitor
>> command handlers to coroutines and let them yield. As a first step, just
>> remove all direct accesses to cur_mon so that we can implement this in
>> the getter function later.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
[...]
>> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
>> index 2ca1e99f17..36fabb5e46 100644
>> --- a/tests/test-util-sockets.c
>> +++ b/tests/test-util-sockets.c
>> @@ -53,27 +53,27 @@ static void test_fd_is_socket_good(void)
>>  static int mon_fd = -1;
>>  static const char *mon_fdname;
>>  
>> -int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
>> -{
>> -    g_assert(cur_mon);
>> -    g_assert(mon == cur_mon);
>> -    if (mon_fd == -1 || !g_str_equal(mon_fdname, fdname)) {
>> -        error_setg(errp, "No fd named %s", fdname);
>> -        return -1;
>> -    }
>> -    return dup(mon_fd);
>> -}
>> -
>>  /* Syms in libqemustub.a are discarded at .o file granularity.
>>   * To replace monitor_get_fd() we must ensure everything in
>>   * stubs/monitor.c is defined, to make sure monitor.o is discarded
>>   * otherwise we get duplicate syms at link time.
>>   */
>>  __thread Monitor *cur_mon;
>
> Hmm.  Since monitor.o's @cur_mon now has internal linkage, the comment
> doesn't apply to @cur_mon anymore.  Easy to fix: move the variable
> before the comment.  Bonus: you don't have to move monitor_get_fd()
> then.
>
> Hmm^2, the comment is stale:
>
> * "libqemustub.a"
>
>   Gone since Commit ebedb37c8d "Makefile: Remove libqemustub.a".  Almost
>   three years.  git-grep finds three more occurences, all bogus.

Thomas posted a patch:

    Subject: [PATCH 07/11] Get rid of the libqemustub.a remainders
    Message-Id: <20200804170055.2851-8-thuth@redhat.com>

>
> * "stubs/monitor.c"
>
>   Commit 6ede81d576 "stubs: Update monitor stubs for
>   qemu-storage-daemon" moved stuff from stubs/monitor.c to
>   monitor-core.c.
>
> * "we must ensure everything in stubs/monitor.c is defined"
>
>   We don't.

These two remain.

> Mind to clean that up beforehand?

[...]


