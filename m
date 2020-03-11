Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4465DC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 08:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED6C2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 08:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FA9hLAsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED6C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBwXn-0002QM-8l
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 04:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1jBwX0-0001sg-BR
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 04:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1jBwWy-0008D8-HV
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 04:15:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35055
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1jBwWy-0008C5-AV
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 04:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583914555;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IVsgANGq7xvj2F/J9GyXr61+wsMoZpXHOc0Sgji+ejs=;
 b=FA9hLAsUpGRKh/cGFR3QzTLvXGjipwEOWkq31NaXTuT5beVvfX3BQdq/4IdVRPsur9arzE
 Mq48sn0bj03UrCbqHu3v+fIpUY2F27pk2nMYhho4ka4adZeKu9OP9T5IXRNKyb9AGKJAZ7
 uE3PvnIVWMi3JDepOFEF5QxlHrjvHHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-JTVUCjd-M2uooFXWXrpUqg-1; Wed, 11 Mar 2020 04:15:43 -0400
X-MC-Unique: JTVUCjd-M2uooFXWXrpUqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F34DE800D50;
 Wed, 11 Mar 2020 08:15:41 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-67.bne.redhat.com [10.64.54.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0779091D74;
 Wed, 11 Mar 2020 08:15:39 +0000 (UTC)
Subject: Re: [PATCH v3] hw/char/pl011: Enable TxFIFO and async transmission
To: qemu-devel@nongnu.org
References: <158390180818.945.5263842815462048004@39012742ff91>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <8b9f1061-5a13-2e45-fe8d-8f72d4a170cb@redhat.com>
Date: Wed, 11 Mar 2020 19:15:38 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <158390180818.945.5263842815462048004@39012742ff91>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/11/20 3:43 PM, no-reply@patchew.org wrote:
[...]
> http://patchew.org/logs/20200311040923.29115-1-gshan@redhat.com/testing.asan/?type=message.

Is it possible to be a false alarm? The detailed errors extracted from above
link is shown as below, and I'm unable to reproduce it at local:

Error message
=============

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img tests/qtest/dbus-vmstate-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="dbus-vmstate-test"
dbus-daemon[8241]: Could not get password database information for UID of current process: User "???" unknown or no memory to allocate password entry
dbus-daemon[8241]: Could not get password database information for UID of current process: User "???" unknown or no memory to allocate password entry


[gwshan@localhost qemu.main]$ MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img tests/qtest/dbus-vmstate-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="dbus-vmstate-test"
PASS 1 dbus-vmstate-test /x86_64/dbus-vmstate/without-list
PASS 2 dbus-vmstate-test /x86_64/dbus-vmstate/with-list
PASS 3 dbus-vmstate-test /x86_64/dbus-vmstate/only-a
PASS 4 dbus-vmstate-test /x86_64/dbus-vmstate/missing-src
PASS 5 dbus-vmstate-test /x86_64/dbus-vmstate/missing-dst

Thanks,
Gavin


