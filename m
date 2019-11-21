Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749B1C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6282068E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHELJ+af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6282068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXnIO-00044f-Bx
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXnHL-0003Gx-69
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXnHJ-0001a5-Tm
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:17:50 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXnHJ-0001Zx-LN
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:17:49 -0500
Received: by mail-wm1-x343.google.com with SMTP id 8so3923204wmo.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Uo1gy0bKtpX0ZralV68Q+zpjOjMh91wdG3ZqPhrLw28=;
 b=sHELJ+afYoiSgK/B/MSg6RshOqHP/236JZF1ukTZ2GWZFcvCAxfdkwDzIg3Egt1Jwl
 FArgPsbV/+RpTzdNtlJJDn4s1wrLHq/Z4Df9e3RBSvSxrUP5m7NIh+DLYCYljWc/audB
 JVHyXBm96R6Iv2FBB4DpKgoDlIkKF2O6iyiFxF5pXfDFpXBxARFzB5tSBtPT8+cCHSXs
 QwN1vE+2RfYG6B3T6MQh00ZcBjDRJr3boTtDCgI/0XYy5ouWBoN+Q9eH85qLdTvMoAUC
 oR3aTSLUl7O2Gdx/kOi+CUQa6eFIU6eCiMhanOfiQ8rIAQKJFQoOSuj9sUn88m+u4vj7
 S8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Uo1gy0bKtpX0ZralV68Q+zpjOjMh91wdG3ZqPhrLw28=;
 b=LOqoQC4ugKqfKjyp+MC+zn/zvRTtPCj1JdaH4nRHVdwwWTm/M1otaoqoPhi+0s9GkY
 cGbyyP19wI2zFhHChivtZ5vpsrdxl8TurRlIBBmv4Zwc4hK9X/jLznOWqpl4wfd0CvsE
 MlPCXtO9GG2hTRFYYkJ3Xqi+qUkBFFq63wvosr5IKaTGEuPWJdw2/z7DJN3HhZ748jYT
 WvPpTJ+wWhh912rHj+HLVTxeA/gGOAWebkAbMSUNRmNo9rXlUK8KDpe5xZEx975oAoSR
 v0sX6ZW9/9pREF6DVUzihbU15N78gUyJww4bNIEiUR+/GnOfs9BiHKVbhL5vo9tqaXF5
 tuiQ==
X-Gm-Message-State: APjAAAUeNz9Ug/Hx0aCGhdgCfQVP56pvwpTw+zOzpQGJhr0U3I8bwXJz
 8dqw7dmnj4yo83BaL2jxIhs=
X-Google-Smtp-Source: APXvYqy1FC8aTq/B7AqjyunYyKwA2FambYBixb/B2ONZHtl9MxgQanUxcyA59bL9BtVhN9itTx3jKg==
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr10196203wml.102.1574345868434; 
 Thu, 21 Nov 2019 06:17:48 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u13sm2813886wmm.45.2019.11.21.06.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 06:17:47 -0800 (PST)
Date: Thu, 21 Nov 2019 14:17:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Micky Yun Chan <chanmickyyun@gmail.com>
Subject: Re: [PATCH v6] Implement backend program convention command for
 vhost-user-blk
Message-ID: <20191121141746.GZ439743@stefanha-x1.localdomain>
References: <20191121015826.4867-1-michan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QZ+LYBYf4/WKxcjd"
Content-Disposition: inline
In-Reply-To: <20191121015826.4867-1-michan@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: michan <michan@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--QZ+LYBYf4/WKxcjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2019 at 09:58:26AM +0800, Micky Yun Chan wrote:
> diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
> index da6aaf51c8..d25c3a957f 100644
> --- a/docs/interop/vhost-user.json
> +++ b/docs/interop/vhost-user.json
> @@ -54,6 +54,37 @@
>    ]
>  }
> =20
> +##
> +# @VHostUserBackendBlockFeature:
> +#
> +# List of vhost user "block" features.
> +#
> +# @read-only: The --read-only command line option is supported.
> +# @blk-file: The --blk-file command line option is supported.

Please also update docs/interop/vhost-user.rst.  That document
duplicates the option documentation and it would be good to keep it
up-to-date.

> +#
> +# Since: 4.0

QEMU 4.2 is close to being released and the codebase is frozen.  The
next release will be 5.0.  Please change this to:

  Since: 5.0

> +##
> +{
> +  'enum': 'VHostUserBackendBlockFeature',
> +  'data': [ 'read-only', 'blk-file' ]
> +}
> +
> +##
> +# @VHostUserBackendCapabilitiesBlock:
> +#
> +# Capabilities reported by vhost user "block" backends
> +#
> +# @features: list of supported features.
> +#
> +# Since: 4.0

Same here.

--QZ+LYBYf4/WKxcjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WnIoACgkQnKSrs4Gr
c8htzQgAhtgj2KBMnMwgQU53ckyVPCXvnRShx7W30OqT6mnB9Fv0uLsjNXgxTgF1
RLyL4IQEatGRqAo7NgoY+HIZjLFxQtdNLUbO5Bdn9QFx6HQk7S7xb1IY9n7MJE2e
bk6E49REuz7hc1uezCMZ/wKP28pgNNuZ8+t75aUwH4Uai2vXSu37GHOvrDSdnmoj
cI+IBHENYpTL0jjhofV1F9oMmzll5fcKkrqEqQKPX3ZdmLxsvaXvfV2uBLwMdNy0
wQaJTTtbQ1UjaGUaE2qC2i/HW6s5ZuHeihnBrty/CDoTBVw0R4xmQ4xCcdYWuYFg
y3KR06PcGF7OQrkFUvc2dxOD/UzHoA==
=dsHJ
-----END PGP SIGNATURE-----

--QZ+LYBYf4/WKxcjd--

