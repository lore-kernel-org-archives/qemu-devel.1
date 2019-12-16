Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44345C2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1153A206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 12:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D84JVSoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1153A206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igpMg-0004PG-8y
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 07:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1igpKb-0001bM-Ig
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1igpKZ-0002CB-FO
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:18:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53797
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1igpKZ-0002BK-8N
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 07:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576498710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=cqaJdP3TtA73S+4ncJOjEYsMFzUZZevQNaQZ+pj7Qs4=;
 b=D84JVSoSUVljPUXJt0LWHL5J/4b2CGI08Mh/wr6VKEUxREsYLI0GbEBlGSsLJvzuvftcsb
 6hldLXN73SLNR2dV9E2dCCz6P3sQaoJCcFoSBwfAy3fS5XQzaGqQ4US+EUcfoBd9nn79xy
 tPcLfu34vsgvQxe2CNT++xof792OJOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-_dXcjtlyNyuub8N3DZ72ZQ-1; Mon, 16 Dec 2019 07:18:26 -0500
X-MC-Unique: _dXcjtlyNyuub8N3DZ72ZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1FC1800D4C;
 Mon, 16 Dec 2019 12:18:24 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-164.ams2.redhat.com [10.36.117.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F170610001B3;
 Mon, 16 Dec 2019 12:18:22 +0000 (UTC)
Subject: Re: [RFC QEMU PATCH] pc-bios/s390-ccw: Add zipl-like "BOOT_IMAGE=x"
 to the kernel parameters
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20191216112432.13412-1-thuth@redhat.com>
 <ffea8f68-714b-798e-3563-12f9bf0668fa@de.ibm.com>
 <20191216130920.42711f32.cohuck@redhat.com>
 <aab20f72-6350-b5a7-5bb0-e068b37bd766@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <80cbf5b0-ffbd-688f-8733-58dace78faab@redhat.com>
Date: Mon, 16 Dec 2019 13:18:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <aab20f72-6350-b5a7-5bb0-e068b37bd766@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: linux-s390@vger.kernel.org,
 =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Stefan Haberland <sth@linux.ibm.com>,
 psundara@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/12/2019 13.15, Christian Borntraeger wrote:
[...]
> I just learned from Peter that booting SCSI also has no BOOT_IMAGE (as
> we have no menu). So Thomas, can you find out the use case for the initial
> bug report.  That might give an indication on how to proceed for all cases.

Apparently this parameter is used by Dracut, see:

https://bugzilla.redhat.com/show_bug.cgi?id=1782026#c4

 Thomas


