Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E514C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0C721741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBAAnAkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0C721741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iziA2-0000kS-I3
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izi7A-0004vK-P3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izi79-0006kI-Pa
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:26:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23567
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izi79-0006ZO-Lg
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580999201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oz18S0aLEvGN637LGZSCbuwG58nQGD+Y3D2gZCFmsYs=;
 b=EBAAnAkMqqIBdJjnSNJZj7vgu44iUHDXCI6UkzNrzHlwsEAF6Q5iRXArlUGPYNPJdrtxNT
 Q960c9Wg84DQDEs1/17y38nfGOxDEQoi4KkYMAX3Ds4660wsOi13ghToGnW4UcSMrnUoMP
 y3nLSWAeHLorYDV9C9/lJYnjWpqUNcI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-UUk-pS2ONnWrgc_avHi98Q-1; Thu, 06 Feb 2020 09:26:24 -0500
Received: by mail-wr1-f72.google.com with SMTP id n23so3448566wra.20
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 06:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FFNDBTxIsN/JE/W483pJkPea3kJlzJ2aeghIvw22K0U=;
 b=CKLg0ZhugJhiKkM8uGsLKXamyzP0JDd3r0aBKfO/YZOf0Y67hRZD32zD3MOAUwAyen
 nDfhsYms0kutrBBdQ8z3pXLhaOKHKd6vKs+JcfMl252YVrH4lWk9M19nf341EdLIk5We
 5FHOsJtRqAEy+iKiXM8yhVeAGtwNl+mYwoNyNvn/ZPftSN1I4Ca9bqnf6h9I/OWWZMUs
 5U8gPYq+faQNmxSC8973Iil/owpT4bWsxh2xFHxQaPzRy07NKRpBLPmrj+VffdZGr9e8
 6YIrJTYSVWN9Xfy3DU5brEgv1TSf/EMWBipxX/9sRmd2h9oeyWt92iXDCFw2TRqoQEzc
 CDlw==
X-Gm-Message-State: APjAAAX8FnGRSwfEtL+6/1rgL+ZeII1Mtm9833v6sLdXHb3gmNggY2Gq
 53PSnl3je5NmtnZau2qsbzPltQr9fmlCqQVRjyX1eqlrcQSapd0mXuBpjZ86825SztnEX8dfw2Q
 egxT5CVfiJEdccpw=
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr4111696wrm.59.1580999183386; 
 Thu, 06 Feb 2020 06:26:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxof8tCkd3RHHS7p8sH2wyGlYAjw2Ja/icYcLBO/qhc6aDRMFYdVfhcErZJnejmJeVZbJeahA==
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr4111680wrm.59.1580999183197; 
 Thu, 06 Feb 2020 06:26:23 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id v14sm4556283wrm.28.2020.02.06.06.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 06:26:22 -0800 (PST)
Subject: Re: [PATCH v2 6/6] tests/boot_linux_console: use os.path for
 filesystem paths
To: Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net
References: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
 <1580914565-19675-7-git-send-email-liam.merwick@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3372c382-3647-7ea6-6a76-ee889cc3f9a5@redhat.com>
Date: Thu, 6 Feb 2020 15:26:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580914565-19675-7-git-send-email-liam.merwick@oracle.com>
Content-Language: en-US
X-MC-Unique: UUk-pS2ONnWrgc_avHi98Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, wainersm@redhat.com,
 slp@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 3:56 PM, Liam Merwick wrote:
> Change extract_from_deb() to use os.path routines to manipulate the
> filesystem path returned when extracting a file.
>=20
> Suggested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>   tests/acceptance/boot_linux_console.py | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 9c55218cb5bb..434608f12027 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -49,7 +49,12 @@ class BootLinuxConsole(Test):
>           process.run("ar x %s %s" % (deb, file_path))
>           archive.extract(file_path, self.workdir)
>           os.chdir(cwd)
> -        return self.workdir + path
> +        # Return complete path to extracted file.  Because callers to
> +        # extract_from_deb() specify 'path' with a leading slash, it is
> +        # necessary to use os.path.relpath() as otherwise os.path.join()
> +        # interprets it as an absolute path and drops the self.workdir p=
art.
> +        return os.path.normpath(os.path.join(self.workdir,
> +                                             os.path.relpath(path, '/'))=
)
>  =20
>       def extract_from_rpm(self, rpm, path):
>           """
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


