Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B700C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 07:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA0D204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 07:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNBbWQO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA0D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZrha-0007Dn-Iy
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 02:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZrgh-0006UT-VN
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZrgf-00064O-Uo
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:24:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21366
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZrgd-00062O-Uv
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 02:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574839469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02w5vcI35zyQ5ijf/Fd2dH1O1EzoqX3iggwHrHr/jh4=;
 b=XNBbWQO5/dtJYEf/aGeb/ga/js0gumrUDYLiPoPJexl6lfR0I2DOgvB78bpLiVpzfKIdjq
 k2JYfTZQUakoP5x2HavU454jymu5+wgnFTcBAogDoGW5tQuCMIFN/fvqCvxt0157HbJrJy
 PfpiQqsnnhKpVH6Oj7YWYEwe6ahnen4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-mZKRo0hRM0W-gto1z-BvQw-1; Wed, 27 Nov 2019 02:24:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 671A78017CC;
 Wed, 27 Nov 2019 07:24:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33C3F5D6C8;
 Wed, 27 Nov 2019 07:24:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D6A081138606; Wed, 27 Nov 2019 08:24:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 5/9] monitor: move hmp_block_job* to blockdev-hmp-cmd.c
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-6-mlevitsk@redhat.com>
Date: Wed, 27 Nov 2019 08:24:23 +0100
In-Reply-To: <20191120185850.18986-6-mlevitsk@redhat.com> (Maxim Levitsky's
 message of "Wed, 20 Nov 2019 20:58:46 +0200")
Message-ID: <87r21tkcig.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: mZKRo0hRM0W-gto1z-BvQw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  blockdev-hmp-cmds.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  monitor/hmp-cmds.c  | 52 ---------------------------------------------
>  2 files changed, 52 insertions(+), 52 deletions(-)
>
> diff --git a/blockdev-hmp-cmds.c b/blockdev-hmp-cmds.c
> index 5ae899a324..e333de27b1 100644
> --- a/blockdev-hmp-cmds.c
> +++ b/blockdev-hmp-cmds.c
> @@ -238,3 +238,55 @@ void hmp_drive_backup(Monitor *mon, const QDict *qdi=
ct)
>      hmp_handle_error(mon, &err);
>  }
> =20
> +

Is this extra blank line intentional?

> +void hmp_block_job_set_speed(Monitor *mon, const QDict *qdict)
> +{
> +    Error *error =3D NULL;
> +    const char *device =3D qdict_get_str(qdict, "device");
> +    int64_t value =3D qdict_get_int(qdict, "speed");
> +
> +    qmp_block_job_set_speed(device, value, &error);
> +
> +    hmp_handle_error(mon, &error);
> +}
[...]


