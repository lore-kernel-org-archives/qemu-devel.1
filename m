Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CF9C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94DA20872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDQaJ0P5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94DA20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0ta-0008EJ-Nl
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kO0mu-0000uH-FV
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:46:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kO0ms-0004ve-Nv
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601567190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vBQKHIN608+tjZJbhahnx6v4ueZgeCoA0FWTzegXEZ4=;
 b=RDQaJ0P5CUoDoaxtTKpsLMEXI1z4ynTdgB2v5CWdNZyMh49f3ocIbI/F70WcdNYk7O0BG+
 6VS4Enn8CoM87mdO6z94XwVzVAfeNG8/TvqztiPdrDLIShKJfP9/gh3Cu/iSlU/1MPkAfn
 W/OS4kuv+Pb7oGuwmXu/q5+DLK9BC3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-GfEEUGTuOcKY4i5sRiCrUw-1; Thu, 01 Oct 2020 11:46:26 -0400
X-MC-Unique: GfEEUGTuOcKY4i5sRiCrUw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 405DF64088;
 Thu,  1 Oct 2020 15:46:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B3121002397;
 Thu,  1 Oct 2020 15:46:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 769751132784; Thu,  1 Oct 2020 17:46:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 1/4] keyval: Parse help options
References: <20200930124557.51835-1-kwolf@redhat.com>
 <20200930124557.51835-2-kwolf@redhat.com>
Date: Thu, 01 Oct 2020 17:46:20 +0200
In-Reply-To: <20200930124557.51835-2-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 30 Sep 2020 14:45:54 +0200")
Message-ID: <87o8lmx837.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fried brain today, I have to go through this real slow.  I apologize in
advance for being denser and more error-prone than usual.

Kevin Wolf <kwolf@redhat.com> writes:

> This adds a new parameter 'help' to keyval_parse() that enables parsing
> of help options. If NULL is passed, the function behaves the same as
> before. But if a bool pointer is given, it contains the information
> whether an option "help" without value was given (which would otherwise
> either result in an error or be interpreted as the value for an implied
> key).
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

You change the parser, but neglected to update the grammar in the big
file comment.

I made the mistake of attempting to review the parser change without
fixing up the grammar first, and got lost in the weeds.  In part because
today is not my day, but also because doing parsers without a grammar
never works out well for me.

Grammar from the big file comment:

 * KEY=VALUE,... syntax:
 *
 *   key-vals     = [ key-val { ',' key-val } [ ',' ] ]
 *   key-val      = key '=' val
 *   key          = key-fragment { '.' key-fragment }
 *   key-fragment = / [^=,.]* /
 *   val          = { / [^,]* / | ',,' }

and

 * Additional syntax for use with an implied key:
 *
 *   key-vals-ik  = val-no-key [ ',' key-vals ]
 *   val-no-key   = / [^=,]* /
 *
 * where no-key is syntactic sugar for implied-key=val-no-key.

According to the commit message, we want to recognize "help" in place of
key-val and val-no-key, but only for callers that opt in.

This is more complex than recognizing it in place of just key-vals.  The
commit message doesn't say why the extra complexity is wanted.  Peeking
ahead in the series, I can see it's for supporting

    -object TYPE,help

in addition to

    -object help

I see.

Making help support opt-in complicates things.  Is there a genuine use
for not supporting help?  Or is just to keep the users that don't
support help yet (but should) working without change?  Mind, I'm not
asking you to make them work, I'm only asking whether you can think of a
genuine case where help should not work.

What are the existing users that don't support help?  Let's see... many
in tests/test-keyval.c (ignore), and qobject_input_visitor_new_str().
That one's used for qemu-system-FOO -audiodev, -display, -blockdev, and
for qemu-storage-daemon --blockdev, --export, --monitor, --nbd-server.

Attempting to get help for them fails like this:

    $ bld-x86/storage-daemon/qemu-storage-daemon --blockdev help
    qemu-storage-daemon: Invalid parameter 'help'
    $ bld-x86/storage-daemon/qemu-storage-daemon --blockdev file,help
    qemu-storage-daemon: Expected '=' after parameter 'help'

I believe making them fail like

    qemu-storage-daemon: no help available

would actually be an improvement.

If we get rid of the case "help is not supported", the grammar update
isn't too bad, something like

 *   key-val      = 'help' | key '=' val

and

 *   key-vals-ik  = 'help' | val-no-key [ ',' key-vals ]

Done for today, hope my brain unfries itself overnight.

[...]


