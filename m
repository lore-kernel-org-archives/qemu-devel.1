Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1FFC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9B5214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ethRgzVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9B5214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dXl-0001J2-0m
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i2dWO-0008Az-Ka
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i2dWL-0006Ae-CL
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:36:34 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:60510)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i2dWK-00069s-NT
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:36:33 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id DCEAD2E07C1;
 Tue, 27 Aug 2019 18:36:29 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 LlRa2zaFHm-aTJKuCEW; Tue, 27 Aug 2019 18:36:29 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1566920189; bh=50/Fnm5x3/Y6b1JBGDRmLynKJXzQjG/xuFkSfBMqegk=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=ethRgzVlcY2+5VJUBGuLTwfFfq6GJ8LcKgiOT9PzYNi/rY7A9gFhYC4H92oI1AwoG
 alNtuN3rmCXOuHG0/AZpWJmakusCJwvGhDu45S4juhfwuKeCgDYbohLFD9rv4ovtgJ
 0ZyORw9PH+tbiiAQ0IrWXZNtLm+4PBPxzU+jPUEw=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp2j.mail.yandex.net (localhost [::1])
 by mxbackcorp2j.mail.yandex.net with LMTP id VDYHKdB2KM-gM8nfwHf
 for <yury-kotov@yandex-team.ru>; Tue, 27 Aug 2019 18:36:18 +0300
Received: by vla1-6bb9290e4d68.qloud-c.yandex.net with HTTP;
 Tue, 27 Aug 2019 18:36:18 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Dr. David Alan Gilbert <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <fb324ab9-b7a2-d56e-a0d1-9f4ae86791ce@redhat.com>
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
 <20190827120221.15725-2-yury-kotov@yandex-team.ru>
 <fb324ab9-b7a2-d56e-a0d1-9f4ae86791ce@redhat.com>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 27 Aug 2019 18:36:28 +0300
Message-Id: <1097381566920178@vla1-6bb9290e4d68.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Add x-validate-uuid
 capability
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.08.2019, 17:02, "Eric Blake" <eblake@redhat.com>:
> On 8/27/19 7:02 AM, Yury Kotov wrote:
>> =C2=A0This capability realizes simple source validation by UUID.
>> =C2=A0It's useful for live migration between hosts.
>>
>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>> =C2=A0---
>> =C2=A0=C2=A0migration/migration.c | 9 +++++++++
>> =C2=A0=C2=A0migration/migration.h | 1 +
>> =C2=A0=C2=A0migration/savevm.c | 45 ++++++++++++++++++++++++++++++++++=
+++++++++
>> =C2=A0=C2=A0qapi/migration.json | 5 ++++-
>> =C2=A0=C2=A04 files changed, 59 insertions(+), 1 deletion(-)
>
> Any reason why this is marked experimental? It seems useful enough that
> we could probably just add it as a fully-supported feature (dropping th=
e
> x- prefix) - but I'll leave that up to the migration maintainers.
>

I thought that all new capabilities have x- prefix... May be it's really
unnecessary here, I'm not sure.

> In fact, do we even need this to be a tunable feature? Why not just
> always enable it? As long as the UUID is sent in a way that new->old
> doesn't break the old qemu from receiving the migration stream, and tha=
t
> old->new copes with UUID being absent, then new->new will always benefi=
t
> from the additional safety check.
>

In such case we couldn't migrate from e.g. 4.2 to 3.1
If it's not a problem then we can always use it.

>> =C2=A0+++ b/qapi/migration.json
>> =C2=A0@@ -415,6 +415,9 @@
>> =C2=A0=C2=A0#
>> =C2=A0=C2=A0# @x-ignore-shared: If enabled, QEMU will not migrate shar=
ed memory (since 4.0)
>> =C2=A0=C2=A0#
>> =C2=A0+# @x-validate-uuid: Check whether the UUID is the same on both =
sides or not.
>> =C2=A0+# (since 4.2)
>
> Maybe:
>
> @x-validate-uuid: Send the UUID of the source to allow the destination
> to ensure it is the same.
>
> if we even need a tunable capability.
>

Yes, it sounds better. Thanks!

>> =C2=A0+#
>> =C2=A0=C2=A0# Since: 1.2
>> =C2=A0=C2=A0##
>> =C2=A0=C2=A0{ 'enum': 'MigrationCapability',
>> =C2=A0@@ -422,7 +425,7 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0'block', 'return-path', 'pause-before-switchover', 'multifd',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
>> =C2=A0- 'x-ignore-shared' ] }
>> =C2=A0+ 'x-ignore-shared', 'x-validate-uuid' ] }
>>
>> =C2=A0=C2=A0##
>> =C2=A0=C2=A0# @MigrationCapabilityStatus:
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc. +1-919-301-3226
> Virtualization: qemu.org | libvirt.org

Regards,
Yury

