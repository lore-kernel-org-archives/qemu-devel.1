Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F6CC33CB6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DC72467C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kk2or+P+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DC72467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuG3R-00041S-Cr
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 08:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iuFzk-00086l-Tw
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iuFzi-0002tS-12
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:24:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53421
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iuFzh-0002sN-Hu
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579699468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDASLWKqXDyn2TjSq7GpWwyCQd5PZ3Siz+5hj0LkwaA=;
 b=Kk2or+P+o3OWpkoH9VuyrQEXcQQx8zycKeDb4c0hfP7jRoTkXgoDF0txBlAX7RF/lpcijp
 WLqHq9uI4xDkDmdJo5b2dS13UUTpEFoft0FBadfrJBiFp/tB1BFV4ukT6BY7dhnQRqoEkU
 Cmruy8s2O/HNta8H0zvOQENhTSWqpN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-In3GfIgZOIOhZ1l-aqY8_A-1; Wed, 22 Jan 2020 08:24:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BEFFDB61;
 Wed, 22 Jan 2020 13:24:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-68.gru2.redhat.com
 [10.97.116.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CB60845A5;
 Wed, 22 Jan 2020 13:24:13 +0000 (UTC)
Subject: Re: [PATCH v1 2/3] tests/docker: better handle symlinked libs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200122102223.20036-1-alex.bennee@linaro.org>
 <20200122102223.20036-3-alex.bennee@linaro.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <00813be1-eadb-b3c8-2a3c-084302de78b6@redhat.com>
Date: Wed, 22 Jan 2020 11:24:11 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200122102223.20036-3-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: In3GfIgZOIOhZ1l-aqY8_A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/22/20 8:22 AM, Alex Benn=C3=A9e wrote:
> When we are copying we want to ensure we grab the first
> resolution (the found in path section). However even that binary might
> be a symlink so lets make sure we chase the symlinks to copy the right
> binary to where it can be found.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/docker/docker.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 31d8adf836..96d4326d53 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -109,7 +109,7 @@ def _get_so_libs(executable):
>       ensure theright data is copied."""
>  =20
>       libs =3D []
> -    ldd_re =3D re.compile(r"(/.*/)(\S*)")
> +    ldd_re =3D re.compile(r"=3D> ?(/.*/)(\S*)")
>       try:
>           ldd_output =3D subprocess.check_output(["ldd", executable]).dec=
ode('utf-8')
>           for line in ldd_output.split("\n"):
> @@ -145,6 +145,7 @@ def _copy_binary_with_libs(src, bin_dest, dest_dir):
>       if libs:
>           for l in libs:
>               so_path =3D os.path.dirname(l)
> +            real_l =3D os.path.realpath(l)

real_l is not used.

- Wainer

>               _copy_with_mkdir(l, dest_dir, so_path)
>  =20
>  =20


