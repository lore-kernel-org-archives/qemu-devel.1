Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A554CC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2E92075A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaS6sDoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2E92075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iooWf-0001vF-Tb
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ionHS-0001tY-Em
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ionHR-0001TJ-3p
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:44:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46863
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ionHQ-0001Sz-W7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578397452;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3LXvuItYxR7i6atdM1wGlIGqNwTRKmjKMcgCDbOvGGc=;
 b=BaS6sDoTB9s2EQwab+0X4v9mONrbkIOVmhYYLR4Pt4t0qZ3csYzXap5xkm6hUsTyRW6T8z
 y+Ljno6WH2Y6mfi0JLNIt0IWej5kf1Tcid56tmIpQBFUv4IX9RtuX4hapN1unPqVl7kzGi
 bPD95c7n4yhDjzJkpEL/Hr5cwlENsB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-mjQa46niNaGU_31Pkz-j0g-1; Tue, 07 Jan 2020 06:44:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13086911EA
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 11:44:10 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0AC960C88;
 Tue,  7 Jan 2020 11:44:00 +0000 (UTC)
Date: Tue, 7 Jan 2020 11:43:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 081/104] virtiofsd: Prevent multiply running with same
 vhost_user_socket
Message-ID: <20200107114357.GV3368802@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-82-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-82-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: mjQa46niNaGU_31Pkz-j0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:38:41PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>=20
> virtiofsd can run multiply even if the vhost_user_socket is same path.
>=20
>   ]# ./virtiofsd -o vhost_user_socket=3D/tmp/vhostqemu -o source=3D/tmp/s=
hare &
>   [1] 244965
>   virtio_session_mount: Waiting for vhost-user socket connection...
>   ]# ./virtiofsd -o vhost_user_socket=3D/tmp/vhostqemu -o source=3D/tmp/s=
hare &
>   [2] 244966
>   virtio_session_mount: Waiting for vhost-user socket connection...
>   ]#
>=20
> The user will get confused about the situation and maybe the cause of the
> unexpected problem. So it's better to prevent the multiple running.
>=20
> Create a regular file under localstatedir directory to exclude the
> vhost_user_socket. To create and lock the file, use qemu_write_pidfile()
> because the API has some sanity checks and file lock.
>=20
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>   Applied fixes from Stefan's review and moved osdep include
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/fuse_lowlevel.c |  1 +
>  tools/virtiofsd/fuse_virtio.c   | 49 ++++++++++++++++++++++++++++++++-
>  2 files changed, 49 insertions(+), 1 deletion(-)

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


