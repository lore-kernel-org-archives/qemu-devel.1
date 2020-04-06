Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA94C2BA18
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 07:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491EF20672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 07:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdyDogoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491EF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLMIJ-0006mf-Ee
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 03:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1jLMHK-0006CX-CB
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 03:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1jLMHI-0005Ok-JX
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 03:34:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49351
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1jLMHI-0005Mt-CL
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 03:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586158478;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ks5m9vi3lAO+O8dbr7nFM3WNeHB+j52BYy7vQ4RstqE=;
 b=WdyDogoIhJXoKbya9+NJvVbAP23q1/nU025LMx4ACEUjlUExdzLPtZ6awF2sn7ZkSrf2kZ
 6Xa4MgvpJgjdy+tgHPGhdCp+56obmFq9YNFC5EyuxW6nuZFg4h33siQbQ+o6tsek1eEVFz
 1IwrGn/7CQkGpxqCeSppMiTFmOjlna0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-w_-2prtuMeWH_3N3oMbXNg-1; Mon, 06 Apr 2020 03:34:37 -0400
X-MC-Unique: w_-2prtuMeWH_3N3oMbXNg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 863FF18B9FC3;
 Mon,  6 Apr 2020 07:34:35 +0000 (UTC)
Received: from redhat.com (ovpn-113-1.rdu2.redhat.com [10.10.113.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EC4F101D489;
 Mon,  6 Apr 2020 07:34:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: dnbrdsky@gmail.com
Subject: Re: [PATCH v5 2/2] lockable: replaced locks with lock guard macros
 where appropriate
In-Reply-To: <20200404042108.389635-3-dnbrdsky@gmail.com>
 (dnbrdsky@gmail.com's message of "Fri, 3 Apr 2020 21:21:08 -0700")
References: <20200404042108.389635-1-dnbrdsky@gmail.com>
 <20200404042108.389635-3-dnbrdsky@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Mon, 06 Apr 2020 09:34:31 +0200
Message-ID: <875zedm5iw.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: quintela@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "open list:iSCSI" <qemu-block@nongnu.org>, stefanha@gmail.com,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dnbrdsky@gmail.com wrote:
> From: Daniel Brodsky <dnbrdsky@gmail.com>
>
> - ran regexp "qemu_mutex_lock\(.*\).*\n.*if" to find targets
> - replaced result with QEMU_LOCK_GUARD if all unlocks at function end
> - replaced result with WITH_QEMU_LOCK_GUARD if unlock not at end
>
> Signed-off-by: Daniel Brodsky <dnbrdsky@gmail.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


