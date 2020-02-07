Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A768C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DABD720838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PU8zoDcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABD720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00Y5-0007fB-3Y
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j00XA-0006Np-Ie
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j00X9-0007Cl-2x
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:06:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29327
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j00X8-00077p-TY
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581070006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SIZFtYQeEvKsn0u7qFVvx0X0aCx4W1/akOWDOSI0V4k=;
 b=PU8zoDcGSfFkH75LFQgR3QYQGLmtS5/mhvu/H+4ATjG9MRwC5fBTSQkLG3FZQF/jXkpC9/
 vQbV5xA7e4Knlv2NKzoPI33/N1KCGdHG6n5tneK33aelcvLUnIJpBcd6vr6UoPKiqaOdrh
 AVGNx0WN/NY7LufnjL9OZjt865GwQyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-KaYzmmwPOcOcbKc2nw7CJA-1; Fri, 07 Feb 2020 05:06:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DF161417;
 Fri,  7 Feb 2020 10:06:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C92DE1001B28;
 Fri,  7 Feb 2020 10:06:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5630111386A7; Fri,  7 Feb 2020 11:06:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 12/29] qapi: Explicitly put "foo: dropped in n.n" notes
 into Notes section
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-13-peter.maydell@linaro.org>
Date: Fri, 07 Feb 2020 11:06:34 +0100
In-Reply-To: <20200206173040.17337-13-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 6 Feb 2020 17:30:23 +0000")
Message-ID: <87mu9usod1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: KaYzmmwPOcOcbKc2nw7CJA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
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
> Put all of these explicitly into Notes: sections (either
> preexisting or new), with the right indentation, and
> standardising on quoting of the symbol with ''.
>
> In the case of QKeyCode, the generated docs were actively
> misformatted:
>    ac_bookmarks
>         since 2.10 altgr, altgr_r: dropped in 2.10
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qapi/machine.json | 2 +-
>  qapi/net.json     | 6 +++---
>  qapi/ui.json      | 3 ++-
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 704b2b0fe31..51ffa96be98 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -20,7 +20,7 @@
>  #        prefix to produce the corresponding QEMU executable name. This
>  #        is true even for "qemu-system-x86_64".
>  #
> -# ppcemb: dropped in 3.1
> +#        'ppcemb': dropped in 3.1
>  #
>  # Since: 3.0
>  ##
> diff --git a/qapi/net.json b/qapi/net.json
> index 109eff71cd4..8fbcbc611b9 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -447,7 +447,7 @@
>  #
>  # Since: 2.7
>  #
> -# 'dump': dropped in 2.12
> +# Notes: 'dump': dropped in 2.12
>  ##
>  { 'enum': 'NetClientDriver',
>    'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> @@ -464,7 +464,7 @@
>  #
>  # Since: 1.2
>  #
> -# 'l2tpv3' - since 2.1
> +# Notes: 'l2tpv3' - since 2.1
>  ##
>  { 'union': 'Netdev',
>    'base': { 'id': 'str', 'type': 'NetClientDriver' },
> @@ -494,7 +494,7 @@
>  #
>  # Since: 1.2
>  #
> -# 'vlan': dropped in 3.0
> +# Notes: 'vlan': dropped in 3.0
>  ##
>  { 'struct': 'NetLegacy',
>    'data': {
> diff --git a/qapi/ui.json b/qapi/ui.json
> index 94a07318f55..6da52b81143 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -776,7 +776,6 @@
>  # @ac_forward: since 2.10
>  # @ac_refresh: since 2.10
>  # @ac_bookmarks: since 2.10
> -# altgr, altgr_r: dropped in 2.10
>  #
>  # @muhenkan: since 2.12
>  # @katakanahiragana: since 2.12
> @@ -790,6 +789,8 @@
>  #
>  # Since: 1.3.0
>  #
> +# Notes: - 'altgr': dropped in 2.10
> +#        - 'altgr_r': dropped in 2.10
>  ##
>  { 'enum': 'QKeyCode',
>    'data': [ 'unmapped',

I'm not sure the "dropped in" notes are worth their keep.  One, they are
too incomplete to be of much use.  Two, I think qemu-deprecated.texi is
a better home for this kind of information.  Easier to consume for the
people who need to know.  In particular, they can watch the sausage
being made by getting themselves added to MAINTAINERS section
"Incompatible changes".

If we decide we want to document "dropped in" in the schema, then we
need to make an effort to reconstruct the missing ones.  Also, members
names should use @name markup, not 'name'.

Cc'ing people ratted out by git-log -S'dropped in'.


