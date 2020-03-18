Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F38C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 12:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBA620753
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 12:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDuj0jIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBA620753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEY6S-0005ZJ-54
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 08:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEY5B-0004fW-3Z
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 08:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEY59-0000PT-HH
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 08:46:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56596)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEY59-0000Ju-7Z
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 08:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584535558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F4hxjhcpQ7NoUUK1DufVgvGrd2Em47L0sw73JysjmII=;
 b=NDuj0jIpcoCP9/9jECGDxOynCfEnHLA4WcHcDJB0NrHCj2JHq2sglMKCgw/zknFRzh0AjL
 o5tj0CV9LJ0APwRQMpLTjKoK53uMMwjzpEmKh7ra5ctK0IB4UZu8uqZZymlk0rYszYLoxx
 djCqPJO7NP9esbBOF8I1hxV5sx2TdPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-0S0zpaZAO2KoggWRnSmv6Q-1; Wed, 18 Mar 2020 08:45:53 -0400
X-MC-Unique: 0S0zpaZAO2KoggWRnSmv6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE6FC1005512;
 Wed, 18 Mar 2020 12:45:52 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73F3B10002A5;
 Wed, 18 Mar 2020 12:45:52 +0000 (UTC)
Subject: Re: [PATCH] build: Silence clang warning on older glib autoptr usage
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200317175534.196295-1-eblake@redhat.com>
 <CAFEAcA8qGWhvoRwT1Wcg6RTWONG7gVSzGbhCFtG-AgQYwZHyQA@mail.gmail.com>
 <4880cc8b-ae70-508b-a0c1-603833699d87@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0d535914-868f-59cb-5309-f4e5806d0fff@redhat.com>
Date: Wed, 18 Mar 2020 07:45:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4880cc8b-ae70-508b-a0c1-603833699d87@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: John Snow <jsnow@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/18/20 6:19 AM, Eric Blake wrote:

>> This wasn't a NetBSD failure. I hit it on my clang-on-x86-64-Ubuntu
>> setup, and also on FreeBSD. (The latter is just the tests/vm
>> FreeBSD config, so you can repro that if you need to.)
>>
>> The ubuntu setup is libglib 2.56.4-0ubuntu0.18.04.4 and
>> clang 6.0.0-1ubuntu2.
>=20
> Thanks; I ran:
>=20
> $ make docker-test-clang@ubuntu1804 DEBUG=3D1

>=20
> to confirm that my test snippet does flush out the error in question.=20
> However, removing DEBUG=3D1 takes a long time to run (hmm, maybe I should=
=20
> set TARGET_LIST to speed it up), and did not reproduce the failure for=20
> me without the patch (making it hard to tell if the patch made a=20
> difference).=C2=A0 I'm still playing with testing, but at least I feel be=
tter=20
> that this patch is on the right track, now that I have an environment=20
> that can reproduce the situation.

Aha - I figured out my problem: I have to apply John's pull request, but=20
not my configure patch, to reproduce the build failure that Peter hit.=20
And with that, I can now state that this patch HAS been fully-tested by=20
me (but giving Tested-by: to my own patch feels weird):

make docker-test-clang@ubuntu1804 TARGETS=3Dx86_64

on the following matrix:

   John's PR =3D>         excluded included
my patch excluded         pass    fail
my patch included         pass    pass

Looks like the next step is for John to send v2 of the pull request with=20
my configure patch inserted.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


