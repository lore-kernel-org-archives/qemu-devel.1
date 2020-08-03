Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3AEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031E720775
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjwfKrMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031E720775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Z3y-0008FY-2R
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 07:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2Z3N-0007op-61
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:54:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52955
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2Z3L-0000fk-EM
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596455690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ahWxR/GnuMvQ9gDhvj2rTV+LBgp97PJ89il2AsYmdMQ=;
 b=WjwfKrMunuQOTYpPQ8fCiv54u47I5++kVnxDy7ZghYcYieTofXGqEIcblBv4jTdqAyNPQx
 K9r6JJfNtyWaFnVh0q2sDfSxpgYtKAIQCcN1iM0ahhPKSBtKgurLtqdAp3CVKU2xYAU2+8
 UfK53WEiEdP8c1JujWzFULfZh9OP7Jk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-l629-B9oOSCHFRj2mKOdRw-1; Mon, 03 Aug 2020 07:54:47 -0400
X-MC-Unique: l629-B9oOSCHFRj2mKOdRw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3ACA18C63C5;
 Mon,  3 Aug 2020 11:54:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 445E98FA5E;
 Mon,  3 Aug 2020 11:54:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E9711132FD2; Mon,  3 Aug 2020 13:54:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 2/2] trace: Example of non-tracing recorder use
References: <20200723132903.1980743-1-dinechin@redhat.com>
 <20200723132903.1980743-3-dinechin@redhat.com>
 <20200803104432.GG244853@stefanha-x1.localdomain>
Date: Mon, 03 Aug 2020 13:54:37 +0200
In-Reply-To: <20200803104432.GG244853@stefanha-x1.localdomain> (Stefan
 Hajnoczi's message of "Mon, 3 Aug 2020 11:44:32 +0100")
Message-ID: <87d048j66a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:37:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Christophe de Dinechin <dinechin@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Thu, Jul 23, 2020 at 03:29:03PM +0200, Christophe de Dinechin wrote:
>> This patch is a simple example showing how the recorder can be used to
>> have one "topic" covering multiple entries. Here, the topic is "lock",
>> the idea being to have the latest lock changes for instance in case of
>> a crash or hang.
>> 
>> Here are a few use cases:
>> 
>> * Tracing  lock updates:
>>     RECORDER_TRACES=lock qemu
>> * Showing lock changes prior to a hang
>>     RECORDER_TRACES=lock qemu &
>>     # Wait until hang
>>     killall -USR2 qemu  # This will trigger a dump
>> * Graphic visualization of lock states:
>>     RECORDER_TRACES="lock=state,id" qemu &
>>     recorder_scope state
>>     # Hit the 't' key to toggle timing display
>>     # Hit the 'c' key to dump the screen data as CSV
>>     cat recorder_scope_data-1.csv
>
> Dan raised a good point regarding integrating recorder functionality
> behind the tracetool interface.
>
> On the other hand, I would like to see where this goes so that we have
> enough experience to design the tracetool interface, if necessary.
>
> Therefore I am for merging this as-is and taking action when it's clear
> that duplication is taking place.

Sounds like we should not yet commit to a stable external interface.

The monitor command is HMP only.  Not a stable interface.  A QMP command
would have to be marked experimental with the customary x- prefix.

The environment variable is an external interface of the recorder
library.  Attempting to police such interfaces of libraries we use seems
futile.


