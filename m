Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB9FC4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 12:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA04520722
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 12:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvR+xE2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA04520722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFd5c-0002ED-Vg
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 08:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFd4b-0001gj-Ij
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 08:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFd4a-00036t-J2
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 08:17:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47669)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFd4a-00034p-G2
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 08:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584793069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NhqfPHgebbtgw12Pua2pmlPAgy0qPPsZtaPSszZFn5Y=;
 b=JvR+xE2Nngo6i/hHR+TB00lzzKcCnub5O7liZimtAUj7MpqGClvP1HhamZS7dJgq0Dp5Xs
 Zv2cbRgGdD7nwrrWqmAXy+dA7uaYCgnITo4F8kd5o7GSyLGvctWXqZJ97uZ+Bg+PRDJqHV
 fXNBFR6G7nnVvKTVhi7ExtVUpXOVPHA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-FoPhTQOXODOpQLmj6cDhMQ-1; Sat, 21 Mar 2020 08:17:45 -0400
X-MC-Unique: FoPhTQOXODOpQLmj6cDhMQ-1
Received: by mail-ed1-f71.google.com with SMTP id y14so7346281edq.22
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 05:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mug+t6S3sDJMSHBYZ13DZQGxDXFXvwF2VfTQfLzYy2g=;
 b=o3FR/KV3RI7M58EPVYV2+3H5T3+HJ7ayi6s9bOo5td9lyh3fcSWa+KM4KC7oc3kgyO
 Yvn0ayCValQz+S+lfM5Q8t8qS0KbCPb9w1YRi1vnmBNDmtZr9sjy9E1KykoPe6CKi5w6
 l8wiYFCrjTTOf3UKwVgU6NysgHD4NLZP4iDONaSJRUGcMI+DkReuaEMLwhIf7e2JSokC
 Mf+Z/I1ifI3Go7BgqREaw7/hzDC+SAIJPMU7+K2Ti5XLPKLKj/ol8ICdxwTanhKuovyT
 6mXnRsTNAE6TE/Zr/a/UR06Wi2+I2pXHq5Jh2ldEZsF0TMuXS9wA0JffgDp1et8QRFRb
 xcVw==
X-Gm-Message-State: ANhLgQ0lbtpIm6w2JUJgexfDYXohXBJcYn6qQj2RipbiP4N2YHMkHtai
 JSL4cYI7eBNKGCDxnC+VU16n3RjGtO76wdqyF1CDoy3x/0qiIqhwMY9jqQE10bmRJm2IieUJWyL
 ocfGlZdzyN6TEImo=
X-Received: by 2002:aa7:d9d4:: with SMTP id v20mr13042248eds.140.1584793063840; 
 Sat, 21 Mar 2020 05:17:43 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtAuoyZ4BZlKnyQWdAkJYcFT1ahtdDuBhB9SjYDegRh5mWPHIJplKK5p+rnFJ9nE20o4XV9cg==
X-Received: by 2002:aa7:d9d4:: with SMTP id v20mr13042225eds.140.1584793063615; 
 Sat, 21 Mar 2020 05:17:43 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id ci22sm355108ejb.41.2020.03.21.05.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2020 05:17:42 -0700 (PDT)
Subject: Re: [PATCH-for-5.0] tools/virtiofsd/passthrough_ll: Fix double close()
To: qemu-devel@nongnu.org
References: <20200321120654.7985-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <efee418f-d160-2d0e-ca99-e112f0264013@redhat.com>
Date: Sat, 21 Mar 2020 13:17:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200321120654.7985-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/21/20 1:06 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On success, the fdopendir() call closes fd. Later on the error
> path we try to close an already-closed fd. This can lead to
> use-after-free. Fix by only closing the fd if the fdopendir()
> call failed.
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: 7c6b66027 (Import passthrough_ll from libfuse fuse-3.8.0)

libfuse is correct, the bug was introduced in commit b39bce121b, so:

Fixes: b39bce121b (add dirp_map to hide lo_dirp pointers)

> Reported-by: Coverity (CID 1421933 USE_AFTER_FREE)
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tools/virtiofsd/passthrough_ll.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 4f259aac70..4c35c95b25 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -1520,8 +1520,7 @@ out_err:
>       if (d) {
>           if (d->dp) {
>               closedir(d->dp);
> -        }
> -        if (fd !=3D -1) {
> +        } else if (fd !=3D -1) {
>               close(fd);
>           }
>           free(d);
>=20


