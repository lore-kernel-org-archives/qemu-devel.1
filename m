Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0795FC17441
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C6C20679
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtLxWNHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C6C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUYeC-0003Ua-TZ
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iUYdG-0002hH-QZ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:03:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iUYdE-0006B5-5h
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:03:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39121
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iUYdD-00069n-CK
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573574582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+b7McQt0TwaHOoMwGjoe08ORfp22kEQAN/32AGZ6qo=;
 b=JtLxWNHULNp1ixVjK8khYf/T4dRUd0F0XhTKQambfa3YYCMn/qKJeP1RFMt+Rs+LNGEz1G
 vMYShuP+zXz3lUqJKI127EPD5PHMtf9RdFkG04VV3nqjScIYHu6V8KsJ6++XKlCsh22KE4
 h/TQyH45RVx0+iIiDmIDjkeGEieNuPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-o8HPmG4GMAazvspV6vTEfg-1; Tue, 12 Nov 2019 11:01:15 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC3E6107ACC8;
 Tue, 12 Nov 2019 16:01:14 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5D9118213;
 Tue, 12 Nov 2019 16:01:12 +0000 (UTC)
Date: Tue, 12 Nov 2019 17:01:09 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/2] block: Remove 'backing': null from
 bs->{explicit_,}options
Message-ID: <20191112160109.GB163480@angien.pipo.sk>
References: <20191108085312.27049-1-kwolf@redhat.com>
 <20191108085312.27049-2-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191108085312.27049-2-kwolf@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: o8HPmG4GMAazvspV6vTEfg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 09:53:11 +0100, Kevin Wolf wrote:
> bs->options and bs->explicit_options shouldn't contain any options for
> child nodes. bdrv_open_inherited() takes care to remove any options that
> match a child name after opening the image and the same is done when
> reopening.
>=20
> However, we miss the case of 'backing': null, which is a child option,
> but results in no child being created. This means that a 'backing': null
> remains in bs->options and bs->explicit_options.
>=20
> A typical use for 'backing': null is in live snapshots: blockdev-add for
> the qcow2 overlay makes sure not to open the backing file (because it is

Note that we also use '"backing": null' as a terminator for the last
image in the chain if the user configures the chain manually.

This is kind-of a protection from opening the backing file from the
header if it was misconfigured somehow. I think this functionality
should be kept despite probably not making practical sense.

In my testing this scenario worked properly.

> already opened and blockdev-snapshot will attach it). After doing a
> blockdev-snapshot, bs->options and bs->explicit_options become
> inconsistent with the actual state (bs has a backing file now, but the
> options still say null). On the next occasion that the image is
> reopened, e.g. switching it from read-write to read-only when another
> snapshot is taken, the option will take effect again and the node
> incorrectly loses its backing file.
>=20
> Fix bdrv_open_inherited() to remove the 'backing' option from
> bs->options and bs->explicit_options even for the case where it
> specifies that no backing file is wanted.
>=20
> Reported-by: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

The fix looks sane-enough to me and works as expected, but since I'm not
familiar enough with this code I'm comfortable only with a:

Tested-by: Peter Krempa <pkrempa@redhat.com>

> ---
>  block.c | 2 ++
>  1 file changed, 2 insertions(+)


