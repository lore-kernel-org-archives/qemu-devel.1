Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04A5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06002074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8yMwzvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06002074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiFg0-0005Mx-R7
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 07:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiFds-0002u0-EG
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:08:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21490
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiFdr-00070v-CY
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591614514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V7BpHoyI4HIE89IDMGhQo0ViZPrIctgET3NjdFf3t94=;
 b=U8yMwzvrGNqwYZ7s3xd+dK4ZSYUc0NoAOP8I8tLnEK+paj2r0z3ZnHI4tvZm26cLM+zu91
 cIiDOX6u0+NANw7knOmDXX4GCChU5I/fiwtI9Rge4en+kBaGsUjuEwkxO08J+A5f6pmUR6
 evFjzcnkvOOl6Y5ya2ce86vFeXAcORg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-gCuBQhHTO_2aAFo1lOEzaA-1; Mon, 08 Jun 2020 07:08:32 -0400
X-MC-Unique: gCuBQhHTO_2aAFo1lOEzaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2F81461;
 Mon,  8 Jun 2020 11:08:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A78A5D9C9;
 Mon,  8 Jun 2020 11:08:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 09DF611386A6; Mon,  8 Jun 2020 13:08:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 00/24] Fixes around device realization
References: <20200528110444.20456-1-armbru@redhat.com>
Date: Mon, 08 Jun 2020 13:08:29 +0200
In-Reply-To: <20200528110444.20456-1-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 28 May 2020 13:04:20 +0200")
Message-ID: <874krlvmqa.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 ehabkost@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, pbonzini@redhat.com,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> This fixes a bunch of bugs I ran into while reworking how qdevs plug
> into buses.
>
> I instrumented the code a bit to flush out instances of bug patterns.
> I posted these hacks separately as '[PATCH not-for-merge 0/5]
> Instrumentation for "Fixes around device realization"'.  PATCH 2/5
> since became "[PATCH 0/2] qom: Make "info qom-tree" show children
> sorted".  It should be applied first.
>
> v2:
> * Rebased
> * PATCH 01: Also fix MMIO addresses, with Alistair's help
> * PATCH 04+05: Replaced by better patches from C=C3=A9dric
> * PATCH 01-03+06+08-11+18: Commit messages improved [Peter, Paolo]
> * PATCH 08+09+18: Avoid qdev_init_nofail() [Peter]
> * PATCH 22: Assertion simplified
>
> Based-on: Message-Id: <20200527084754.7531-1-armbru@redhat.com>

Peter, you commented on v1 of PATCH 06 and 09.  Please review v2.

Mark, you commented on v1 of PATCH 10.  Please review v2.

PATCH 18 needs review.  Philippe, perhaps?


