Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8B1C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 540712065D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrND3/1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540712065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv08y-0001fN-Vu
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 11:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jv086-0000rh-JG
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:12:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28884
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jv085-0001mM-0y
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594653147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xRKSYv1jroEW18nmtaAG4aYyJI8AAtlTjZxKsZf/wb0=;
 b=XrND3/1slCp5hAgNksgaxk1Ac4xantVAz24CzV0b1ERZgbKMtiKWkI7po+eC2Mscq86R1+
 FPOJ3se2BnLuJHZPQd/1HVmlTjAp/LSFkEZBUTLdtxC14S22k73Qyv1/7Mbk2BjOszlGrG
 GtBUvnWvPIwxpMpACRXvzqc7Mm1GUI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-9ftAQH4xN7eAoLdQeynlPQ-1; Mon, 13 Jul 2020 11:12:19 -0400
X-MC-Unique: 9ftAQH4xN7eAoLdQeynlPQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81EBB6D0DB;
 Mon, 13 Jul 2020 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 562777880F;
 Mon, 13 Jul 2020 15:11:51 +0000 (UTC)
Date: Mon, 13 Jul 2020 11:11:50 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 01/12] python/machine.py: consolidate _post_shutdown()
Message-ID: <20200713151150.GA2717117@localhost.localdomain>
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-2-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-2-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 01:06:38AM -0400, John Snow wrote:
> Move more cleanup actions into _post_shutdown. As a change, if QEMU
> should so happen to be terminated during a call to wait(), that event
> will now be logged.
>=20
> This is not likely to occur during normative use.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>=20
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 041c615052..f7e68191c2 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -283,6 +283,8 @@ def _post_launch(self):
>              self._qmp.accept()
> =20
>      def _post_shutdown(self):
> +        self._load_io_log()
> +
>          if self._qemu_log_file is not None:
>              self._qemu_log_file.close()
>              self._qemu_log_file =3D None
> @@ -296,6 +298,17 @@ def _post_shutdown(self):
>          while len(self._remove_files) > 0:
>              self._remove_if_exists(self._remove_files.pop())
> =20
> +        exitcode =3D self.exitcode()
> +        if exitcode is not None and exitcode < 0:
> +            msg =3D 'qemu received signal %i; command: "%s"'
> +            if self._qemu_full_args:
> +                command =3D ' '.join(self._qemu_full_args)
> +            else:
> +                command =3D ''
> +            LOG.warning(msg, -int(exitcode), command)
> +
> +        self._launched =3D False
> +
>      def launch(self):
>          """
>          Launch the VM and make sure we cleanup and expose the
> @@ -344,7 +357,6 @@ def wait(self):
>          self._popen.wait()
>          if self._qmp:
>              self._qmp.close()
> -        self._load_io_log()

Nice consolidation of responsibilities!

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8MebMACgkQZX6NM6Xy
CfP9Gw/9Hs+7oFxcbpL3eZ/e9mcCrBfJghVxQnk0+usV1hl6fUd473GceHjc5dFj
su4QFxRuEhQwkjbbUr6SDh9Swc7NYOvo8MVWkNcFLD9Q5s1+NVYJEgwV/4AThh5p
dlnIWapjm8NyPi4S8JoTqczvxkwmbEzWg7UdHIP/qd0CXB/MZBjVZbbRjFkFGZyU
NwxezXj0dmxLuLHh9H0ASkXUKJmNhPIk3a3y5sVdkfBlma0uT/TNCD9lrgggY7O1
4PUDrFgNSpWSWmpc1t3INH9x6CkJ9qm/qjrrkdYOXa1JgaBohiH2K+NC8WwjBUHp
yAYKjyb2vI2Cp+gouREfx/D0LEqDzrGdCIuEuFswtEosDWe3k++JeY8777rIOAVu
uj+6iabmaKb2t1irY6cMigaPMZthqACJmSus9RPQotBtSZdtmBiLe4xzNij0eVWX
PTaGr5TnljUdxjyqT0HpSmoNckEMNa/re3iNqI08MplctSbtt32hHFontdTcEXsw
h7+Og6YCO9MZT26m1Q0sghDHzE0uRvFOhFR4ZSGC8lOrPRGVvS9A1CSEWem6KQ4Z
DmfhrUCKmuhnKR89vOgmyhSyq4o3IpKMUzkeCDHvMm8wSVOBL2rj/0I+yw6w4uGN
ETHatg+fH03WFWR5okRj/2PK5dAiGcNtY0ZIpu9FUVdO2+yPQ6c=
=ZfI8
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--


