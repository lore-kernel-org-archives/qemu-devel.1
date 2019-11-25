Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54051C43215
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B40207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egRwVL+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B40207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZDNy-0000rN-Ub
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 07:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iZDMO-0007OF-WD
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iZDHS-0005li-DA
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:15:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29794
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iZDHS-0005kj-8j
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574684149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtqBsD/LX/DKKllG+LDa11qGhPVG4nkJnIYoShnTlcY=;
 b=egRwVL+Ud9Y2XVZcMiIk/CN3xB6sKsYVAkiX9SD0nvGoLEn876ph5ywy6EXgBxQhpk6tUS
 tgiSboqbYS39WnSbOVs9wX60wMS6rxEzqSpgI9xh7NL2aSP1y62LJilmAwxpnZXazGq583
 PtSPj0ij7gvM4JqztlPqgXJMljiFtSE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-Mh1opPwjOd-dItkyVX6VsA-1; Mon, 25 Nov 2019 07:15:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6899410CE781;
 Mon, 25 Nov 2019 12:15:36 +0000 (UTC)
Received: from localhost (ovpn-116-36.gru2.redhat.com [10.97.116.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22C735D9CA;
 Mon, 25 Nov 2019 12:15:32 +0000 (UTC)
Date: Mon, 25 Nov 2019 09:15:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v17 03/14] util/cutils: refactor do_strtosz() to support
 suffixes list
Message-ID: <20191125121531.GD4438@habkost.net>
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-4-tao3.xu@intel.com>
 <87pnhgjubs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87pnhgjubs.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Mh1opPwjOd-dItkyVX6VsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: lvivier@redhat.com, thuth@redhat.com, mst@redhat.com,
 jonathan.cameron@huawei.com, sw@weilnetz.de, Tao Xu <tao3.xu@intel.com>,
 fan.du@intel.com, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 jingqi.liu@intel.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 08:20:23AM +0100, Markus Armbruster wrote:
> Tao Xu <tao3.xu@intel.com> writes:
>=20
> > Add do_strtomul() to convert string according to different suffixes.
> >
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Tao Xu <tao3.xu@intel.com>
>=20
> What's the actual change here?  "Refactor" suggests the interfaces stay
> the same, only their implementation changes.  "Support suffixes list"
> suggests some interface supports something new.

1) Parameters added to suffix_mul() (suffix table);
2) do_strtomul() is being extracted from do_strtosz().

do_strtomul() interface and behavior stays the same.

--=20
Eduardo


