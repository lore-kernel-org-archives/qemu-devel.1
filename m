Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A464C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601DB2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VczASS9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601DB2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTihO-0001KZ-In
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1jTigE-00089A-OB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1jTicG-0000r0-Jg
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:06:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57637
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1jTicG-0000qg-54
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588150971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VjuPXPbccSFQy8fOsNiTPUHFYKf6nayM6E1JXRNDJ6M=;
 b=VczASS9ncgr0QETm2YNL+NtTI5d/7IwR/Fq5LmXFUPL3xn6Ps0cyFx843HinZDYnW0kaaG
 lGVgTRw37xE6jvQIe2hUgZibHZnUJTdZzuL35pupjp183LY7qjCJNKhp20MRGeK4k7vuq2
 xbb9QbLGd7lJmEYpLXqqCN2xdvIL2Lw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-SBYtuLzjO8mGBmNckwebEA-1; Wed, 29 Apr 2020 05:02:47 -0400
X-MC-Unique: SBYtuLzjO8mGBmNckwebEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14D0280B71D;
 Wed, 29 Apr 2020 09:02:46 +0000 (UTC)
Received: from localhost (ovpn-112-30.ams2.redhat.com [10.36.112.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFEE05D77C;
 Wed, 29 Apr 2020 09:02:38 +0000 (UTC)
Date: Wed, 29 Apr 2020 10:02:37 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 9/9] block: Drop unused .bdrv_has_zero_init_truncate
Message-ID: <20200429090237.GR3888@redhat.com>
References: <20200428202905.770727-1-eblake@redhat.com>
 <20200428202905.770727-10-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200428202905.770727-10-eblake@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, "open list:Sheepdog" <sheepdog@lists.wpkg.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Liu Yuan <namei.unix@gmail.com>,
 Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 28, 2020 at 03:29:05PM -0500, Eric Blake wrote:
> Now that there are no clients of bdrv_has_zero_init_truncate, none of
> the drivers need to worry about providing it.
>=20
> What's more, this eliminates a source of some confusion: a literal
> reading of the documentation as written in ceaca56f and implemented in
> commit 1dcaf527 claims that a driver which returns 0 for
> bdrv_has_zero_init_truncate() must not return 1 for
> bdrv_has_zero_init(); this condition was violated for parallels, qcow,
> and sometimes for vdi, although in practice it did not matter since
> those drivers also lacked .bdrv_co_truncate.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
...
> diff --git a/block/ssh.c b/block/ssh.c
> index f9e08a490069..098dbe03c15b 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -1397,7 +1397,6 @@ static BlockDriver bdrv_ssh =3D {
>      .bdrv_co_create_opts          =3D ssh_co_create_opts,
>      .bdrv_close                   =3D ssh_close,
>      .bdrv_has_zero_init           =3D ssh_has_zero_init,
> -    .bdrv_has_zero_init_truncate  =3D ssh_has_zero_init,
>      .bdrv_co_readv                =3D ssh_co_readv,
>      .bdrv_co_writev               =3D ssh_co_writev,
>      .bdrv_getlength               =3D ssh_getlength,

This part seems fine, so ACK.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/


