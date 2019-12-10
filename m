Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878FEC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E7B20726
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4k4kdVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E7B20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iedMj-0003qW-HX
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 06:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iedLn-00032s-9Y
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iedLl-0004oS-Qg
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:06:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40321
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iedLl-0004ns-Lg
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575976000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n1ypnUIu0Gg7Pqf/duP2UEnxSpPTACDf4UXgAc3+bQw=;
 b=Z4k4kdVzBW0K+fSXPN7264itUSm5lDFwSBAahIXW/GH7pRt38NZ2dkfN9K3iLraUqJfYFQ
 lV8VRjzZZl1dMufwYLtcLd9pCvu3SrGjWfcSeRh+lh3EUHQyC3F0B1g21WM2/I+uX6kO42
 PIAceMzLVpPdAxAm6GgxYl5k2ERhAfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-PpIuBbjXPte093oEJGRPPA-1; Tue, 10 Dec 2019 06:06:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03BB1A1A74
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 11:06:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-181.ams2.redhat.com
 [10.36.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47AE06E501;
 Tue, 10 Dec 2019 11:06:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D0BF311386A7; Tue, 10 Dec 2019 12:06:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/2] net: Drop the legacy "name" parameter from the -net
 option
References: <20191206053640.29368-1-thuth@redhat.com>
 <20191206053640.29368-2-thuth@redhat.com>
Date: Tue, 10 Dec 2019 12:06:30 +0100
In-Reply-To: <20191206053640.29368-2-thuth@redhat.com> (Thomas Huth's message
 of "Fri, 6 Dec 2019 06:36:39 +0100")
Message-ID: <878snk30eh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: PpIuBbjXPte093oEJGRPPA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: libvir-list@redhat.com, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> It's been deprecated since QEMU v3.1, so it's time to finally
> remove it. The "id" parameter can simply be used instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
[...]
> diff --git a/qapi/net.json b/qapi/net.json
> index 335295be50..ff280ccd16 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -488,18 +488,16 @@
>  #
>  # @id: identifier for monitor commands
>  #
> -# @name: identifier for monitor commands, ignored if @id is present
> -#
>  # @opts: device type specific properties (legacy)
>  #
>  # Since: 1.2
>  #
>  # 'vlan': dropped in 3.0
> +# 'name': dropped in 5.0
>  ##

Uh, when did we start to add "dropped in" to our doc comments?

We should either do this systematically, or not at all.  If the former,
we have quite a few "dropped in" to add belatedly.

I vote for "not at all".

>  { 'struct': 'NetLegacy',
>    'data': {
>      '*id':   'str',
> -    '*name': 'str',
>      'opts':  'NetLegacyOptions' } }
> =20
>  ##
[...]

History:

$ git-log -S"dropped in" -- qapi qapi-schema.json
commit ffaee83bcb28913b8b854aeab78b1a1f2115712d
Author: Markus Armbruster <armbru@redhat.com>
Date:   Tue Jul 9 17:20:53 2019 +0200

    qapi: Move query-target from misc.json to machine.json
   =20
    Move query-target and its return type TargetInfo from misc.json to
    machine.json, where they are covered by MAINTAINERS section "Machine
    core".  Also move its implementation from arch_init.c to
    hw/core/machine-qmp-cmds, where it is likewise covered.
   =20
    All users of SysEmuTarget are now in machine.json.  Move it there from
    common.json.
   =20
    Signed-off-by: Markus Armbruster <armbru@redhat.com>
    Message-Id: <20190709152053.16670-3-armbru@redhat.com>

commit 416756cc049006ab8a05fe39e5f2e6af25cad9d2
Author: Thomas Huth <thuth@redhat.com>
Date:   Tue Aug 21 13:27:48 2018 +0200

    Record history of ppcemb target in common.json
   =20
    We recently removed the long deprecated "ppcemb" target.  This adds a
    comment in common.json about the SysEmuTarget type, recording when it w=
as
    removed.
   =20
    Suggested-by: Eric Blake <eblake@redhat.com>
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

commit 4088b5536436090207dcf6d15e47908f74b2d8f2
Author: Thomas Huth <thuth@redhat.com>
Date:   Tue May 15 18:26:20 2018 +0200

    qapi/net.json: Fix the version number of the "vlan" removal
   =20
    "vlan" will be dropped in 2.13, not in 2.12. And while we're at it,
    use the better wording "dropped in" instead of "removed with" (also
    for the "dump" removal).
   =20
    Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
    Reported-by: Eric Blake <eblake@redhat.com>
    Signed-off-by: Thomas Huth <thuth@redhat.com>
    Reviewed-by: Eric Blake <eblake@redhat.com>
    Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

commit 608cfed66a6adeac136b0c09cd62d081062256f3
Author: Markus Armbruster <armbru@redhat.com>
Date:   Thu Aug 24 21:14:00 2017 +0200

    qapi-schema: Collect UI stuff in qapi/ui.json
   =20
    UI stuff is remote desktop stuff (Spice, VNC) and input stuff (mouse,
    keyboard).
   =20
    Cc: Gerd Hoffmann <kraxel@redhat.com>
    Signed-off-by: Markus Armbruster <armbru@redhat.com>
    Message-Id: <1503602048-12268-9-git-send-email-armbru@redhat.com>
    Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

commit 912092b8e47f31c3db25e088af8460d9e752da29
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Thu Jul 27 12:47:20 2017 +0200

    ui: drop altgr and altgr_r QKeyCodes
   =20
    The right alt key (alt_r aka KEY_RIGHTALT) is used for AltGr.
    The altgr and altgr_r keys simply don't exist.  Drop them.
   =20
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
    Reviewed-by: Eric Blake <eblake@redhat.com>
    Message-id: 20170727104720.30061-1-kraxel@redhat.com


