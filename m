Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70168C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C42B20724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ho9U12jI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C42B20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCi0A-0004Sz-8r
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 06:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jChzC-0003Ke-17
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jChzA-0005G8-5z
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:56:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59437
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jChzA-0005Bi-0S
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584096970;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4i/+Cz29FbdiRvKCyiFiduFRs0i+Z9wYhrLD0/PG6Go=;
 b=Ho9U12jIBYw6dA4qLs3LfjvNtb+FlNyT+OTxRAlNRSWuGvRkbTHTUreSmtDBZwXPAWpNRO
 8vQ6LCqEipBWmKnXcK1Gn/HYy25183EpOOqMVuf4G9G7JTaG2Z5LlYXQ/yGlUTXt+9Iq4J
 dDKyOGmykmnhTS4A3MHeRQLdzV47h98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-2fCzhnLIOLOqKi5wh2Jgfg-1; Fri, 13 Mar 2020 06:56:07 -0400
X-MC-Unique: 2fCzhnLIOLOqKi5wh2Jgfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2CBE8017CC;
 Fri, 13 Mar 2020 10:56:05 +0000 (UTC)
Received: from redhat.com (ovpn-112-40.ams2.redhat.com [10.36.112.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8345C92D56;
 Fri, 13 Mar 2020 10:56:00 +0000 (UTC)
Date: Fri, 13 Mar 2020 10:55:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] modules: load modules from versioned /var/run dir
Message-ID: <20200313105557.GC962573@redhat.com>
References: <20200306132648.27577-1-christian.ehrhardt@canonical.com>
 <20200310093910.GB140737@stefanha-x1.localdomain>
 <ab8aaa05-8738-f789-8281-cc9d4235a225@msgid.tls.msk.ru>
 <d837839f-e1e5-3cbf-b8fd-a2a6cc4ad5ce@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d837839f-e1e5-3cbf-b8fd-a2a6cc4ad5ce@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 pkg-qemu-devel@lists.alioth.debian.org, Cole Robinson <crobinso@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 08:45:21AM +0100, Paolo Bonzini wrote:
> On 13/03/20 08:34, Michael Tokarev wrote:
> >> The use of /var/run makes me a little uneasy.  I guess it's related to
> >> wanting to uninstall the old package so the .so in their original
> >> location cannot be used (even if they had a versioned path)?
> >=20
> > BTW, this is /run nowadays, not /var/run, as far as I can see.
>=20
> /var/run is still symlinked to /run.  QEMU generally uses /var/run,
> though we could consider switching sooner or later.

Only Linux commonly uses /run, others still use /var/run.=20

We really only need a "configure --rundir=3D/run"  arg to override the
default, in the same way distros pick /etc and /var, instead of
/usr/etc and /usr/var.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


