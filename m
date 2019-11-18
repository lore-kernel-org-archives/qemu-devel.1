Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273A8C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 16:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA793218AE
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 16:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtXvrp5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA793218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWjtT-0003la-3Y
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 11:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iWjrV-00029a-Gx
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 11:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iWjrT-0001R8-1R
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 11:26:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49464
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iWjrS-0001Ql-OL
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 11:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574094405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a/4OPilHS8b1K7iwXr6jIhlFNx+544CKRHr29DMaRec=;
 b=YtXvrp5H+mnrSSAMrtAnYIXJkk1mTXdwQyZx9gHawy7pd+OMQ7oWwc8RYwkiw3fAkV6qao
 tsdjmEqQqDu0GTAqEJ7I/GUm+Ph48S1HL8SODzeGpbuyC3osVrpIYDcFAI2ZR1fuiJcM6U
 p/dPYOj08InJ3IfUDaNXK2LQfMhj0do=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-mxE3lcOMMse3MWcWOnfJ1w-1; Mon, 18 Nov 2019 11:26:42 -0500
X-MC-Unique: mxE3lcOMMse3MWcWOnfJ1w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8B6310BCF03;
 Mon, 18 Nov 2019 16:26:40 +0000 (UTC)
Received: from andariel.pipo.sk (unknown [10.40.205.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C5184BB;
 Mon, 18 Nov 2019 16:26:39 +0000 (UTC)
Date: Mon, 18 Nov 2019 17:26:36 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/2] block: Fix multiple blockdev-snapshot calls
Message-ID: <20191118162636.GC3745@andariel.pipo.sk>
References: <20191108085312.27049-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191108085312.27049-1-kwolf@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2019 at 09:53:10 +0100, Kevin Wolf wrote:
> Kevin Wolf (2):
>   block: Remove 'backing': null from bs->{explicit_,}options
>   iotests: Test multiple blockdev-snapshot calls

Hi,

I'm not sure how the freeze rules for qemu are at this point thus:

Will this patchset make it into 4.2. I argue it's a pretty important fix
as it ends up in image corruption.

If it won't make into we will need to add a QMP feature flag to detect
presence of the fix so that I can gate libvirt's support of blockdev
with it. (This can also be done if we make it into 4.2 but I'll be okay
infering it from other fixes present in 4.2).

Thanks

Peter

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAl3SxjkACgkQHGwCByjY
1GolRA//ckIILxdZfywDW9YttrqB3u8ewtZ+g+pLizoWoOy07UfP2UEm4pjHxakg
/qhndLShpIdd2TwlI2uxjninS8kbxI1dRT9G5eK/q6xhQN7ls4NpIGOfFm8BkNeg
bHF93hyg/Sjuk3t7YAzgEAbxJ0iZ2gZsB9/qEHV6+KRLlaZQtFlCO5LsCcMe0yaj
GketjPB7KDcYOcXQPTedMMkzzjeGPsFRqidCP/OMGe0T1/9pU8NcSmbdJGUxarzl
OCt7JwVHB8Z5cLll6BuuDWRAdu9Do1u4WZyTEKVw6UUEt9Et650eAoW6tWTfIghd
9HjRwgBMje4nXlkWyiLA4N/wb0TuD73rubBGijVEOV3htndhCE0ZqreRlnFOTAfq
4+CYV0M2+n89SinP1B9GR19Prbj8h2CgW2EuGMCIAw7FXyT3V04VlVwlONCryIqu
bbtAsy6rBcQfvPxo+kBkrFNTd7UR/Xc7cim+eDXzBrq4Lq7a+S2cGc2UghTF9+vx
6tTS1Yy9nrKUYETyR4q3ISQTqFqz7NCkjz85kZBaamjywQdR+sRbqmZZ/bm+XdFT
aA3iRTatE9M1vu0CTqU3FLG+6lztfTTQOFFfF5mRV7dRIBKnmZJqJFSWz3dBzobO
FmNy3QJ0g0kmvNTLiD+B7IjKgXpdoPttEFfEQm5PcI3VW6clCtY=
=j6PD
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--


