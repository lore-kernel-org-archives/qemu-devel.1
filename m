Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55489C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F1F20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hX0VWc72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F1F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih6kw-0002ug-BC
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih6PB-000846-57
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih6PA-0002Ni-3R
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:32:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47642
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih6PA-0002Lc-0D
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576564343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zjBSVLAPrSUsxpZESXtvMv7w4MQ6O3MDPh0LpuJXUw8=;
 b=hX0VWc72XzQC5Dte4X8py57xDBhnaIKfdGNOj1YTIBksLdHk9NtBYM3xbkXGDKpCVDwXlD
 KP+7zw4ZqeO1yrXFV56fUrHIUFbGgygNoFP+1dPDWNb0nKkZWo+kUbLypwQXLbqvqlMMW1
 u/+iA7ecynNsyx6v4CZxKPJdDNmZps0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-Iso8akjbNz-IEGB7ktm_1g-1; Tue, 17 Dec 2019 01:32:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84F0D477;
 Tue, 17 Dec 2019 06:32:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75DE368863;
 Tue, 17 Dec 2019 06:32:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8A1F811386A7; Tue, 17 Dec 2019 07:32:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PULL 51/88] ppc: well form kvmppc_hint_smt_possible error hint
 helper
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
 <20191217044322.351838-52-david@gibson.dropbear.id.au>
Date: Tue, 17 Dec 2019 07:32:15 +0100
In-Reply-To: <20191217044322.351838-52-david@gibson.dropbear.id.au> (David
 Gibson's message of "Tue, 17 Dec 2019 15:42:45 +1100")
Message-ID: <877e2vpimo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Iso8akjbNz-IEGB7ktm_1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <david@gibson.dropbear.id.au> writes:

> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Make kvmppc_hint_smt_possible hint append helper well formed:
> rename errp to errp_in, as it is IN-parameter here (which is unusual
> for errp), rename function to be kvmppc_error_append_*_hint.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-Id: <20191127191434.20945-1-vsementsov@virtuozzo.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Review led to the commit message to be replaced for this and related
patches.  It's in my "[PULL 00/34] Error reporting patches for
2019-12-16".  No big deal, but if you respin, either steal that message
or drop this patch.


