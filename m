Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C240C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB52320708
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BT7yGk0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB52320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY4jV-0002tN-1B
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 03:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iY4ib-00029Z-BE
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:55:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iY4iZ-0003lQ-50
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:55:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49865
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iY4iY-0003kw-QM
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574412905;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JUwxCrnzB76cIKSClpenWgv6NBaDCE7HbEhGyx6PRx0=;
 b=BT7yGk0XpDbeiNjLJo48an0H7smjhaMTq35eJF9TyLyT78Fo8KJPlaCkkjywDCb+5jzIE9
 2TDznrWTr+cTiEoK/2VmjNXXtKzjT70QuBerFDyG4K5c7VjIhQEcUtDL+yOjFO6X5la7Rg
 TXXGucTS5ut7vaRUM94TpdEWnvwmIqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-fFu7lGW2P5yaylNO0MdYwg-1; Fri, 22 Nov 2019 03:55:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8745A91220;
 Fri, 22 Nov 2019 08:55:00 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F17105D6A3;
 Fri, 22 Nov 2019 08:54:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 1/2] migration: Fix incorrect integer->float conversion
 caught by clang
In-Reply-To: <20191122080039.12771-2-armbru@redhat.com> (Markus Armbruster's
 message of "Fri, 22 Nov 2019 09:00:38 +0100")
References: <20191122080039.12771-1-armbru@redhat.com>
 <20191122080039.12771-2-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Fri, 22 Nov 2019 09:54:56 +0100
Message-ID: <87zhgoi93z.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: fFu7lGW2P5yaylNO0MdYwg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: Fangrui Song <i@maskray.me>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> wrote:
> From: Fangrui Song <i@maskray.me>
>
> Clang does not like qmp_migrate_set_downtime()'s code to clamp double
> @value to 0..INT64_MAX:
>
>     qemu/migration/migration.c:2038:24: error: implicit conversion from '=
long' to 'double' changes value from 9223372036854775807 to 922337203685477=
5808 [-Werror,-Wimplicit-int-float-conversion]
>
> The warning will be enabled by default in clang 10. It is not
> available for clang <=3D 9.
>
> The clamp is actually useless; @value is checked to be within
> 0..MAX_MIGRATE_DOWNTIME_SECONDS immediately before.  Delete it.
>
> While there, make the conversion from double to int64_t explicit.
>
> Signed-off-by: Fangrui Song <i@maskray.me>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> [Patch split, commit message improved]
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Should I get this through migration tree, or are you going to pull it?

Later, Juan.


