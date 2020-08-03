Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66825C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCB72076C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+I8oPAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCB72076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Yzp-00071J-A8
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 07:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2Yyh-00063n-Pn
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:50:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47586
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2Yyf-00009k-Ao
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596455399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q9fSbs/9gkw6OE0IAhUhkxwHsAXWYuqQ9twQ0Vpo98Y=;
 b=E+I8oPAFrLfaHm+6qNqkQ2D9b7JCs0J3pIMEXIyLUIxuJDPYoPyfGpEO53wPkzQlCAREEe
 XHWaihiqZNueN3KBeHMzFh1i54AKaQnGsZBE4rt11b80z7bSTN+rBPoGY/+qRhfhwI7h0P
 IX/g0zCxdMNHYiLzsm9VTvqp9XkXwTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-ixaiPtsbMQec-cFiPhQfFA-1; Mon, 03 Aug 2020 07:49:58 -0400
X-MC-Unique: ixaiPtsbMQec-cFiPhQfFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6317A101C8A0;
 Mon,  3 Aug 2020 11:49:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F26410013C1;
 Mon,  3 Aug 2020 11:49:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 21E1B1132FD2; Mon,  3 Aug 2020 13:49:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v4 1/2] trace: Add support for recorder back-end
References: <20200723132903.1980743-1-dinechin@redhat.com>
 <20200723132903.1980743-2-dinechin@redhat.com>
Date: Mon, 03 Aug 2020 13:49:50 +0200
In-Reply-To: <20200723132903.1980743-2-dinechin@redhat.com> (Christophe de
 Dinechin's message of "Thu, 23 Jul 2020 15:29:02 +0200")
Message-ID: <87eeooj6e9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 01:24:44
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
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Christophe de Dinechin <dinechin@redhat.com> writes:

> The recorder library provides support for low-cost continuous
> recording of events, which can then be replayed. This makes it
> possible to collect data after the fact, for example to show the
> events that led to a crash or unexpected condition.
>
> In this series, minimal recorder support in qemu is implemented using
> the existing tracing interface. For each trace, a corresponding
> recorder is created with a generic name and a default size of 8 entries.
>
> In addition, it is possible to explicitly enable recorders that are
> not qemu traces, for example in order to use actually record events
> rather than trace them, or to use the real-time graphing capabilities.
> For that reason, a limited set of recorder-related macros are defined
> as no-ops even if the recorder trace backend is not configured.
>
> Recorder-specific features, notably the ability to perform a
> post-mortem dump and to group traces by topic, are not integrated in
> this series, as doing so would require modifying the trace
> infrastructure, which is a non-objective here. This may be the topic
> of later series if there is any interest for it.
>
> HMP COMMAND:
> The 'recorder' hmp command has been added, which supports two
> sub-commands:
> * recorder dump: Dump the current state of the recorder. You can
>   give that command a recorder name, to only dump that recorder.
> * recorder trace: Set traces using the recorder_trace_set() syntax.
>   You can use "recorder trace help" to list all available recorders.

Standard comment for patches adding HMP-only monitor commands:

In general, functionality available in HMP should also available in QMP.
Exceptions include functionality that makes no sense in QMP, or is of
use only for human users.  If you think your command is an exception,
please explain why in the commit message.

If it isn't, you need to implement it for QMP (including suitable test
cases), then rewrite the HMP version to reuse either the QMP command or
a common core.

Example for "makes no sense in QMP": setting the current CPU, because a
QMP monitor doesn't have a current CPU.

Examples for "is of use only for human users": HMP command "help", the
integrated pocket calculator.


