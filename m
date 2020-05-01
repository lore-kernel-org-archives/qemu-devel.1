Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4125DC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043A5208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpjU//eG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043A5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUVGK-00014B-3O
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 08:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUVFl-0000aU-Dr
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUVFk-00049i-1t
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:58:53 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUVFj-00049O-HT
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:58:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id k12so5870974wmj.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 05:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=wkZPhGS/1psm2tq+lOyOdVxJool2RQ12LQ7K0xxlDeM=;
 b=QpjU//eGecWAlbZ0T9aTUW9v4/0bWKLusw6OuFLcRj+eDFIoCrk+lfhYdsMMdOVEEf
 lLlW9shjMhjnfd+gnS6AfUPD0Vy785INgMFhUzirOX4VdCbkhPNeIRq39frxI06bdyOu
 gVgK3v9QHJsYKrGVu41H/dFVTcLyGeH2+EmOz+/g7zpmqnYPLWjWyoS9QkMqTUhirQpT
 CvK5WtvBvWS5H5JXy9Y/6zv3VEKFRpIFPjDr3AHD6SD6WjYPh4c4UKBYxg3WD/dWMnfj
 sLIgoj/h0iTcqnx80QTcqUhRoTI82+ixiyXb686ipxV+n1SBokfmm6F3gWcDf0Uu7vS7
 yCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=wkZPhGS/1psm2tq+lOyOdVxJool2RQ12LQ7K0xxlDeM=;
 b=tuoaKDWoZ2TfVOc9dJr9GoD3GRjfVi2w86pxoR5ab0RGOzUCiwOavZq9ly2K+wmmmV
 zEZG46UL3pbBTZHjlyUXSOzIZHcKld+Dm14t0mghFFzxfVXT8gDzXu3nfaNrYuKT61fF
 kMICCoFHbbYtklkwzqAffx2RrIW6frYKzyVist+JbDkn9U3GEqqcbPja7H3nDN0tAWyn
 pvF7LtvcViGSdSczXEDBHdi+C7D+EwbLc+9wW88MOPvD0l1d3oNU7Mv8Z0uk0rOvjcOf
 IEcz0Xc1pCEbmuYkwEqZyax4PmKfYXltsFCLl0SERtXCNE54GiT6OgAXRaSuUXqwpdXV
 zddQ==
X-Gm-Message-State: AGi0Pua6QDY2hCdTptHyEe7H/x/T8AMx9mXROBoQnBsrMT4o7RTiAMZb
 6rAtRgBqmng9lL7J9ShOLEOv9qrt8iE=
X-Google-Smtp-Source: APiQypIj1l0RXJFFqYB0zNsrCVb4Z5wjsI+LPVb7BfsEvI4zt05pRK1QZjFTedEhw3lr8hafEHEz1g==
X-Received: by 2002:a1c:4b12:: with SMTP id y18mr4049459wma.149.1588337929633; 
 Fri, 01 May 2020 05:58:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j13sm4161659wro.51.2020.05.01.05.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 05:58:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A8D501FF7E;
 Fri,  1 May 2020 13:58:47 +0100 (BST)
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501111505.4225-5-alex.bennee@linaro.org>
 <ad941829-a2f3-6ef3-6251-0681b36be24a@redhat.com>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v1 4/4] .travis.yml: reduce the load on [ppc64] GCC
 check-tcg
In-reply-to: <ad941829-a2f3-6ef3-6251-0681b36be24a@redhat.com>
Date: Fri, 01 May 2020 13:58:47 +0100
Message-ID: <877dxvke0o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/1/20 1:15 PM, Alex Benn=C3=A9e wrote:
>> This seems to be timing out quite often and occasionally running out
>> of disk space. Relegate it to light duties.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   .travis.yml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/.travis.yml b/.travis.yml
>> index 49267b73b3..fe708792ca 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -458,7 +458,7 @@ jobs:
>>             - genisoimage
>>         env:
>>           - TEST_CMD=3D"make check check-tcg V=3D1"
>> -        - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTMMU=
_TARGETS},ppc64le-linux-user"
>> +        - CONFIG=3D"--disable-containers --target-list=3Dppc64-softmmu,=
ppc64le-linux-user"
>
> Cc'ing David, since I'm not sure about this one... Maybe split as we
> did with other jobs?

We could do but it lengthens the run even more. Having
ppc64le-linux-user ensures we exercise the majority of the TCG code
generator so I think the only area we aren't covering is the PPC TCG
softmmu backend. We could add another softmmu target but I didn't want
to play favourites.

>
>>         - name: "[s390x] GCC check-tcg"
>>         arch: s390x
>>=20


--=20
Alex Benn=C3=A9e

