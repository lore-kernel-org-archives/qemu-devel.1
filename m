Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3034C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8004E206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3kEPrj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8004E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqYec-0005lZ-Po
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 05:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqYcc-0002dZ-HW
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:01:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44234
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqYca-0000gz-Ab
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593594094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7YTS6MnDyMv4lTExixCVsbTrsyAeyYSij5ieO6lNT5Q=;
 b=b3kEPrj/U1AioDykr5txGXqlLUIBiFClHx5QIAolDeLgLXMbwLyS1+xNj1Ao59Zm5h+Z3y
 xKbkcVbj9sQSgVAN/I44fKgOy4p1CXvYtoaiVC0WHmlk+AfIkBmqL4+xGgftXyEHVroyqR
 9yhzqlbfNAsD5uZcB1/L85Q4QOglLxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-ktanh5USOWu_uCJepEUqNw-1; Wed, 01 Jul 2020 05:01:32 -0400
X-MC-Unique: ktanh5USOWu_uCJepEUqNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5C3818A822D;
 Wed,  1 Jul 2020 09:01:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BD6A7554B;
 Wed,  1 Jul 2020 09:01:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA44411384A6; Wed,  1 Jul 2020 11:01:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 15/46] qemu-option: Tidy up opt_set() not to free
 arguments on failure
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-16-armbru@redhat.com>
 <f9545aa8-93d1-1b0c-9303-f8f8df6c2468@virtuozzo.com>
Date: Wed, 01 Jul 2020 11:01:29 +0200
In-Reply-To: <f9545aa8-93d1-1b0c-9303-f8f8df6c2468@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 29 Jun 2020 13:37:03 +0300")
Message-ID: <87ftabbod2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 24.06.2020 19:43, Markus Armbruster wrote:
>> opt_set() frees its argument @value on failure.  Slightly unclean;
>> functions ideally do nothing on failure.
>>
>> To tidy this up, move opt_create() from opt_set() into its callers,
>> along with the cleanup.
>
> Hmm, let me think a bit..
>
> So, prior to this patch:
>
> opt_set gets name/value pair and sets the option in opts object, it
> seems absolutely obvious and standard behavior for Map-like object.
>
> The fact that for setting an option we create a QemuOpt object, and
> somehow register it inside opts object is an implementation detail.

You explain behavior on success.  The issue is behavior on failure.

> after the patch:
>
> opt_set gets opt object, which is already registered in opts. So,
> it seems like option is "partly" set already, and opt_set only
> finalize the processing.

Yes, opt_set() becomes a bit of a misnomer: it doesn't add a QemuOpt to
@opts, it validates a QemuOpt against its key's description, if @opts
has descriptions.

Hmm, opt_set() is now almost identical to qemu_opts_validate()'s loop
body.  Perhaps I can de-duplicate.

> And, as opt_set() only finalize the "set" operation, on opt_set
> failure we need additional roll-back of "set" operation first step.
>
> Additional fact, indirectly showing that something is unclear here
> is that we pass "opts" to opt_set twice: as "opts" parameter and
> inside opt: (opt->opts must be the same, assertion won't hurt if
> you decide to keep the patch).

Valid point.

> =====
>
> Semantics before the patch seems clearer to me.
>
> To improve the situation around "value", we can just g_strdup it
> in opt_create as well as "name" argument (and use const char*
> type for "value" argument as well)

We don't strdup() there because opts_do_parse() extracts the value with
get_opt_name(), which strdup()s it.  strdup()ing it some more isn't
wrong, I just dislike it.

Let me try the de-duplication, and then we'll see whether you still
dislike the patch.


