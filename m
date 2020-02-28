Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B1CC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F725246A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bij/u3Wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F725246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7nTO-0007EM-5X
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 16:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j7nSm-0006me-My
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j7nSk-0006JY-Vk
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:46:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22643
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j7nSk-0006JE-QV
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582926386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hr5q6AyGD5n1eh1Ew4RDlniK5pjlIC56b42GHfVxv0o=;
 b=Bij/u3WiMtTlKGPLp+vjnRY/TbCoeW+Jttaq76kEcf/Fny/BTjeJn+d4Mez/GtksMbIolL
 uY9Gm/RFs8xy+B2t1382h+E2Q2oQbiax+3oceFNy8yUdw5snZm8foA93MTMX0PrZ126xSG
 yZXlftdJAoD9ZPUM9tlU5jRSDdb4xls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-yn37GE-MNS-omZ7daGO3xg-1; Fri, 28 Feb 2020 16:46:22 -0500
X-MC-Unique: yn37GE-MNS-omZ7daGO3xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A4FD800D53;
 Fri, 28 Feb 2020 21:46:21 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2C121001B2C;
 Fri, 28 Feb 2020 21:46:20 +0000 (UTC)
Date: Fri, 28 Feb 2020 16:46:20 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v3 1/4] target/i386: Add Denverton-v2 (no MPX) CPU model
Message-ID: <20200228214620.GA494511@habkost.net>
References: <20200212081328.7385-1-tao3.xu@intel.com>
 <20200212081328.7385-2-tao3.xu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20200212081328.7385-2-tao3.xu@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 04:13:25PM +0800, Tao Xu wrote:
> Because MPX is being removed from the linux kernel, remove MPX feature
> from Denverton.
>=20
> Signed-off-by: Tao Xu <tao3.xu@intel.com>

Queued, thanks!

--=20
Eduardo


