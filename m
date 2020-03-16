Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858FDC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F14420658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfV4u9fX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F14420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDjp6-0003hb-3W
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 03:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDjdM-0001Bk-1Z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 02:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDjdK-0003ch-Rx
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 02:53:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51048
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDjdK-0003Jm-Gz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 02:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584341633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8by8enI9YoBo7nITvgQmjIJhUiSnmsmPWE3sDt+oxjk=;
 b=CfV4u9fXSzlb1iGVKBH/MYtTiZzONMvndEB8bomZdeXZ9IZ2tKm6d0heuetVGQwi9u8Gdn
 ZoA+IBAPkk51VKxJaoluyXSJDZ0M9ckydAD/TRkTl65XVy6ZzRy8Y4LqKXfBzTUwYb+wiL
 mM0LQ4aR/WodbLjw9n6UkxkrQZbhxK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-IwDXr6AhN_imLvLjN9P18w-1; Mon, 16 Mar 2020 02:53:51 -0400
X-MC-Unique: IwDXr6AhN_imLvLjN9P18w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ADDB107ACCC;
 Mon, 16 Mar 2020 06:53:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15352907F7;
 Mon, 16 Mar 2020 06:53:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9CD621138404; Mon, 16 Mar 2020 07:53:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 4/8] hw/ide: Move MAX_IDE_BUS define to one header
References: <cover.1584134074.git.balaton@eik.bme.hu>
 <eb14ddee41be26f38ee0fe5ff0ff42c79afe9731.1584134074.git.balaton@eik.bme.hu>
Date: Mon, 16 Mar 2020 07:53:45 +0100
In-Reply-To: <eb14ddee41be26f38ee0fe5ff0ff42c79afe9731.1584134074.git.balaton@eik.bme.hu>
 (BALATON Zoltan's message of "Fri, 13 Mar 2020 22:14:34 +0100")
Message-ID: <8736a8n62u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, philmd@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 hpoussin@reactos.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BALATON Zoltan <balaton@eik.bme.hu> writes:

> There are several definitions of MAX_IDE_BUS in different boards (some
> of them unused) with the same value. Move it to include/hw/ide/internal.h
> to have it in a central place.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

This one feels a bit questionable.

The number of (PATA) IDE buses provides by a host bus adapter depends on
the HBA.  It happens to be 2 for all HBAs we implement, but it could
really be anything.

Similar for SATA, where the common number is 6, but could really be
anything.  I can't see offhand whether any HBA we implement provides a
different number.

By moving MAX_IDE_BUS to include/hw/ide/internal.h, you bake the
accidental commonality into the interface to the IDE core.  I'd prefer
not to.


