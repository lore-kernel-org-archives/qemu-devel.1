Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CE1C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F92A20665
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aK934ffS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F92A20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZzSl-0001db-7S
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 10:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZzRs-0001BM-8O
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZzRq-0006JZ-SX
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:41:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25421
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZzRq-0006Ix-HR
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574869305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xVweYuJ+TQO4KSvemNg+XOjI2/58rDvi7Vw7BBtYYmI=;
 b=aK934ffSxozsmHKGzZl4TGMhIeoC0NQre/tF4Gdyf7cE/UtrqIHpTAYnHSmyfainbjlJD5
 jqToRMFYmK5tBKoI8swLcxYbVgULdRhw+RKTOb+HdsRIdEIPRJg1fLXXZX9OdtZVqSJ+W6
 nxOHano0q41HlXIPGyiD6ZaRBqG3eJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-v5yfvhLnPgeGPoHStRj_NA-1; Wed, 27 Nov 2019 10:41:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64B861005512;
 Wed, 27 Nov 2019 15:41:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF2835D6C8;
 Wed, 27 Nov 2019 15:41:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3E3531138606; Wed, 27 Nov 2019 16:41:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v11 00/15] Introduce the microvm machine type
References: <20191018105315.27511-1-slp@redhat.com>
Date: Wed, 27 Nov 2019 16:41:30 +0100
In-Reply-To: <20191018105315.27511-1-slp@redhat.com> (Sergio Lopez's message
 of "Fri, 18 Oct 2019 12:53:00 +0200")
Message-ID: <87imn58gyd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: v5yfvhLnPgeGPoHStRj_NA-1
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
Cc: berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com, philmd@redhat.com,
 groug@kaod.org, qemu-devel@nongnu.org, marcandre.lureau@gmail.com,
 kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net,
 lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sergio Lopez <slp@redhat.com> writes:

> microvm is a machine type inspired by Firecracker and constructed
> after its machine model.
>
> It's a minimalist machine type without PCI nor ACPI support, designed
> for short-lived guests. microvm also establishes a baseline for
> benchmarking and optimizing both QEMU and guest operating systems,
> since it is optimized for both boot time and footprint.

I know this has been merged, but I ask anyway: got some boot time and
memory footprint measurements?


