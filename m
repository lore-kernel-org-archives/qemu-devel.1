Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569C3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2BC214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+vvb3rU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2BC214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUZVk-0002w5-8p
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iUZV7-0002Vy-Ri
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iUZV5-0002GY-QT
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:58:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54587
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iUZV5-0002D2-Ap
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573577922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DEIhJvVrHl0Oa1XKwGVoSB1tDog/8nxNLWQ6hgh9650=;
 b=a+vvb3rUJIgC5QeZzx/WSvPM2ed2FR1m6G/tpdg0cKnfZCksf3chzYTZXXPiVJ44VCzI8x
 7F/7Lfue2NYyM/0I/WKA8kJXDYeJs6qe82d4WulSuWFMJzuHSi3tcIMpjkm2X2J830l/af
 w2QlgndCNiZ839Fhoqg9xYnO5a2N4m4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-BCthSfNoOpCwgvP04SmTSQ-1; Tue, 12 Nov 2019 11:58:40 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92D62801E50;
 Tue, 12 Nov 2019 16:58:39 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94E753ABE;
 Tue, 12 Nov 2019 16:58:29 +0000 (UTC)
Date: Tue, 12 Nov 2019 17:58:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2] s390x: Properly fetch the short psw on diag308 subc 0/1
Message-ID: <20191112175827.2d7bdb15.cohuck@redhat.com>
In-Reply-To: <20191111152808.13371-1-frankja@linux.ibm.com>
References: <20191111152808.13371-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: BCthSfNoOpCwgvP04SmTSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: borntraeger@de.ibm.com, qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 Nov 2019 10:28:08 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> We need to actually fetch the cpu mask and set it. As we invert the
> short psw indication in the mask, SIE will report a specification
> exception, if it wasn't present in the reset psw.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/cpu.c | 12 ++++++++++--
>  target/s390x/cpu.h |  1 +
>  2 files changed, 11 insertions(+), 2 deletions(-)

So, is this change -rc material, or should it go in during the next
release? I'm a bit confused here.

[Also, does this need a change in the tcg code, or is that something
that should just be done eventually? Sorry, drowning a bit in mails
here...]


