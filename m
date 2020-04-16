Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DEAR_SOMETHING,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D4CC2D0EF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 07:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309AF2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 07:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACr0UNYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309AF2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOzJD-0005KS-B1
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 03:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOzIW-0004pb-MB
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 03:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOzIV-0004oQ-Nn
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 03:50:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56929
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOzIV-0004o6-L8
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 03:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587023455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlZ2C0GPzKofHUBAbzZ3svQZUODE+iDqcnqN4xBHcqA=;
 b=ACr0UNYP4QTzuQWRD4xD6eDhQT4KaivTI6xK2lloe2DjaDmEe4rpTqW/kvrhw/eoAoWjIa
 8N2GgAzqX7tk/n3dZjA7+WLGviAgJInZi4IxwGbWelK/cKSwoE/36B35ZvJASMwbX/+mAY
 ngU9mvr5L5oHo9n1aQlojI7Z0uawvak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-OtgBs6GdOcuQE_RUpHgh_g-1; Thu, 16 Apr 2020 03:50:51 -0400
X-MC-Unique: OtgBs6GdOcuQE_RUpHgh_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48E1F107ACC9;
 Thu, 16 Apr 2020 07:50:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFFFB1001DD8;
 Thu, 16 Apr 2020 07:50:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 45B2B11385C8; Thu, 16 Apr 2020 09:50:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: <janine.schneider@fau.de>
Subject: Re: Integration of qemu-img
References: <00fc01d61256$35f849c0$a1e8dd40$@fau.de>
Date: Thu, 16 Apr 2020 09:50:48 +0200
In-Reply-To: <00fc01d61256$35f849c0$a1e8dd40$@fau.de> (janine schneider's
 message of "Tue, 14 Apr 2020 14:14:12 +0200")
Message-ID: <877dyfc1if.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: qemu-block

<janine.schneider@fau.de> writes:

> Dear Sir or Madam,
>
> =20
>
> I am a PhD student at the Friedrich-Alexander-University Erlangen-N=C3=BC=
rnberg
> in Bavaria Germany and I am currently working on an open-source forensic
> analysis tool. I would like to use qemu-img for converting virtual discs =
to
> raw files and to get virtual disc information. By now I tried to create a
> qemu-img DLL with the qemu source code you provide on your website, but I=
 am
> unable to compile it properly. Therefore, I would like to ask you if ther=
e
> is a simple solution to integrate qemu-img to other C++ projects? Or is
> there a precompiled qemu-img DLL which I could use? Thank you very much f=
or
> your support.
>
> =20
>
> Best,
>
> Janine Schneider
>
> =20


