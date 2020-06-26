Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEEDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D95207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYWNYdgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D95207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonQk-0006UW-8C
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jonPO-0005Y4-EP
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:24:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53484
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jonPL-0002b2-Vh
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593174278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CVrYblkIZQxVa97CNTiuaDjPW/y4eRlG3ZPryB1YObI=;
 b=eYWNYdgFPtIN/I4omXkeMpfywT//x1wy9lZgd+x+S08rrj3re0q5N0WBrDiSGtFdlSqbIu
 k9Qr3sH38YHD48nYqu/SR1HtvlqjMLwpOoyR7KwGjB7CbVvvwjNqCQsGDAzcLwC6gxX7hP
 07ElggPz9VwFDDCH6FZhqywccZTRBMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-sCNsyTI5O3CB3nLPwdVo2A-1; Fri, 26 Jun 2020 08:24:36 -0400
X-MC-Unique: sCNsyTI5O3CB3nLPwdVo2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 617AA804001;
 Fri, 26 Jun 2020 12:24:35 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB93560BF4;
 Fri, 26 Jun 2020 12:24:34 +0000 (UTC)
Date: Fri, 26 Jun 2020 13:24:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 06/17] block/nvme: Replace qemu_try_blockalign(bs) by
 qemu_try_memalign(pg_sz)
Message-ID: <20200626122433.GM281902@stefanha-x1.localdomain>
References: <20200625184838.28172-1-philmd@redhat.com>
 <20200625184838.28172-7-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625184838.28172-7-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="P9KQiUGMzYCFwWCN"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--P9KQiUGMzYCFwWCN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 08:48:27PM +0200, Philippe Mathieu-Daud=E9 wrote:
> qemu_try_blockalign() is a generic API that call back to the
> block driver to return its page alignment. As we call from
> within the very same driver, we already know to page alignment
> stored in our state. Remove indirections and use the value from
> BDRVNVMeState.

The higher-level qemu_try_blockalign() API does not require all callers
to be aware of the memory alignment details. It seems like a
disadvantage to duplicate that knowledge throughout the code, even if
it's in the same driver source code.

Is there an advantage to this patch that I've missed?

--P9KQiUGMzYCFwWCN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl716QEACgkQnKSrs4Gr
c8i49Af/VNrVe9/a87o+iEER3EzaPbA4MVCXjxSc2dtd59hxLzHrmamk7CbEbQlF
AFOodKa5P8EF2BZ1beN7YBKGc7StQ+aGbXFWjCzxaYM0TOV11qy+bL2UV3zfBxbO
3o0Bmnz8HVrg2t5bjBWL3ffLHTcFPvoJ4P54YyjMPG0GdZC3IqKctR/d7Cw1rDof
z0XDpfNPfyG42vbRQCDjJLS5HewHV1pffgA4KdM52cEMs/oh+nPkXQKLk2Jgdm25
0ZtuEt1unLYLaeMU0znSH7QYnF6giwMLsh4D8pS81KJVYeVtANAxkLIKsT1yBWc/
6QiOxAjGpQyBDck0gPf5vqFCNmxe5w==
=ktED
-----END PGP SIGNATURE-----

--P9KQiUGMzYCFwWCN--


