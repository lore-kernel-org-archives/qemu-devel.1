Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB90C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF2620772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvU6tRuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF2620772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH5gY-00028D-Sh
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jH5fU-0001Zx-35
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jH5fS-0008PU-BG
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:01:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jH5fR-0008NK-QC
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585141317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CzCrGM+3LqQaC5E37nhGuRRihky/o7rrCeDWzT+0/t0=;
 b=FvU6tRuy42ju6tcP4kCYP1K8mm+ZrVB2jLNykq2ToMfxQVTSNDAzijtVdVmCpVhYkt2myv
 oba2oX5DSF1emuGP3mJ7p0WZECJbjwkNut4kqG6n435hYGjorJggpFWeTex1lFjv5qidda
 uc8OzaVXrZoM45BxKUQawwwqvCm/7A0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-GFNIy0udOqC52O_yVRyjDw-1; Wed, 25 Mar 2020 09:01:53 -0400
X-MC-Unique: GFNIy0udOqC52O_yVRyjDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC155DB60;
 Wed, 25 Mar 2020 13:01:51 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB3C260BF3;
 Wed, 25 Mar 2020 13:01:48 +0000 (UTC)
Subject: Re: [PATCH 2/6] block/mirror: fix use after free of local_err
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-3-vsementsov@virtuozzo.com>
 <8cb2bda7-55f5-2646-3c35-d901089ccde5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6a231ab1-869c-d9ba-5ccf-9d8c213e5cf1@redhat.com>
Date: Wed, 25 Mar 2020 08:01:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8cb2bda7-55f5-2646-3c35-d901089ccde5@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 quintela@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 marcandre.lureau@redhat.com, den@openvz.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 6:11 AM, Max Reitz wrote:
> On 24.03.20 16:36, Vladimir Sementsov-Ogievskiy wrote:
>> local_err is used again in mirror_exit_common() after
>> bdrv_set_backing_hd(), so we must zero it. Otherwise try to set
>> non-NULL local_err will crash.
>=20
> OK, but wouldn=92t it be better hygiene to set it to NULL every time it i=
s
> freed?

If we change the signature to error_report_err(&local_err), where=20
error_report_err both reports the error (if any) AND sets local_err to=20
NULL, then we fix the problem for all callers.  It's a global=20
search-and-replace job (Coccinelle is great for that) to update all=20
callers to the new signature.

>  (There is a second instance of error_report_err() in this
> function.  I=92m a bit worried we might introduce another local_err use
> after that one at some point in the future, and forget to run the cocci
> script then.)
>=20
> Are the cocci scripts run regularly by someone?  E.g. as part of a pull
> to master?

I'm not aware of any automated procedure for it at the moment; rather,=20
it is still ad hoc as someone notices something needs to be re-run.  But=20
there was another thread about someone considering automating Cocci=20
scripts as part of the Euler robot...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


