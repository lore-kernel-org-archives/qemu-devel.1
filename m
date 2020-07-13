Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8103C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4AB7206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnNmuEov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AB7206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv0Ty-0002cJ-UC
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 11:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jv0TN-0002Cq-1V
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:34:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47325
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jv0TK-0005Jh-OL
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594654464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w2jE5SVQftwtbM+W2tE0TknBaecty+ZwfEvkT9wkVMQ=;
 b=TnNmuEovHOkTLuovbkfyBlPNNhwooyIz+NS/EIn8ecB/Kb1/r4SvWpQ+3STYXHxT0j8dUP
 hRBhPeBtzuFI1SnCaOaQxZkdx9HoQp6GVrn0UZ7m8rLx/1IoSLzdC+kjykVa3DNSoSpWsF
 U/j1E3td6I2/TPgj4IqMPhpXhQIQS9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-czHXqsZhP4KZsjIj-9MJcg-1; Mon, 13 Jul 2020 11:34:22 -0400
X-MC-Unique: czHXqsZhP4KZsjIj-9MJcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A00C7800FED;
 Mon, 13 Jul 2020 15:34:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F13411A888;
 Mon, 13 Jul 2020 15:34:17 +0000 (UTC)
Date: Mon, 13 Jul 2020 11:34:16 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 02/12] python/machine.py: Close QMP socket in cleanup
Message-ID: <20200713153416.GB2717117@localhost.localdomain>
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-3-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-3-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 01:06:39AM -0400, John Snow wrote:
> It's not important to do this before waiting for the process to exit, so
> it can be done during generic post-shutdown cleanup.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index f7e68191c2..938c891b1d 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -283,6 +283,10 @@ def _post_launch(self):
>              self._qmp.accept()
> =20
>      def _post_shutdown(self):
> +        if self._qmp:
> +            self._qmp.close()
> +            self._qmp =3D None
> +
>          self._load_io_log()
> =20
>          if self._qemu_log_file is not None:
> @@ -355,8 +359,6 @@ def wait(self):
>          Wait for the VM to power off
>          """
>          self._popen.wait()
> -        if self._qmp:
> -            self._qmp.close()
>          self._post_shutdown()
> =20
>      def shutdown(self, has_quit=3DFalse, hard=3DFalse):
> @@ -377,7 +379,6 @@ def shutdown(self, has_quit=3DFalse, hard=3DFalse):
>                  try:
>                      if not has_quit:
>                          self._qmp.cmd('quit')
> -                    self._qmp.close()
>                      self._popen.wait(timeout=3D3)
>                  except:
>                      self._popen.kill()
> --=20
> 2.21.3
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8MfvMACgkQZX6NM6Xy
CfP7DBAAjF/X2NjP5MZQetwXtgciG0AJTap+fo0qlozbxsHubd4DcdXnvqzExxTC
D4Jyz0t8hVB+Gdi0OtPoRMnO7mmPbZ1PX5DLT5NJ4vQnTIKgUD7uaXTPJqlo0Jh4
iS4Hjzqm9NnDCvAEIaCwgsEm6b1n1KsmoF9oCqYOTqsDnOtarZKbgfMOjt9DTCig
VhUZGdX9PQ/4fmz/LE6Bu507x1CMs1Dce0P70vB7RHUgGemQA5WLKlejaRbqta0B
0pzCqTdvXFpmLl8hZ9HUGq/ahcLr7+wuBnuxVuMrTQk9bP/vLIcfGeu4lm4THMIO
GxoWzuRyfchArHK+PV1M0KMBGMdQsohhAQnSFFCJ9xFjFNGhm4yv2QSuoq+RGg+s
DB9hkz67RqbsBkwPHXHcjSWCaFpDJ2+1RLNvt4QIlDE2m1l9K+ByJ+wdBexPhDnG
BFYEh3KmPQbdX3sb1JA4hf/dSefIv98y4Ly6/4qKNPV8XCi8l67KBV3LuiI4qcxu
EOtxJeaL7qxAErW95F5DAQ48Y3iilNbW5P19dDhjy9iJpzwg6pgdxghsYb/Zv/N4
82I0gue2ZPbP0bnXl2xDZkL41s3DnXeK0ETi16g3rEczGN+mSD/vWh86DNHYFJ5c
scyzmzZwbgh49IB2U4hxUGz8eYkkRqITV5A2Ww/yCNbrAdCxxrY=
=cxi4
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--


