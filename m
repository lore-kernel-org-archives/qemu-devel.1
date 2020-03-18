Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29BEC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 13:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A08420724
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 13:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fl/e024X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A08420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEYME-0002co-Lk
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 09:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEYLP-00022l-I3
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 09:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEYLO-0006ai-3U
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 09:02:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47327)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEYLN-0006XL-VM
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 09:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584536565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rsa56PYwo4MTKolN6JgGWUo6rBu/gmKcH++X2c0CZwk=;
 b=fl/e024XA9VTjl6Ml/0j0EAf39xTFM0OIq9YXcKn77lSrQlyEA/BGQY1wTqpAFdk+E9MQn
 LpeoE6chsS8KcWp5Mjs905h3DUfwdIAiJv9nVZ8Blu/3/vpofaGa5GVWaAdUrmujLnlzcm
 pcX3MsoPS/MPSBkMqaLoSsLVIhVkLbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-ooxTPdKiONujGTfAJ4Jr4Q-1; Wed, 18 Mar 2020 09:02:43 -0400
X-MC-Unique: ooxTPdKiONujGTfAJ4Jr4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E7DA86A067;
 Wed, 18 Mar 2020 13:02:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C4305F905;
 Wed, 18 Mar 2020 13:02:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 60B0B1138404; Wed, 18 Mar 2020 14:02:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
 <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
 <871rq08tn9.fsf@dusky.pond.sub.org>
 <eca27715-554d-2c2e-5e58-ffd01abb654c@ilande.co.uk>
 <e1ae65dd-f9cd-b0ee-0ea6-f3c2b010fdab@redhat.com>
 <87tv2p8y5j.fsf@dusky.pond.sub.org>
 <3f512e33-5875-eee4-bbe8-61e7b313743d@redhat.com>
 <87mu8g3kgj.fsf@dusky.pond.sub.org>
 <bd83fe53-6541-b04d-04d9-76ddd29e2b99@redhat.com>
Date: Wed, 18 Mar 2020 14:02:37 +0100
In-Reply-To: <bd83fe53-6541-b04d-04d9-76ddd29e2b99@redhat.com> (Paolo
 Bonzini's message of "Mon, 16 Mar 2020 09:43:33 +0100")
Message-ID: <875zf1ak9e.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Pan Nengyuan <pannengyuan@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 16/03/20 07:03, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>>> On 15/03/20 15:56, Markus Armbruster wrote:
>>>>>
>>>>> The question is why they are not, i.e. where does the above reasoning=
 break.
>>>> I don't know.  But let's for the sake of the argument assume this
>>>> actually worked.  Asking for help in the monitor then *still* has side
>>>> effects visible in the time span between .instance_init() and
>>>> finalization.
>>>>
>>>> Why is that harmless?
>>>
>>> I don't really have an answer, but if that is a problem we could change
>>> "info qtree" to skip non-realized devices.
>>=20
>> Can we convince ourselves that "info qtree" is the *only* way to observe
>> these side effects?
>
> There is of course qom-get/qom-set, but those _should_ show this side
> effect.
>
> If we decide that "info qtree" should only show devices visible to the
> guest (as opposed to all objects that have been created), then "show
> only realized devices" is not even a hack but the correct implementation
> of the concept.
>
> Paolo
>
>> If yes, a hack to ignore unrealized devices "fixes" the problem.
>>=20
>> If no, it sweeps it under the rug.

I fear we're getting lost in the weeds.  The question what qom-get /
qom-set / info qtree should show is of no concern to me when writing a
device model.  I need guidance on how to spread the work between
instance initialization and realize, and on the requirements for
unrealize and finalize.

Let's try to separate the self-evident parts from the unclear parts,
starting with the self-evident.  Please correct mistakes.

Object instantiation must be completely reverted by finalization.

device-introspect-test guards against a particularly egregious violation
of this rule, namely output of "info qtree" after initialization +
finalization differing from output before.  Surprisingly common issue.
It's what made Peter invite me to this thread.

Device realization must be completely reverted by unrealization.

We don't always implement unrealize.  Fine when the device cannot be
unrealized.  But the code doesn't seem to guard against omitting
unrealize when the device actually can be unrealized.

Properties for use with device_add must exist after object
instantiation.

But is that true?  Setting a property can run arbitrary code.  What if
setting property P to value V runs code that adds property Q?  Then
device_add P=3DV,Q=3DW works provided P gets set before Q, which is
anybody's guess.

So "must exist" is actually "should exist", and we' already moved from
the self-evident to the unclear.

Even less clear: what side effects may be visible between object
initialization and realization / finalization?

A safe but constricting answer would be "only host resource
reservation".

What's your answer?

I've hardly begun talking about the distribution of work between
initialization and realize, and I'm floundering already.  May I have
some clear, hard rules, please?


