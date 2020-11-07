Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5239BC388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 08:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8706720704
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 08:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g49XLmPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8706720704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbK0J-00054e-5j
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 03:55:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kbJzB-0004b9-9n
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 03:54:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kbJz8-0004Vl-PL
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 03:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604739248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7/UTySDRstT/I59dyK44Gj5yQZuMVBSiMoU7YQDXExQ=;
 b=g49XLmPtuNuTWhrS07fWolLKNyHPvd0v02+gqqlPzUDxkOvc/EL0b820mWndm6DrOUvgKU
 SExMAqaDc7F7+DyfvfxazR39cgPPcNGk7o8H5X+rBLsVAWzoxez199R7nKcHHoL0nVu96l
 iWiPg339lHNWUU9boEUPV6oKlDUHb1g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-SGNegEw9PK-UoGe8Ww1Ykw-1; Sat, 07 Nov 2020 03:54:04 -0500
X-MC-Unique: SGNegEw9PK-UoGe8Ww1Ykw-1
Received: by mail-wr1-f71.google.com with SMTP id e11so1499680wrw.14
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 00:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ul8SOCQe0jntizxbhdV2NtIY1ffHzFNCMn1j9bPi8AU=;
 b=RYX+kJ0XJpRg5zVmmi0YLTX1h/BWzkqpSQSlTexegnqKavJ+Tfdt/QbJVv9rQ7tLAv
 PemrFh0f1itrXh3PzQ7Y49lsdNdFfu3rE5mnIUL6STKcrhrJtamTbAdP4V/nrUaSzz7L
 0Iey9UyM4bam42MEsFi5SllMeld0b2QJD5W0/Qrs56FG1HZimoSezcLLiyiGbE9YRrw3
 YMZo0sD7eGZ20jlFFrzSoa7Tc/3LMkFZIiMiCHAm0xwzzGAxEQcbfM6zt8n1RDE5wiTQ
 sz95PEtBYhyYSbgAPQYWb6JJBL1gtlZn+ur/Q5KsLMrmkO0txXaZKKGHJEl523et2rBC
 e+xg==
X-Gm-Message-State: AOAM531tOCvghQZCiZkm46kvyWF2F/q20bVZzBpheDmkwlZvGPuY31SE
 LdZc9rCBeZdUxOV2JqX94qAmPjYxnfmxJQia1SW6YaiO9/fz4p7GfO/I7NcrHqUu+sds7932rXt
 LmQf14+0sfhHtBsA=
X-Received: by 2002:adf:de91:: with SMTP id w17mr6761922wrl.84.1604739243559; 
 Sat, 07 Nov 2020 00:54:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwj4FAtwDhH4JLQHbWUkQnUTqyon2nOq7/4/Z/1CbBWE44AIAMKaek2KD2oMi9y/6WUVMMuew==
X-Received: by 2002:adf:de91:: with SMTP id w17mr6761904wrl.84.1604739243352; 
 Sat, 07 Nov 2020 00:54:03 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id n8sm5244281wmc.11.2020.11.07.00.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 00:54:01 -0800 (PST)
Date: Sat, 7 Nov 2020 03:53:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] meson: always include contrib/libvhost-user
Message-ID: <20201107035314-mutt-send-email-mst@kernel.org>
References: <20201106210340.698771-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201106210340.698771-1-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 03:12:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 06, 2020 at 09:03:40PM +0000, Stefan Hajnoczi wrote:
> libvhost-user is needed when CONFIG_LINUX is set. The CONFIG_VHOST_USER
> check in meson.build is incorrect.
> 
> In fact, no explicit check is needed since this dependency is not built
> by default. If something declares a dependency on libvhost-user then it
> will be built, otherwise it won't be built (i.e. on non-Linux hosts).
> 
> This fixes ./configure --disable-vhost-user && make.
> 
> Fixes: bc15e44cb2191bbb2318878acdf5038134e56394 ("configure: introduce --enable-vhost-user-blk-server")
> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Applied, thanks!

It's probably time to move libvhost-user out of contrib.


> ---
>  meson.build | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index f5175010df..b473620321 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1450,11 +1450,7 @@ trace_events_subdirs += [
>    'util',
>  ]
>  
> -vhost_user = not_found
> -if 'CONFIG_VHOST_USER' in config_host
> -  subdir('contrib/libvhost-user')
> -endif
> -
> +subdir('contrib/libvhost-user')
>  subdir('qapi')
>  subdir('qobject')
>  subdir('stubs')
> -- 
> 2.28.0
> 


