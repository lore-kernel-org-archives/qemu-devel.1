Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF0C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC53E206E9
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfGpEw/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC53E206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKMek-0001Tx-Rb
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 09:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jKMdu-00012R-Hc
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jKMds-0001BW-5H
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:45:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28376
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jKMdr-0001Ay-DB
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585921550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7EWyUwvx0uoaHLlXfZNdlW/nIec3KrwopfePigunuok=;
 b=BfGpEw/QgEf7Ian6YXYZNgAd8xoIQieuPVUvs+obO2qLR9V/jwSxkGQ5Uy+5XLYml+xorH
 Zz0LsPykpPNFrvMdg6j0AMrudzJl6Xl1GVbfR0Md0EI35SOJjfUpgTrdtpxBArDy5Woxl5
 TxJXaQZydx/Si9JmNXVww66aPLlPALw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-3pSpDIMZN3OQmEivEJU6aw-1; Fri, 03 Apr 2020 09:45:48 -0400
X-MC-Unique: 3pSpDIMZN3OQmEivEJU6aw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B2BA10CE790;
 Fri,  3 Apr 2020 13:45:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-152.ams2.redhat.com
 [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F004B19A8;
 Fri,  3 Apr 2020 13:45:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C8C5E1138610; Fri,  3 Apr 2020 15:45:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Question about scsi device hotplug (e.g scsi-hd)
References: <7302c0b9f2327b9b61b4adb465f166e339e46ac1.camel@redhat.com>
 <20200401150944.GA4500@stefanha-x1.localdomain>
 <4bc42bf2-939f-f6c4-ea45-0d08eb42fc2b@redhat.com>
 <ffa77fc719232b8dc0e6e78bd3781fd77c5adcf8.camel@redhat.com>
 <20200403124145.GC146016@stefanha-x1.localdomain>
Date: Fri, 03 Apr 2020 15:45:45 +0200
In-Reply-To: <20200403124145.GC146016@stefanha-x1.localdomain> (Stefan
 Hajnoczi's message of "Fri, 3 Apr 2020 13:41:45 +0100")
Message-ID: <87a73s4r92.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@gmail.com> writes:

[...]
> It would be nice to have a general solution in qdev core that makes
> thread-safe hotplug easy for all devices.

Excuse my ignorance / confusion...

The "realize" concept exists to enable

    create device
    configure / wire up step by step without impact on the guest
    realize, device becomes "real" atomically

How and why does this break down with threads?


