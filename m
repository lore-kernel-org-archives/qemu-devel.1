Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD02C4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC6672076B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4VHo3GH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6672076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLcEB-0005o8-QN
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLbwn-0007PR-3C
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLbwj-0002m7-W7
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:50:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600995045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y3uCgNgeQ/PAPtZW3gDF2g8oCDnwvW7deiVRsnLVDAQ=;
 b=i4VHo3GHABi7VSyvQ32wBA3chCN6mhp7zPj+S13N7HpSboUDWi2tRYqI8PIU/qJz1amYYz
 gZEasSUNfITTsQn6m/Hizy/lLX1FxbxIDJj01H23OatB5hV6w2/q7qxL+s7AJ2etXd387e
 cRaDJT2ZkCuuvnMeofK8V66eOeVgOOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-dVRFLPfcP0-lk02NzvmURg-1; Thu, 24 Sep 2020 20:50:40 -0400
X-MC-Unique: dVRFLPfcP0-lk02NzvmURg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF640425DD;
 Fri, 25 Sep 2020 00:50:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 431E41002C0D;
 Fri, 25 Sep 2020 00:50:39 +0000 (UTC)
Date: Thu, 24 Sep 2020 20:50:37 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 09/16] qapi/expr.py: rewrite check_if
Message-ID: <20200925005037.GB368253@localhost.localdomain>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-10-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922211313.4082880-10-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:13:06PM -0400, John Snow wrote:
> This is a only minor rewrite to address some minor style nits.  Don't
> compare against the empty list to check for the empty condition, and
> move the normalization forward to unify the check on the now-normalized
> structure.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

And just to make sure there was not change in the logic:

Tested-by: Cleber Rosa <crosa@redhat.com>

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9tPtkACgkQZX6NM6Xy
CfNM3RAAiRkdxe3/KaDzyu58Gw9B/GzbXtVp6JEzRzlXzEwDYOM/DJFkwyLBil7B
PbYqds9+3yNuqjjOpdSiRNeJNvVIWDiZthcM6e9j42PE7r0qEHOusoEdMadUxjc3
GFbiGlOckItlVM4rPTAFQ+JzLR522Nysvvth78qSFY2XoUDeZEtOFRwrOLbhJnsI
6WrzRtVbXLeGDHZFx74Cq3hau0gi+nuUVWfIJRtmm1Ml52hkSdB+YhdoQT7fcd1Q
a9asZGIIiGzvt69mq4IoFv6Y11/DICRdRiN0UU7kXLzqDAB0Stk0QwAEwlA6g3VI
2fCy5cCWYNnX7EYopiSyvm4I4skOBzLOvIdrC83U+rQGhHJfkqJmT1BpyTR828Fp
s5fC9U1Qmg5wV/BltC9qe4FVw9isAUUzK2vUukWf2KGdPNcW8If8z90KbjlSDFJi
Jl4Yf9erIDJzsiBO7p2Xc05ZfmKDR30V3QZ7uSGanwKHi7GgzNHnGaSbYWdMmxN2
cblZ8MKF5Ed/3XMAVDifwT1Hk0GiPwSLGDb25acdxAKbaGmE6TqnfjmcIlTSMzHA
hvBU4RlpxROn2vTNNG2aZTwJ2hUuzJv3S0peUQ9NVhZxn2KSM49c5/o7VbzRhkSY
SgMnKye67A+mqy73bx56X7LTIqagT6I8OOzBwoUk/E4UrLq0j7w=
=USLk
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--


