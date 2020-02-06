Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BBFC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24EC20730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeKgtOow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24EC20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izg1s-0003SN-U1
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1izg11-0002rH-QE
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:12:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1izg10-0004zc-Ih
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:12:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49868
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1izg10-0004ym-F2
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580991131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d4it+xLNcJYbLr3TPv8GWLwY4E9TsajHVAhH6suzjrI=;
 b=EeKgtOowlQvwDJARfs59KINdrKPkjkT67/PnaL5tGiyxZt+RbtyQhsVoqiiRqFpJLqr5o/
 xueuQkmJVgq3WY5kflW64NZvONDpG2YrR8m0TraEvMzRHO9NzwCSi4nodOa4frQ8+hHWeb
 iJbo9Bb0kAavG2ClTsjDtIjrVujlPOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-IZo9p3uhM3a3dj2t9zLLcA-1; Thu, 06 Feb 2020 07:12:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6FA4DB63;
 Thu,  6 Feb 2020 12:12:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 671C3790C8;
 Thu,  6 Feb 2020 12:12:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ED3C111386A7; Thu,  6 Feb 2020 13:11:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
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
Date: Thu, 06 Feb 2020 13:11:58 +0100
In-Reply-To: <20200206100920.GD2391707@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Thu, 6 Feb 2020 10:09:20 +0000")
Message-ID: <8736bnx6cx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: IZo9p3uhM3a3dj2t9zLLcA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Feb 06, 2020 at 10:40:37AM +0100, Markus Armbruster wrote:
>> > If the user screwsup, it should give an error that prompts the user
>> > to the parameter they got wrong.
>> >
>> > Output from commands should normally be pretty formatted (with an opti=
on
>> > to display raw json for those needing it).
>> >   e.g. that 'query-version' should give either just the package
>> >   version (as info version currently does) or:
>> >       4.2.50  Package: v4.2.0-1188-gd95a3885a9
>> >
>> > We shouldn't lose any HMP commands that some people find useful
>> >   Ditching HMP isn't an option until we've got almost all of it
>> >   covered.
>>=20
>> In particular, we currently use HMP for debugging and monitoring
>> purposes, where we don't need or want QMP's rigor, neither its rigorous
>> interface stability, nor its structured I/O.  We want the "whipuptitude"
>> we get from monitor_printf().  This is actually a point David has made
>> several times.
>
> I'd like to argue that this decision to keep these debugging/monitoring
> things in HMP only was a mistake, because it ensures that QEMU internals
> need to keep HMP related code forever.
>
> What we actually need is a part of QMP that does not have the long term
> stability requirement, nor need for fully structured data. In fact this
> pretty much already exists - we have declared the 'x-' prefix as a way
> to model QMP commands which are experimental / suboptimal / subject
> to change.
>
> I suggest that every HMP command which does not have a QMP equivalent
> should be turned into a QMP command with an "x-" prefix, with no
> extra modelling applied

Makes sense (see my point about "allowing some [whipuptitude] in QMP"),
except I disagree with your example:

> Take "info block"
>
> (hmp) info block
> ide1-cd0: [not inserted]
>     Attached to:      /machine/unattached/device[23]
>     Removable device: not locked, tray closed
>
> floppy0: [not inserted]
>     Attached to:      /machine/unattached/device[16]
>     Removable device: not locked, tray closed
>
> sd0: [not inserted]
>     Removable device: not locked, tray closed
>
>
> I suggest we support it as "x-query-block"
>
> (qmp) x-query-block
> {
>     "return": {
>         "info": "ide1-cd0: [not inserted]
>     Attached to:      /machine/unattached/device[23]
>     Removable device: not locked, tray closed
>
> floppy0: [not inserted]
>     Attached to:      /machine/unattached/device[16]
>     Removable device: not locked, tray closed
>
> sd0: [not inserted]
>     Removable device: not locked, tray closed"
>     }
> }

This commmand does have a QMP equivalent: query-block.

Hmm, no more.  It actually wraps around both query-block and
query-named-block-nodes now.  I think that makes it an example of "go
beyond 1:1".

A better example for "allowing whipuptitude" would be "info registers".

> Functionally we in fact already support pretty much exactly
> that via the "human-monitor-command"  QMP command.
>
> The difference is that with the latter, we will still have to
> keep around the internal dispatching machinery for HMP inside
> QEMU forever. If we transplant all remaining HMP commands with
> an "x-" prefix, we open up the possibility of completely
> separating HMP out and having QEMU work exclusively with QMP
> internally.
>
> This is complementary to an improved qmp-shell client.

Yes.


