Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDFEC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 01:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF102073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 01:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4q2ixC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF102073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icfcr-0006Kw-9F
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 20:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1icfbh-0005Vq-Bb
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 20:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1icfbe-00058C-QW
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 20:07:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37844
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1icfbe-000530-6j
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 20:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575508017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUjQ2mKJAhKs192k1MpvPZr39Y82vEShtk3lZH2kAA8=;
 b=Z4q2ixC4M6yT13X6NQC6wzx3FKlUsZ4gqPJCE/b6QWPyoox+2wgjeWId+OTE/Vk3GOArvp
 tAkPPXNTm8FeoIVF+rWcvHCVMBRbbRpGNPzD1grwf5rKSTnn7jqxFKoNvhBQWy4+CCD2WG
 vPw1JiXDdt1bSuDKYE8Lhcs0WTnvy/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-CzDPwS52Obi3w3gqDe5IRQ-1; Wed, 04 Dec 2019 20:06:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECB7018543A0;
 Thu,  5 Dec 2019 01:06:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-37.rdu2.redhat.com
 [10.10.125.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1818C19C6A;
 Thu,  5 Dec 2019 01:06:46 +0000 (UTC)
Date: Wed, 4 Dec 2019 20:06:44 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 1/7] iotests: Provide a function for checking the
 creation of huge files
Message-ID: <20191205010644.GA9976@localhost.localdomain>
References: <20191204154618.23560-1-thuth@redhat.com>
 <20191204154618.23560-2-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191204154618.23560-2-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: CzDPwS52Obi3w3gqDe5IRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: qemu-block@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Eric Auger <eric.auger@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 04, 2019 at 04:46:12PM +0100, Thomas Huth wrote:
> Some tests create huge (but sparse) files, and to be able to run those
> tests in certain limited environments (like CI containers), we have to
> check for the possibility to create such files first. Thus let's introduc=
e
> a common function to check for large files, and replace the already
> existing checks in the iotests 005 and 220 with this function.
>=20
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/005       |  5 +----
>  tests/qemu-iotests/220       |  6 ++----
>  tests/qemu-iotests/common.rc | 10 ++++++++++
>  3 files changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
> index 58442762fe..b6d03ac37d 100755
> --- a/tests/qemu-iotests/005
> +++ b/tests/qemu-iotests/005
> @@ -59,10 +59,7 @@ fi
>  # Sanity check: For raw, we require a file system that permits the creat=
ion
>  # of a HUGE (but very sparse) file. Check we can create it before contin=
uing.
>  if [ "$IMGFMT" =3D "raw" ]; then
> -    if ! truncate --size=3D5T "$TEST_IMG"; then
> -        _notrun "file system on $TEST_DIR does not support large enough =
files"
> -    fi
> -    rm "$TEST_IMG"
> +    _require_large_file 5T
>  fi
> =20
>  echo
> diff --git a/tests/qemu-iotests/220 b/tests/qemu-iotests/220
> index 2d62c5dcac..15159270d3 100755
> --- a/tests/qemu-iotests/220
> +++ b/tests/qemu-iotests/220
> @@ -42,10 +42,8 @@ echo "=3D=3D Creating huge file =3D=3D"
> =20
>  # Sanity check: We require a file system that permits the creation
>  # of a HUGE (but very sparse) file.  tmpfs works, ext4 does not.
> -if ! truncate --size=3D513T "$TEST_IMG"; then
> -    _notrun "file system on $TEST_DIR does not support large enough file=
s"
> -fi
> -rm "$TEST_IMG"
> +_require_large_file 513T
> +
>  IMGOPTS=3D'cluster_size=3D2M,refcount_bits=3D1' _make_test_img 513T
> =20
>  echo "=3D=3D Populating refcounts =3D=3D"
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 0cc8acc9ed..6f0582c79a 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -643,5 +643,15 @@ _require_drivers()
>      done
>  }
> =20
> +# Check that we have a file system that allows huge (but very sparse) fi=
les
> +#
> +_require_large_file()
> +{
> +    if ! truncate --size=3D"$1" "$TEST_IMG"; then
> +        _notrun "file system on $TEST_DIR does not support large enough =
files"
> +    fi
> +    rm "$TEST_IMG"
> +}
> +
>  # make sure this script returns success
>  true
> --=20
> 2.18.1
>=20

This is a good refactor even without considering the CI environment
issues it will help to address.

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>


