Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE54C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C5B20643
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdOik6Nj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C5B20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipBTi-0006EX-V6
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ipBSN-00051v-0W
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:33:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ipBSL-0002VQ-9l
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:33:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47469
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ipBSL-0002UA-67
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578490384;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VQR2RCi3gks8yKm9J3cqt6uLn8ZXaWfEmTgCPtqzKhE=;
 b=SdOik6NjcbFyLyeb8k/+/+3MdmfPIdvmqXkjmB1oXVjuIrXbPwBZ4AxvVabqrAn9swdsli
 F4mdGzqCXwJimcgLKEy1T2pfAHpYinUUynXdh2bOC3PGJmsN4gCl7IcmZpzfXjv+pk+n+l
 1XZpFZDItpoK2yG4I12HtpM/qMhqqHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-GWP_HXvHPKSYk3o6oiqwaQ-1; Wed, 08 Jan 2020 08:33:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68EC8801E6C;
 Wed,  8 Jan 2020 13:32:59 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90AD019C69;
 Wed,  8 Jan 2020 13:32:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Subject: Re: [PATCH v2] migration/ram: Yield periodically to the main loop
In-Reply-To: <87imlmgk01.fsf@secure.laptop> (Juan Quintela's message of "Wed, 
 08 Jan 2020 14:23:10 +0100")
References: <20191125133632.21387-1-yury-kotov@yandex-team.ru>
 <87imlmgk01.fsf@secure.laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 08 Jan 2020 14:32:54 +0100
Message-ID: <87eewagjjt.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: GWP_HXvHPKSYk3o6oiqwaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Reply-To: quintela@redhat.com
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 yc-core@yandex-team.ru, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Juan Quintela <quintela@redhat.com> wrote:
> Yury Kotov <yury-kotov@yandex-team.ru> wrote:
>> Usually, incoming migration coroutine yields to the main loop
>> while its IO-channel is waiting for data to receive. But there is a case
>> when RAM migration and data receive have the same speed: VM with huge
>> zeroed RAM. In this case, IO-channel won't read and thus the main loop
>> is stuck and for instance, it doesn't respond to QMP commands.
>>
>> For this case, yield periodically, but not too often, so as not to
>> affect the speed of migration.
>>
>> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Nack.

The idea is good.  But it fails migration-test to fail from time to time
(50% of the time on my laptop).

Will investigate why this is failing.

Later, Juan.


