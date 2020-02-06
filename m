Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8244C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7146C20838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1zDw9nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7146C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iziy5-0002Sg-JO
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 10:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iziwp-0001Fu-H7
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iziwo-0004TP-Fu
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:20:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59097
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iziwo-0004NT-Ah
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581002405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xcfKxQndcirrRb/mIWlIGpZms2DALMdwWdkGKo2oy3M=;
 b=a1zDw9nhAshulCxJ23Z0HVI1xDyZF3NXzQPihwyiKUnU6/jNnBfCQzdKxOPxsCIl2zs67h
 xDTJ7WOOT3iPxlDFf71ZI2czOqlKeiSA5XBKELj2MlbSkUVopmBtQGfP7RvTCILMBxR1wM
 cpjaYuv2cXAIdDPh7r2B9C1NvJdj3C4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-_Gzkd4J7Nxq9_nnLV500qg-1; Thu, 06 Feb 2020 10:20:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39E3F1400;
 Thu,  6 Feb 2020 15:20:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CA15790EE;
 Thu,  6 Feb 2020 15:19:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CCEB711386A7; Thu,  6 Feb 2020 16:19:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
References: <20200130125319.GD1891831@redhat.com>
 <87zhe5ovbv.fsf@dusky.pond.sub.org>
 <20200130150108.GM1891831@redhat.com>
 <877e18oq76.fsf@dusky.pond.sub.org>
 <87mu9xxwzv.fsf@dusky.pond.sub.org>
 <20200205093011.GA5768@dhcp-200-226.str.redhat.com>
 <20200205102303.GB2221087@redhat.com>
 <87a75xgl6w.fsf@dusky.pond.sub.org>
 <87h803ua2c.fsf@dusky.pond.sub.org>
 <20200206133658.GL2391707@redhat.com>
 <20200206142558.GB4926@linux.fritz.box>
Date: Thu, 06 Feb 2020 16:19:56 +0100
In-Reply-To: <20200206142558.GB4926@linux.fritz.box> (Kevin Wolf's message of
 "Thu, 6 Feb 2020 15:25:58 +0100")
Message-ID: <87pnerd9pf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: _Gzkd4J7Nxq9_nnLV500qg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 06.02.2020 um 14:36 hat Daniel P. Berrang=C3=A9 geschrieben:
>> On Thu, Feb 06, 2020 at 02:20:11PM +0100, Markus Armbruster wrote:
>> > One more question regarding the array in
>> >=20
>> >     { 'struct': 'QCryptoBlockAmendOptionsLUKS',
>> >       'data' : {
>> >                 'keys': ['LUKSKeyslotUpdate'],
>> >                  '*unlock-secret' : 'str' } }
>> >=20
>> > Why an array?  Do we really need multiple keyslot updates in one amend
>> > operation?
>>=20
>> I think it it is unlikely we'd use this in libvirt. In the case of wanti=
ng
>> to *change* a key, it is safer to do a sequence of "add key" and then
>> "remove key". If you combine them into the same operation, and you get
>> an error back, it is hard to know /where/ it failed ? was the new key
>> added or not ?
>
> I think the array came in because of the "describe the new state"
> approach. The state has eight keyslots, so in order to fully describe
> the new state, you would have to be able to pass multiple slots at once.

I see.

Of course, it can also describe multiple new states for the same slot.

Example:

    [{'state': 'active', 'keyslot': 0, 'secret': 'sec0'},
     {'state': 'active', 'keyslot': 0, 'secret': 'sec1'}]

    where slot 0's old state is 'inactive'.

Which one is the new state?

If we execute the array elements one by one, this first makes slot 0
active with secret 'sec0', then tries to make it active with secret
'sec1', which fails.  Simple enough, but it's not really "describe the
new state", it's still "specify a series of state transitions".

If we merge the array elements into a description of the new state of
all eight slots, where a slot's description can be "same as old state",
then this makes slot 0 active with either secret 'sec0' or 'sec1',
depending on how we resolve the conflict.  We could even make conflicts
an error, and then this would fail without changing anything.

What do we want?

Is this worth the trouble?


