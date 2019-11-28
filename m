Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE337C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60FE2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnxIZitF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60FE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaITk-0000O6-Ny
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 07:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iaIO9-0005yF-0h
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:55:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iaIO3-00076f-Gw
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:55:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25783
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iaIO3-0006xi-C8
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574942104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26FvW88Zge2Jojt9F4xu0/08ZBH7eJqXzVCxrElzIrU=;
 b=FnxIZitFIXa3nohriCbpLmV0zXxhWmpODO+Cc2Emk6zs65UX2ExMG+4bPAbjxxnaq/v0LE
 7x1onDwk5edxdOIm4JWsj6RgDEIC3gDhisJtNXK2ckYoHkgx0gJlh0dPY9JbQYyFtbdECI
 N4nJ06O0v7q0zaQpvttClbmbhjwEQUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-Wy8KNJ7UNJqrbaH_d2kNww-1; Thu, 28 Nov 2019 06:55:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 350E7800D41;
 Thu, 28 Nov 2019 11:55:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE1656084E;
 Thu, 28 Nov 2019 11:54:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E0B01138606; Thu, 28 Nov 2019 12:54:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v19 0/8] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
References: <20191128082109.30081-1-tao3.xu@intel.com>
Date: Thu, 28 Nov 2019 12:54:55 +0100
In-Reply-To: <20191128082109.30081-1-tao3.xu@intel.com> (Tao Xu's message of
 "Thu, 28 Nov 2019 16:21:01 +0800")
Message-ID: <87a78gnrlc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Wy8KNJ7UNJqrbaH_d2kNww-1
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 jonathan.cameron@huawei.com, sw@weilnetz.de, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, jingqi.liu@intel.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tao Xu <tao3.xu@intel.com> writes:

> This series of patches will build Heterogeneous Memory Attribute Table (H=
MAT)
> according to the command line. The ACPI HMAT describes the memory attribu=
tes,
> such as memory side cache attributes and bandwidth and latency details,
> related to the Memory Proximity Domain.
> The software is expected to use HMAT information as hint for optimization=
.
>
> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and repo=
rt
> the platform's HMAT tables.
>
> The V18 patches link:
> https://patchwork.kernel.org/cover/11263551/

With at least the error message in PATCH 3 fixed:
Acked-by: Markus Armbruster <armbru@redhat.com>


