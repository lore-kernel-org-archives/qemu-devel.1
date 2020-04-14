Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E22EC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2DFB20575
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdJ+szWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DFB20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOG2T-0004S5-6E
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 03:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOG1Q-0003dr-5A
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOG1P-00020T-32
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:30:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48330
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOG1O-00020D-W8
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586849414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jf2MoCdtVShmunKMeFIyKeOLpTDkv/YxWYy4EHmEAVM=;
 b=NdJ+szWs/PByZjnAXZjkWFOMo3rz5LIwh0u/PJF5UUSna05zoNvSFpTF3d3GZoBtI2WgFx
 RITskP7bcWsi+JxWy5GiItTVn7V+5cFIP0HA6MmoP7DRyyLBDNXvFJMpwThuNBwC5Zt4tD
 9fTIkOBgGp4/dHSKZ7m0Ki6hppsOvpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272--VWU4OwaObe8sTNHmwADJQ-1; Tue, 14 Apr 2020 03:30:11 -0400
X-MC-Unique: -VWU4OwaObe8sTNHmwADJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C46F1005509;
 Tue, 14 Apr 2020 07:30:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 527A25DDA9;
 Tue, 14 Apr 2020 07:30:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0E7D11385C8; Tue, 14 Apr 2020 09:30:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH 2/2] Makefile: remove old compatibility gunks
References: <20200411092203.4167-1-cfontana@suse.de>
 <20200411092203.4167-4-cfontana@suse.de>
Date: Tue, 14 Apr 2020 09:30:00 +0200
In-Reply-To: <20200411092203.4167-4-cfontana@suse.de> (Claudio Fontana's
 message of "Sat, 11 Apr 2020 11:22:03 +0200")
Message-ID: <87eesqzfrb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe Mathieu-Daude <philmd@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Alex Bennee <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Claudio Fontana <cfontana@suse.de> writes:

> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  Makefile | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 7be15eeb7c..00377f28b9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -567,12 +567,6 @@ slirp/all: .git-submodule-status
>  =09=09CC=3D"$(CC)" AR=3D"$(AR)" =09LD=3D"$(LD)" RANLIB=3D"$(RANLIB)"=09\
>  =09=09CFLAGS=3D"$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS=3D"$(QEMU_LDFLAGS)")
> =20
> -# Compatibility gunk to keep make working across the rename of targets
> -# for recursion, to be removed some time after 4.1.
> -subdir-dtc: dtc/all
> -subdir-capstone: capstone/all
> -subdir-slirp: slirp/all
> -
>  $(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
>  =09$(qom-obj-y)

Reviewed-by: Markus Armbruster <armbru@redhat.com>


