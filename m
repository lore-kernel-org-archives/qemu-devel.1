Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D36DC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA51121D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjMRpbld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA51121D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwwQ-0007hn-O4
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 06:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kFwux-0005wy-FM
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:01:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43870
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kFwuv-0001J4-C6
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599645688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mLxxqccAK772g755sAwvvHBQj3xExEC/1XyjXdV4ce0=;
 b=SjMRpbld8x8maty9gLBWACvUktSFNiGbgGB6GBn4yO5dgre1/WZbBApEbs8PAX9bDo3Uyv
 HNqipX4oFwf8x52MT4tcDubpgHN7hLLDF6cp9cYFIsHIXDfPpBkA0K+3fFMzZcSN0Osha+
 jrPezMsEiEdV9/aVSW/kjPlu8rNno50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-FFDG1SY_P5yre2V2jCCgYA-1; Wed, 09 Sep 2020 06:01:24 -0400
X-MC-Unique: FFDG1SY_P5yre2V2jCCgYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6204A802B7E;
 Wed,  9 Sep 2020 10:01:23 +0000 (UTC)
Received: from gondolin (ovpn-113-3.ams2.redhat.com [10.36.113.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E90F65D9EF;
 Wed,  9 Sep 2020 10:01:15 +0000 (UTC)
Date: Wed, 9 Sep 2020 12:01:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/s390x/css: Remove double initialization
Message-ID: <20200909120113.148b51f3.cohuck@redhat.com>
In-Reply-To: <20200907024020.854465-1-philmd@redhat.com>
References: <20200907024020.854465-1-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:43:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  7 Sep 2020 04:40:20 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Fix eventual copy/paste mistake introduced in commit bc994b74ea
> ("s390x/css: Use static initialization for channel_subsys fields").
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/s390x/css.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 519dc91316d..9961cfe7bf6 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -353,7 +353,6 @@ static ChannelSubSys channel_subsys =3D {
>      .pending_crws =3D QTAILQ_HEAD_INITIALIZER(channel_subsys.pending_crw=
s),
>      .do_crw_mchk =3D true,
>      .sei_pending =3D false,
> -    .do_crw_mchk =3D true,
>      .crws_lost =3D false,
>      .chnmon_active =3D false,
>      .indicator_addresses =3D

Thanks, applied.


