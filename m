Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BB7C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21CB217D6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQMwQXCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21CB217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRH7-0006Au-L4
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iXRFS-00059k-5A
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iXRFP-00014P-RT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:46:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29648
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iXRFP-000147-O2
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574261183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mkQSy1JsEDb47zCrHiqjXZODC6vw83dhZ1Cy6O2FHmk=;
 b=XQMwQXCZjzgRRufsqSKoviptXrfXw30dQWpw+llhlCMHFR1LWup2MeSyTTEp7dKL99Ontb
 FMW/Do8Ea2WBmoyEmBzWAQbnqLxlZ1BqdbpTy2QEuuA0OMw3osyHLQBL31FSi9s19Y1j6Y
 xhTavSPW3C6XftLBY6j2/+8H+4Ql2zs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-PCBYc7Z7NRK1Upvg-3gqNA-1; Wed, 20 Nov 2019 09:46:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 836C15F9;
 Wed, 20 Nov 2019 14:46:20 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4600D5456D;
 Wed, 20 Nov 2019 14:46:17 +0000 (UTC)
Subject: Re: [PATCH 5/6] iotests: Support job-complete in run_job()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191120140319.1505-1-kwolf@redhat.com>
 <20191120140319.1505-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <03afb9a7-4b18-21b7-7c74-7ebbdd13b3ad@redhat.com>
Date: Wed, 20 Nov 2019 08:46:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120140319.1505-6-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: PCBYc7Z7NRK1Upvg-3gqNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 8:03 AM, Kevin Wolf wrote:
> Automatically complete jobs that have a 'ready' state and need an
> explicit job-complete. Without this, run_job() would hang for such
> jobs.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index b409198e47..c4063ef6bb 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -617,6 +617,8 @@ class VM(qtest.QEMUQtestMachine):
>                           error =3D j['error']
>                           if use_log:
>                               log('Job failed: %s' % (j['error']))
> +            elif status =3D=3D 'ready':
> +                self.qmp_log('job-complete', id=3Djob)
>               elif status =3D=3D 'pending' and not auto_finalize:
>                   if pre_finalize:
>                       pre_finalize()
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


