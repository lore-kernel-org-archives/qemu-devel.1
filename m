Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6E0C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780012075E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzUfGlsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780012075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOJ0-0007s9-Kb
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jOOHQ-0006BQ-NA
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jOOHJ-0004s7-W5
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:19:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38898
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jONXB-0001lv-Ak
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 11:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586878292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6yPgsSE4OWXkD6OLed8cp+voX1L86uQXOFF8yFIR+9M=;
 b=EzUfGlsFEH4fGpvmGf2ocUIiYPdYhvan6xr4o+3BnWJnN+hiRIKsq78GeI8TUeoSSc+FJV
 lQUM8eUOnHjtR5oeO4Y006NM2vXX0w3rfECAXonWUk25InI25TSeW8COBYWs52bfddvG/E
 JkLBZbBdVaLfOxHwABSLh8qlwoJpwZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-gAkImttRMmSXb4ULLXDzYA-1; Tue, 14 Apr 2020 11:31:30 -0400
X-MC-Unique: gAkImttRMmSXb4ULLXDzYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D558080268C;
 Tue, 14 Apr 2020 15:31:29 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-1.ams2.redhat.com [10.36.114.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 791AA5C1BE;
 Tue, 14 Apr 2020 15:31:28 +0000 (UTC)
Date: Tue, 14 Apr 2020 17:31:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH for-5.0] qcow2: Add incompatibility note between backing
 files and raw external data files
Message-ID: <20200414153126.GN7747@linux.fritz.box>
References: <20200410121816.8334-1-berto@igalia.com>
MIME-Version: 1.0
In-Reply-To: <20200410121816.8334-1-berto@igalia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.04.2020 um 14:18 hat Alberto Garcia geschrieben:
> Backing files and raw external data files are mutually exclusive.
> The documentation of the raw external data bit (in autoclear_features)
> already indicates that, but we should also mention it on the other
> side.
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

I don't think this is critical for 5.0, so if I make a pull request for
other reasons, I'll include it, but if you agree, I won't send one just
for this patch.

Kevin


