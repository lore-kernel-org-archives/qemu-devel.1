Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1945C2D0BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:35:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFD52073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 10:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSlaNMM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFD52073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iecrk-0002pT-LT
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 05:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iecqu-0002Bp-5V
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iecqr-0007KI-2W
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:34:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29702
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iecqq-0007JY-Hd
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 05:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575974082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TmTl8vVzDstJfwTs/KiCzHtcND47IpjWsKd4fkRatA4=;
 b=iSlaNMM0T3lmonsTYpN0rE6RjKoUadGEqnJEtgWo92bfs8UtlVXcW7vrKjJxrL3BMAs8NO
 N0eHWPBdp+KSHL8FCHGGq2mRdaL5aelk7nvFiHSzRRO3ZLtG429Cib57m76fNSUPpACfBC
 48b5EhRGIM00VKHfz937FdJvlgi+Pik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-yTDVnDjiMKmsrxp4wgnVsw-1; Tue, 10 Dec 2019 05:34:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5481E107ACC9;
 Tue, 10 Dec 2019 10:34:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-181.ams2.redhat.com
 [10.36.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81D361001938;
 Tue, 10 Dec 2019 10:34:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1470711386A7; Tue, 10 Dec 2019 11:34:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 2/2] Add -mem-shared option
References: <20191128172807.788e6aeb@redhat.com>
 <CAJ+F1CLZxhMf-bOAB4sVfuB1yaUMqiO70-ogpKVS3CqfC7y5KA@mail.gmail.com>
 <20191129110703.2b15c541@redhat.com>
 <04dadf85-cd35-fd37-9642-8087cba625bd@redhat.com>
 <20191129131652.6683b769@redhat.com>
 <528bb183-3d44-e541-8765-9c0e01f23157@redhat.com>
 <20191202083948.3e8bb134@redhat.com>
 <20191202210057.GQ14595@habkost.net>
 <1ff4cc6a-0ec8-96ff-1e39-e682429852e4@redhat.com>
 <20191203154303.035c33b3@redhat.com>
 <20191209205840.GJ498046@habkost.net>
Date: Tue, 10 Dec 2019 11:34:32 +0100
In-Reply-To: <20191209205840.GJ498046@habkost.net> (Eduardo Habkost's message
 of "Mon, 9 Dec 2019 17:58:40 -0300")
Message-ID: <87tv6831vr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: yTDVnDjiMKmsrxp4wgnVsw-1
X-Mimecast-Spam-Score: 0
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
Cc: Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 QEMU <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-A?= =?utf-8?Q?ndr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> +Markus
>
> On Tue, Dec 03, 2019 at 03:43:03PM +0100, Igor Mammedov wrote:
>> On Tue, 3 Dec 2019 09:56:15 +0100
>> Thomas Huth <thuth@redhat.com> wrote:
>>=20
>> > On 02/12/2019 22.00, Eduardo Habkost wrote:
>> > > On Mon, Dec 02, 2019 at 08:39:48AM +0100, Igor Mammedov wrote: =20
>> > >> On Fri, 29 Nov 2019 18:46:12 +0100
>> > >> Paolo Bonzini <pbonzini@redhat.com> wrote:
>> > >> =20
>> > >>> On 29/11/19 13:16, Igor Mammedov wrote: =20
>> > >>>> As for "-m", I'd make it just an alias that translates
>> > >>>>  -m/mem-path/mem-prealloc   =20
>> > >>>
>> > >>> I think we should just deprecate -mem-path/-mem-prealloc in 5.0.  =
CCing
>> > >>> Thomas as mister deprecation. :) =20
>> > >>
>> > >> I'll add that to my series =20
>> > >=20
>> > > Considering that the plan is to eventually reimplement those
>> > > options as syntactic sugar for memory backend options (hopefully
>> > > in less than 2 QEMU releases), what's the point of deprecating
>> > > them? =20
>> >=20
>> > Well, it depends on the "classification" [1] of the parameter...
>> >=20
>> > Let's ask: What's the main purpose of the option?
>> >=20
>> > Is it easier to use than the "full" option, and thus likely to be used
>> > by a lot of people who run QEMU directly from the CLI? In that case it
>> > should stay as "convenience option" and not be deprecated.
>> >=20
>> > Or is the option merely there to give the upper layers like libvirt or
>> > some few users and their scripts some more grace period to adapt their
>> > code, but we all agree that the options are rather ugly and should
>> > finally go away? Then it's rather a "legacy option" and the deprecatio=
n
>> > process is the right way to go. Our QEMU interface is still way=20
>> > overcrowded, we should try to keep it as clean as possible.
>>=20
>> After switching to memdev for main RAM, users could use relatively
>> short global options
>>  -global memory-backend.prealloc|share=3Don
>> and
>>  -global memory-backend-file.mem-path=3DX|prealloc|share=3Don
>>=20
>> instead of us adding and maintaining slightly shorter
>>  -mem-shared/-mem-path/-mem-prealloc
>
> Global properties are a convenient way to expose knobs through
> the command line with little effort, but we have no documentation
> on which QOM properties are really supposed to be touched by
> users using -global.
>
> Unless we fix the lack of documentation, I'd prefer to have
> syntactic sugar translated to -global instead of recommending
> direct usage of -global.

Fair point.

I'd take QOM property documentation over still more sugar.

Sometimes, the practical way to make simple things simple is sugar.  I
can accept that.  This doesn't look like such a case, though.


