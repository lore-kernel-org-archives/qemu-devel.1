Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC59BC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B653820692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxysUYza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B653820692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipBa6-0003jq-J6
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ipBZL-0003I2-Sn
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ipBZK-0000JV-Qh
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:40:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22922
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ipBZK-0000IM-Mp
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578490818;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjyV7AFxu1WQoNBlYZQiaY6wXEDqa7Uzglz27IU18mQ=;
 b=IxysUYzauwPuVU3L4D7eFp1I9zE04Tz0nYitfPlf0GQ+5Fz0pchY8DQjU3GivSJKv2MBdM
 nKa/un/iPhQXi/8gqVCH4nDUs3W/0/uM6xjnscyieVgiZLro+uIdhiDWZI+df9Xaiz3/Dz
 UUQzfv/PEApL1xoVStlNcwFXuEccX94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-Hxp0wkNGPzCaAxWl1-GEow-1; Wed, 08 Jan 2020 08:40:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1E5C10054E3;
 Wed,  8 Jan 2020 13:40:15 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DAEB5D9E5;
 Wed,  8 Jan 2020 13:40:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 0/1] Removing RAMBlocks during migration
In-Reply-To: <20200107145914-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Tue, 7 Jan 2020 15:02:10 -0500")
References: <20191209074102.5926-1-yury-kotov@yandex-team.ru>
 <20200107145914-mutt-send-email-mst@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 08 Jan 2020 14:40:01 +0100
Message-ID: <878smigj7y.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Hxp0wkNGPzCaAxWl1-GEow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: quintela@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, yc-core@yandex-team.ru,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Igor Mammedov <imammedo@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Dec 09, 2019 at 10:41:01AM +0300, Yury Kotov wrote:
>> Hi,
>>=20
>> I found that it's possible to remove a RAMBlock during migration.
>> E.g. device hot-unplugging initiated by a guest (how to reproduce is bel=
ow).
>> And I want to clarify whether RAMBlock removing (or even adding) during
>> migration is valid operation or it's a bug.
>
> There's a very basic problem though: list of RAMBlock's on source and
> destination must match otherwise destination will be confused.
>
> It is probably fixable: keep a fake RAMBlock around until migration is
> complete, and send some kind of "RAMBlock removed" message to
> destination so it knows to remove it there as well.

Do we have the data to know that a device is unplugged?
I think that it would be just easier just queue that command.  Let the
guest unplug whatever it wants, and on destination, once that we know
that we have finish migration, we just do the rest of the staff.

As stated on the thread, we really want _not_ to have hotplug/unplug
during migration, but if a guest can initiate one, we can only "delay"
the bits that happen inside qemu.

Later, Juan.


