Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD199C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDCA20866
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDtjOt0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDCA20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBh7q-0007SP-N5
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jBh71-0006Uy-MM
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jBh70-0005PV-HO
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:48:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29437
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jBh70-0005NR-DI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583855286;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SXPiD0RK2RHx+SHhJV9XF8L0S5Hl7rdffyH3WXYMKAc=;
 b=GDtjOt0TNNl5dMAANx27ECgNhIXz0NPbbCnDEvYgGbrAOGE1WZU0nD8zguf9lR1V2E5m8k
 6ZU919Z8v7lNPsf8UhuVYEm0nmc5ngnvKRdTyANXCTYRlrjYh1yLDjoM/+nmyaSz9jbe/C
 ZrQHN2yVewmSKTB1aA+LFGXD7Ygq/iA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-TB-07bEMPY-JZvfe6vKg9Q-1; Tue, 10 Mar 2020 11:47:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B72DD8017CC;
 Tue, 10 Mar 2020 15:47:54 +0000 (UTC)
Received: from redhat.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AD3A100164D;
 Tue, 10 Mar 2020 15:47:52 +0000 (UTC)
Date: Tue, 10 Mar 2020 15:47:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Subject: Re: [PATCH v2 1/1] modules: load modules from versioned /var/run dir
Message-ID: <20200310154749.GK3234052@redhat.com>
References: <20200310145806.18335-1-christian.ehrhardt@canonical.com>
 <20200310145806.18335-2-christian.ehrhardt@canonical.com>
MIME-Version: 1.0
In-Reply-To: <20200310145806.18335-2-christian.ehrhardt@canonical.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: TB-07bEMPY-JZvfe6vKg9Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>, Cole Robinson <crobinso@redhat.com>,
 qemu-devel@nongnu.org, pkg-qemu-devel@lists.alioth.debian.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 03:58:06PM +0100, Christian Ehrhardt wrote:
> On upgrades the old .so files usually are replaced. But on the other
> hand since a qemu process represents a guest instance it is usually kept
> around.
>=20
> That makes late addition of dynamic features e.g. 'hot-attach of a ceph
> disk' fail by trying to load a new version of e.f. block-rbd.so into an
> old still running qemu binary.
>=20
> This adds a fallback to also load modules from a versioned directory in t=
he
> temporary /var/run path. That way qemu is providing a way for packaging
> to store modules of an upgraded qemu package as needed until the next reb=
oot.
>=20
> An example how that can then be used in packaging can be seen in:
> https://git.launchpad.net/~paelzer/ubuntu/+source/qemu/log/?h=3Dbug-18473=
61-miss-old-so-on-upgrade-UBUNTU
>=20
> Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1847361
> Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> ---
>  configure     | 15 +++++++++++++++
>  util/module.c | 14 ++++++++++++++
>  2 files changed, 29 insertions(+)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


