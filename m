Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19594C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98DE2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YENrr/mL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98DE2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzJh-0005bO-Rc
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihzAS-0003o3-Ui
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihzAP-0003XA-TR
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:00:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31427
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihzAM-0003OF-UQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576774839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qt3Yui3W77t3yE8WPftZI8tQg877ett0YHKtZ1TsHkI=;
 b=YENrr/mLt8tSAMJG+CFXmPVgE2OC/YyZAWBWOkWx/TH1NuX1pCW5jr7GLfKD8iH55fcmHK
 sHynkM/k8MRvhRgW+Eczup60ccxHsbx0iObc2LUN7LCeqMo+jgZhpwtBr+U8Z5g0xVsLnf
 IeNQC6Xt3p6ZDduCT+WTcNjVmUnsk5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-W6ROymW3Oc--vi5LW49eMQ-1; Thu, 19 Dec 2019 12:00:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06ADDDB61
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 17:00:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FF345D9CD;
 Thu, 19 Dec 2019 17:00:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BEE4311386A7; Thu, 19 Dec 2019 18:00:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 11/14] monitor/qmp: Explicit we ignore few
 QEMUChrEvent in IOEventHandler
References: <20191218172009.8868-1-philmd@redhat.com>
 <20191218172009.8868-12-philmd@redhat.com>
Date: Thu, 19 Dec 2019 18:00:32 +0100
In-Reply-To: <20191218172009.8868-12-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 18 Dec 2019 18:20:06
 +0100")
Message-ID: <87bls4merz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: W6ROymW3Oc--vi5LW49eMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> The Chardev events are listed in the QEMUChrEvent enum. To be
> able to use this enum in the IOEventHandler typedef, we need to
> explicit all the events ignored by this frontend, to silent the
> following GCC warning:
>
>     CC      monitor/qmp.o
>   monitor/qmp.c: In function =E2=80=98monitor_qmp_event=E2=80=99:
>   monitor/qmp.c:345:5: error: enumeration value =E2=80=98CHR_EVENT_BREAK=
=E2=80=99 not handled in switch [-Werror=3Dswitch]
>     345 |     switch (event) {
>         |     ^~~~~~
>   monitor/qmp.c:345:5: error: enumeration value =E2=80=98CHR_EVENT_MUX_IN=
=E2=80=99 not handled in switch [-Werror=3Dswitch]
>   monitor/qmp.c:345:5: error: enumeration value =E2=80=98CHR_EVENT_MUX_OU=
T=E2=80=99 not handled in switch [-Werror=3Dswitch]
>   cc1: all warnings being treated as errors
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Add all missing enums
>
> Cc: Markus Armbruster <armbru@redhat.com>
> ---
>  monitor/qmp.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index b67a8e7d1f..6c46be40f8 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -365,6 +365,11 @@ static void monitor_qmp_event(void *opaque, int even=
t)
>          mon_refcount--;
>          monitor_fdsets_cleanup();
>          break;
> +    case CHR_EVENT_BREAK:
> +    case CHR_EVENT_MUX_IN:
> +    case CHR_EVENT_MUX_OUT:
> +        /* Ignore */
> +        break;
>      }
>  }

With the comment dropped:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


