Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B1ECA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 21:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA5E21479
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 21:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NM5r9F1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA5E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPCtG-0000UR-1f
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 17:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPCsL-000857-Kg
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 17:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPCsJ-0002Xr-8v
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 17:48:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56895
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPCsJ-0002Xe-51
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 17:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572299310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+FnY556XaZabap60WeHUAdd6eReXn9Du3eL04jCWAA=;
 b=NM5r9F1xDItWqBuSCnKR/Z6ktxgodhJY23g/JTRgTqEFWzD2+eXJ6S0bnO/vovmenYABd0
 ig4Cz6FspQpbwlmBPZXTCMq4AsRD7g6EToT5rGeOoEoSg2306nFsKXN61bUBqkJ5LYqpqF
 yDfCIbEwKfIZxUn3972IG61O360Tolg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-BIjXZ882PruftRhWxT2NLQ-1; Mon, 28 Oct 2019 17:48:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB0671005510;
 Mon, 28 Oct 2019 21:48:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22CEF61F30;
 Mon, 28 Oct 2019 21:48:10 +0000 (UTC)
Date: Mon, 28 Oct 2019 17:48:08 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 25/26] tests/boot_linux_console: Add sdcard test for the
 Exynos4210
Message-ID: <20191028214808.GG18794@localhost.localdomain>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-26-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191028073441.6448-26-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: BIjXZ882PruftRhWxT2NLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 08:34:40AM +0100, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> This test boots a Linux kernel on a smdkc210 board and verify
> the serial output is working.
>=20
> The cpio image used comes from the linux-build-test project:
> https://github.com/groeck/linux-build-test
>=20
> Since this test is not reliable due to clock timing issues,
> it is disabled with the 'skip' property.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> v2:
> - use archive.gzip_uncompress (Cleber)
> - check getenv(AVOCADO_ALLOW_UNTRUSTED_CODE) (pm215)
> ---
>  tests/acceptance/boot_linux_console.py | 47 ++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index cbb8cddf47..489df4862c 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -13,6 +13,7 @@ import lzma
>  import gzip
>  import shutil
> =20
> +from avocado import skip
>  from avocado import skipUnless
>  from avocado_qemu import MachineTest
>  from avocado_qemu import exec_command_and_wait_for_pattern
> @@ -474,6 +475,52 @@ class BootLinuxConsole(MachineTest):
>          self.wait_for_console_pattern('Boot successful.')
>          # TODO user command, for now the uart is stuck
> =20
> +    @skip("unstable clock timings")
> +    def test_arm_exynos4210_sdcard(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:smdkc210
> +        """
> +        deb_url =3D ('https://snapshot.debian.org/archive/debian/'
> +                   '20190928T224601Z/pool/main/l/linux/'
> +                   'linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.d=
eb')
> +        deb_hash =3D 'fa9df4a0d38936cb50084838f2cb933f570d7d82'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinuz-4.19.0-6-armm=
p')
> +        dtb_path =3D '/usr/lib/linux-image-4.19.0-6-armmp/exynos4210-smd=
kv310.dtb'
> +        dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> +
> +        rootfs_url =3D ('https://github.com/groeck/linux-build-test/raw/=
'
> +                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
> +                      'arm/rootfs-armv5.ext2.gz')
> +        rootfs_hash =3D '093e89d2b4d982234bf528bc9fb2f2f17a9d1f93'
> +        rootfs_path_gz =3D self.fetch_asset(rootfs_url, asset_hash=3Droo=
tfs_hash)
> +        rootfs_path =3D os.path.join(self.workdir, 'rootfs.ext2')
> +        archive.gzip_uncompress(rootfs_path_gz, rootfs_path)
> +
> +        self.vm.set_machine('smdkc210')
> +        self.vm.set_console(console_index=3D1)

This also depends on the resolution of the
'QEMUMachine._console_index' question.

- Cleber.


