Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE29AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 00:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9CE822254
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 00:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oo4O7dDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CE822254
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQgbZ-0006Zt-FQ
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 20:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kQgak-0006A6-Ia
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 20:49:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kQgab-0005Fm-6h
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 20:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602204531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fGN4sGfLVPv8buRSWimhYOM+K3xZVKgz8sBbBXs3lIA=;
 b=Oo4O7dDPU+sUz4DyVsUlOG7tYp6B1WDAs7dvY2uklToNvN53swkv8KvkzNtM0mEqI3Pjkt
 jt9vttn4KQYMFAdaUZKtkFm9EQ8idIBcvTxIKwRcjcggT+CDe6xHQwWkYAP2b/1rUjslUE
 3/NM7cuww0n7OuXStX3FMQP+AfvMUCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-reIw4uXJNEKScM-nhZsH8A-1; Thu, 08 Oct 2020 20:48:47 -0400
X-MC-Unique: reIw4uXJNEKScM-nhZsH8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FF3987950B;
 Fri,  9 Oct 2020 00:48:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3A695D9E8;
 Fri,  9 Oct 2020 00:48:41 +0000 (UTC)
Date: Thu, 8 Oct 2020 20:48:40 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 3/3] tests/acceptance: Test case for detecting -object
 crashes
Message-ID: <20201009004840.GK240186@localhost.localdomain>
References: <20201008202713.1416823-1-ehabkost@redhat.com>
 <20201008202713.1416823-4-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201008202713.1416823-4-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LHvWgpbS7VDUdu2f"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Vikram Garhwal <fnu.vikram@xilinx.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--LHvWgpbS7VDUdu2f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2020 at 04:27:13PM -0400, Eduardo Habkost wrote:
> Add a simple test case that will run QEMU directly (without QMP)
> just to check for crashes when using `-object`.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Cleber Rosa <crosa@redhat.com>
> Cc: "Philippe Mathieu-Daud=E9" <philmd@redhat.com>
> Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  tests/acceptance/object_option.py | 49 +++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 tests/acceptance/object_option.py
>=20
> diff --git a/tests/acceptance/object_option.py b/tests/acceptance/object_=
option.py
> new file mode 100644
> index 0000000000..2b8bd00db1
> --- /dev/null
> +++ b/tests/acceptance/object_option.py
> @@ -0,0 +1,49 @@
> +# Copyright (c) 2020 Red Hat, Inc.
> +#
> +# Author:
> +#  Eduardo Habkost <ehabkost@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import avocado_qemu
> +import subprocess
> +import shlex
> +
> +class ObjectOption(avocado_qemu.Test):
> +    """Check if ``-object`` option behaves as expected"""
> +
> +    def run(self, cmd, *args, **kwargs):
> +        cmdstr =3D ' '.join(shlex.quote(c) for c in cmd)
> +        self.log.info("Command: %s", cmdstr)

Maybe "Running command: %s" is clearer?

> +        return subprocess.run(cmd, encoding=3D'utf-8', *args, **kwargs)

I'd just use `universal_newlines=3DTrue` (equivalent to `text`, but
that's Python 3.7+ only), so the current encoding will be respected.
I understand "utf-8" is a safe choice, but IMO, if someone sets a
different default, it should be respected, unless there's a clear
reason not to do so.

> +
> +    def devices(self):

Maybe call it `get_devices()` or make it a property?

> +        out =3D self.run([self.qemu_bin, '-object', 'help'],
> +                       check=3DTrue, stdout=3Dsubprocess.PIPE).stdout
> +        lines =3D out.split('\n')
> +        return [l.strip() for l in lines[1:] if l.strip()]
> +

In case the `CalledProcessError` is raised on subprocess.run(), the
following test status will be ERROR, which is a condition you were not
testing for, something unexpected.  Given that you're using `check=3DTrue`,
I'd decorate this test with:

   @avocado.fail_on(subprocess.CalledProcessError)

> +    def test_help(self):
> +        """Check if ``-object ...,help`` behaves as expected"""
> +        for device in self.devices():
> +            self.run([self.qemu_bin, '-object', '%s,help' % (device)],
> +                     check=3DTrue,
> +                     stdout=3Dsubprocess.DEVNULL)
> +
> +    def test_crash(self):
> +        """Check for crashes when using ``-object ...``"""

Maybe change the wording here, given that this is really checking that
QEMU doesn't crash, right?  So something like "Checks that QEMU
doesn't crash ..." seems clearer to me.

> +        for device in self.devices():
> +            r =3D self.run([self.qemu_bin, '-object',
> +                                '%s,id=3Dobj0' % (device),
> +                                '-monitor', 'stdio'],
> +                         input=3D'quit\n',
> +                         stdout=3Dsubprocess.DEVNULL,
> +                         stderr=3Dsubprocess.PIPE)

I know adding command line options to QEMU (specially at this stage)
is, at the very least, frowned upon, but I can't help to think that an
option similar to Python's "-c" would be very helpful in testing
scenarios.

> +            if r.returncode not in (0, 1):
> +                self.log.warn("QEMU stderr: %s", r.stderr)
> +                self.log.warn("QEMU exit code: %d", r.returncode)
> +                if r.returncode < 0:
> +                    self.fail("QEMU crashed")
> +                else:
> +                    self.fail("Unexpected exit code")
> --=20
> 2.26.2
>=20

This looks fine, but this test is clearly provocative (at least to
me), given at it's a bit more barebones than the approached used in
"empty_cpu_model.py".  It seems to show the need for:

1) a custom test class (similar to avocado_qemu.Test) that can be
   more suitable to more barebones tests like this

2) a custom QEMU "varianter" implementation we've talked about in the
   past, with which the test code could be simplified.  For instance,
   setting hypothetical configuration "qemu-varianter=3Dobjects" could
   produce:

  [ {"object": "authz-list"},
    {"object": "authz-list-file"},
    ...
    {"object": "tls-creds-x509"} ]

I had not attempted this before, because Avocado was limited to
applying variants globally to a job.  Starting with version 81.0
(released a month or so ago), this is no longer a limitation.

A simple PoC is here:

  https://gitlab.com/cleber.gnu/qemu/-/commit/30f26b662326502c2d82aabca2250=
09ccdebe6aa

Can be run with:

  ./tests/venv/bin/python job_object_option.py

And the tests themselves would look like this:

  https://paste.centos.org/view/4c5f413d

Let me know if any of this makes sense.

Thanks,
- Cleber.

--LHvWgpbS7VDUdu2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9/s2MACgkQZX6NM6Xy
CfMJTw//UY6+/7iF+Anh6eKYyeYStI+Ld+Eu1zkmpcPaQ8d9rnjyetyhcDN04ZEs
7+Akr+hDxL/OfwUo3HT44gDkQVG+NgKYQkvUdLqFLCTLSkffgaX5wrd7Z1WHiDvY
Vchl6IZ8QL8lgAJmcMTuc6hCkpbvnPgmowhWiP2hrUOOxd13Rs5ScDBxHNLhO5Z3
VUn3Mul9n2wGTtU6lV+6t2RDGOTf3thkB3N/PQFmaxPAQ7r7D3fUijEnUzav4cJT
ya63D885CqwgHik6muV6zUJT+eMUSwT+Nugx4zU7HzGyvbsMB2lf8xMDdm1rC3OT
fTE8Yrh3+FugoCBWhZav/2Bi9iA1auJyf7AXoc0/zGjdPK57jUqLm4WnA7sJqbeu
ygLJQLJd/ubhAW67dPa6uIFftL9cL2hsgHk3c1/2we5Yu6CPB17WM7f2WDsdHG6/
4xFlcQlgFoCOxiiB/xCncrvhsWgVMnVQDr1iaX72n45r2BBukQ9cJHUVnmKWtNKt
NExRUPUUIV1YU6FoEWl8UClqf4AEyrsjz293En2bCS71smoKZvCj9wF+jv5+ozOP
uoLsqF6S5hbsc7iAohaAzyRubiZusZ+G/7H3b9nweAR57x/p/2GpX0sKQhIK4va+
13D2lS9A0WUYY3VIhvXgztq7YxvmbdhwecIYaZU/ntHwdMabGYc=
=QQQ0
-----END PGP SIGNATURE-----

--LHvWgpbS7VDUdu2f--


