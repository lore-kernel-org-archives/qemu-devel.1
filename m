Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19274C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85DD20644
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZVgYKUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85DD20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOI4i-0001HQ-3s
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 05:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOI3u-0000lm-V6
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOI3u-0008SS-23
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:40:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52057
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOI3t-0008SK-V8
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586857257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUQhfmu3fTdViWn1z4JQ5YpQYYV7Oca7Y2wSfhgwcoc=;
 b=iZVgYKUmCjPQa4+87pIgCq+/HKArPn1Dvdce/51akqQDx9kffCFoLaHtYmmU8osHncbzJG
 QUpv8nPHKuSxQRr64JMH32wUsFy8u9TQXODvFDcL5q89G6rnKwvsZn4SKJzN0Z42S7o++t
 8PI31XBEIjQJRdld2ywHNe8K/dIPyko=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-tMG8F7UUOXmnkbfFBLwLDg-1; Tue, 14 Apr 2020 05:40:54 -0400
X-MC-Unique: tMG8F7UUOXmnkbfFBLwLDg-1
Received: by mail-wr1-f72.google.com with SMTP id n7so8394248wru.9
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 02:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EfdwzE1Q6YzduFUyS03q8akkcmklYlFnKvnDjsRLjo0=;
 b=uTMGEmG74+cfsbSH00/lR+WR0OmaG3RZPBTeosu4DgG8uK6i/2Yh5NBaF4R3a36eSp
 bs0M3mw7RAag6dk79tz/WSXdAVgT8VdJcihds3sH8TdORCid+415HQfEpP6MX7ogOQ7a
 cG5m3UKEBWiSwwQ5awYNk4Bt5CoTBrMX09OXxzwHvWkZZbJtBTVk77JLbokpu1AH3n4l
 mfXoiL2ZM9BvYVTqEXY334dXbyqpY05YEdzehWUrVAXGL6NzV4CP/henwg+dF0mILfOA
 Ec9g8nvq+qZbY5PPzbJJJoFTeR1wtB3vBCGfSxjhAWiXVoqMZTLBAf0Zp9wKOxFrCiXS
 /m+w==
X-Gm-Message-State: AGi0PubjhZxusZn3CtNoViw7U3+TkrYy9pevZp+iC/kjj1JKqy/LAeGH
 +yugtoj9YKvsQ6auPP4qGyl3sHmnC0UJq6nGkZj3T2NJ7ZJWZHNjGeyAGdlVY8Adns6FFULYHAr
 CL5lS6B4mK/DvWlw=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr21746861wrs.427.1586857252860; 
 Tue, 14 Apr 2020 02:40:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypIvWTRIxq7OrHlZvGN3Jy6UG7etxF0en0oN/GXypa1sKAjPTgh4qJ/ByRa/G7mh1OcI6nq3ow==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr21746845wrs.427.1586857252652; 
 Tue, 14 Apr 2020 02:40:52 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a9sm12963487wmm.38.2020.04.14.02.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 02:40:52 -0700 (PDT)
Subject: Re: [PATCH RESEND v3 2/2] Makefile: remove old compatibility gunks
To: Claudio Fontana <cfontana@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Markus Armbruster <armbru@redhat.com>
References: <20200411093150.4741-1-cfontana@suse.de>
 <20200411093150.4741-3-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4d079bb3-d73d-a9c1-a6df-a0919de82877@redhat.com>
Date: Tue, 14 Apr 2020 11:40:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200411093150.4741-3-cfontana@suse.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Alex Bennee <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/11/20 11:31 AM, Claudio Fontana wrote:
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>   Makefile | 6 ------
>   1 file changed, 6 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 7be15eeb7c..00377f28b9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -567,12 +567,6 @@ slirp/all: .git-submodule-status
>   =09=09CC=3D"$(CC)" AR=3D"$(AR)" =09LD=3D"$(LD)" RANLIB=3D"$(RANLIB)"=09=
\
>   =09=09CFLAGS=3D"$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS=3D"$(QEMU_LDFLAGS)")
>  =20
> -# Compatibility gunk to keep make working across the rename of targets
> -# for recursion, to be removed some time after 4.1.
> -subdir-dtc: dtc/all
> -subdir-capstone: capstone/all
> -subdir-slirp: slirp/all
> -
>   $(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
>   =09$(qom-obj-y)
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


