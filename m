Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41F6C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 20:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF69214D8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 20:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Loc+B785"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF69214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSRfP-0007SW-Qv
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 15:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iSRei-0006wc-H0
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 15:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iSReg-0000Sn-Vs
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 15:11:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25044
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iSReg-0000SX-Ry
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 15:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573071110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfpWyMF56NwZoUqcwzRjXyCTYP6hb4aaedJqadUkO4w=;
 b=Loc+B785+lSuxniqwHNHBdZPJWL1PS32s8wCCzkz02Zu0gp+vrq1jNViWiJFrZ6B6L4FL9
 dLGd2g/fNBPERzAkpjL/oRomwUyzkfxtdLPjvGIZU1rL2dz4xYhUeW44bQ1L28CZAiPokx
 Ny6txGCoEZhbOPYGkCxEw/vfBMG6XaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-aK_h-r2lNu6rF0LBCdwsaw-1; Wed, 06 Nov 2019 15:11:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4577107ACC4;
 Wed,  6 Nov 2019 20:11:47 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE39A600CD;
 Wed,  6 Nov 2019 20:11:46 +0000 (UTC)
Date: Wed, 6 Nov 2019 20:11:44 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 0/6] migration/postcopy: enable compress during postcopy
Message-ID: <20191106201144.GM2802@work-vm>
References: <20191018004850.9888-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191018004850.9888-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: aK_h-r2lNu6rF0LBCdwsaw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> This patch set tries enable compress during postcopy.
>=20
> postcopy requires to place a whole host page, while migration thread migr=
ate
> memory in target page size. This makes postcopy need to collect all targe=
t
> pages in one host page before placing via userfaultfd.
>=20
> To enable compress during postcopy, there are two problems to solve:
>=20
>     1. Random order for target page arrival
>     2. Target pages in one host page arrives without interrupt by target
>        page from other host page
>=20
> The first one is handled by counting the number of target pages arrived
> instead of the last target page arrived.
>=20
> The second one is handled by:
>=20
>     1. Flush compress thread for each host page
>     2. Wait for decompress thread for before placing host page
>=20
> With the combination of these two changes, compress is enabled during
> postcopy.

What have you tested this with? 2MB huge pages I guess?

Dave

> Wei Yang (6):
>   migration/postcopy: reduce memset when it is zero page and
>     matches_target_page_size
>   migration/postcopy: wait for decompress thread in precopy
>   migration/postcopy: count target page number to decide the
>     place_needed
>   migration/postcopy: set all_zero to true on the first target page
>   migration/postcopy: enable random order target page arrival
>   migration/postcopy: enable compress during postcopy
>=20
>  migration/migration.c | 11 --------
>  migration/ram.c       | 65 ++++++++++++++++++++++++++++++-------------
>  2 files changed, 45 insertions(+), 31 deletions(-)
>=20
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


