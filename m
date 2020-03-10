Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF06C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEFC222C3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RORsMMzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEFC222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBicB-0001GW-Gk
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 13:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jBibF-0000KW-I5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jBibE-0003pF-95
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:23:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25000
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jBibE-0003kn-4l
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583861002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qyN4ooOsxSMWfMbNGjbBku5UC5Y5Cd/ZF2qt8oz/Pdc=;
 b=RORsMMzP8WUHDkrEuR/mTzUi2AV3pWCLTXhcvhOoW3XX76w9kzA8zlxvviU0Ghip1eb/x0
 52f6A87JMPU+S/xrp9qOccWBBdwQ7CpwsrW820k49N9iTXyL24/wy7vEh0DLjrL2WBGom5
 se1kcdrc4tQGELkXao7BsXLikJk7sKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-IIFdPbSCNiiG2sOYLbOiRg-1; Tue, 10 Mar 2020 13:23:18 -0400
X-MC-Unique: IIFdPbSCNiiG2sOYLbOiRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E1B2189F764;
 Tue, 10 Mar 2020 17:23:17 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3D165D9CA;
 Tue, 10 Mar 2020 17:23:14 +0000 (UTC)
Date: Tue, 10 Mar 2020 18:23:13 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v9 0/4] delete created files when
 block_crypto_co_create_opts_luks fails
Message-ID: <20200310172313.GH6926@linux.fritz.box>
References: <20200130213907.2830642-1-danielhb413@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200130213907.2830642-1-danielhb413@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.01.2020 um 22:39 hat Daniel Henrique Barboza geschrieben:
> The version 8 of this patch series got buried and it's now
> conflicting with master. Rebase and re-sending it.
>=20
> Also, I contemplated the idea of moving/copying the password
> verification in qcrypto_block_luks_create() all the way back to the
> start of block_crypto_co_create_opts_luks(), failing early before the
> bdrv_create_file(), avoiding the problem altogether without the
> need of a delete_file API I'm trying to push here (see patch 03
> commit message for detailed info about the bug).
>=20
> This idea was dropped after I saw that:
>=20
> - We would need to store the resulting password, now being retrieved
> early in block_crypto_co_create_opts_luks(), in a new
> QCryptoBlockCreateOptions string to be used inside
> qcrypto_block_luks_create() as intended. An alternative would be to
> call qcrypto_secret_lookup_as_utf8() twice, discarding the first
> string;
>=20
> - There are a lot of ways to fail in qcrypto_block_luks_create()
> other than a non-UTF8 password that would trigger the same problem.
> A more appropiate way of doing what I intended, instead of
> copying/hacking code around to fail before bdrv_create(), is some sort
> of bdrv_validate() API that would encapsulate everything that is
> related to user input validation for the security drivers. This
> API could then be called before the file creation (maybe inside
> bdrv_create itself) and fail early if needed. This is too overkill
> for what I'm trying to fix here, and I'm not sure if it would be
> a net gain compared to the delete_file API.
>=20
>=20
> All that said, I believe that this patch series presents a sane
> solution with the code we have ATM.
>=20
>=20
> changes in this version:
> - rebase with current master at 204aa60b37
> - previous version:
> https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg01551.html

Thanks, applied to the block branch.

Kevin


