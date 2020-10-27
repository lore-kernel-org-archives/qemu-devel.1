Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FDEC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 00:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B663120882
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 00:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGUv5r5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B663120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXCrP-0004zF-PQ
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 20:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXCqq-0004Wr-MV
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 20:28:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXCqo-00073k-2E
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 20:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603758511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfCtGCv7fyD1l3GrgVxrr1tp+F1tgVs7wfoRQE4G50k=;
 b=CGUv5r5sEksjZDRMgf0BoqHlCo75eZWElgJYtyOLiDsV5BSjOqn+lSJiGcOL4ZAyMpKzi9
 6bCoZZSzNBtxobsztN7Y44Hg8b7FCkrGKVDE7H3nxXcEOgXKaNZbBM8lwmrZo5upnxfLuw
 kOW3RWPrjuME9f4JbzM3KC6Ukmbzb2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-lio90piwPwypwIuOuys7PA-1; Mon, 26 Oct 2020 20:28:29 -0400
X-MC-Unique: lio90piwPwypwIuOuys7PA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E49BD64089;
 Tue, 27 Oct 2020 00:28:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECAF15578D;
 Tue, 27 Oct 2020 00:28:23 +0000 (UTC)
Date: Mon, 26 Oct 2020 20:28:22 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: runaway avocado
Message-ID: <20201027002822.GA2265721@localhost.localdomain>
References: <CAFEAcA8z=vQ9E6hNKUuzk2EgH8Dpkxo=3YbnQ5iX0DYCQDr6bg@mail.gmail.com>
 <caccebbf-e12d-ab91-d631-ae126d8cddf7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <caccebbf-e12d-ab91-d631-ae126d8cddf7@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 avocado-devel <avocado-devel@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 11:43:36PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing avocado-devel@
>=20
> On 10/26/20 11:35 PM, Peter Maydell wrote:
> > So, I somehow ended up with this process still running on my
> > local machine after a (probably failed) 'make check-acceptance':
> >=20
> > petmay01 13710 99.7  3.7 2313448 1235780 pts/16 Sl  16:10 378:00
> > ./qemu-system-aarch64 -display none -vga none -chardev
> > socket,id=3Dmon,path=3D/var/tmp/tmp5szft2yi/qemu-13290-monitor.sock -mo=
n
> > chardev=3Dmon,mode=3Dcontrol -machine virt -chardev
> > socket,id=3Dconsole,path=3D/var/tmp/tmp5szft2yi/qemu-13290-console.sock=
,server,nowait
> > -serial chardev:console -icount
> > shift=3D7,rr=3Drecord,rrfile=3D/var/tmp/avocado_iv8dehpo/avocado_job_w9=
efukj5/32-tests_acceptance_reverse_debugging.py_ReverseDebugging_AArch64.te=
st_aarch64_virt/replay.bin,rrsnapshot=3Dinit
> > -net none -drive
> > file=3D/var/tmp/avocado_iv8dehpo/avocado_job_w9efukj5/32-tests_acceptan=
ce_reverse_debugging.py_ReverseDebugging_AArch64.test_aarch64_virt/disk.qco=
w2,if=3Dnone
> > -kernel /home/petmay01/avocado/data/cache/by_location/a00ac4ae676ef0322=
126abd2f7d38f50cc9cbc95/vmlinuz
> > -cpu cortex-a53
> >=20
> > and it was continuing to log to a deleted file
> > /var/tmp/avocado_iv8dehpo/avocado_job_w9efukj5/32-tests_acceptance_reve=
rse_debugging.py_ReverseDebugging_AArch64.test_aarch64_virt/replay.bin
> >=20
> > which was steadily eating my disk space and got up to nearly 100GB
> > in used disk (invisible to du, of course, since it was an unlinked
> > file) before I finally figured out what was going on and killed it
> > about six hours later...
> >

Ouch!

> > Any suggestions for how we might improve the robustness of the
> > relevant test ?
> >

While this test may be less robust/reliable than others, the core
issue is that the automatic shutdown of the QEMU "vms" can be
improved.  My best guess is that this specific test ended in ERROR,
and (or because?) the tearDown() method failed to end these processes.

All tests can be improved at once by adding a second, even more
forceful round of shutdown.  Currently the process gets, in the worst
case scenario, a SIGKILL.

But, in addition to that, an upper layer above the test could be given
the responsibility to look for and clean up resouces initiated by a
test.  The Avocado job has hooks for running callbacks right before
its own process exits, but, with the new Avocado architecture (AKA "N(ext)
Runner") this should probably be implemented as async cleanup actions
that begin right after a test ends.

I'll give the "second more forceful round of shutdown" approach some
and testing, and in addition to that, open an issue to track the upper
layer resource cleanup on Avocado.

Thanks,
- Cleber.

> > thanks
> > -- PMM
> >=20
>=20
>=20

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+XaaMACgkQZX6NM6Xy
CfO8AQ//Ufzivd8veQ9dorcKqmy3BYhbsvZ+DxU6vCDpg0BQse2V9KdHRCTJIUkh
fFNunpZU4sqzv7a0mlgZdXzkMCMq7A6ZbOOPpVUJR3vZlnukaXc9AqqzWHy7HU+C
OOmVzhCXL9xmPhJU9XM/JdHv4kvyTlDLGfnwFrKEOHrIi4t74VuMdvn5Z99/6oGU
uca+k/Dj4Hes80t+k7+i2TPx0LeMMPpaPsxVXdvTwCr9h7ZSFbu8tJN6re7iVOaT
IaxOzPkB8XNlX30rZ33IgQe7SP34vLZi9Iyck9vfoFKbmsCuty1uAZwoFHCVxMg3
d9f5OqbYBS6EwYXWymkYYcsEz665Hz2ftj5sxx8uP/ENGhRegq9AdUeAZsTsL5uI
VxVCm8Ucp33Gf+DDZG1AzuOo+80C9gf0OZnaIEaIZ7HeMm2kNiIPEJgFkvNTesPF
NwgI5YbP97dYZcE+PdarxW1thVbJCRLg8fS3frQNY/38fP0QmsrDM0BP54VOQuAk
JGR/NyKhWI4qyQMQgSvBa2Lo5+GJ1AvB+X2pomwNdQvUi7Nq/YMxqiJd6+X+REtb
BKMHviGzBfm+UFrbML3e/yh3X58ZDrNskqHGUoSjJ0hs07xChHIKTNEu3Y2H3GpO
3gUvQoH6TNpydvznuGPxvDUHIPhassla6mRBJM10dYQf2Slvb8A=
=vK/q
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--


