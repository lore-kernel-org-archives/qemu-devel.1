Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53430C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 06:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D27A20702
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 06:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4CoWvK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D27A20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuscj-0007bb-90
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 01:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iusbq-0007A7-PD
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 01:38:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iusbo-0004i0-15
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 01:38:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42318
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iusbn-0004hA-UC
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 01:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579847903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fz1KLoJ+ZqpEdfasn0FLvg9SNwjMaIBM84Bb2l7wfYs=;
 b=a4CoWvK0//hsHB/988L3/eNOY5p7pHwiRUACbCutTVTCAf269ivZ57WOpqNxD+4ZpWNew3
 JC6F7bCSMo5MFeg0uSjVj75F27tkLG1M7cEF8aR/xRlQGJJ0WccZ/OX9q6wKwzQCe7W6TK
 /BtzhPHxX0GuVyf6IRb1SRx3mwUx5mA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-GtPqzb3jMoClkYad5miiEg-1; Fri, 24 Jan 2020 01:38:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EB7A1882CC0;
 Fri, 24 Jan 2020 06:38:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EAFD867E3;
 Fri, 24 Jan 2020 06:38:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 213B71138600; Fri, 24 Jan 2020 07:38:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
Date: Fri, 24 Jan 2020 07:38:11 +0100
In-Reply-To: <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com> (John Snow's
 message of "Thu, 23 Jan 2020 12:58:45 -0500")
Message-ID: <87r1zp4awc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: GtPqzb3jMoClkYad5miiEg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 1/23/20 2:19 AM, Markus Armbruster wrote:
[...]
>> Any conventional parser can be made streaming by turning it into a
>> coroutine.  This is probably the simplest solution for handwritten
>> streaming LL parsers, because it permits recursive descent.  In Python,
>> I'd try a generator.
>>=20
>> Our actual solution for QMP predates coroutine support in QEMU, and is
>> rather hamfisted:
>>=20
>> * Streaming lexer: it gets fed characters one at a time, and when its
>>   state machine says "token complete", it feeds the token to the
>>   "streamer".
>>=20
>> * "Streamer": gets fed tokens one at a time, buffers them up counting
>>   curly and square bracket nesting until the nesting is zero, then
>>   passes the buffered tokens to the parser.
>>=20
>> * Non-streaming parser: it gets fed a sequence of tokens that constitute
>>   a full expression.
>>=20
>> The best I can say about this is that it works.  The streamer's token
>> buffer eats a lot of memory compared to a real streaming parser, but in
>> practice, it's a drop in the bucket.
>>=20
>
> I looked into this at one point. I forget why I didn't like it. I had

Because it's confusing?  Took me a while to get used to it.

> some notion that I should replace this one too, but forget exactly why.
> Maybe it wasn't that bad, if I've forgotten.

Bigger fish to fry.

[...]


