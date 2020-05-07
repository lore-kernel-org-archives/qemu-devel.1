Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C84C47257
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CA9218AC
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aP2aHK7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CA9218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkh7-0003CW-LY
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkY2-0000or-46
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:43:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkY0-00035X-1n
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588873379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QqXs+4p0UzibebDzREgeiVymJKSTSD/jei/aikWxysM=;
 b=aP2aHK7rPUCc3ar1t9x3C3roINg2NM4YHDiiZKZnmrc69BQ81OI9iXuGm+4yLH8SnBiP+Y
 GrN7ZRsxiIfewOI9dAygGuSuViwfaJ/XxYEEoVSsq29AEOhKoAA6YEW9uwy6JTk2omjSkN
 58ObhY47bSvdl5WX7kh7XeGDeqNuI1U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-A_Gi0DOHMVWRpHhk0jUnSA-1; Thu, 07 May 2020 13:42:57 -0400
X-MC-Unique: A_Gi0DOHMVWRpHhk0jUnSA-1
Received: by mail-ej1-f69.google.com with SMTP id a23so3224432ejv.14
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F7GGoxEF3psu6MRTXWTgeCNDDYeHsWjOqb0+9njiZtU=;
 b=T4boMzTDctKXVp1rxVpDIJ9AjpyVb72/wjgVxiNZK1SaSmfXyZ7Lu5Qs8884n4agnY
 SJy+3lSMYooJ8b9ixFw8uXnWSkkzQr2+Vbr/OgZlxSPchiYVHVlF0Sof6KrKXHr52qef
 Ny+L8wRa/sDETSuvQurMt4lTjp3IE0ahV1XCMqzxd/hfY9Eze445eS0PRhRu5Gu56Hx9
 bvYNXkJyom1q43XYfdGbio5ojmZoU3oZz9hnggimrxZ07FmaL3unnshhQXMg3u0sTHlO
 0wUPWQpdjJp0fBFM43UUXIouPcp4R7D2gTkycco5wkj6hLh+Gcj6rFtvO/TcT5jskJ0j
 JMHQ==
X-Gm-Message-State: AGi0PuYzfksdtjsmnKwddfqDLgn46kDQSOGwLHMBxQ/zVNB4XosiUjPh
 N2XRPUfvV+eTqF8cUJuSA26zGu6cwk0quazpteH+DrEgYEGPBueElBLVdmFPWheXKCsRjclkhe5
 boZgaf6LYMBfIwTw=
X-Received: by 2002:a05:6402:1766:: with SMTP id
 da6mr12795803edb.119.1588873376477; 
 Thu, 07 May 2020 10:42:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypKAOIbzI830xSvBzDNleX77ZWkTaPgP+bPdn2JhJxW/bz0S3S3ozoTS79tQ9UBvRKXddDwGBQ==
X-Received: by 2002:a05:6402:1766:: with SMTP id
 da6mr12795770edb.119.1588873376233; 
 Thu, 07 May 2020 10:42:56 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m5sm636707ejk.27.2020.05.07.10.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 10:42:55 -0700 (PDT)
Subject: Re: [PATCH 08/10] hw/block: Let the NVMe emulated device be
 target-agnostic
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200507173958.25894-1-philmd@redhat.com>
 <20200507173958.25894-9-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <322769a8-59b1-10e0-cd28-134cf66fa113@redhat.com>
Date: Thu, 7 May 2020 19:42:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200507173958.25894-9-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 7:39 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Now than qemu_ram_msync() has been ...

Oops =3D)

"Now than qemu_ram_msync() is no more target-specific, we can
make this device-generic."

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   hw/block/Makefile.objs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
> index 47960b5f0d..8855c22656 100644
> --- a/hw/block/Makefile.objs
> +++ b/hw/block/Makefile.objs
> @@ -13,6 +13,6 @@ common-obj-$(CONFIG_SH4) +=3D tc58128.o
>  =20
>   obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk.o
>   obj-$(CONFIG_VHOST_USER_BLK) +=3D vhost-user-blk.o
> -obj-$(CONFIG_NVME_PCI) +=3D nvme.o
> +common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
>  =20
>   obj-y +=3D dataplane/
>=20


