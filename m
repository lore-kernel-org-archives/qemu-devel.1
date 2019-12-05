Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2D9C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5F62464D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrSeyJ+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5F62464D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icw5y-00056Z-6M
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1icw4L-000444-IZ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1icw4C-0007dI-Va
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:41:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1icw4C-0007a2-H0
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575571291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MnMz7dRHtgI5UQt9DBgHPyQOuLxeMns84kuvxpBbf/Q=;
 b=TrSeyJ+k9senfqyO0Q1KBRgXJFyOLhuFG26oAw2mzh9HQh7sZ3iQ0QMBoX4lncJ2/r2A8C
 DFYBNCicJejMXigUr+2JRMFEXs5Smy5ZHyEhUBm5+pIQELsD+ISrucjibm5goALtisB77y
 4iqvzKstZiZ8hCQHn0T/QXfEntfHYzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-k4t1wV0nMsmTAQkiD1q2yA-1; Thu, 05 Dec 2019 13:41:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1AA11093B6E;
 Thu,  5 Dec 2019 18:41:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-37.rdu2.redhat.com
 [10.10.125.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 714345D6A3;
 Thu,  5 Dec 2019 18:41:20 +0000 (UTC)
Date: Thu, 5 Dec 2019 13:41:18 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 2/7] iotests: Skip test 060 if it is not possible to
 create large files
Message-ID: <20191205184118.GB29262@localhost.localdomain>
References: <20191204154618.23560-1-thuth@redhat.com>
 <20191204154618.23560-3-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191204154618.23560-3-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: k4t1wV0nMsmTAQkiD1q2yA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Wed, Dec 04, 2019 at 04:46:13PM +0100, Thomas Huth wrote:
> Test 060 fails in the arm64, s390x and ppc64le LXD containers on Travis
> (which we will hopefully enable in our CI soon). These containers
> apparently do not allow large files to be created. The repair process
> in test 060 creates a file of 64 GiB, so test first whether such large
> files are possible and skip the test if that's not the case.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/060 | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
> index b91d8321bb..d96f17a484 100755
> --- a/tests/qemu-iotests/060
> +++ b/tests/qemu-iotests/060
> @@ -49,6 +49,9 @@ _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
> =20
> +# The repair process will create a large file - so check for availabilit=
y first
> +_require_large_file 64G
> +
>  rt_offset=3D65536  # 0x10000 (XXX: just an assumption)
>  rb_offset=3D131072 # 0x20000 (XXX: just an assumption)
>  l1_offset=3D196608 # 0x30000 (XXX: just an assumption)
> --=20
> 2.18.1
>=20

The behavior and failure is indeed pretty consistent accross those
architectures:

 - arm64: https://travis-ci.org/clebergnu/qemu/jobs/621238740#L4217
 - ppc64le: https://travis-ci.org/clebergnu/qemu/jobs/621238741#L4252
 - s390x: https://travis-ci.org/clebergnu/qemu/jobs/621238742#L4265

And with this, 060 gets skipped properly:

 - arm64: https://travis-ci.org/clebergnu/qemu/jobs/621248591#L4202
 - ppc64le: https://travis-ci.org/clebergnu/qemu/jobs/621248592#L4236
 - s390x: https://travis-ci.org/clebergnu/qemu/jobs/621248593#L4250

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>


