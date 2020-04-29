Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3EAC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743A42076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRM5B/e3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743A42076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTigi-0008RA-HK
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1jTibB-0001Kd-M2
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1jTiap-0002Zw-Ap
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:01:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34661
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1jTiao-0002Q4-QF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588150881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WGV1onOfjI+5skUtn2kngiT8PAxVHslHeJ0ELlbc0sk=;
 b=CRM5B/e3PJayl1VRqAu0FqDmgxYCAF8cDgPvTiFdL3I+Lsfv2yrkj9Hpbyri0Qkyy2saob
 xztwa4pdHaKQD3xfSIJhSqHxT0hQeh35J4mOiFK9cb1kIddf5w2m9tOiITKHScOI56j4KS
 V0VTS9adG3vNtr14T+t9mRxswmCXqQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-VzTelW5EPhaprbGU9l6jHQ-1; Wed, 29 Apr 2020 05:01:17 -0400
X-MC-Unique: VzTelW5EPhaprbGU9l6jHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E7371800D4A;
 Wed, 29 Apr 2020 09:01:14 +0000 (UTC)
Received: from localhost (ovpn-112-30.ams2.redhat.com [10.36.112.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D31A910013BD;
 Wed, 29 Apr 2020 09:01:13 +0000 (UTC)
Date: Wed, 29 Apr 2020 10:01:12 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 6/9] ssh: Support BDRV_REQ_ZERO_WRITE for truncate
Message-ID: <20200429090112.GQ3888@redhat.com>
References: <20200428202905.770727-1-eblake@redhat.com>
 <20200428202905.770727-7-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200428202905.770727-7-eblake@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=rjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 28, 2020 at 03:29:02PM -0500, Eric Blake wrote:
> Our .bdrv_has_zero_init_truncate can detect when the remote side
> always zero fills; we can reuse that same knowledge to implement
> BDRV_REQ_ZERO_WRITE by ignoring it when the server gives it to us for
> free.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/ssh.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/block/ssh.c b/block/ssh.c
> index 9eb33df8598c..f9e08a490069 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -883,6 +883,10 @@ static int ssh_file_open(BlockDriverState *bs, QDict=
 *options, int bdrv_flags,
>      /* Go non-blocking. */
>      ssh_set_blocking(s->session, 0);
>=20
> +    if (s->attrs->type =3D=3D SSH_FILEXFER_TYPE_REGULAR) {
> +        bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;
> +    }
> +

As the libssh sftp API is written this is all fine, so ACK:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

On the other hand the actual openssh / libssh code is a bit hairy.
Openssh simply copies the st_mode field onto the wire (with
byte-swapping).  Libssh assumes that S_IFREG =3D=3D 0100000 and translates
this bit to SSH_FILEXFER_TYPE_REGULAR.  This happens to be true on
Linux and *BSD but as far as I can tell isn't defined in POSIX.
Anyway I guess it'll work in all places that we care about.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top


