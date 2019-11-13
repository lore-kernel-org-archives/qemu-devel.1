Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E523DC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 13:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4B9222BD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 13:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIlpLYE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4B9222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUslz-0003L1-Rl
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 08:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iUskx-0002T3-Vw
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iUskv-0007df-UN
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:32:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38895
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iUskr-0007ap-W9
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573651936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ov8V4FHwBeAN3WrtICHv61hTPeLLJuA4gdTTu53/p/w=;
 b=MIlpLYE2drokCziNHmgbQ1KbKYKEMtMzIeuSFx1+1aHaATr8J2mroR18bc1XFr41QIYrXb
 FjLPDaQovAl7eISSWRWgr2YlpPvQu5RMufEzXt/R6a+LPTCMZfpOeb37To7uhsJgPoD0cL
 AJ8xPP2er+MxNGy9Nqmqoor3xJQSiko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-xoCkUO6zOfextzC6BAyq6Q-1; Wed, 13 Nov 2019 08:32:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4219107ACC6;
 Wed, 13 Nov 2019 13:32:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-183.ams2.redhat.com
 [10.36.116.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCC595DA7C;
 Wed, 13 Nov 2019 13:32:00 +0000 (UTC)
Subject: Re: [PATCH v1 1/5] tests/vm: make --interactive (and therefore
 DEBUG=1) unconditional
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191113115952.775-1-alex.bennee@linaro.org>
 <20191113115952.775-2-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7b29d4db-8ea4-5a81-de17-56ae3973ce82@redhat.com>
Date: Wed, 13 Nov 2019 14:31:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191113115952.775-2-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: xoCkUO6zOfextzC6BAyq6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org,
 f4bug@amsat.org, cota@braap.org, stefanha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/11/2019 12.59, Alex Benn=C3=A9e wrote:
> While the concept of only dropping to ssh if a test fails is nice it
> is more useful for this to be unconditional. You usually just want to
> get the build up and running and then noodle around debugging or
> attempting to replicate.
>=20
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> ---
> v2
>   - fix spelling
> ---
>  tests/vm/basevm.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 91a9226026d..0b8c1b26576 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -403,7 +403,7 @@ def main(vmcls):
>      exitcode =3D 0
>      if vm.ssh(*cmd) !=3D 0:
>          exitcode =3D 3
> -    if exitcode !=3D 0 and args.interactive:
> +    if args.interactive:
>          vm.ssh()
> =20
>      if not args.snapshot:
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>


