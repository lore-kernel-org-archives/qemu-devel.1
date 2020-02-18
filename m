Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC90C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEF0207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSNVlP3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEF0207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3w3H-00060k-4i
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3w2i-0005cG-VU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:07:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3w2h-0003pM-Li
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:07:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57043
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3w2h-0003pC-I1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582006054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jlVia0qwAwWGAw5A5pmixvpnUmjU15bvqrCiw2jdnJM=;
 b=bSNVlP3F+faBxv84hBgTKtVWdRP5CSCZHbEm2K8MGkHRFmyiqUkHBpUR6YBRBKpy0DB0nw
 mcRp4s/M4bNklUu0xWifs9PPzXjhzPWgkHvwQ/kouOabn2wnDsbF1Zk4tcEPzkzqUm92o1
 dwkBu5v7YTYnSMpWP7GpbImAAB4lni4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-sB9-ILdiMvKuUZz_qZV7vw-1; Tue, 18 Feb 2020 01:07:32 -0500
Received: by mail-wm1-f70.google.com with SMTP id 7so571926wmf.9
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SDxzlX2W6Xk3p7gYBl5BSHXJp7weTrLh74UZFqknAaY=;
 b=A5w892nclt+ia/7scN9St2ZoF6PbRCgM4WZxSOLsJeS4uy/bCOtfQDrXqC6SNuwVcU
 /2YObvz4unfr4VVruYIeaewPsMYDfGI9FD5y2vt7DjIV60tt4gKA+lSdOBiBIAtYcgm/
 pq7v+Y3hQ4YF+2ehgVCENkcB1lUpP5CVsQSb5ta5Iktg7+BZug+Z4YLJIUJgQDIB7m1A
 dDHRHsZKb6kTEHYoJlQYE8iHGzMUq171TZBBH1AgJdIKUE3vCJW4dxI9J2cVxO0abPC7
 hJkEEI2ikl0l1NivTPSK6CmrNln9x6GXM7mBQi+AcQ2zm2hfwSCA7B5zslVRXrL/tcNq
 ZBbA==
X-Gm-Message-State: APjAAAWTjH+vND1BinGvbACAWDpVNxYkxZm32VWAAzx7QsgfWIH3z163
 cR6/VqrP/a+kX8wLQd0i9lnMFwW7iA0+5aFM7ugK+7S8bLoX8CF+tJ1mZEc+mXmnlnqHm7fI3Wh
 gPPdY2h10QG7z2Bc=
X-Received: by 2002:adf:f10a:: with SMTP id r10mr26900536wro.202.1582006051595; 
 Mon, 17 Feb 2020 22:07:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7wN179Bb32cTkP7U72iC4OKtk5iTMi2t0EnBOS27/pHbRqIwUQMBpUNEZvsN72Y8ixGEBDg==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr26900519wro.202.1582006051402; 
 Mon, 17 Feb 2020 22:07:31 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id f8sm208590wrt.28.2020.02.17.22.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 22:07:30 -0800 (PST)
Subject: Re: [RFC PATCH v2 3/3] tools/virtiofsd/fuse_lowlevel: Fix
 fuse_out_header::error value
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200217094240.9927-1-philmd@redhat.com>
 <20200217094240.9927-4-philmd@redhat.com> <20200217200645.GF3434@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c843c960-3eb2-5f00-e855-372481d0309e@redhat.com>
Date: Tue, 18 Feb 2020 07:07:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217200645.GF3434@work-vm>
Content-Language: en-US
X-MC-Unique: sB9-ILdiMvKuUZz_qZV7vw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:06 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
>> Fix warning reported by Clang static code analyzer:
>>
>>      CC      tools/virtiofsd/fuse_lowlevel.o
>>    tools/virtiofsd/fuse_lowlevel.c:195:9: warning: Value stored to 'erro=
r' is never read
>>            error =3D -ERANGE;
>>            ^       ~~~~~~~
>>
>> Fixes: 2de121f01e
>> Reported-by: Clang Static Analyzer
>> Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Nice, this actually fixes 3db2876

Good catch, so this fix can be applied to QEMU (while patch #1 needs=20
backport from upstream libfuse), right?

>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks.

>=20
>> ---
>> RFC because untested
>> ---
>>   tools/virtiofsd/fuse_lowlevel.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowl=
evel.c
>> index 704c0369b2..2dd36ec03b 100644
>> --- a/tools/virtiofsd/fuse_lowlevel.c
>> +++ b/tools/virtiofsd/fuse_lowlevel.c
>> @@ -192,7 +192,7 @@ int fuse_send_reply_iov_nofree(fuse_req_t req, int e=
rror, struct iovec *iov,
>>  =20
>>       if (error <=3D -1000 || error > 0) {
>>           fuse_log(FUSE_LOG_ERR, "fuse: bad error value: %i\n", error);
>> -        error =3D -ERANGE;
>> +        out.error =3D -ERANGE;
>>       }
>>  =20
>>       iov[0].iov_base =3D &out;
>> --=20
>> 2.21.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


