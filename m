Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C9BC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C7D20869
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJX3LW6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C7D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iafWa-00036E-Eo
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:37:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iaf5c-0000cB-Mk
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iaf5Q-0005om-Do
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:09:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30411
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iaf5P-0005X1-64
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575029359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0WvdslD24jhPbBUA4/qjiprYQBAez5RTSsn1X8a4Qg=;
 b=HJX3LW6NDNy34Qgkrp7blCLzhEEOJ3CWrzn+Xfh+hru3mkH3XtFM1l/sulFSRxUdBm+ba2
 UhjjKHIHR3xrxr1Kg3qisRK7DSvePrdOnf+hYZsmbnKI48WM4OMJTk6Q21OhSzvswWjWtU
 Ihc0EQEGfqI1ujZLckVE78XugrZml5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-0PqiVrwEM9CU2FaT1nmYNw-1; Fri, 29 Nov 2019 07:09:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E5721005514;
 Fri, 29 Nov 2019 12:09:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 393795C1BB;
 Fri, 29 Nov 2019 12:09:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BEEB61138606; Fri, 29 Nov 2019 13:09:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6] backends/cryptodev: drop local_err from
 cryptodev_backend_complete()
References: <20191127194541.24304-1-vsementsov@virtuozzo.com>
 <874kynyzyo.fsf@dusky.pond.sub.org>
 <1b532161-7de9-8ea5-0771-69fdeb5b70bc@virtuozzo.com>
Date: Fri, 29 Nov 2019 13:09:10 +0100
In-Reply-To: <1b532161-7de9-8ea5-0771-69fdeb5b70bc@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 29 Nov 2019 08:31:34 +0000")
Message-ID: <87eexqubo9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 0PqiVrwEM9CU2FaT1nmYNw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: "philmd@redhat.com" <philmd@redhat.com>,
 "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 29.11.2019 9:10, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>=20
>>> No reason for local_err here, use errp directly instead.
>>=20
>> Related: "[PATCH v6] hw/vfio/ap: drop local_err from vfio_ap_realize".
>> I'm surprised it's just two.  Did you search for the anti-pattern
>> systematically?
>
> As I remember - no, only where it breaks automation. Here empty "out: }"
> label will break compilation, if not fixed before or after coccinelle
> run. So, here I fixed it before.

Got it.

A through sweep would be nice, but the goal you're pursuing here
involves more than enough churn already.  Don't worry about it now.

[...]


