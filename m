Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A09BC433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 03:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0248121973
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 03:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsUPfnxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0248121973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvBmB-0005p0-AA
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 23:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvBlK-0005Oq-HI
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 23:37:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28173
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvBlH-0002Cn-WD
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 23:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594697862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWHH107voNvrLByo1KuPa4tXhF+fVhuDYR8MuCuhjgU=;
 b=IsUPfnxGpB9Ui9oA37KSPCIPPNQHhsXDoW9shKBtdVBsnPSSFFHyUm1xxWSXm2fbLtbeQ4
 KLKIfuUfn/4oR3uIxgqOzqMG/+8C3w+enOsKZryLlL+/3JroTf6Rb7z77z8/NAqzTlhKCr
 ddPEhMXpo168Yv/SoA9D6CqBVzpfHGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-pfpq17VJPDGy-i_jre65BQ-1; Mon, 13 Jul 2020 23:37:38 -0400
X-MC-Unique: pfpq17VJPDGy-i_jre65BQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01A6D1009448;
 Tue, 14 Jul 2020 03:37:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41B08797E9;
 Tue, 14 Jul 2020 03:37:33 +0000 (UTC)
Date: Mon, 13 Jul 2020 23:37:31 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 08/12] tests/acceptance: wait() instead of shutdown()
 where appropriate
Message-ID: <20200714033731.GF2983508@localhost.localdomain>
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-9-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-9-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:44:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 01:06:45AM -0400, John Snow wrote:
> When issuing 'reboot' to a VM with the no-reboot option, that VM will
> exit. When then issuing a shutdown command, the cleanup may race.
>=20
> Add calls to vm.wait() which will gracefully mark the VM as having
> exited. Subsequent vm.shutdown() calls in generic tearDown code will not
> race when called after completion of the call.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py   | 10 ++++++++++
>  tests/acceptance/linux_ssh_mips_malta.py |  2 ++
>  2 files changed, 12 insertions(+)
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8NKHgACgkQZX6NM6Xy
CfOvgQ//TiGcgenKSw4LCMGa0cJfbuSP76Rw38uvnU5uX7M/H4ov0Cnt4q5HUail
gZTwawcf0F/FObza9nBpmEpiCXQJrD2602mYWZo04QlFd+VPp+SlLC7zb134Dt+d
tuAr8WlbWdfz3ByqILAJrmu2K8245pKxMipGeJjgSv6iMf/wx3IIWWruWYjofweT
xRy7Q2Zc3VMChR0j5VFAN51osKMbcUOrMpqGpVmIk3rVJj59NNCIBOi+7c/PhZRQ
SMKlleB6fHhOfqg4dLh+jbnlDXknFE1zKHeDJGhr1/T2zSQRUy3p0JtrMeq9N9iC
qejRSttJVlq6njmunV9NJbrPmZv4HWQc6p/v9MA576E6UexHZfDzsdpHgxq35x5O
/aGsuq8IB7HpXDxNqGOxo8JoIg033JBDwYc9G22W6eUJsdXQ16EW0Ji0YDg9frUH
UGXb46hRwXpGniFn5d5VBH19V0g7LxP0IqxgApZ4kz8KH+XCPOoKkZDa7IEj9oPv
PE7sm5kr9owuUYZ1schgz1rsNlkz0PMXnRRoGTTh3l7jteSVUjh21UqiTCqgzIGg
J7hqY0Vhjhdo7G1uYgsCmc125PkMNOV1PldmKEyKxxFSx8/jrOPGjTL2MmW4Mwa6
fHdPbST0BlBKStEcS9ictLLNVn95tRDPMC+JOpfZBB0F48XJLHs=
=dj3e
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--


