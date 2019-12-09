Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EFCC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E145E2072D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/PCAUbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E145E2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieF7L-000512-Su
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 04:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ieF5v-00041F-Ig
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ieF5u-00072R-Lc
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:12:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49286
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ieF5u-00072H-Hc
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575882762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZJAxh1/PjCaE4IqeYJIILLBag2+W4wGcEmn2KiR0Qk=;
 b=a/PCAUbDhxcr9qc7vO7YGGolJmhXkHfxWUS8Lje+ce25Y2KfQJQTmkEkZYCerXOVVJiW23
 JYotDLxqg8UdFLvpYyFXXj9JmPe5kqcTwsimeFST3wQjF6RntOpVML4iqxtlVMgTaj0fIT
 nM4/zNWqwpOjO/8crlrnDDsmgu5JLkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-1dn3j3CXPdunPg2A7jZo5g-1; Mon, 09 Dec 2019 04:12:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E620E800D41;
 Mon,  9 Dec 2019 09:12:39 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC4305D9CD;
 Mon,  9 Dec 2019 09:12:30 +0000 (UTC)
Date: Mon, 9 Dec 2019 10:12:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 PATCH 2/3] cpu: Introduce cpu_class_set_parent_reset()
Message-ID: <20191209101228.1f0a3957.cohuck@redhat.com>
In-Reply-To: <157565784026.3897844.6515055734977835356.stgit@bahia.lan>
References: <157565782864.3897844.627720481210693346.stgit@bahia.lan>
 <157565784026.3897844.6515055734977835356.stgit@bahia.lan>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 1dn3j3CXPdunPg2A7jZo5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 06 Dec 2019 19:44:00 +0100
Greg Kurz <groug@kaod.org> wrote:

> Similarly to what we already do with qdev, use a helper to overload the
> reset QOM methods of the parent in children classes, for clarity.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/core/cpu.c         |    8 ++++++++
>  include/hw/core/cpu.h |    4 ++++
>  2 files changed, 12 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


