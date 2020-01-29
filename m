Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D240C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C2D20716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9clbukT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C2D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwjNI-0002fN-9Z
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 04:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iwjMC-0001yh-NC
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iwjMB-0008W4-Qv
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:09:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54075
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iwjMB-0008Tb-Nj
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580288995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jHDQHJR7jVN2ZdhbBBmRidYepfeqSMIaJMPK35m2NHM=;
 b=B9clbukTSetFN5axyVZmAeWzXRDqhBOSgv8a34Ud0Dw5PS6ysHmeSPV11Ewg+JWAN1ZW5A
 8+5wHxe50lT8Q332zYAkz02VaKAmZTM0B5cVZqgnJ+Rsl4ypR68D53jR624tMdcsHG52OU
 TX5+XaM1qVwt0vuZFHPE8wagoH5oQNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-M9oPHiszNXuB4gyMlxpY8w-1; Wed, 29 Jan 2020 04:09:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 238B1DB63;
 Wed, 29 Jan 2020 09:09:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC3D885752;
 Wed, 29 Jan 2020 09:09:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4B2241138404; Wed, 29 Jan 2020 10:09:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 3/4] monitor: Create monitor/qmp-cmds-control.c
References: <20200128175211.30007-1-kwolf@redhat.com>
 <20200128175211.30007-4-kwolf@redhat.com>
Date: Wed, 29 Jan 2020 10:09:50 +0100
In-Reply-To: <20200128175211.30007-4-kwolf@redhat.com> (Kevin Wolf's message
 of "Tue, 28 Jan 2020 18:52:10 +0100")
Message-ID: <87wo9a39y9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: M9oPHiszNXuB4gyMlxpY8w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Move all of the QMP commands handlers to implement the 'control' module
> (qapi/control.json) that can be shared between the system emulator and
> tools such as a storage daemon to a new file monitor/qmp-cmds-control.c.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
[...]
> diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
> new file mode 100644
> index 0000000000..dc789de3f8
> --- /dev/null
> +++ b/monitor/qmp-cmds-control.c
> @@ -0,0 +1,153 @@
> +/*
> + * QMP commands related to the monitor (common functions for sysemu and =
tools)

Rather long line.  Let's s/common functions for/common to/.

The parenthesis is aspirational.  I'd add it when it becomes factual,
but I'm willing to accept it even now.

[...]

With the comment tweak:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


