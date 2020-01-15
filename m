Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAE8C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292842072B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiC0t1Zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292842072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irhbA-0003Ih-CX
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 07:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1irhaE-0002mI-8U
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1irha9-0005kC-9M
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:15:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50397
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1irha8-0005id-UK
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579090531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tAiljNb7HsnUxrJZkEsktItBsnScGc/YKcbXQgKbp4s=;
 b=GiC0t1Zywfei+r/KVQKY/h8YeHeQ+Rm13nIcD3Ro630HdtdEwigLXbnoxmhinCBv/Q0zvu
 AAmVV4XgZWMkxNC4MUF3HwMENfCjzh0KM1JQ7b6XGK/PAqN5KnkN6+fmo1qUw0QSsEtd9s
 ++TOfycaeNFn9EkoYI861/yohWDBFUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-jmfrMKFaO2OZQuQD-xVTGA-1; Wed, 15 Jan 2020 07:15:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5D63800A02;
 Wed, 15 Jan 2020 12:15:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB0181000329;
 Wed, 15 Jan 2020 12:15:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 484D81138600; Wed, 15 Jan 2020 13:15:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
 <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
Date: Wed, 15 Jan 2020 13:15:17 +0100
In-Reply-To: <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com> (Christophe de
 Dinechin's message of "Wed, 15 Jan 2020 10:34:09 +0100")
Message-ID: <87r200zzje.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: jmfrMKFaO2OZQuQD-xVTGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Christophe de Dinechin <dinechin@redhat.com> writes:

> Thanks a bunch. This clarifies a number of my misconceptions about
> how this is currently used. Most notably this one:
>
>> On 15 Jan 2020, at 10:20, Markus Armbruster <armbru@redhat.com> wrote:
>>=20
>>> We don=E2=80=99t want the QAPI to let arbitrary fields of a QOM object
>>> be modified, do we?
>>=20
>> We already do: QMP command qom-set.  If it breaks your guest, you get to
>> keep the pieces.
>
> Ouch. I certainly did not expect that.
>
> "It is not what you don=E2=80=99t know that kills you, it is what you kno=
w that ain=E2=80=99t so".

Do we have a legitimate use for qom-set right now?  Hmm, let's check
libvirt... aha:

* qemuMonitorJSONSetMemoryStatsPeriod() uses it to control
  virtio-balloon's guest-stats-polling-interval property, in accordance
  with docs/virtio-balloon-stats.txt.

* qemuMonitorJSONSetIOThread() uses it to control iothread's properties
  poll-max-ns, poll-grow, poll-shrink.  Their use with -object is
  documented (in qemu-options.hx), their use with qom-set is not.

Oh well.

>>>> http://dreamsongs.com/RiseOfWorseIsBetter.html
>>>=20
>>> You know that I positively hate this ;-)
>>=20
>> It's been a tough lesson for me, too.
>
> Not sure I can call it a =E2=80=9Clesson=E2=80=9D. Much like a philosophy=
 to fight against, IMO.

The tough lesson isn't philosophy, it's an observation: "I believe that
worse-is-better [...] has better survival characteristics than
the-right-thing".

>>> Well, I guess we can expand the schema. #ILoveJSON.
>>=20
>> Basing the QAPI language on JSON was a poor choice.  Not sure that's
>> fixable at a reasonable cost.
>
> Well, at least now I have a slightly better understanding of the related =
costs
> and trade-offs. Thanks a lot for explaining.

You're welcome!


