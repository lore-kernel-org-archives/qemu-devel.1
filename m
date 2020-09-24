Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07836C4741F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AEB2376F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkArcVj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AEB2376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLLkC-000399-6f
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLLjB-0002gK-DW
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLLj9-0000RK-OU
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600932699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0QMW4yOQ/HtvF+phJgIRlPWQEe1a2V8H0NXPaC+X90=;
 b=BkArcVj3XIKuPAi/f6VLcFKE01rz4F+uWxL1/51OCH7n/6cmi4JKVipGDx3azYNLBK4ojB
 +7fnMDA2G2Qq7bu2UVbN7r+Jxaf2poze/bnuu69cqJB808cJYtjn3sZEDTli8MPxd4XT6B
 e2jlL6OKwakHU+JIk63AzZFoIpl2ThI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-kVJuPTJjO2m49XFmro6m7A-1; Thu, 24 Sep 2020 03:31:35 -0400
X-MC-Unique: kVJuPTJjO2m49XFmro6m7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56778800400;
 Thu, 24 Sep 2020 07:31:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A86F55778;
 Thu, 24 Sep 2020 07:31:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA3951132E9A; Thu, 24 Sep 2020 09:31:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <CAMxuvay_mQjukGvinb6ur+8z-YyKxu=BdquuF=+yf+UrNmmd2A@mail.gmail.com>
 <87y2l1kel8.fsf@dusky.pond.sub.org>
 <CAJ+F1CLjZ5EA+R+Bo9WGTwJ1ju3tCXWbquP5gkQwRA4fL6V9Kw@mail.gmail.com>
Date: Thu, 24 Sep 2020 09:31:29 +0200
In-Reply-To: <CAJ+F1CLjZ5EA+R+Bo9WGTwJ1ju3tCXWbquP5gkQwRA4fL6V9Kw@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Sep 2020
 20:25:06 +0400")
Message-ID: <87mu1fwrzi.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>,
 Sergio Lopez Pascual <slp@redhat.com>, "Hajnoczi, Stefan" <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

[...]
> What does this freedom really gives us in exchange? We don't want to comm=
it
> to a stable API? It's not rocket science, everybody else does it with
> interface version numbers. What makes QEMU/QMP so different?

It's not rocket science, and we're so used to it that we don't even
notice anymore how awful it is.

When you compile to native code, exact interface match is required for
efficiency.

This used to be pretty much a non-issue: when you compile and link
statically, the only interface remaining at run time is system calls.

Dynamic linking threw us into DLL hell.  Yes, we figured out how to
version symbols, when to bump sonames, and how prepare for and make
binary compatible interface changes.  It's still awful.  People deploy
in containers just to get out of this awful game.  But remember: there's
a *reason*, namely efficiency.

Once you go beyond a single process, you need interprocess
communication.  We use procedure calls for intraprocess communication,
so remote procedure calls are an obvious solution for interprocess
communication.

Where many RPC systems have gone wrong, in my opinion, is bringing along
the awfulness of exact interface matches, with much less of a reason,
but even more awfulness: you now get to also wrestle with multiple
versions of servers fighting over ports and such.

Yes, containers, I know.  They help a lot with keeping such messes under
control.  But some messes are necessary, while others are not.

I respectfully disagree with the notion that "everybody else does it
with interface version numbers".  There's a ton of IPC protocols out
there that do not require exact interface matches.

[...]


