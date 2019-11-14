Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A678FC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 03:00:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B818D206E4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 03:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/x1lygF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B818D206E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV5NI-0003iy-LH
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 22:00:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iV5MT-0003EM-0L
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 21:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iV5MR-0000Hz-Em
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 21:59:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iV5MR-0000GO-1Z
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 21:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573700394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X31Ul619DDj+Iot/r9lrnyO5ViX6bDUXJiQI42b0Z40=;
 b=V/x1lygFupw6AFiXtYEXqGOvNQY/1idUV1xicy/icztpil0x28x4awBruCbHm/D2AxxQFZ
 Fhst1+OVXcvqeMq3wpkAOXWLH35LDxDPJOgkfxr2CW20SIvHAKo/mV9HCy0kYJ0+W02W/b
 y6HG7qM4kF04Z85JZWDZHlYuCBEGjDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-G4pTlZsjN6iJBx8BtHnJ-Q-1; Wed, 13 Nov 2019 21:59:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8C26A189E;
 Thu, 14 Nov 2019 02:59:49 +0000 (UTC)
Received: from [10.3.116.242] (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2639E10C9F0A;
 Thu, 14 Nov 2019 02:59:48 +0000 (UTC)
Subject: Re: [PATCH v3 1/4] nbd/server: Prefer heap over stack for parsing
 client names
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20191114024635.11363-1-eblake@redhat.com>
 <20191114024635.11363-2-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <304af45f-673b-a481-7674-9cf4f35c9111@redhat.com>
Date: Wed, 13 Nov 2019 20:59:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191114024635.11363-2-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: G4pTlZsjN6iJBx8BtHnJ-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/13/19 8:46 PM, Eric Blake wrote:
> As long as we limit NBD names to 256 bytes (the bare minimum permitted
> by the standard), stack-allocation works for parsing a name received
> from the client.  But as mentioned in a comment, we eventually want to
> permit up to the 4k maximum of the NBD standard, which is too large
> for stack allocation; so switch everything in the server to use heap
> allocation.  For now, there is no change in actually supported name
> length.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   include/block/nbd.h | 10 +++++-----
>   nbd/server.c        | 25 +++++++++++++++----------
>   2 files changed, 20 insertions(+), 15 deletions(-)

> @@ -427,7 +431,7 @@ static void nbd_check_meta_export(NBDClient *client)
>   static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_=
zeroes,
>                                               Error **errp)
>   {
> -    char name[NBD_MAX_NAME_SIZE + 1];
> +    g_autofree char *name;

This needs to be:

g_autofree char *name =3D NULL;

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


