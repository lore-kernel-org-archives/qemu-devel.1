Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756F7C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9B120706
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNuPiCVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9B120706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEpC-0004Ki-4s
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1idEP9-0002Hq-Ps
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1idEP7-0002m1-LM
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:16:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55767
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1idEP7-0002hD-Eo
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575641773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QydCtaGu0VxNLL1vkJgck5UBv6FIuo7+xYoT62obZJU=;
 b=WNuPiCVFqtykdArdtsfKsuIY130OeRw9Q16csGfmLPUU3DG0XYUTGs5Clgb4OLG88Anakw
 bz3xRoryi2HKw0K2w7UVZuZ+9moEcAfKm47Q7xWfxW6P9pJ21Q1u+u9GxWMKtqugRQadKe
 yMD1Yxu6e2iC4TjlKkzgwfBK1f3P1eI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-Ywo88t0dNVOFL__UeWWsrg-1; Fri, 06 Dec 2019 03:14:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34BFA102CE28;
 Fri,  6 Dec 2019 08:14:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2D8819C7F;
 Fri,  6 Dec 2019 08:13:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 22B421138606; Fri,  6 Dec 2019 09:13:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [RFC v5 024/126] error: auto propagated local_err
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-25-vsementsov@virtuozzo.com>
 <87muc8p24w.fsf@dusky.pond.sub.org>
 <55393c08-5bda-8042-1a95-f350b3781d99@virtuozzo.com>
 <87d0d3c5k7.fsf@dusky.pond.sub.org>
 <eef60af5-ff92-3df7-bad5-c981690d66ad@virtuozzo.com>
 <a6df5b5b-7b76-fe38-cbd4-f2473a109d3d@virtuozzo.com>
Date: Fri, 06 Dec 2019 09:13:57 +0100
In-Reply-To: <a6df5b5b-7b76-fe38-cbd4-f2473a109d3d@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 5 Dec 2019 16:36:42 +0000")
Message-ID: <87h82dna62.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Ywo88t0dNVOFL__UeWWsrg-1
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Alberto Garcia <berto@igalia.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Anthony Green <green@moxielogic.com>, Laurent Vivier <lvivier@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Chris Wulff <crwulff@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Michael Walle <michael@walle.cc>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 "sheepdog@lists.wpkg.org" <sheepdog@lists.wpkg.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Palmer Dabbelt <palmer@sifive.com>, Eric Farman <farman@linux.ibm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Hannes Reinecke <hare@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, Liu Yuan <namei.unix@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Amit Shah <amit@kernel.org>, Stefan Weil <sw@weilnetz.de>,
 Greg Kurz <groug@kaod.org>, Yuval Shaia <yuval.shaia@oracle.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Stafford Horne <shorne@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Paul Durrant <paul@xen.org>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Ari Sundholm <ari@tuxera.com>,
 Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Jason Dillaman <dillaman@redhat.com>, Antony Pavlov <antonynpavlov@gmail.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "integration@gluster.org" <integration@gluster.org>,
 Laszlo Ersek <lersek@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Max Reitz <mreitz@redhat.com>,
 Denis Lunev <den@virtuozzo.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>, Marek Vasut <marex@denx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>,
 David Gibson <david@gibson.dropbear.id.au>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Wen Congyang <wencongyang2@huawei.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 05.12.2019 17:58, Vladimir Sementsov-Ogievskiy wrote:
>> 05.12.2019 15:36, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> 04.12.2019 17:59, Markus Armbruster wrote:
>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>
>>>>>> Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
>>>>>> functions with errp OUT parameter.
>>>>>>
>>>>>> It has three goals:
>>>>>>
>>>>>> 1. Fix issue with error_fatal & error_prepend/error_append_hint: use=
r
>>>>>> can't see this additional information, because exit() happens in
>>>>>> error_setg earlier than information is added. [Reported by Greg Kurz=
]
>>>>>>
>>>>>> 2. Fix issue with error_abort & error_propagate: when we wrap
>>>>>> error_abort by local_err+error_propagate, resulting coredump will
>>>>>> refer to error_propagate and not to the place where error happened.
>>>>>
>>>>> I get what you mean, but I have plenty of context.
>>>>>
>>>>>> (the macro itself doesn't fix the issue, but it allows to [3.] drop =
all
>>>>>> local_err+error_propagate pattern, which will definitely fix the iss=
ue)
>>>>>
>>>>> The parenthesis is not part of the goal.
>>>>>
>>>>>> [Reported by Kevin Wolf]
>>>>>>
>>>>>> 3. Drop local_err+error_propagate pattern, which is used to workarou=
nd
>>>>>> void functions with errp parameter, when caller wants to know result=
ing
>>>>>> status. (Note: actually these functions could be merely updated to
>>>>>> return int error code).
>>>>>>
>>>>>> To achieve these goals, we need to add invocation of the macro at st=
art
>>>>>> of functions, which needs error_prepend/error_append_hint (1.); add
>>>>>> invocation of the macro at start of functions which do
>>>>>> local_err+error_propagate scenario the check errors, drop local erro=
rs
>>>>>> from them and just use *errp instead (2., 3.).
>>>>>
>>>>> The paragraph talks about two cases: 1. and 2.+3.
>>>>
>>>> Hmm, I don't think so.. 1. and 2. are issues. 3. is a refactoring.. We=
 just
>>>> fix achieve 2 and 3 by one action.
>>>>
>>>>> Makes me think we
>>>>> want two paragraphs, each illustrated with an example.
>>>>>
>>>>> What about you provide the examples, and then I try to polish the pro=
se?
>>>>
>>>> 1: error_fatal problem
>>>>
>>>> Assume the following code flow:
>>>>
>>>> int f1(errp) {
>>>>       ...
>>>>       ret =3D f2(errp);
>>>>       if (ret < 0) {
>>>>          error_append_hint(errp, "very useful hint");
>>>>          return ret;
>>>>       }
>>>>       ...
>>>> }
>>>>
>>>> Now, if we call f1 with &error_fatal argument and f2 fails, the progra=
m
>>>> will exit immediately inside f2, when setting the errp. User will not
>>>> see the hint.
>>>>
>>>> So, in this case we should use local_err.
>>>
>>> How does this example look after the transformation?
>>=20
>> Good point.
>>=20
>> int f1(errp) {
>>      ERRP_AUTO_PROPAGATE();
>>      ...
>>      ret =3D f2(errp);
>>      if (ret < 0) {
>>         error_append_hint(errp, "very useful hint");
>>         return ret;
>>      }
>>      ...
>> }
>>=20
>> - nothing changed, only add macro at start. But now errp is safe, if it =
was
>> error_fatal it is wrapped by local error, and will only call exit on aut=
omatic
>> propagation on f1 finish.
>>=20
>>>
>>>> 2: error_abort problem
>>>>
>>>> Now, consider functions without return value. We normally use local_er=
r
>>>> variable to catch failures:
>>>>
>>>> void f1(errp) {
>>>>       Error *local_err =3D NULL;
>>>>       ...
>>>>       f2(&local_err);
>>>>       if (local_err) {
>>>>           error_propagate(errp, local_err);
>>>>           return;
>>>>       }
>>>>       ...
>>>> }
>>>>
>>>> Now, if we call f2 with &error_abort and f2 fails, the stack in result=
ing
>>>> crash dump will point to error_propagate, not to the failure point in =
f2,
>>>> which complicates debugging.
>>>>
>>>> So, we should never wrap error_abort by local_err.
>>>
>>> Likewise.
>>=20
>> And here:
>>=20
>> void f1(errp) {
>>       ERRP_AUTO_PROPAGATE();
>>       ...
>>       f2(errp);
>>       if (*errp) {
>>           return;
>>       }
>>       ...
>>=20
>> - if errp was NULL, it is wrapped, so dereferencing errp is safe. On ret=
urn,
>>     local error is automatically propagated to original one.
>
> and if it was error_abort, it is not wrapped, so will crash where failed.

We still need to avoid passing on unwrapped @errp when we want to ignore
some errors, as in fit_load_fdt(), but that should be quite rare.
Doesn't invalidate your approach.

[...]


