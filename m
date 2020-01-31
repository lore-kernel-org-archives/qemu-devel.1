Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11CCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9760520661
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I88ZsZeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9760520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixK56-0004fx-Qr
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 19:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixJol-0001SX-R7
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixJok-00047I-Hj
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:05:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59219
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixJok-00046g-Dc
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580429149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgOGkJX0zSSG4g/ToxKO7oKoa4KbniA6jPGu3h9O+hg=;
 b=I88ZsZeQqM13gR19W0Vn81UYYgcXHNGBFqfMuiTTGyhSw6C4kqWeIT1ghiA/WV9OAeUtzm
 KHQ9Ov6hcPHQNmTiuD6Sfb8szEE53dYFPsFOtoKItyb6MpoA0ZA+HTaMuAOr1VpyrnNG84
 rkmbUPBCzEDC3rfwPnQuHlLh47MHdzM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-d9uRV-WyM2eUMt4PKSQmsA-1; Thu, 30 Jan 2020 19:05:48 -0500
Received: by mail-wr1-f70.google.com with SMTP id j4so2458449wrs.13
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 16:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1kDPehyb9kTgFeLwdaBNOgodn7vYOuttv9DkYxDkbWs=;
 b=O5JJ2GMEB6X5qFbhZ7tzaZ0fGSeTmCw4qG5ix91tx9KoYwFK1xAvSUAzKmawWMCnQ3
 sJoZzNl7P3NNGWLGS+YK89GOwFC2JfbK4YCXQEXTRNmVL/EnJnX+vFfph5tJwwWusVMW
 eOpvtQ2Ndgk+0X5bk3XisFkhhkAO35DnbjRKye8UT6IglExmFlDARSskEtH/nU0ctO7b
 /hOFOPVjgVpFI4cCNO1DJmMqGpLWLtRiwRAmVdCys+r8nfJh2+jYzqX1wnUwelug8Zf3
 e6e32W2UY7iK1TAUQNifTkONOpGThSQ4eRCYUo//467Vovpez3Ah+R6ANWxR/0BQXjtg
 eN9w==
X-Gm-Message-State: APjAAAUYlEYCnRAz3kz9dl4NXRbraJrJh0YLdUomT0bC6Arofl4WaNgz
 DyjFJyM1+vHkPDnqFwrPgaKv1lymBGH9C/cjkUpq00Ht/Y+9rp2RFSEMPiyM3R83q14Ip1Oj0P1
 TPlBHaAhyK62foE0=
X-Received: by 2002:adf:a41c:: with SMTP id d28mr8659436wra.410.1580429147011; 
 Thu, 30 Jan 2020 16:05:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqydR3lX243XEDooXHLS+JtadhniUD7jjfuSCyYSGWNDFD5qJBS91BHZcGkHaI96/BoKabjKPw==
X-Received: by 2002:adf:a41c:: with SMTP id d28mr8659421wra.410.1580429146830; 
 Thu, 30 Jan 2020 16:05:46 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id v8sm9500821wrw.2.2020.01.30.16.05.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 16:05:43 -0800 (PST)
Subject: Re: [PATCH v2 15/29] tests: rename virtio_seg_max_adjust to
 virtio_check_params
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-16-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <72ecf23c-e61e-a03a-d54a-cb30c84b22df@redhat.com>
Date: Fri, 31 Jan 2020 01:05:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-16-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: d9uRV-WyM2eUMt4PKSQmsA-1
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/29/20 10:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> From: Denis Plotnikov <dplotnikov@virtuozzo.com>
>=20
> Since, virtio_seg_max_adjust checks not only seg_max, but also
> virtqueue_size parameter, let's make the test more general and
> add new parameters to be checked there in the future.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Message-Id: <20200129140702.5411-5-dplotnikov@virtuozzo.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   .../{virtio_seg_max_adjust.py =3D> virtio_check_params.py}          | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   rename tests/acceptance/{virtio_seg_max_adjust.py =3D> virtio_check_par=
ams.py} (100%)
>=20
> diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance=
/virtio_check_params.py
> similarity index 100%
> rename from tests/acceptance/virtio_seg_max_adjust.py
> rename to tests/acceptance/virtio_check_params.py
>=20

Thanks, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


