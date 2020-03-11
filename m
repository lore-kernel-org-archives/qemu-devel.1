Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2972EC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121122074A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 23:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNI5/14k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121122074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAQs-0003uz-5U
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 19:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCAQH-0003TH-8D
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCAQG-0000NY-1g
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:05:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43589
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCAQF-0000M6-U1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 19:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583967954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G5cQ6I5Lhpd3hKlv7Yl6Kyf1K+nkpjES+WJHsaNtcZE=;
 b=WNI5/14k3l4FDfgjdPM4JbEklAhnI0BnyVb+IcC+ToJ40UU67DUbvHXDbJC4iORoV0xVh8
 nqvFbUkPlU20r3LOIYFclpkkp8x3KT1gpeTBRUDDYiT8le114KO+GFaD7+6xQq87DyAhlN
 JcGzfbSMXZ6/pfA4v9e3Rq604QPgy4o=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-SqKgnjOUP3y6jtKm1YMmlw-1; Wed, 11 Mar 2020 19:05:51 -0400
X-MC-Unique: SqKgnjOUP3y6jtKm1YMmlw-1
Received: by mail-qt1-f198.google.com with SMTP id n4so2298800qtv.5
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 16:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZVUJ6Vhjtjtox39dzL3Wc8DIZK2cVB4R+Y+abaTYARs=;
 b=alkQac1p5wJz/SXFZRhyfQWq691Y3fPuOwEJjJHhz6pkvzMmx5qY6FKHxfeMqrZDzw
 aUu2poBiNHoaxgFXFhb0CZTPbiixmhZDF/NH2nYWFW93AUJKut0KqnPbQQU3WwYXsFH+
 5XEdbeK9nfLnRSEN4JpJdVBVPnozp677IdraQqFnOE6I1TPb8/Q3eCx6qdJmb/HtltgR
 ZSNYgRY40gmNzvYVtQksPEIzf7k/ESUecFitv9HxvyvjQzasf1kIvM3HAxEz0WNqTx2Z
 HLMG/eLZ9YAcnMyvHACsN8YkaYr0MXJJSJz++/dFAYECJt1AnU0mOmU2D8ckomu5Szwb
 B76w==
X-Gm-Message-State: ANhLgQ0wrVQzXzMxr5zHZMEv+KGnHIQSQKG7TO/If6mNNPH+nU/kwpR4
 K3ZJQdNILYknKhVLSkTtUa0i4PuTn56syBPjA+hQFJnkRFDY/NTPyADcvVmipJGL7sQxJANlRD/
 DLjS+EWhiSXDhmeY=
X-Received: by 2002:ac8:777b:: with SMTP id h27mr4124772qtu.119.1583967950505; 
 Wed, 11 Mar 2020 16:05:50 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuA+pWKkZjSzlswQ6rocAT81Xy/zXF/h3bhvfHsyC7wksArEx9Bvj4zOdcL/o3pGVQ/zslMeQ==
X-Received: by 2002:ac8:777b:: with SMTP id h27mr4124758qtu.119.1583967950281; 
 Wed, 11 Mar 2020 16:05:50 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id m65sm6098104qke.109.2020.03.11.16.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 16:05:49 -0700 (PDT)
Date: Wed, 11 Mar 2020 19:05:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 1/2] Use -isystem for linux-headers dir
Message-ID: <20200311190458-mutt-send-email-mst@kernel.org>
References: <20200311225130.1599619-1-ehabkost@redhat.com>
 <20200311225130.1599619-2-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200311225130.1599619-2-ehabkost@redhat.com>
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
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 jtomko@redhat.com, qemu-devel@nongnu.org, jingqi.liu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 06:51:29PM -0400, Eduardo Habkost wrote:
> glibc and Linux-provided headers are known to generate macro
> redefinition warnings when used together.  For example:
> <linux/mman.h> and <sys/mman.h> duplicate some macro definitions.
>=20
> We normally never see those warnings because GCC suppresses
> warnings generated by system headers.  We carry our own copy of
> Linux header files, though, and this makes those warnings not be
> suppressed when glibc headers are included before Linux headers
> (e.g. if <sys/mman.h> is included before <linux/mman.h>).
>=20
> Use -isystem instead of -I for linux-headers.  This makes the
> compiler treat our linux-headers directory the same way it treats
> system-provided Linux headers, and suppress warnings generated by
> them.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  Makefile.target | 2 +-
>  configure       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Makefile.target b/Makefile.target
> index 2d43dc586a..934a9f7431 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -12,7 +12,7 @@ endif
> =20
>  $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
>  ifdef CONFIG_LINUX
> -QEMU_CFLAGS +=3D -I../linux-headers
> +QEMU_CFLAGS +=3D -isystem ../linux-headers
>  endif
>  QEMU_CFLAGS +=3D -iquote .. -iquote $(SRC_PATH)/target/$(TARGET_BASE_ARC=
H) -DNEED_CPU_H
> =20
> diff --git a/configure b/configure
> index cbf864bff1..04a2a7f2dd 100755
> --- a/configure
> +++ b/configure
> @@ -899,7 +899,7 @@ Linux)
>    linux=3D"yes"
>    linux_user=3D"yes"
>    kvm=3D"yes"
> -  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/linux-headers -I$PWD/linux-headers $QE=
MU_INCLUDES"
> +  QEMU_INCLUDES=3D"-isystem \$(SRC_PATH)/linux-headers -I$PWD/linux-head=
ers $QEMU_INCLUDES"

Shouldn't both be -isystem?

>    supported_os=3D"yes"
>    libudev=3D"yes"
>  ;;
> --=20
> 2.24.1


