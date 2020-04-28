Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8B4C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4911520661
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAOZHXuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4911520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTScM-0005JJ-Cd
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 11:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTSYs-0000y2-4V
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTSWQ-00084Y-Oh
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:54:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55568
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jTSWQ-00084A-A6
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588089105;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZR2NOfP2zuNtKFZgEaHB+9F/k94H5ZExxLHYhekdacs=;
 b=hAOZHXuQlNCQOlt1nCkOSXTtw3XFzU807ewbGaOZ65SdVE+X/K5LN0nvjUaqh6qHJFp5oV
 z0yr2aV+WyjJOAkAi19wzfz79HTnUPGlduM33WLYZMR45cuGzgldmBf4QYZ7LC0ph0YayO
 M/d6wtNrLtpfQZgcGUf5YQa4TUc4Dfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-Zpsb3qDkPyO4vMgIBNNLVg-1; Tue, 28 Apr 2020 11:51:43 -0400
X-MC-Unique: Zpsb3qDkPyO4vMgIBNNLVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E1B2800685;
 Tue, 28 Apr 2020 15:51:42 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F09915D710;
 Tue, 28 Apr 2020 15:51:38 +0000 (UTC)
Date: Tue, 28 Apr 2020 16:51:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 05/14] block/amend: refactor qcow2 amend options
Message-ID: <20200428155135.GC1467943@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
 <20200308151903.25941-6-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200308151903.25941-6-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 08, 2020 at 05:18:54PM +0200, Maxim Levitsky wrote:
> Some qcow2 create options can't be used for amend.
> Remove them from the qcow2 create options and add generic logic to detect
> such options in qemu-img
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/qcow2.c              | 108 ++++++---------------
>  qemu-img.c                 |  18 +++-
>  tests/qemu-iotests/049.out | 102 ++++++++++----------
>  tests/qemu-iotests/061.out |  12 ++-
>  tests/qemu-iotests/079.out |  18 ++--
>  tests/qemu-iotests/082.out | 149 ++++------------------------
>  tests/qemu-iotests/085.out |  38 ++++----
>  tests/qemu-iotests/087.out |   6 +-
>  tests/qemu-iotests/115.out |   2 +-
>  tests/qemu-iotests/121.out |   4 +-
>  tests/qemu-iotests/125.out | 192 ++++++++++++++++++-------------------
>  tests/qemu-iotests/134.out |   2 +-
>  tests/qemu-iotests/144.out |   4 +-
>  tests/qemu-iotests/158.out |   4 +-
>  tests/qemu-iotests/182.out |   2 +-
>  tests/qemu-iotests/185.out |   8 +-
>  tests/qemu-iotests/188.out |   2 +-
>  tests/qemu-iotests/189.out |   4 +-
>  tests/qemu-iotests/198.out |   4 +-
>  tests/qemu-iotests/243.out |  16 ++--
>  tests/qemu-iotests/250.out |   2 +-
>  tests/qemu-iotests/255.out |   8 +-
>  tests/qemu-iotests/263.out |   4 +-
>  tests/qemu-iotests/280.out |   2 +-
>  24 files changed, 283 insertions(+), 428 deletions(-)

Kind of annoying how the option order changes, but that's not
a functional problem and there's no easy way to avoid it.
Perhaps the original code should have alphabetically ordered
them but that's not your problem to solve really.

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


