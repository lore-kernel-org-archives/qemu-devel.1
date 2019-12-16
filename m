Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC531C2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8EB20665
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D23mFPg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8EB20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igscv-0004co-Lh
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1igsbN-00037l-JU
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1igsbM-00032k-IP
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:48:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58856
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1igsbM-0002yq-En
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576511283;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTymmXvftj84IfEA1KCVzmFyxk8nzfnBYzAXmYklk28=;
 b=D23mFPg/AYpDbCH2/LB44YnTd4z1rjT1aGV5ZPMiMBj0LgZYeklS8SP69ouBABOjGZeyjF
 LwDfkam8p+fWs0wlp6etXHLzlh6awaQyRHyjoZ1ON67cqqnfUkYSJq3VcljEeiTX3zmzTH
 qWSfFEQD6LH/P9bed1QheLwfMs6HBCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-0tcru5M5OeGyTXwoQxs4kg-1; Mon, 16 Dec 2019 10:48:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36E7A8017DF
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 15:47:59 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5F495C1B0;
 Mon, 16 Dec 2019 15:47:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 01/10] migration-test: Create cmd_soure and cmd_target
In-Reply-To: <f9961f1e-6898-f49d-203d-558872ee6f8d@redhat.com> (Paolo
 Bonzini's message of "Mon, 16 Dec 2019 14:31:01 +0100")
References: <20191212222033.1026-1-quintela@redhat.com>
 <20191212222033.1026-2-quintela@redhat.com>
 <f9961f1e-6898-f49d-203d-558872ee6f8d@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Mon, 16 Dec 2019 16:47:57 +0100
Message-ID: <87k16w6zma.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 0tcru5M5OeGyTXwoQxs4kg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 12/12/19 23:20, Juan Quintela wrote:
>> @@ -584,16 +585,16 @@ static int test_migrate_start(QTestState
>> **from, QTestState **to,
>>          cmd_src =3D g_strdup_printf("-machine accel=3D%s -m 150M"
>
> There will be conflicts here as this "-machine accel=3D%s" will change to
> "-accel", but nothing major.

Thanks.

Anyways, that just mean to fix it in two places, not in eight.
I was wondering about merging the common bits of the source and target,
but it looked more complicated that the simple deprecation.

Later, Juan.


