Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C810C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A57C2083E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SU4vKKno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A57C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j95sp-0002iM-83
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 06:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j95rc-0001VD-AC
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j95rb-00070u-5e
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:37:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36503
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j95rb-00070m-2A
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583235446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+eQxk25q/RrVlvkJRjwqS+xZaXeXBNTmaocXxTfoT2A=;
 b=SU4vKKno8aXT6RvYq0Jt6rRWsuNdKZ9rAxaGpfCHTiYZSbKrnSdUnv5Kmj7Rn6AwklUjNl
 FIkB8s2qhuq/ebZhsN2BPzkZ2Oc2QuVgct0/JjKA43WCk9C8CZDWPA2lcuOHgUzk8/hMYB
 8WoYAPnjBE8QP9LXNAuX1gHWuz8SiFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-pwNSoa4LPJWqsye6_oWkaQ-1; Tue, 03 Mar 2020 06:37:24 -0500
X-MC-Unique: pwNSoa4LPJWqsye6_oWkaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30F0D19251A6;
 Tue,  3 Mar 2020 11:37:23 +0000 (UTC)
Received: from work-vm (ovpn-117-2.ams2.redhat.com [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A20D291D6A;
 Tue,  3 Mar 2020 11:37:19 +0000 (UTC)
Date: Tue, 3 Mar 2020 11:37:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: Re: [Virtio-fs] [PATCH v4 0/2] virtiofsd: Fix xattr operations
Message-ID: <20200303113717.GD3170@work-vm>
References: <20200227055927.24566-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <20200227055927.24566-1-misono.tomohiro@jp.fujitsu.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Misono Tomohiro (misono.tomohiro@jp.fujitsu.com) wrote:
> Currently xattr operations on virtiofs does not work properly in some cas=
e:
>  - directory ... cannot set
>  - special files (pipe) ... cause hang
>=20
> This fixes these problems and now xfstests generic/062 passes on virtiofs
> with -o xattr option (I tested with xfs).
>=20
> v3 -> v4:
>  - No logic change
>  - Some code style fix/update comments and commit log as suggested by Viv=
ek
>  - CC qemu-devel ML too
>=20
> Previous versions can be found in virtiofs ML:
>  v3: https://www.redhat.com/archives/virtio-fs/2020-February/msg00032.htm=
l
>=20
> Thanks,

Thanks,

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

and queued.

(I suspect there's some more cleanup involved in the error paths in
those functions; I'll have a look another time).

Dave

> Misono Tomohiro (2):
>   virtiofsd: passthrough_ll: cleanup getxattr/listxattr
>   virtiofsd: Fix xattr operations
>=20
>  tools/virtiofsd/fuse_virtio.c    |  13 +++
>  tools/virtiofsd/passthrough_ll.c | 139 ++++++++++++++++---------------
>  tools/virtiofsd/seccomp.c        |   6 ++
>  3 files changed, 89 insertions(+), 69 deletions(-)
>=20
> --=20
> 2.21.1
>=20
>=20
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


