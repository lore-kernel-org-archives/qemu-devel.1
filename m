Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1949C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84392072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cV1SbPcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84392072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6CAK-0003S6-Qd
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 06:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1j6C9g-000330-Ha
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1j6C9f-00028K-Dx
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:44:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46118
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1j6C9f-00028D-9H
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582544646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqjeL9elM34+DRT35i6Rrj3lAQACibs0F0yxjpbe1ng=;
 b=cV1SbPcxQR4b8orqupn0kq8wepZVx/nwD/OINAjqu91AZrvo7m818c7y9o+nN62IezwqCE
 CN6zOHhRn4FSymSr4Qq4D0j9ZSzTTOljAsoio8wcdqrsAT7S+iYK8I4Cx+J4LsI5QVape1
 S7XdwAYZOnOi5FrpyoeuvoCiv8wQTrQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-0MAFI2GsPi-tkR_vqc9N0w-1; Mon, 24 Feb 2020 06:44:04 -0500
X-MC-Unique: 0MAFI2GsPi-tkR_vqc9N0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF2361005510;
 Mon, 24 Feb 2020 11:44:03 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-177.brq.redhat.com [10.40.204.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B73C60BF3;
 Mon, 24 Feb 2020 11:43:59 +0000 (UTC)
Date: Mon, 24 Feb 2020 12:43:56 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 0/3] Tighten qemu-img rules on missing backing format
Message-ID: <20200224114356.GD3296@andariel.pipo.sk>
References: <20200222112341.4170045-1-eblake@redhat.com>
 <20200224110145.GB3296@andariel.pipo.sk>
MIME-Version: 1.0
In-Reply-To: <20200224110145.GB3296@andariel.pipo.sk>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: Error: Can't connect to API
 socket.
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 12:01:45 +0100, Peter Krempa wrote:
> On Sat, Feb 22, 2020 at 05:23:38 -0600, Eric Blake wrote:

[...]

> > libvirt HAS to use blockdev-open on the backing chain and supply a
> > backing format there, and thus has to probe images.  If libvirt ever
> > probes differently than qemu, we are back to the potential
> > guest-visible data corruption or potential host CVEs.
>=20
> As I've elaborated in [1] I disagree with the host CVE part. The

[1] https://www.redhat.com/archives/libvir-list/2020-February/msg00624.html

> insecure part is not probing the format itself, but probing format AND
> using the backing file of the image if we probed format.


