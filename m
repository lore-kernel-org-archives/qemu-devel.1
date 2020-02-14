Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42033C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0512082F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQrIJMAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0512082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Utu-0005QI-8f
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 01:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2UtK-00051p-4h
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:55:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2UtI-0002fB-6d
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:55:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45395
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2UtI-0002d6-1o
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581663354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/mLPGiBPTq+s99qKKdl/AHlfI9wooOHUZwuTwLONqAw=;
 b=NQrIJMAp2SwnBpN3kWD1KotFqHTq6DAJTuBVg9CE2CGSaEx/7/KBuECkUgAjJubBry2JUL
 q7ciKDg0WDj1i888x20EHzNlFTwD5OVf+SaaaFJXvvZeLybpN94dc1GEl3YgRIpAWKO/Mh
 gJgS/NQkv8D5PVN4kR+uTBYkgYPLEL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-Fv4SI1MpOSeIc8yaAn9FjQ-1; Fri, 14 Feb 2020 01:55:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 962188017CC;
 Fri, 14 Feb 2020 06:55:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5018F19E9C;
 Fri, 14 Feb 2020 06:55:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB56511385C9; Fri, 14 Feb 2020 07:55:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 18/30] qapi: Delete all the "foo: dropped in n.n" notes
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-19-peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 07:55:46 +0100
In-Reply-To: <20200213175647.17628-19-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 13 Feb 2020 17:56:35 +0000")
Message-ID: <87pneh1wul.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Fv4SI1MpOSeIc8yaAn9FjQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> A handful of QAPI doc comments include lines like
> "ppcemb: dropped in 3.1". The doc comment parser will just
> put these into whatever the preceding section was; sometimes
> that's "Notes", and sometimes it's some random other section,
> as with "NetClientDriver" where the "'dump': dropped in 2.12"
> line ends up in the "Since:" section.
>
> This tends to render wrongly, more so in the upcoming rST
> generator, but sometimes even in the texinfo, as in the case
> of QKeyCode:
>    ac_bookmarks
>        since 2.10 altgr, altgr_r: dropped in 2.10
>
> We now have a better place to tell users about deprecated
> and deleted functionality -- qemu-deprecated.texi.
> So just remove all these "dropped in" remarks entirely.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Perhaps qemu-deprecated.texi should be updated -- Markus
> said he'd look into that. So this patch is to some extent
> a placeholder to get these broken bits of doc comment out
> of the way.

The appropriate place is appendix "Recently removed features", which
appeared in commit 3264ffced3 "dirty-bitmaps: remove deprecated autoload
parameter", v4.2.0.  We did not document any prior removals then.

Perhaps we should systematically document all removals since v4.1.0.  I
can look into that.

I'm not sure documenting older removals now is worth our while.  If you
think it is, let me know.

All the 'dropped in' notes removed in this patch are older.  Nothing to
do for qemu-deprecated.texi unless we choose to systematically document
older removals.

> ---
>  qapi/machine.json | 2 --
>  qapi/net.json     | 4 ----
>  qapi/ui.json      | 1 -
>  3 files changed, 7 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 704b2b0fe31..6c11e3cf3a4 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -20,8 +20,6 @@
>  #        prefix to produce the corresponding QEMU executable name. This
>  #        is true even for "qemu-system-x86_64".
>  #
> -# ppcemb: dropped in 3.1
> -#
>  # Since: 3.0
>  ##
>  { 'enum' : 'SysEmuTarget',

This is SysEmuTarget.  Visible in QMP query-target and query-cpus-fast.

> diff --git a/qapi/net.json b/qapi/net.json
> index 80dcf0df06e..1cb9a7d782b 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -446,8 +446,6 @@
>  # Available netdev drivers.
>  #
>  # Since: 2.7
> -#
> -# 'dump': dropped in 2.12
>  ##
>  { 'enum': 'NetClientDriver',
>    'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',

This is enum NetClientDriver.  Visible in QMP netdev_add and -netdev.

> @@ -493,8 +491,6 @@
>  # @opts: device type specific properties (legacy)
>  #
>  # Since: 1.2
> -#
> -# 'vlan': dropped in 3.0
>  ##
>  { 'struct': 'NetLegacy',
>    'data': {

This is struct NetLegacy.  Visible in -net, I think.

> diff --git a/qapi/ui.json b/qapi/ui.json
> index 89126da395b..e16e98a060d 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -779,7 +779,6 @@
>  # @ac_forward: since 2.10
>  # @ac_refresh: since 2.10
>  # @ac_bookmarks: since 2.10
> -# altgr, altgr_r: dropped in 2.10
>  #
>  # @muhenkan: since 2.12
>  # @katakanahiragana: since 2.12

This is enum QKeyCode.  Visible in QMP send-key arguments.


