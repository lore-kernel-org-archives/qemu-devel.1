Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C74C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 06:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A414420708
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 06:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDqvYFn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A414420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXfxT-00024I-Oc
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 01:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iXfwp-0001dN-N4
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 01:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iXfwl-0001Op-TE
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 01:28:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53178
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iXfwl-0001Hz-La
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 01:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574317684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9yiXpfUwE3mpuXek4Ird8BJ+QjZsDNv35LKJiUz+o6A=;
 b=ZDqvYFn/c1AZQtHySwVzhb/XjLbH1LsxkQqzpoMj8nfApQNtIBgFMuDRSFPu1USVOMViSC
 pv8kEG/AcHQ/eM/NI2cVEjAjf9Vue236O0poDh2y8MZgbOQJ2QAhcAH+bKkvSq5NmyB/l9
 1GuKzpQiChn0L01EAfHaukobzvY+dKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118--U90i3HBM1SDag8CKhd9Vw-1; Thu, 21 Nov 2019 01:28:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E9E31804975;
 Thu, 21 Nov 2019 06:28:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7DE05B082;
 Thu, 21 Nov 2019 06:27:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 664A71138606; Thu, 21 Nov 2019 07:27:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/6] qapi: Module fixes and cleanups
References: <20191120182551.23795-1-armbru@redhat.com>
Date: Thu, 21 Nov 2019 07:27:58 +0100
In-Reply-To: <20191120182551.23795-1-armbru@redhat.com> (Markus Armbruster's
 message of "Wed, 20 Nov 2019 19:25:45 +0100")
Message-ID: <87tv6xkakx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: -U90i3HBM1SDag8CKhd9Vw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Kevin recently posted a minimally invasive fix for empty QAPI
> modules[*].  This is my attempt at a fix that also addresses the
> design weakness that led to the bug.

[*] Subject: [RFC PATCH 15/18] qapi: Support empty modules
Message-Id: <20191017130204.16131-16-kwolf@redhat.com>


