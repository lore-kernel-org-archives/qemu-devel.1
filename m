Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECC7C4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17B620791
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwBgcmSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17B620791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLcJf-00061h-0f
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLbjQ-0007CJ-6N
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLbjO-00014m-0Z
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:36:59 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600994217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2dUCzdVUkuTdAww/li56/VasxLw9TQmOafVW/btgx8o=;
 b=XwBgcmSjyao4XnQAGcWLqRYZSZJCpElXYLEC+zJJnV/93LUpFJ4iXp2myGMORiBEV6Zcf+
 lTx6c7YERtNAq/5KKpqnXil+cDmM+JqiJnyASj3ufrBl0TiJ9jbhChupc0IA/TjVaF/xkn
 hLmruuRpnNOioxz23z9RM0nNdsiwTcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-8WAPK6LGPneMHIbvap_MeQ-1; Thu, 24 Sep 2020 20:36:54 -0400
X-MC-Unique: 8WAPK6LGPneMHIbvap_MeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C00FE2FD08;
 Fri, 25 Sep 2020 00:36:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01B695C1C7;
 Fri, 25 Sep 2020 00:36:52 +0000 (UTC)
Date: Thu, 24 Sep 2020 20:36:51 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 07/16] qapi/expr.py: Add casts in a few select cases
Message-ID: <20200925003651.GJ347918@localhost.localdomain>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-8-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922211313.4082880-8-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FCKy2vjPBX+S/5dE"
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

--FCKy2vjPBX+S/5dE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:13:04PM -0400, John Snow wrote:
> Casts are instructions to the type checker only, they aren't "safe" and
> should probably be avoided in general. In this case, when we perform
> type checking on a nested structure, the type of each field does not
> "stick".
>=20
> We don't need to assert that something is a str if we've already checked
> that it is -- use a cast instead for these cases.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--FCKy2vjPBX+S/5dE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9tO6AACgkQZX6NM6Xy
CfMmaxAAkFEccZRtNFNtYnqOypfhSzOKMyQJ3qUevKV3zdkg9XjYJ1jcqKswFA8A
t4+ozK/oES19rjAeBpz/dah68zqSiBapPjDgWsZCQnThzpiow97WOe7r6Ha/OZFk
vjk/pIwNNfjKkr9kGxUrIzsZkMTFtzwAJRYTFFVplCGIv/4imvsGB6+vN3QNw5Tm
FG8zHXQgjdNf1vqgJRopK/7M8GHy64PRdA4QEx3YyWNMIw/fZqI4uN5Yz+6qaeR2
57F5fODD1EjseATca+akNXsHjH7CJ80G/fo2SWf7zszz0xu3Jfv+IazO9jcPG15G
IiKNnHeEIIQepQuH33a+3y2kW65p+Ra9cB36mQPfXnv3HOhnsYjFKEcM9okZYt0R
fBc/5ER2Jf72RlRzYCs7TDW8cJMcRtrcRPy0ZzCDyMp+Kj9ip+HELBLNl/UrHhb2
8oOWWIFTgiGrzvesE6z7XIQH5GpM5f406vQOwYJ3bgojSFCKdCKdQkmu0jIW+pxp
1ObkWPgVo/ptORpxLQZjhZNPPCjQ5L/R18vvScvpS5bVROtuuSCH2RdzltvH0veX
XJ+hD8eTgwh/NPlggypFbntQd3HCuYFNltXzFRG5ySgrV++WtpYf4vGjvN9BNwCM
Or7Ho9dx0+2e0QTRd7IyY/ErBGrAGh1go9uty+Xu3GMBuu/1MRg=
=Ukqb
-----END PGP SIGNATURE-----

--FCKy2vjPBX+S/5dE--


