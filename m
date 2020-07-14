Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5B7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127E421883
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUfCyILO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127E421883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvCKY-00028T-AI
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 00:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvCJq-0001h2-9A
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:13:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20424
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvCJn-0006vG-HR
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594700001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ZIJIipE9cg8bwhPzQf2ETwY6+cQqw8DaZS2NzYqFhQ=;
 b=PUfCyILOcccxHwZorX0IrK8F3IMsd1Rv3jySyXKAo0C0WkDgW7SJs2NGuSXBXIROQclsCv
 kVuZjETlmXP2eojjRB/9sjGiwaDbvAsJGhvWrFKJ0XvpqBDxJgNIauSKvMwDLtwqZP/iCM
 Q3aQyUbMbC6EcYiK+ktf2qhtpvXJvgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-5Y9_6AVaOAOcyRZPlv4qLQ-1; Tue, 14 Jul 2020 00:13:18 -0400
X-MC-Unique: 5Y9_6AVaOAOcyRZPlv4qLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A08918FF662;
 Tue, 14 Jul 2020 04:13:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 284E2724D4;
 Tue, 14 Jul 2020 04:13:13 +0000 (UTC)
Date: Tue, 14 Jul 2020 00:13:11 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 10/12] python/machine.py: split shutdown into hard and
 soft flavors
Message-ID: <20200714041311.GH2983508@localhost.localdomain>
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-11-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-11-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 23:07:52
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

--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 01:06:47AM -0400, John Snow wrote:
> This is done primarily to avoid the 'bare except' pattern, which
> suppresses all exceptions during shutdown and can obscure errors.
>=20
> Replace this with a pattern that isolates the different kind of shutdown
> paradigms (_hard_shutdown and _soft_shutdown), and a new fallback shutdow=
n
> handler (_do_shutdown) that gracefully attempts one before the other.
>=20
> This split now also ensures that no matter what happens,
> _post_shutdown() is always invoked.
>=20
> shutdown() changes in behavior such that if it attempts to do a graceful
> shutdown and is unable to, it will now always raise an exception to
> indicate this. This can be avoided by the test writer in three ways:
>=20
> 1. If the VM is expected to have already exited or is in the process of
> exiting, wait() can be used instead of shutdown() to clean up resources
> instead. This helps avoid race conditions in shutdown.
>=20
> 2. If a test writer is expecting graceful shutdown to fail, shutdown
> should be called in a try...except block.
>=20
> 3. If the test writer has no interest in performing a graceful shutdown
> at all, kill() can be used instead.
>=20
>=20
> Handling shutdown in this way makes it much more explicit which type of
> shutdown we want and allows the library to report problems with this
> process.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py | 95 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 80 insertions(+), 15 deletions(-)
>=20
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index aaa173f046..b24ce8a268 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -48,6 +48,12 @@ class QEMUMachineAddDeviceError(QEMUMachineError):
>      """
> =20
> =20
> +class AbnormalShutdown(QEMUMachineError):
> +    """
> +    Exception raised when a graceful shutdown was requested, but not per=
formed.
> +    """
> +
> +
>  class MonitorResponseError(qmp.QMPError):
>      """
>      Represents erroneous QMP monitor reply
> @@ -365,6 +371,7 @@ def _early_cleanup(self) -> None:
>          """
>          Perform any cleanup that needs to happen before the VM exits.
> =20
> +        May be invoked by both soft and hard shutdown in failover scenar=
ios.
>          Called additionally by _post_shutdown for comprehensive cleanup.
>          """
>          # If we keep the console socket open, we may deadlock waiting
> @@ -374,32 +381,90 @@ def _early_cleanup(self) -> None:
>              self._console_socket.close()
>              self._console_socket =3D None
> =20
> +    def _hard_shutdown(self) -> None:
> +        """
> +        Perform early cleanup, kill the VM, and wait for it to terminate=
.
> +
> +        :raise subprocess.Timeout: When timeout is exceeds 60 seconds
> +            waiting for the QEMU process to terminate.
> +        """
> +        self._early_cleanup()

Like I commented on patch 5, I don't think the *current* type of
cleanup done is needed on a scenario like this...

> +        self._popen.kill()

... as I don't remember QEMU's SIGKILL handler to be susceptible to
the race condition that motivated the closing of the console file in
the first place.  But, I also can not prove it's not susceptible at
this time.

Note: I have some old patches that added tests for QEMUMachine itself.
I intend to respin them on top of your work, so we may have a clearer
understanding of the QEMU behaviors we need to handle.  So, feel free
to take the prudent route here, and keep the early cleanup.

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8NMNQACgkQZX6NM6Xy
CfOEUBAAshtpeB6gUPUyGqVy/nXmY4Dpayv20qJQTB6krinaTsGclcs61SHWiaY+
5HsTvo6nibIkBv5OZ0CvM+Zs3eJDlh3HXRk+wtsJqKSFacryigU318WapFL3ieFf
yne8kudeTenyCsGOAK/G/v30oMUt5exZF5NwybpuQwVeINKaKTR7Ig8NMh0kU2z+
KpMVRfxJSPyTaBzqrKIDvw9skt/Ex8YyN7OGswJ2kpxSQ9etEkTSmf+qdNxwxuN8
wEBXkzh/MxgnH9obzjElhx8CWrFQY4q+/+EwdhcgHsFujbP+RWXz0HG5ZjvZiZJB
+cA4XOTokXcA8dA5N+jdlkRku0gxrCXr0/ZYTbH6LIcrnRgUk0NUeGP7GaMvtT7e
8ciCR9U+oCAclakRCOvY3ESMoF5UPCKEZX/sUK4UgaCKkDaj9AVsCZHk/2Xsw9Bo
fbqBQE9H57/Ojv9tme9XrSV7PHpZLv7orNtLZva43sVJsTWkOx6oEczbR4JZHzKx
uRYxDsYdDjVD2uG7NDM8x/6WcOSTftJnIJJVEwlKoFHoL3kfNqyi7OzKLxLbxHvw
SmNE2RbIsJX4sxxyQz7kqEILToyDN+f9NdhM/XgRIXPFxdPAHkX8/1a7yRx42dBo
+G9fAxbzlvH6QNNTj7XPXLY8IVbpt13RXVavwumkOROub/ucHd0=
=u70L
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--


