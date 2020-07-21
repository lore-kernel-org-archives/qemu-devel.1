Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03579C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C395A20729
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXo4Bxwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C395A20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxp2m-0000SP-3H
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 05:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxp23-00081H-8D
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 05:57:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36685
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxp21-0006Ke-KE
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 05:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595325472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uwojRtX9rCrCbpJHZfWY4BxhZMoHEbevn1Zu4yV/GJ4=;
 b=eXo4BxwaFACi9kAekW+v0fbQDqhS0cB8kAKxVCvJys53hnVh+nhPjP3zLlTLnN1GTsZAcb
 ZXxPFyb8EQIKkuJNx4MaAaT6Jp8Z5C8YE1/iWT/pWP7ENhfUKx0hxEYCUU3aSAURZ9e5Pu
 8fYseKeFCpKV2tBLhmqpjE5EysFC+7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-HnhwASimPraQTHJQS0LwSg-1; Tue, 21 Jul 2020 05:57:50 -0400
X-MC-Unique: HnhwASimPraQTHJQS0LwSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58B68805721;
 Tue, 21 Jul 2020 09:57:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 657405D9CA;
 Tue, 21 Jul 2020 09:57:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0092D111CA27; Tue, 21 Jul 2020 11:57:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1] hw/isa/isa-superio: Fix IDE controller realization
References: <20200720172348.23465-1-f4bug@amsat.org>
 <87zh7t9tda.fsf@dusky.pond.sub.org>
 <c0c7fd3d-fa14-df6f-ecb9-44a7a2a783e6@amsat.org>
Date: Tue, 21 Jul 2020 11:57:44 +0200
In-Reply-To: <c0c7fd3d-fa14-df6f-ecb9-44a7a2a783e6@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 21 Jul 2020 10:46:15
 +0200")
Message-ID: <87wo2x8a1z.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:46:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 7/21/20 10:15 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>=20
>>> When realizing a Super I/O with IDE controller [*], we get:
>>>
>>>   qom/object.c:1684: object_property_try_add_child: Assertion `!child->=
parent' failed.
>>>   Aborted (core dumped)
>>>
>>> This is because the device is already realized when we try to
>>> add the QOM property to the parent. Fix by realizing *after*
>>> adding the QOM relationship.
>>>
>>> [*] Set ISASuperIOClass::ide.count =3D N with N not zero
>>=20
>> Is this a latent bug, or can it bite in master?  If the latter, can you
>> show how to reproduce?
>
> Latent bug for master:
>
> $ git grep ide.count
> hw/isa/isa-superio.c:149:    if (k->ide.count && (!k->ide.is_enabled ||
> k->ide.is_enabled(sio, 0))) {
> hw/isa/isa-superio.c:197:    sc->ide.count =3D 0;
> hw/isa/smc37c669-superio.c:100:    sc->ide.count =3D 0;
> hw/isa/vt82c686.c:529:    sc->ide.count =3D 0;
>
> I hit it rebasing undergoing series for 5.2 and testing them.

Let's tweak the commit message like this

    [*] Set ISASuperIOClass::ide.count =3D N with N not zero (no such
    thing currently exists; the bug is latent)

Preferably with that or something like it:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


