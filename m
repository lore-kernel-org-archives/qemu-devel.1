Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D175C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDDB20838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9b0lIZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDDB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k13vd-0003q1-AR
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 04:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k13ut-0003Pw-Ut
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:27:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42258
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k13us-0005zi-6V
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596097673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6kIONUU8gN8VfaNS2ebfWYVSEgQ5k2a/FOH5IiAgzKg=;
 b=W9b0lIZQYXeXHKgBpc7q8LDhC3CCS4fAhN0mTcNwzmJjO8Y6jdHesMNU74ZoUqSRjPNvys
 5tKcvN1T+5yylspC848ThzFYGiDPvC3i8OMCu2ZM75xb6UAjH3/aszlNeAWNQVoNbe3+/W
 2GrEVWl6kU8h+QUkBAbyxoSwiAre3I8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-C7lxBTTsN-KsNqGm4Bk29Q-1; Thu, 30 Jul 2020 04:27:50 -0400
X-MC-Unique: C7lxBTTsN-KsNqGm4Bk29Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7CB7E92B;
 Thu, 30 Jul 2020 08:27:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68D718A181;
 Thu, 30 Jul 2020 08:27:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0462F1132FD2; Thu, 30 Jul 2020 10:27:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-5.2 v4] hw/core/qdev: Increase qdev_realize() kindness
References: <20200727175112.6820-1-f4bug@amsat.org>
 <87d04gf5i4.fsf@dusky.pond.sub.org>
 <b5cd0d50-c0a6-afee-5b63-80bb83e7e001@redhat.com>
 <87r1suahxu.fsf@dusky.pond.sub.org>
 <c086f053-b4db-532d-2c8e-b29ec5e3e708@redhat.com>
Date: Thu, 30 Jul 2020 10:27:47 +0200
In-Reply-To: <c086f053-b4db-532d-2c8e-b29ec5e3e708@redhat.com> (Paolo
 Bonzini's message of "Thu, 30 Jul 2020 00:25:10 +0200")
Message-ID: <87sgd92yrg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Dau?= =?utf-8?Q?d=C3=A9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/07/20 09:39, Markus Armbruster wrote:
>> Taking a step back, I disagree with the notion that assertions should be
>> avoided just because we have an Error **.  A programming error doesn't
>> become less wrong, and continuing when the program is in disorder
>> doesn't become any safer when you add an Error ** parameter to a
>> function.
>
> I don't think it is actually unsafe to continue after passing a bus-less
> device with a bus_type to qdev_realize.  It will fail, but orderly.
>
> So even though it's a programming error, it should not be a big deal to
> avoid the assertion here: either the caller will pass &error_abort, or
> it will print a nice error message and let the user go on with their
> business.

An error message the user can do nothing about other than report as a
bug is never nice.

We can try to phrase the message in a way that makes "this is a bug,
please report" clear, but doing that case-by-case can only result in
inconsistency and confusion.  Having a common way to do it gets us to:

>> If you're calling for recovering from programming errors where that can
>> be done safely, we can talk about creating the necessary infrastructure.
>> Handling them as if they were errors the user can do something about can
>> only lead to confusion.

Moreover, we want programming errors reported even when we recover, so
they get fixed.  If we treat them like any other error, that is not
assured: errors may be handled silently.

> I'm not particularly attached to the change, but it seemed inconsistent
> to use error_setg(&error_abort).

From error.h:

 * Please don't error_setg(&error_fatal, ...), use error_report() and
 * exit(), because that's more obvious.
 * Likewise, don't error_setg(&error_abort, ...), use assert().


