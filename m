Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C3AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 12:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824822075A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 12:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EajcBPgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824822075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPPIn-0007b4-Go
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 08:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kPPHq-00072g-Ql
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 08:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kPPHn-00038o-KF
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 08:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601899690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XykrSJ0k2LgDUj4/I5lxDGEo9j/p+itcgjaxVD1IFnk=;
 b=EajcBPgv7vAhL47S+dx8lrBSvPRv3x8FMv51UGQN1qZ2dbaE8CKn6iZdJlcNpvD1Pq6N4b
 Q+6/K3IXwWzrFJX7bsCOuUCM2lb/ZD6J9OIw3RPYj0ti2L8tlnmKtPPdHdHySe9JAwuOba
 hovp0xPaRLI6S1NOOcaZyzQb6meAjdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-RpA3Ll_3PlqNOVGzOZC2_w-1; Mon, 05 Oct 2020 08:08:08 -0400
X-MC-Unique: RpA3Ll_3PlqNOVGzOZC2_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7068803F4A;
 Mon,  5 Oct 2020 12:08:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F9195C1BD;
 Mon,  5 Oct 2020 12:08:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C4FE511329C1; Mon,  5 Oct 2020 14:08:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 1/4] keyval: Parse help options
References: <20200930124557.51835-1-kwolf@redhat.com>
 <20200930124557.51835-2-kwolf@redhat.com>
 <87o8lmx837.fsf@dusky.pond.sub.org>
Date: Mon, 05 Oct 2020 14:08:05 +0200
In-Reply-To: <87o8lmx837.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Thu, 01 Oct 2020 17:46:20 +0200")
Message-ID: <87mu10dgey.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

[...]
> Making help support opt-in complicates things.  Is there a genuine use
> for not supporting help?  Or is just to keep the users that don't
> support help yet (but should) working without change?  Mind, I'm not
> asking you to make them work, I'm only asking whether you can think of a
> genuine case where help should not work.
>
> What are the existing users that don't support help?  Let's see... many
> in tests/test-keyval.c (ignore), and qobject_input_visitor_new_str().
> That one's used for qemu-system-FOO -audiodev, -display, -blockdev, and
> for qemu-storage-daemon --blockdev, --export, --monitor, --nbd-server.
>
> Attempting to get help for them fails like this:
>
>     $ bld-x86/storage-daemon/qemu-storage-daemon --blockdev help
>     qemu-storage-daemon: Invalid parameter 'help'
>     $ bld-x86/storage-daemon/qemu-storage-daemon --blockdev file,help
>     qemu-storage-daemon: Expected '=' after parameter 'help'
>
> I believe making them fail like
>
>     qemu-storage-daemon: no help available
>
> would actually be an improvement.

Potential issue: if an option's implied key may have the value "help",
then option argument "help" can be either parsed as "give me help", or
as "implied-key=help".

None of the existing options have this issue:

* audiodev: union Audiodev, implied key "driver" is enum AudiodevDriver,
   "help" is not among its values

* display: union DisplayOptions, implied key "type" is enum
   DisplayType, "help" is not among its values

* blockdev: union BlockdevOptions, implied key "driver is enum
   BlockdevDriver, "help" is not among its values

* export: union BlockExport, implied key "type" is enum BlockExportType,
  "help" is not among its values

* monitor: struct MonitorOptions, implied key "mode"is enum MonitorMode,
  "help" is not among its values

* nbd-server: struct NbdServerOptions, no implied key.

We're good.

What's the risk of not staying good?

The implied keys above are all QAPI enums.

The only existing QAPI enum with a value 'help' is QKeyCode.

The only existing C enum with a name that ends in _HELP is the one
defining Mac keycodes in hw/input/adb-keys.h.

For completeness, I double-checked non of the existing occurences of
string "help" are used as values of option parameters.

We'll almost certainly stay good.

What if we manage to mess this up against all odds?

In my opinion, consistency in getting help is more important than
consistency within a badly designed option: option argument "help"
should give you help even when that means you can't omit the implied key
when its value is "help".

[...]


