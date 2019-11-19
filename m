Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EBEC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:30:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FE6208A1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKbTVx3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FE6208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7KY-0008RS-U1
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iX7Iv-0007i5-D2
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iX7Is-000823-C8
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:28:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54496
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iX7Is-00081N-8R
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574184517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPP5TJcKZY0opHcK3J1Fq7WtDbZVvfly1N9BrqSYJXs=;
 b=DKbTVx3+fGG/IkMO82c1QEellDZOCTbNLM5CyC7ROEz/rcn+L9Ss86kqDo8enD2gsZ7lNj
 f4XcVJY6uBmYEH1ciDNXWbgExeeqMI7yOof6AHVpjgMrn0kTZqhXrJgGYOwjAkVE3PPtCm
 JeoQw0vxhv42l44ipCDG4J6WMm5609g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-HzhAl6g3Msq3VNtd8B1xIw-1; Tue, 19 Nov 2019 12:28:35 -0500
Received: by mail-wm1-f69.google.com with SMTP id x16so3003972wmk.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 09:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q5/VoO7CS29nbGMdS4ApW/cjCAgW0FMUMXnKEJHEAJ8=;
 b=elKGOyHBjePmlbsZJsgRPib6T8ypgXV4DHDrSLvoUqByEMyCTZfuwe3JXuotbLYXsG
 YvjkGOWlrIyMypVnA/XDhQB/8fhWuhS7v757AUZATmGesOAj2obe7VKtZBFrfMIWy/Du
 CscMUtk1EfaoWcFKnkaNEalLJzm4wiuR1LZ2QTwqGDQp2joAjzMLjP/1Jck9J0N+IJWF
 npGW2R1IjYRDsvLBTmV/05hlCYTJHAv6x/hD3fc45HUKvGECPaBxEYQY48P+u3e8/Tj8
 4r7VabGVANtKheiD0lOBIUEkyefyYursU04yNN3oOAL5OuQmtv8QGwdHaS3lvOe0LHBZ
 1+QQ==
X-Gm-Message-State: APjAAAV6qs4PhDFBL0gJppAJDEP1MImzNQaAyJQB3bpCa5hEcfO0pd0t
 ceC2Cz+90SDH3nspkIfqISitnPA2nXksOuf9R9ytcnqVjKr1iThlBvhtbV9lOljIJYMFrpT1Dvg
 nZvoMD/RHqRlwY24=
X-Received: by 2002:adf:979a:: with SMTP id s26mr39556754wrb.92.1574184514680; 
 Tue, 19 Nov 2019 09:28:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqwqU+J1Ey3fKUiDKJ55ub90eQSN+qsU3xZv1V0yeiY30wmEmEK1TW27hJH6cnxzLWeV8QvniQ==
X-Received: by 2002:adf:979a:: with SMTP id s26mr39556719wrb.92.1574184514377; 
 Tue, 19 Nov 2019 09:28:34 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id c24sm32161763wrb.27.2019.11.19.09.28.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2019 09:28:33 -0800 (PST)
Subject: Re: [PATCH 3/6] tests/hd-geo-test: Skip test when images can not be
 created
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191119170822.45649-1-thuth@redhat.com>
 <20191119170822.45649-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9aa4803a-9584-1af6-c49f-a8f08146c63c@redhat.com>
Date: Tue, 19 Nov 2019 18:28:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119170822.45649-4-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: HzhAl6g3Msq3VNtd8B1xIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 6:08 PM, Thomas Huth wrote:
> In certain environments like restricted containers, we can not create
> huge test images. To be able to use "make check" in such container
> environments, too, let's skip the hd-geo-test instead of failing when
> the test images could not be created.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/hd-geo-test.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
> index 7e86c5416c..a249800544 100644
> --- a/tests/hd-geo-test.c
> +++ b/tests/hd-geo-test.c
> @@ -34,8 +34,13 @@ static char *create_test_img(int secs)
>       fd =3D mkstemp(template);
>       g_assert(fd >=3D 0);
>       ret =3D ftruncate(fd, (off_t)secs * 512);
> -    g_assert(ret =3D=3D 0);
>       close(fd);
> +
> +    if (ret) {
> +        free(template);
> +        template =3D NULL;
> +    }
> +
>       return template;
>   }
>  =20
> @@ -934,6 +939,10 @@ int main(int argc, char **argv)
>       for (i =3D 0; i < backend_last; i++) {
>           if (img_secs[i] >=3D 0) {
>               img_file_name[i] =3D create_test_img(img_secs[i]);
> +            if (!img_file_name[i]) {
> +                g_test_message("Could not create test images.");
> +                goto test_add_done;
> +            }
>           } else {
>               img_file_name[i] =3D NULL;
>           }
> @@ -965,6 +974,7 @@ int main(int argc, char **argv)
>                          "skipping hd-geo/override/* tests");
>       }
>  =20
> +test_add_done:
>       ret =3D g_test_run();
>  =20
>       for (i =3D 0; i < backend_last; i++) {
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


