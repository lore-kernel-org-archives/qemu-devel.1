Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B443EC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE02205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyJJHyIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE02205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDpRj-0001Oa-8j
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 09:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jDo6R-0005WU-6P
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jDo6Q-0004x3-18
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:40:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29796
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jDo6O-0004kV-QL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584358812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VwRmbCExmYCNVMWyVPJ4VZXF7rudjH6YT+M5qS1APn0=;
 b=KyJJHyInCrmTgj/YgJ6TXX126pk4N5ceWvn69dp7dRKq0DjHurhQEXWzh8WL5MsCPeeJ3D
 C94BWaaWTjzOK93pHLtB2g9zXL5H18QOK5nup1ndG9EQdyUXq+5h9DkwtMq+DRNciZAehM
 AEfbxg+473hhwNAdRUgv/AXdIEY/Ob8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-A759pUnKNkSOWtUsyrC9RA-1; Mon, 16 Mar 2020 07:40:10 -0400
X-MC-Unique: A759pUnKNkSOWtUsyrC9RA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E63A1005509;
 Mon, 16 Mar 2020 11:40:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3B6A92D50;
 Mon, 16 Mar 2020 11:40:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C4B309AF5; Mon, 16 Mar 2020 12:40:07 +0100 (CET)
Date: Mon, 16 Mar 2020 12:40:07 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [PATCH 1/4] usb-serial: Move USB_TOKEN_IN into a helper function
Message-ID: <20200316114007.a4aie3vszsplkttq@sirius.home.kraxel.org>
References: <20200312125524.7812-1-jandryuk@gmail.com>
 <20200312125524.7812-2-jandryuk@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200312125524.7812-2-jandryuk@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> +    if (len > s->recv_used)
> +        len =3D s->recv_used;

scripts/checkpatch.pl flags a codestyle error here.

> -        if (len > s->recv_used)
> -            len =3D s->recv_used;

Which is strictly speaking not your fault as you are just moving around
existing code.  It's common practice though that codestyle is fixed up
too when touching code.  Any chance you can make sure the patches pass
checkpatch & resend?

thanks,
  Gerd


