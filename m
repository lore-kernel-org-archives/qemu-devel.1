Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAD8C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 07:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55FDF21741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 07:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXehTPfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FDF21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0KNk-00060t-JJ
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 02:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j0KMv-0005ZL-H5
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 02:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j0KMt-0005ev-65
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 02:17:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59159
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j0KMs-0005ea-Ns
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 02:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581146249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b+BNlrYfGqEzk1sTQGjNuX85rcE+On8rRsyO0pj9WY8=;
 b=PXehTPfwELvMgKsO/WnbVjoJ6va1od4h7Lxbo0p2l6g9vI/0oIHNuUPHunor+UmusCbQH5
 o6Cu8iKRpwl/rYYMjo7JJGuglYX6PKH5a3bP68zeGIShtp/B/keCuodPl3kuSHS7nnr/n6
 FJK2Oc64hj4cuzmOBsUmY9twicjPnW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-ElAXjIedMD-M2qg1X2roig-1; Sat, 08 Feb 2020 02:17:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3D351084420;
 Sat,  8 Feb 2020 07:17:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 437F160BE1;
 Sat,  8 Feb 2020 07:17:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB04211386A7; Sat,  8 Feb 2020 08:17:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: qmp-shell for GSoC/Outreachy?
References: <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com>
 <20200127143505.GD5669@linux.fritz.box>
 <20200127202925.GE3419@work-vm>
 <20200128105932.GC6431@linux.fritz.box>
 <20200205130946.GC5768@dhcp-200-226.str.redhat.com>
 <a45df5ab-3cad-0fbe-901f-4bc1ba28d38e@redhat.com>
 <20200205194944.GP3210@work-vm> <877e10xdd6.fsf@dusky.pond.sub.org>
 <20200206100920.GD2391707@redhat.com>
 <8736bnx6cx.fsf@dusky.pond.sub.org>
 <28064ba5-d76a-e59e-e836-52b8a62b0271@redhat.com>
Date: Sat, 08 Feb 2020 08:17:15 +0100
In-Reply-To: <28064ba5-d76a-e59e-e836-52b8a62b0271@redhat.com> (John Snow's
 message of "Fri, 7 Feb 2020 16:03:48 -0500")
Message-ID: <875zghmttw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ElAXjIedMD-M2qg1X2roig-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, "Denis V.
 Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> A note:
>
> qmp-shell could offer some sugared versions of things like "query-block"
> that do some work understanding the reply from QEMU and printing it in a
> nice human format.

This is exactly how HMP commands should work.

By moving them to qmp-shell, we get to code them in qmp-shell's language
(Python, I guess) rather than C.

I think we need to decide what qmp-shell's mission should be: is it a
better socat for the QMP monitor, or a replacement for the traditional
HMP monitor?

You may answer "both".  It'll complicate things, though.  More on that
below.

> This is generally what I have in mind for things when it's possible: use
> "real" QMP interfaces to do the query, and then use qmp-shell code to
> display "pretty" results.
>
> e.g.
>
>>> query-block
>
> might execute the raw QMP command and give you back the giant textwall
> of gibberish, but perhaps:
>
>>> ?info block
>
> would execute query-block behind the scenes, digest the results, and
> pretty-print some results.
>
> These shell-local commands, denoted by the "?" prefix, could be
> user-extensible python extensions that simply react to incoming data,
> optionally perform extra work, and display results.

As long as we develop qmp-shell and QMP together, we don't *have* to
separate name spaces.  It could simply be "info block".

However, consider chardev-add.  Example from char.json:

    -> { "execute" : "chardev-add",
         "arguments" : { "id" : "baz",
                         "backend" : { "type" : "pty", "data" : {} } } }
    <- { "return": { "pty" : "/dev/pty/42" } }

Here's the HMP equivalent:

    (qemu) chardev-add pty,id=3Dbaz
    char device redirected to /dev/pts/16 (label baz)

With your proposed "?" prefix, the straightforward way to run
chardev-add gives your the (thankfully non-giant) textwall of gibberish.
If you stick in a "?" and change the "-" to "_", you get the
pretty-printed version.  Not exactly the kind of UX we strive for, I'm
afraid, even if we fix the '-' vs. '_' nonsense.

If qmp-shell aims to be a better socat for the QMP monitor, then "?info
block" is out of scope, and so is pretty-printed chardev-add.

If qmp-shell aims to replace HMP, then query-block is out of scope, and
so is JSON-printing chardev-add.  Also, "qmp-shell" is a misnomer.

If qmp-shell aims to do both, we need to try harder :)

Kevin mentioned another way to provide HMP-like functionality in
qmp-shell: "have a QMP mode and an HMP mode and the user can switch
between these modes."

> Otherwise, for commands where this is too laborious, too intensive, or
> just not worth it -- but we cannot be rid of them -- I like Dan's idea
> of just offering e.g.
>
> 'x-debug-foo' and returning big text blobs, so we don't have to waste
> any brain-calories on devising a properly structured response.

To actually replace HMP, we'll want such commands.

> Actually, we can even use the featureflags to tag such commands as e.g.
> "human-ui-only" and could conditionally compile them out for enterprise
> deployments where poor behavior WRT synchronicity is a security liability=
.

Everybody knows enterprise deployments always work, and always perform
perfectly.  Commands for debugging and monitoring them are quite
superfluous ;-P


