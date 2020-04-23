Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2759DC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:31:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F5E20736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtAjDRrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F5E20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRa53-0000Cl-1G
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 07:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jRa4E-0007o5-5G
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jRa4D-0005cK-Ni
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:30:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23901
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jRa4D-0005Y8-9T
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587641452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDqnqpzYGHtkBLlozguMHW9/eLX687kUZ09nt/UPbBI=;
 b=TtAjDRrrzxx46XtLN6LV5JLt15BnOr1tUz1sX9cctmlopyyOC53baODnxvsPdKEabA7vQN
 NnTJ4qhBbEYyHUYnSVruc1b47paqkMzjLrlT+okIqtIHddGjwx/0o569MJIOjrlp5dW2Hi
 ASj68six8lKJohVCf6P68dseEvY86EI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-G2AFXUvJO4uyTrq9pY8_Sw-1; Thu, 23 Apr 2020 07:30:50 -0400
X-MC-Unique: G2AFXUvJO4uyTrq9pY8_Sw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1719B100CC95
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 11:30:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 094D460F8D;
 Thu, 23 Apr 2020 11:30:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4FA881753B; Thu, 23 Apr 2020 13:30:44 +0200 (CEST)
Date: Thu, 23 Apr 2020 13:30:44 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 07/14] bochs-display: Fix vgamem=SIZE error handling
Message-ID: <20200423113044.2eqn7uy4lpqfiz26@sirius.home.kraxel.org>
References: <20200422130719.28225-1-armbru@redhat.com>
 <20200422130719.28225-8-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200422130719.28225-8-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 03:07:12PM +0200, Markus Armbruster wrote:
> bochs_display_realize() rejects out-of-range vgamem.  The error
> handling is broken:
>=20
>     $ qemu-system-x86_64 -S -display none -monitor stdio
>     QEMU 4.2.93 monitor - type 'help' for more information
>     (qemu) device_add bochs-display,vgamem=3D1
>     Error: bochs-display: video memory too small
>     (qemu) device_add bochs-display,vgamem=3D1
>     RAMBlock "0000:00:04.0/bochs-display-vram" already registered, abort!
>     Aborted (core dumped)
>=20
> Cause: bochs_display_realize() neglects to bail out after setting the
> error.  Fix that.
>=20
> Fixes: 765c94290863eef1fc4a67819d452cc13b7854a1
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>


