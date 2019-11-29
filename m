Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F4FC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C0FA216F4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1ET0Uqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0FA216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaijb-0003Hv-9L
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 11:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iaiaa-0004B7-CQ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iaiYR-0005SV-3n
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:51:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24186
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iaiYQ-0005P4-Vb
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575042693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+XJxQxMMVOlGRd7VcDUfkaDTkTsObMIZmGCHSto/32k=;
 b=e1ET0UqsHG40jiN516Be1U8J/bs9uygDhru6NH0lhCPxcYmzKKU/Sbep5zpPKV37dtSk/f
 WD0DlUpmWL5yzVVUfsaHciqkDagHB2HBBxgrTQi+iP79Z6SbtkoFItJjyxY+jw96upqozh
 mNxyS/cFATWR9+c6167Qp5eEVEA+D3U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-jqYH_cEcN6--stTKIkWGUQ-1; Fri, 29 Nov 2019 10:51:31 -0500
Received: by mail-wr1-f70.google.com with SMTP id e3so15727501wrs.17
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 07:51:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P5MaXAGOEtqCjQSFhr61tNxB779w5vvW5JZg9oLQQik=;
 b=LK/KXhcm10X0J51poQuWAOWMejCekV2pQHhqEjqvziZKw/J/v/K0Q5R4CKUbt6Lg5F
 LfH9WLZPdyLMe5dafsxZZUPRKKbXqW8YhteLqiCrT1Qaxt8hs1BI3yJwdq2d/3gkbm/C
 3uMww3IDjEbVkJZ9Y2W3xX/PZ3rq3FcgEXnwgvodgneg/8RmiU6BckL3Bg3rj0l59qjn
 aKkvtpbx+Vqb3J71H1eeHZ9lJtXcI/qw7IHZ292v6yglcvYgeAK1uHyzozkDlXeRrB3v
 U4jtIPbV6fFtuPBDxHsCQwhXlpFm1szXx8V9GUsyFE+ItrTDH3cF4zXGZ7ZRryjVJkid
 AlqA==
X-Gm-Message-State: APjAAAXYaRe1kilVjD2LSPA+WsvBdgH2TjOb999hOqUgfbUBOeHaFWD1
 vL86MCl8XxpfyTqhrnnyQtM+Ss4s4+B1zU9PQga7zhBYiV57HOWjbrgUWBM6V34ttnP36rBc8x3
 ZgVEIzGzx2Nh9j0A=
X-Received: by 2002:a1c:2745:: with SMTP id n66mr15216851wmn.171.1575042690840; 
 Fri, 29 Nov 2019 07:51:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqxOd/qxYO+iE8UFAFf4xVqtpdnTdKjcuE0mDhnMQEBPNan5CZAGNFCITnSTe/FoyaSbLdxhVw==
X-Received: by 2002:a1c:2745:: with SMTP id n66mr15216833wmn.171.1575042690618; 
 Fri, 29 Nov 2019 07:51:30 -0800 (PST)
Received: from [192.168.1.74] (67.23.27.109.rev.sfr.net. [109.27.23.67])
 by smtp.gmail.com with ESMTPSA id i9sm26977398wrb.2.2019.11.29.07.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2019 07:51:30 -0800 (PST)
Subject: Re: [PATCH] ci: Use libcap-ng
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, thuth@redhat.com, pbonzini@redhat.com,
 Greg Kurz <groug@kaod.org>
References: <20191129142126.32967-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3297c897-69ab-c30f-98dd-dd3138e6325b@redhat.com>
Date: Fri, 29 Nov 2019 16:51:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129142126.32967-1-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: jqYH_cEcN6--stTKIkWGUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/29/19 3:21 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> We currently enable libcap-dev in build-clang to pick up the 9p proxy
> helper.  Paolo's patch changes that to use libcap-ng, so switch to using

It is not obvious you are referring to "virtfs-proxy-helper: switch from=20
libcap to libcap-ng" he recently posted.

Since Greg is going to take Paolo's patch, I'd suggest he also takes=20
this one, so he can update the commit description with either "the=20
previous patch" or the commit sha1.

> it.  This also means we'll be testing the scsi pr manager and the bridge
> helper.

This is good news.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   .gitlab-ci.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index be57c6a454..62a9609798 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -59,7 +59,7 @@ build-user:
>  =20
>   build-clang:
>    script:
> - - apt-get install -y -qq clang libsdl2-dev libattr1-dev libcap-dev
> + - apt-get install -y -qq clang libsdl2-dev libattr1-dev libcap-ng-dev
>         xfslibs-dev libiscsi-dev libnfs-dev libseccomp-dev gnutls-dev lib=
rbd-dev
>    - ./configure --cc=3Dclang --cxx=3Dclang++ --enable-werror
>         --target-list=3D"alpha-softmmu arm-softmmu m68k-softmmu mips64-so=
ftmmu
>=20


