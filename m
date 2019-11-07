Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FA3C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D292084C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVDQUHXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D292084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSnNo-0008MO-7x
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 14:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iSnMd-0007fS-9l
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:22:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iSnMb-0004jF-L9
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:22:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45907
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iSnMb-0004i7-BI
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573154556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gsw9PzAc0IEqdWb8I5TaIHJ8iFmBGaGz56fn5j28d4=;
 b=hVDQUHXvVEDUuS2SKHLNd2SNtt3xyH+Rx5M8ShfsiNUv0P+GICyx9ZafVv9NKJ4GuN4L+1
 OZbKtAQZk0U+yh6wI0CKh4UEzFB1TokjSyhaQItVOx4ed/JgwdHEJ+LS074oRe8m5PZH08
 NhlGK+OGTkFBCXN1qyJALwmI6cy9apQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-r5amCxuRMu6LI46MmA47Rg-1; Thu, 07 Nov 2019 14:22:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3E221005500;
 Thu,  7 Nov 2019 19:22:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-91.gru2.redhat.com
 [10.97.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6D1760BEC;
 Thu,  7 Nov 2019 19:22:25 +0000 (UTC)
Subject: Re: [PATCH v7 5/8] Acceptance tests: keep a stable reference to the
 QEMU build dir
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-6-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <5a8c7d1a-a7b7-2b7c-2ac6-fe79d7dcd1e8@redhat.com>
Date: Thu, 7 Nov 2019 17:22:24 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191104151323.9883-6-crosa@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: r5amCxuRMu6LI46MmA47Rg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Beraldo Leal <bleal@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/4/19 1:13 PM, Cleber Rosa wrote:
> This is related to the the differences in in-tree and out-of-tree
> builds in QEMU.  For simplification, <BLD> means my build directory.
>
> Currently, by running a `make check-acceptance` one gets (in
> tests/acceptance/avocado_qemu/__init__.py):
>
>     SRC_ROOT_DIR: <BLD>/tests/acceptance/avocado_qemu/../../..
>
> This in itself is problematic, because after the parent directories
> are applied, one may be left not with a pointer to the build directory
> as intended, but with the location of the source tree (assuming they
> differ). Built binaries, such as qemu-img, are of course not there and
> can't be found.
>
> Given that a Python '__file__' will contain the absolute path to the
> file backing the module, say:
>
>     __file__: <BLD>/tests/acceptance/avocado_qemu/__init__.py
>
>                    |  4  |     3    |      2     |     1     |
>
> A solution is to not "evaluate" the third parent dir (marked as 4
> here) because that ends up following the "tests" directory symlink to
> the source tree.  In fact, there's no need to keep or evaluate any of
> the parent directories, we can just drop the rightmost 4 components,
> and we'll keep a stable reference to the build directory (with no
> symlink being followed).  This works for either a dedicated build
> directory or also a combined source and build tree.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index 6618ea67c1..17ce583c87 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -16,7 +16,7 @@ import tempfile
>  =20
>   import avocado
>  =20
> -SRC_ROOT_DIR =3D os.path.join(os.path.dirname(__file__), '..', '..', '..=
')
> +SRC_ROOT_DIR =3D os.path.dirname(os.path.dirname(os.path.dirname(os.path=
.dirname(__file__))))

In this case, wouldn't make sense to rename the constant from=20
SRC_ROOT_DIR to BUILD_ROOT_DIR?

This patch looks good to me besides that.

- Wainer

>   sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
>  =20
>   from qemu.machine import QEMUMachine


