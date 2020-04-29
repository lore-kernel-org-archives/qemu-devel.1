Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB999C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75A7206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUaM19h5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75A7206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTgQJ-0003Ia-Rr
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTgNb-0002Ut-Bi
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTgMp-0007WO-QC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:39:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28986
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTgMp-0007SZ-DF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588142325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNkQgG3mqwztgM0di8XKN/guVi2IMZSPlTwwL/OIM50=;
 b=OUaM19h5p3rm+gsFXe+7r+GCThUz5g08rOJt8HaVEll7/QKyTNj58cL3aw5Y2JB/iw3rjs
 eRkQpw5GJXo+wf1xVOQoxGBVZQ4AMpizqzwio8QS7uuxOcusPE7J/abdW77mnpHUIYSqef
 fAW/S1R6VySrLk3K7ojUS4ZztGNP2AA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-BwPoBK7DPaeIrgN0l8V2MQ-1; Wed, 29 Apr 2020 02:38:44 -0400
X-MC-Unique: BwPoBK7DPaeIrgN0l8V2MQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6554D189952B;
 Wed, 29 Apr 2020 06:38:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2D7B648D0;
 Wed, 29 Apr 2020 06:38:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 49D8911358BC; Wed, 29 Apr 2020 08:38:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1 v3 5/7] hw/mips/boston: Add missing
 error-propagation code
References: <20200413205250.687-1-f4bug@amsat.org>
 <20200413205250.687-2-f4bug@amsat.org>
Date: Wed, 29 Apr 2020 08:38:40 +0200
In-Reply-To: <20200413205250.687-2-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 13 Apr 2020 22:52:50
 +0200")
Message-ID: <877dxyvlsf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paul Burton <pburton@wavecomp.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Running the coccinelle script produced:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/find-missing-error_propagate.cocci \
>     --keep-comments --smpl-spacing --dir .
>   HANDLING: ./hw/mips/boston.c
>   [[manual check required: error_propagate() might be missing in object_p=
roperty_set_int() ./hw/mips/boston.c:462:4]]
>   [[manual check required: error_propagate() might be missing in object_p=
roperty_set_str() ./hw/mips/boston.c:460:4]]
>
> Since the uses are inside a MachineClass::init() function,
> directly use &error_fatal instead of error_propagate().
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

I duplicated this patch in

    [PATCH 08/11] mips/boston: Fix boston_mach_init() error handling
    [PATCH 09/11] mips/boston: Plug memory leak in boston_mach_init()

Sorry!

I'd replace my patches by yours to give you proper credit, but your
commit message mentions "the coccinelle script", presumably the one from
PATCH 3/7, and that patch isn't quite ready in my opinion.  Also, only
my version documents the memory leak.


