Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BB1C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 05:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B663922522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 05:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBMNSPZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B663922522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itmKT-0007kF-VP
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 00:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1itmJe-0007GE-MD
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1itmJd-0008Op-Ig
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:43:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39720
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1itmJd-0008OV-FH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 00:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579585384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ke6kdANLkx+TogH4Xqrewy892//8qh6EzCqpSTQVWPE=;
 b=VBMNSPZJGhz7YqW8vDlb800agbXA/xbbE2GoEPja3Y5a4874gJUxa1KZpVeRjyuTjxAD6W
 SE9/oeVrLOzS72+Xm2CJBSptuji0pLId6xuRuNmw1eoP0Zl88GOrBCdxAQbLgfoVPHtihj
 HjJoJo6EM1dfKq7JRUy4cPbeT0MkiDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-Cw9DBNv4MJKNQ-gScUsuUg-1; Tue, 21 Jan 2020 00:43:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B280218A6EC1;
 Tue, 21 Jan 2020 05:43:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F194C89E9D;
 Tue, 21 Jan 2020 05:42:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 87CA41138600; Tue, 21 Jan 2020 06:42:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
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
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
Date: Tue, 21 Jan 2020 06:42:47 +0100
In-Reply-To: <20200120100849.GB345995@stefanha-x1.localdomain> (Stefan
 Hajnoczi's message of "Mon, 20 Jan 2020 10:08:49 +0000")
Message-ID: <871rrtmkko.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Cw9DBNv4MJKNQ-gScUsuUg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Wed, Jan 15, 2020 at 01:15:17PM +0100, Markus Armbruster wrote:
>> Christophe de Dinechin <dinechin@redhat.com> writes:
>> >> On 15 Jan 2020, at 10:20, Markus Armbruster <armbru@redhat.com> wrote=
:
>> * qemuMonitorJSONSetIOThread() uses it to control iothread's properties
>>   poll-max-ns, poll-grow, poll-shrink.  Their use with -object is
>>   documented (in qemu-options.hx), their use with qom-set is not.
>
> I'm happy to use a different interface.
>
> Writing a boilerplate "iothread-set-poll-params" QMP command in C would
> be a step backwards.

No argument.

> Maybe the QAPI code generator could map something like this:
>
>   { 'command': 'iothread-set-poll-params',
>     'data': {
>         'id': 'str',
> =09'*max-ns': 'uint64',
> =09'*grow': 'uint64',
> =09'*shrink': 'uint64'
>     },
>     'map-to-qom-set': 'IOThread'
>   }
>
> And turn it into QOM accessors on the IOThread object.

I think a generic "set this configuration to that value" command is just
fine.  qom-set fails on several counts, though:

* Tolerable: qom-set is not actually generic, it applies only to QOM.

* qom-set lets you set tons of stuff that is not meant to be changed at
  run time.  If it breaks your guest, you get to keep the pieces.

* There is virtually no documentation on what can be set to what values,
  and their semantics.

In its current state, QOM is a user interface superfund site.


