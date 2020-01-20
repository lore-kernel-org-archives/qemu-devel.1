Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F41C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF352073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZO4eF02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF352073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUP9-0004T7-Bc
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1itULD-0000v5-Hs
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1itUL9-0008R5-1Q
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:31:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55568
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1itUL8-0008QW-TG
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579516286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5WGWKmofX6t0dBsNCTeEtuN+1yfimqIg88Gfpm47KIA=;
 b=GZO4eF02s0M/JXrJdZbYW9zm4qJ/JEcLRWvtIlcq5g6fxBBxlw7HwLZ+GBTYhyWch1O1Ks
 Kjt3k+9suEw1lgTz54IvFdwg9dJai5myJxArm408XlnT5ackZ18MosA+MyDl6CtT2RsmzA
 ueuzPCjRuqSFtJdZwVBbwaYFA+zz/ws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-hYJ4ocHTNEqF3BMKboULbw-1; Mon, 20 Jan 2020 05:31:24 -0500
X-MC-Unique: hYJ4ocHTNEqF3BMKboULbw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C72A800D4E
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 10:31:24 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EAF428984;
 Mon, 20 Jan 2020 10:31:18 +0000 (UTC)
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-95-dgilbert@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 094/104] virtiofsd: do not always set FUSE_FLOCK_LOCKS
In-reply-to: <20191212163904.159893-95-dgilbert@redhat.com>
Date: Mon, 20 Jan 2020 11:31:15 +0100
Message-ID: <871rru8ln0.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: Peng Tao <tao.peng@linux.alibaba.com>
>
> Right now we always enable it regardless of given commandlines.
> Fix it by setting the flag relying on the lo->flock bit.
>
> Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4lgXMACgkQ9GknjS8M
AjUvsBAAqNU6BjIinj/5SVlV9J2WTQmQ/jKxADXJUzzvzzlboWZLzeiLp5xkxC5o
6G322FVL7jmw7S4vrUXZNEr8INvLJtwgyTqfM+0i4E+VwPHyGNqL2cbt92Y0hnEK
sMrJ8ztCHbo+1nvBy1TgARILpQR76v3QRPdQOQVCJ5rWYMtSkJyYXkCoV1oG3ne9
U3cupsoHxMId3NZzxBVIE/HETsVfd8z8YiJI2wqcLWqTgJXu31O+uj7flnsdfb1w
zMkk4ywiHXYcc4oBaQbOnyF4mQ7OwCK+EqIpzDmlaRdIoXpPHLqaqBnO9Qf4GazO
CnmvcT5OHIQT6eOlxnPrTBFXLkaHmrRH1u5C2ImEPQXFi1600bAyc0h598JucIyd
tqZtwt6bYCF5yeVix4X/A9iDG2lBRJY9Ambn4OQQszYr81RUIdh8l9zhbe3kik8E
w0ufV39HLfnv3+seX9eeycLI3DWHKf++BG5igEaTmEHEwh2TyYxpD8SVavfsBr8x
q2onBu+rijljhWyIwIiuOrSgGSdlHZT/gdVrH2hchoFx8zi2j3NctReZlbparJv5
5/EWfGG00/VqwdTrvduhujXQi+fG+ZyeyFWCXVF5LTnp2nJNg1994xZ4yeH4h0BF
gHrA5sqXTvZ79vIf8KCw+fe1MuzYERjEx8E6pM2prgAqknrTFLk=
=6Y8l
-----END PGP SIGNATURE-----
--=-=-=--


