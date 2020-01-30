Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D45C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD0620702
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gt16Y4vH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD0620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8aN-0003xY-4o
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 07:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1ix8Zg-0003XR-FS
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:05:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1ix8Zf-0000Uq-C1
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:05:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54453
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ix8Zf-0000T1-8Y
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580385929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y6V2BsTdQLNZ6T4ppkCdoaH1P4ca/tY6cFSaYStgJjc=;
 b=gt16Y4vHX4rOcjkJ+d7mFjvo28SvsWdvtIPuBIjs2Xon1CU2dkxQ7d9QdCHJnTuKTv2uEh
 DpVS+FhVoPGx1AEJQuXnTlVVLRw3oN0e30YHBEN8unm//m8OBRL5hM48AK7cK5vsJUMXIl
 HzUqQdQSfUJI7ie0KqOTL9Tyw1JTzlA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-0r9DVaBoNI6W3eRD-pPsjA-1; Thu, 30 Jan 2020 07:05:10 -0500
Received: by mail-wr1-f72.google.com with SMTP id w6so1602864wrm.16
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 04:05:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pFSsYstpZ987L0uwgGEufdHggvxd5jBZqOvs75niF9w=;
 b=G4w00FqF7l1V5r0QcXvx9xkX2Kuw7rbAkfuPBg4UiLiDv41NOEbs0tVrHtnIr3gFFX
 G/wE3bGVYd0FMqzbtPcM828i8Qs1ldCslqpwCvJ/M7Eo2vRuZLIvz9T1G+18oOEc/XCf
 q1P2fGkD0asZcQPd/Ntvv5Dnz9XjzH7xtzZIVvn4g3+vPlH9lRxfSOfNKPIB/kFGEG7Q
 3yoNN/zcVArhhzGIvY4I5cV+b9PBZ/DI6Utrdr229/B6PUvdZIEfF155oajMOAwHUce5
 G8n6oBwYXZaeEaglUG3ynxb9QywHO4mxGEFN3QY+Cfg9zg/Vp8GyTF3F0dLzULsLAJsM
 SLQw==
X-Gm-Message-State: APjAAAW3mpTMMUlyT40ZUdqolfB/ySVb0tE9i2t/QujIBUF7k9TKAss4
 nnQ6k8LUY+G+NEPZCWOt4Pb2ArXQ1ccwoV0llhwDYlCHzt1P52Qq+6OO/iYrXjRkOAVrCPeaxQC
 7feNiNRoLNeMBVLg=
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr5497755wmi.51.1580385909436;
 Thu, 30 Jan 2020 04:05:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyyYzsJcXfytr0BBj1PtMgaYDMIKiQ51URlnWAiCcNVZuSi0UdPgSrnxwWutQc6dAwprK6qaw==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr5497720wmi.51.1580385909192;
 Thu, 30 Jan 2020 04:05:09 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.4.209])
 by smtp.gmail.com with ESMTPSA id g25sm11890567wmh.3.2020.01.30.04.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 04:05:08 -0800 (PST)
Date: Thu, 30 Jan 2020 13:05:06 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH 5/6] tests/boot_linux_console: add extract_from_rpm method
Message-ID: <20200130120506.mq6tejv5i2k776k5@steredhat>
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-6-git-send-email-liam.merwick@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1580142994-1836-6-git-send-email-liam.merwick@oracle.com>
X-MC-Unique: 0r9DVaBoNI6W3eRD-pPsjA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: fam@euphon.net, slp@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, wainersm@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 27, 2020 at 04:36:33PM +0000, Liam Merwick wrote:
> Add a method to extract a specified file from an RPM to the test's
> working directory and return the path to the extracted file.
>=20
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>  tests/acceptance/boot_linux_console.py | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 43bc928b03a2..6af19ae3b14a 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -51,6 +51,20 @@ class BootLinuxConsole(Test):
>          os.chdir(cwd)
>          return self.workdir + path
> =20
> +    def extract_from_rpm(self, rpm, path):
> +        """
> +        Extracts a file from a rpm package into the test workdir
> +
> +        :param rpm: path to the rpm archive
> +        :param path: path within the rpm archive of the file to be extra=
cted
> +        :returns: path of the extracted file
> +        """
> +        cwd =3D os.getcwd()
> +        os.chdir(self.workdir)
> +        process.run("rpm2cpio %s | cpio -id %s" % (rpm, path), shell=3DT=
rue)
> +        os.chdir(cwd)
> +        return self.workdir + '/' + path
                                  ^
    Is the extra slash needed? (just because the extract_from_deb()
    doesn't put it)

Anyway this patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> +
>      def do_test_x86_64_machine(self):
>          """
>          :avocado: tags=3Darch:x86_64
> --=20
> 1.8.3.1
>=20


