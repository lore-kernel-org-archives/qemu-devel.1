Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69088C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 02:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3248721D95
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 02:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9LcgfST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3248721D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvB0w-0001Lc-Ew
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 22:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvB0L-0000sG-Or
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 22:49:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39087
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvB0I-0007uA-Pk
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 22:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594694949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M94XDkNOtn0euCR3HywdfhJeG04vQx4a3xFzQSk4qik=;
 b=T9LcgfSTkDaVtfvxEncPJfTH/TRBBEUE4CibcD8v0h1/xii+tP7HgqoSLuwa9fpnFuiaET
 a69Ttut/ktJ1USA+MobJn3fNcLdEawgytUJdr78Gn6n7ZA3oOZXxDDazl6Zd6LnOwIO5w6
 kXPPk8Yo9UAn/0UnajUV2Zn5HEQBIig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-pbADkt16NCC5SvcAAdO2JQ-1; Mon, 13 Jul 2020 22:49:05 -0400
X-MC-Unique: pbADkt16NCC5SvcAAdO2JQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D5FD18C63C2;
 Tue, 14 Jul 2020 02:49:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FCDD1A914;
 Tue, 14 Jul 2020 02:49:00 +0000 (UTC)
Date: Mon, 13 Jul 2020 22:48:58 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 05/12] python/machine.py: Prohibit multiple shutdown()
 calls
Message-ID: <20200714024858.GA2983508@localhost.localdomain>
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-6-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-6-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:30:31
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

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 01:06:42AM -0400, John Snow wrote:
> If the VM is not launched, don't try to shut it down. As a change,
> _post_shutdown now unconditionally also calls _early_cleanup in order to
> offer comprehensive object cleanup in failure cases.
>=20
> As a courtesy, treat it as a NOP instead of rejecting it as an
> error. This is slightly nicer for acceptance tests where vm.shutdown()
> is issued unconditionally in tearDown callbacks.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index cac466fbe6..e66a7d66dd 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -283,6 +283,13 @@ def _post_launch(self):
>              self._qmp.accept()
> =20
>      def _post_shutdown(self):
> +        """
> +        Called to cleanup the VM instance after the process has exited.
> +        May also be called after a failed launch.
> +        """
> +        # Comprehensive reset for the failed launch case:
> +        self._early_cleanup()
> +

I'm not following why this is needed here.  AFAICT, the closing of the
console socket file was introduced when the QEMU process was alive,
and doing I/O on the serial device attached to the console file (and
was only necessary because of that).  In those scenarios, a race
between the time of sending the QMP command to quit, and getting a
response from QMP could occur.

But here, IIUC, there's no expectations for the QEMU process to be alive.
To the best of my understanding and testing, this line did not contribute
to the robustness of the shutdown behavior.

Finally, given that currently, only the closing of the console socket
is done within _early_cleanup(), and that is conditional, this also does
no harm AFAICT.  If more early cleanups operations were needed, then I
would feel less bothered about calling it here.

>          if self._qmp:
>              self._qmp.close()
>              self._qmp =3D None
> @@ -328,7 +335,7 @@ def launch(self):
>              self._launch()
>              self._launched =3D True
>          except:
> -            self.shutdown()
> +            self._post_shutdown()
> =20
>              LOG.debug('Error launching VM')
>              if self._qemu_full_args:
> @@ -357,6 +364,8 @@ def _launch(self):
>      def _early_cleanup(self) -> None:
>          """
>          Perform any cleanup that needs to happen before the VM exits.
> +
> +        Called additionally by _post_shutdown for comprehensive cleanup.
>          """
>          # If we keep the console socket open, we may deadlock waiting
>          # for QEMU to exit, while QEMU is waiting for the socket to
> @@ -377,6 +386,9 @@ def shutdown(self, has_quit=3DFalse, hard=3DFalse):
>          """
>          Terminate the VM and clean up
>          """
> +        if not self._launched:
> +            return
> +

Because of the additional logic, it'd be a good opportunity to make
the docstring more accurate.  This method may now *not* do *any* of if
termination and cleaning (while previously it would attempt those
anyhow).

- Cleber.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8NHRgACgkQZX6NM6Xy
CfPfxQ/+IAvplSz2sySp2oAie326nhYEd9qhvNPPBoAAbNMPGo5HjdiKmoArKJvf
Kvz3RI9c3/sQP3QWjkmbnM0K9zjYx7kypNc/XLaDz+QmUhMIkf/ftocO4CZ+8g0U
Ksc0kUgktZQd4lg8TIBo5E+CcTmX6J1CFgC8cEv/0kPOsV09Tkxh5YAzyj1F4l+B
ZBosugOTGIIeeDTAPNzqUaDmr419c6bs+L7LcIF2Ch1Rv19CRLz4+7+VlFTirHLR
U0cyF53CFOg7H9p+TtRHBPBCaJeN3/Sd5S3KHv6hWZAVa258jvpVL+JNjKXqirD7
z0E51rMAybV3vm5zeFwdEfcwsWJ3doBsOtN4TEESLf+Z55Z0qOwwYBqRt9zvC71c
kUJtaW8XkHeG5ykY33J05kSXvW3lzCwZz7GBdL1KnsGTbm4fsIo/5rIoA+jMAnMU
3fh+KUwCBRqhPtKCp7YWWaSi06pz/V1rmXwE7bcoGSrOnL7PJkiUlv2wrOPt5jk5
KQL76PKB4LbTdn/Td+EOlGg9XhpLN0uEk+2Vo3D8x2LLp7b/nPa2EwQ7OEpp2vMh
+eStd+bVx2tZNYq/WL41RlQIaQzfz5wPEWzmmmojCos5uQzoFMdzkkMs5j3aHGm3
9VuWvvNR7LCnlAdpr1qLMDWq9rudG99E1qijJqUWPAetsvsaqRo=
=mYkC
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--


