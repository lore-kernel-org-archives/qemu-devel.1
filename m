Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE29EC33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7166420658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vwu7oO+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7166420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyVIi-00008e-Iu
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iyV6b-0004QA-AD
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iyV6a-00064x-5o
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:21:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47929
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iyV6a-00063t-22
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580710865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=An5cqHBWwGqGGUU8PYbKVTuwAqN/87rzwuOzlBQQ8Q8=;
 b=Vwu7oO+6JnlTGwD1JM/YU6U3rq8Ka1pMMBPFF1CPG8iPT4hqhyZNU1eJaa8f75RmA8ScsO
 GYQ8MKhBflAbAFfkIhIpoMxLLBA9yodRptj/Q6GwKXdPVbOIEeny18T6x6RKIeCERUZp2R
 iEw5gyJUxlT7daddx5rv+qgF1RRg/mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-HsifY2vMNs2yhdnAUWz_YQ-1; Mon, 03 Feb 2020 01:21:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AE58800D41;
 Mon,  3 Feb 2020 06:21:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C990A90F47;
 Mon,  3 Feb 2020 06:20:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B9FE1138404; Mon,  3 Feb 2020 07:20:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <871rrp474i.fsf@dusky.pond.sub.org>
 <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <87sgk3x2im.fsf@dusky.pond.sub.org>
 <20200127115606.GA5669@linux.fritz.box>
 <1c65b678-7bb4-a4cc-5fa6-03d6d27cf381@redhat.com>
 <20200128102855.GA6431@linux.fritz.box>
 <87mua7bvwf.fsf@dusky.pond.sub.org>
 <20200128125409.GF6431@linux.fritz.box>
 <4cf1864c-3527-b015-0691-1788a37f4f7e@redhat.com>
 <20200202092152.GA3456@localhost.localdomain>
 <CABgObfaLetjGmv=21gCQWruvXNkrMBUVCjQaKrTjppZrL=MW-A@mail.gmail.com>
Date: Mon, 03 Feb 2020 07:20:51 +0100
In-Reply-To: <CABgObfaLetjGmv=21gCQWruvXNkrMBUVCjQaKrTjppZrL=MW-A@mail.gmail.com>
 (Paolo Bonzini's message of "Sun, 2 Feb 2020 11:44:37 +0100")
Message-ID: <87lfpk6vjw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: HsifY2vMNs2yhdnAUWz_YQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il dom 2 feb 2020, 10:22 Kevin Wolf <kwolf@redhat.com> ha scritto:
>
>> Am 31.01.2020 um 13:27 hat Eric Blake geschrieben:
>> > On 1/28/20 6:54 AM, Kevin Wolf wrote:
>> >
>> > > >
>> > > > The arguments as dotted keys:
>> > > >
>> > > >      id=3Dbar,backend.type=3Dfile,backend.data.out=3D/tmp/bar.log
>> > > >
>> > > > Observe there's quite some of nesting.  While that's somewhat
>> cumbersome
>> > > > in JSON, it's a lot worse with dotted keys, because there nesting
>> means
>> > > > repeated key prefixes.  I could give much worse examples, actually=
.
>> > >
>> > > This is true, but even without the repeated keys (e.g. in a syntax t=
hat
>> > > would use brackets), it would still be unnecessarily verbose and
>> > > probably hard to remember:
>> > >
>> > >      id=3Dbar,backend=3D{type=3Dfile,data=3D{out=3D/tmp/bar.log}}
>>
>> [...] I actually think that a syntax like this might make sense for
>> something like qmp-shell. It might even be more convenient on the
>> command line than dotted keys if you get a lot of repetition (despite
>> the required quoting), but it's strictly speaking incompatible because
>> you could use {} in strings today.
>>
>
> If you are willing to feed schema info to the parser, in principle you
> could keep backwards compatibility. There would be limitations such as
> putting the discriminator before the fields, so I am not sure it's a good
> idea.

Problem: the 'any' type, where the schema doesn't provide the necessary
information.

Problem: 'gen': false, where we pass the arguments raw, ignoring the
schema.

If we didn't restrict alternate types so severly, it would also be a
problem.  For instance, with

    { 'alternate': 'Alt',
      'data': { 'one': 'number',
                'two': 'str' } }

we don't know what to do for value "on" branch to take for value 42.
Not a problem because we reject this alternate.  See
tests/qapi-schema/alternate-conflict-*json for more examples.

> Better QOM introspection would be a requirement, too.

I guess this is what you believe is needed to solve these problems.


