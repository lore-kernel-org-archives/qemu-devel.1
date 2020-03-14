Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75EBC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 11:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8772076B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 11:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwbAM8C9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8772076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD56p-00038s-Jg
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 07:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jD56E-0002kU-M2
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jD56C-0003rx-Bh
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:37:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22188
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jD56C-0003il-3u
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584185819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3EtCP9YizKUYIF1ZN6juDcOBwv6j6T1uLYRUvfLUJVg=;
 b=LwbAM8C9uC5llOkp+H73JRqAgQ8oIPmglGU2qtLTbgZp7uEwHh1FVaVVDjghdjLju3IjBT
 WNjcQpwuFhr0gNat1HXvb5G6vUlSUweU6L7m11kdBxRS7/uMip3uet2LZTefDCmQNMUAr1
 E+yOvZrTun6hvlmVZ9uKFOF2NQWmtnI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-MRHhhA0KO-uwwGVRxQyd6g-1; Sat, 14 Mar 2020 07:36:56 -0400
X-MC-Unique: MRHhhA0KO-uwwGVRxQyd6g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27998800D50;
 Sat, 14 Mar 2020 11:36:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDCAB10016EB;
 Sat, 14 Mar 2020 11:36:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 539B01138404; Sat, 14 Mar 2020 12:36:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] softmmu/vl.c: Handle '-cpu help' and '-device help'
 before 'no default machine'
References: <20200313172447.15471-1-peter.maydell@linaro.org>
Date: Sat, 14 Mar 2020 12:36:53 +0100
In-Reply-To: <20200313172447.15471-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 13 Mar 2020 17:24:47 +0000")
Message-ID: <87d09f9nhm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> Currently if you try to ask for the list of CPUs for a target
> architecture which does not specify a default machine type
> you just get an error:
>
>   $ qemu-system-arm -cpu help
>   qemu-system-arm: No machine specified, and there is no default
>   Use -machine help to list supported machines
>
> Since the list of CPUs doesn't depend on the machine, this is
> unnecessarily unhelpful. "-device help" has a similar problem.
>
> Move the checks for "did the user ask for -cpu help or -device help"
> up so they precede the select_machine() call which checks that the
> user specified a valid machine type.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This has been on-and-off irritating me for years, and it's
> embarrassing how simple the fix turns out to be...

Same here.  The patch works as advertized, thus:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

Can you offer a completeness argument?  We call is_help_option() and
qemu_opt_has_help_opt() from quite a few places.


