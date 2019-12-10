Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607A7C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B0920663
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNvnb25W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B0920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieZp6-0000Lu-Bh
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 02:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ieZoH-0007w3-Lz
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ieZoG-0000JF-Li
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:19:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52365
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ieZoG-0000Ip-IO
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 02:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575962392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MVCUZTxkFLHn1KcNUE1Tkb/iWtHuF/R/PA68DA98ySc=;
 b=cNvnb25WYvfl3rEub0wzZRF/sGBj/SioSDwF0/RrHcp1VBj7jeGYZLV9wq5C1l4QkqY9xI
 JQrjScOjvzpxrTJnT61hYeHXvnf9c1j/vJsADNcALyocniNHLyrTP4FReSb39SacSj7rhY
 yBg53RSYGtIT+uGv+aBdvgZjPOYotG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-Li9mtpf_Ou26YD1imLi4Sg-1; Tue, 10 Dec 2019 02:19:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3C328017DF;
 Tue, 10 Dec 2019 07:19:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-181.ams2.redhat.com
 [10.36.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93DC45C219;
 Tue, 10 Dec 2019 07:19:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CDF7111386A7; Tue, 10 Dec 2019 08:19:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v8 07/21] ppc: well form kvmppc_hint_smt_possible error
 hint helper
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-8-vsementsov@virtuozzo.com>
Date: Tue, 10 Dec 2019 08:19:45 +0100
In-Reply-To: <20191205174635.18758-8-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 5 Dec 2019 20:46:21 +0300")
Message-ID: <87h828odf2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Li9mtpf_Ou26YD1imLi4Sg-1
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
Cc: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Make kvmppc_hint_smt_possible hint append helper well formed:
> switch errp paramter to Error *const * type, as it has uncommon
> behavior: not change the pointer to return error, but operate on
> already existent error object.
> Rename function to be kvmppc_error_append_*_hint.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Let's adapt PATCH 03's commit message, like this:

  ppc: make Error **errp const where it is appropriate

  Mostly, Error ** is for returning error from the function, so the
  callee sets it. However kvmppc_hint_smt_possible gets already filled
  errp parameter. It doesn't change the pointer itself, only change the
  internal state of referenced Error object. So we can make it Error
  *const * errp, to stress the behavior. It will also help coccinelle
  script (in future) to distinguish such cases from common errp usage.

  While there, rename the function to
  kvmppc_error_append_smt_possible_hint().

With something like that:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


