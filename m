Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1F9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 04:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C100920842
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 04:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIKmz1Mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C100920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3BDR-0004fd-2J
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 00:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3BCc-00047e-5f
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 00:38:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44443
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3BCZ-0004aP-5A
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 00:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596602333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1+IRZUt9cyEPbb+e6AQbzApEJa7HEzjTUNgCD2l6vKc=;
 b=JIKmz1MortKc1C20x3kCnQeWiLJzhPM5+wxmC9egZb9CZAKn6U0yT1cA1ejXacdtYcPDe7
 hgSVIW1azZUiJiZWMzwkbh8EheaKpcz3uCz17tmw0Xpuy8kIXCKTjByMh71l8p+idFUQ27
 iLNcHl4EiD5YU3lH55NYdlReUnS8WdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-mir_klMQPvqwG-loa6_w6g-1; Wed, 05 Aug 2020 00:38:52 -0400
X-MC-Unique: mir_klMQPvqwG-loa6_w6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88B06100960F;
 Wed,  5 Aug 2020 04:38:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A1E471765;
 Wed,  5 Aug 2020 04:38:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B4B851141D60; Wed,  5 Aug 2020 06:38:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Josh DuBois <josh@joshdubois.com>
Subject: Re: [PATCH] trace/simple: Allow enabling simple traces from command
 line
References: <20200723053359.256928-1-josh@joshdubois.com>
 <20200729130535.GI37763@stefanha-x1.localdomain>
 <e08651bd-f775-eb85-817c-44d27ff072dc@joshdubois.com>
 <87h7tkm70n.fsf@dusky.pond.sub.org>
 <A86BEB45-4022-4D7C-936C-5CDCC580EBF8@joshdubois.com>
Date: Wed, 05 Aug 2020 06:38:48 +0200
In-Reply-To: <A86BEB45-4022-4D7C-936C-5CDCC580EBF8@joshdubois.com> (Josh
 DuBois's message of "Tue, 4 Aug 2020 12:41:12 -0500")
Message-ID: <87h7th7llz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Josh DuBois <duboisj@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Josh DuBois <josh@joshdubois.com> writes:

> On Aug 3, 2020, at 4:08 AM, Markus Armbruster <armbru@redhat.com> wrote:
>> 
>>> 
>>> - prior to db25d56c014aa1a96319c663e0a60346a223b31e, just like today,
>>> QEMU built with simple tracing will always produce a trace-<pid> file,
>>> regardless of whether the user asks for traces at runtime.
>> 
>> When you send a patch with a Fixes: tag, consider cc'ing people involved
>> in the commit being fixed.  I might have spotted the regression.
>
> Sure, this makes sense.  
>
>> I missed the CLI issue.  I just wanted my directories not littered with
>> trace files ;)
>> 
>> Stefan, what shall we do for 5.1?
>> 
>> If we keep littering, the annoyance will make me drop the trace backend
>> "simple" from my build tests.  I might even remember to put it back when
>> the fix arrives.
>
> I haven't seen another response, but I just noticed a 'last call' for 5.1.  If this means something is going to get excluded from regular build tests, that seems important - I for one have no objection to simply reverting this - 1b7157be3a8c4300fc8044d40f4b2e64a152a1b4 <-- my "fix."

These are just my local build test.  Our CI is not affected.

Reverting is up to Stefan.

> I will try to send a better fix along sometime soonish, but I probably won't get to that before 5.1.  If the nuisance of the trace-<pid> files is causing real-world problems for someone actually doing regular development, that seems more important than the command line issue, to me.  Just my $0.02.
>
> Cheers, and sorry if your build dirs do end up littered again.

Sorry for breaking your use case, and looking forward to your fix for
your fix!


