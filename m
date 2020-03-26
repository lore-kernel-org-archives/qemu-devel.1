Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0515AC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A1320737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOqw51jO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A1320737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSb7-0004gq-Uy
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jHSYv-0002ZW-SR
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jHSYu-0004oy-Vu
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:28:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48517)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jHSYt-0004oB-7y
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585229322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4WBg5CNHrCX+HnopXFTzXesaQuWuulC8fl8X7FIBpDQ=;
 b=UOqw51jONNpvfGxTFMNc8mJufWb2JPhOuF8ez7gjzkidNC6oMA/wy373I2AoEooZMfR2hp
 OrGguhuBnOHkU5r2u7MEUc9G+ifocysjBmNq72/kYZ/9mgtTv/Y9uQLUnGWSoS8ozNIW56
 5hUIOskjMTEEIw/MSF0Y33is4Yanp/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-ROd7EWlGOAiYBC1yEss5vg-1; Thu, 26 Mar 2020 09:28:40 -0400
X-MC-Unique: ROd7EWlGOAiYBC1yEss5vg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ECA11005509;
 Thu, 26 Mar 2020 13:28:38 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-205.ams2.redhat.com [10.36.112.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B88475D9CD;
 Thu, 26 Mar 2020 13:28:29 +0000 (UTC)
Date: Thu, 26 Mar 2020 14:28:28 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 2/2] block: trickle down the fallback image creation
 function use to the block drivers
Message-ID: <20200326132828.GC7391@linux.fritz.box>
References: <20200326011218.29230-1-mlevitsk@redhat.com>
 <20200326011218.29230-3-mlevitsk@redhat.com>
 <922a6eb5-cb33-d2e4-ba0b-15078d1a6c59@redhat.com>
MIME-Version: 1.0
In-Reply-To: <922a6eb5-cb33-d2e4-ba0b-15078d1a6c59@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, integration@gluster.org,
 sheepdog@lists.wpkg.org, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Liu Yuan <namei.unix@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 26.03.2020 um 14:20 hat Eric Blake geschrieben:
> > +++ b/block/file-posix.c
> > @@ -3513,6 +3513,8 @@ static BlockDriver bdrv_host_device =3D {
> >       .bdrv_reopen_prepare =3D raw_reopen_prepare,
> >       .bdrv_reopen_commit  =3D raw_reopen_commit,
> >       .bdrv_reopen_abort   =3D raw_reopen_abort,
> > +    .bdrv_co_create_opts =3D bdrv_co_create_opts_simple,
> > +    .create_opts         =3D &bdrv_create_opts_simple,
>=20
> I'd drop the leading & for consistency with the rest of this struct
> initializer.

This one isn't a function pointer, so I think the & is necessary.

Kevin


