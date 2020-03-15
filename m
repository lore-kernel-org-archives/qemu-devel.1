Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B39C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B268C205ED
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fz7RLl6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B268C205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDVbP-0000bI-Q5
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 11:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jDVSy-0004lF-WC
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 11:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jDVSv-0004Sq-VG
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 11:46:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58657
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jDVSv-0004Pm-QU
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 11:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584287173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=os18f27xbz3j9Dd0kXTe1Jkg0vVoeMl0Fcs+sR5sYlw=;
 b=fz7RLl6GUQ33NfeYVSA2SnRvywjF4zz5AyjFqH0QgIkx4564ZqPZpKyP8iSfJvLaHl4qjA
 z0sd7+4IfwmQgurA1sSMNFPIZ+eorkw/16s3NgGOFvXTawzZfMzEmZx20hvOV5n6eUSSeZ
 CikQyzeIkb8u8pdH+15YqHwA4O4GlSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-hUW2O1b6Mhm_k1QZbdk8aQ-1; Sun, 15 Mar 2020 11:46:09 -0400
X-MC-Unique: hUW2O1b6Mhm_k1QZbdk8aQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90903800D4E;
 Sun, 15 Mar 2020 15:46:08 +0000 (UTC)
Received: from localhost (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B50CC5C1B2;
 Sun, 15 Mar 2020 15:46:05 +0000 (UTC)
Date: Sun, 15 Mar 2020 11:46:04 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/2] Fix MAP_SYNC support when host has older glibc
 version
Message-ID: <20200315154604.GX1187748@habkost.net>
References: <20200311232342.1614944-1-ehabkost@redhat.com>
 <7a2bc684-b07e-3825-10db-5f2bf0c33edf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7a2bc684-b07e-3825-10db-5f2bf0c33edf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, jingqi.liu@intel.com, jtomko@redhat.com,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 14, 2020 at 10:39:11AM +0100, Paolo Bonzini wrote:
> On 12/03/20 00:23, Eduardo Habkost wrote:
> > Changes v1 -> v2:
> > * Use -isystem for $PWD/linux-headers too
> >   Reported-by: "Michael S. Tsirkin" <mst@redhat.com>
> >=20
> > This is an alternative to the patch submitted at:
> >=20
> >   From: Jingqi Liu <jingqi.liu@intel.com>
> >   Subject: [PATCH] util: fix to get configuration macros in util/mmap-a=
lloc.c
> >   Date: Thu,  5 Mar 2020 23:41:42 +0800
> >   Message-Id: <20200305154142.63070-1-jingqi.liu@intel.com>
> >=20
> > Before moving the osdep.h include to the top of the file, we had
> > to address warnings triggered when <linux/mman.h> was included
> > after <sys/mman.h> (done in patch 1/2).
> >=20
> > Eduardo Habkost (2):
> >   Use -isystem for linux-headers dir
> >   mmap-alloc: Include osdep.h before checking CONFIG_LINUX
> >=20
> >  Makefile.target   | 2 +-
> >  configure         | 2 +-
> >  util/mmap-alloc.c | 7 +++----
> >  3 files changed, 5 insertions(+), 6 deletions(-)
> >=20
>=20
> Queued, thanks.

Please don't queue patch 2/2.  It breaks the build on mips.

--=20
Eduardo


