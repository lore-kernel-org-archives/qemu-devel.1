Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C7CC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0455220663
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjbfj9ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0455220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieZjn-0005O1-S8
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 02:15:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ieZj5-0004vE-HQ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ieZj2-0004RQ-A8
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:14:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47652
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ieZj1-0004Qg-Ry
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575962066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gpXescD7BewFGQPvuCvklwbzxsORHJD58Q5HNfKcflA=;
 b=cjbfj9efNBDhIicQvcPulGoEjNrcOJu6tCEIrWHqrwiadzy8/KQRvhGNytrqNlNUOIY4u2
 TDzRRiSi5dtlwKuaSSYMR8dvw8bxYzll2A2lkpPbRNioigeyJwqyVTe4OUdPmbPyszwLZi
 3yM0gitN/GhSzYGtRJzqoi++90c0rYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-P4kWV-f9NiS31vRyN8HCdA-1; Tue, 10 Dec 2019 02:14:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73A2118C35A9;
 Tue, 10 Dec 2019 07:14:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-181.ams2.redhat.com
 [10.36.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 401DF5D726;
 Tue, 10 Dec 2019 07:14:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C5D2411386A7; Tue, 10 Dec 2019 08:14:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
Subject: Re: [PATCH v8 06/21] qdev-monitor: well form error hint helpers
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-7-vsementsov@virtuozzo.com>
 <87blslcuwe.fsf@dusky.pond.sub.org>
Date: Tue, 10 Dec 2019 08:14:20 +0100
In-Reply-To: <87blslcuwe.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Fri, 06 Dec 2019 16:53:53 +0100")
Message-ID: <87r21codo3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: P4kWV-f9NiS31vRyN8HCdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>
>> Make qbus_list_bus and qbus_list_dev hint append helpers well formed:
>> switch errp paramter to Error *const * type, as it has uncommon
>> behavior: not change the pointer to return error, but operate on
>> already existent error object.
>> Rename functions to be error_append_*_hint.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> "well form error hint helpers" tells me nothing.  PATCH 03 does the same
> (less function renames), and is titled "make Error **errp const where it
> is appropriate".  I like that better.  No big deal, and certainly not
> worth a respin by itself.  I'm happy to touch up commit messages in my
> tree.

Let's adapt PATCH 03's commit message, like this:

  qdev-monitor: make Error **errp const where it is appropriate

  Mostly, Error ** is for returning error from the function, so the
  callee sets it. However qbus_list_bus and qbus_list_dev get already
  filled errp parameter. They don't change the pointer itself, only
  change the internal state of referenced Error object. So we can make
  it Error *const * errp, to stress the behavior. It will also help
  coccinelle script (in future) to distinguish such cases from common
  errp usage.

  While there, rename the functions to
  qbus_error_append_bus_list_hint(), qbus_error_append_dev_list_hint().

With something like that:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


