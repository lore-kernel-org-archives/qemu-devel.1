Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0E8C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1578220708
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnNKIpWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1578220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY4k9-0003uE-AO
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 03:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iY4jG-0002lt-QM
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:55:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iY4jF-00045y-Ra
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:55:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42458
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iY4jF-00045l-No
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574412949;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zbJikIq9CKwSEcHz6wGPv04ne3C9Kf0INkPOFcOtJ+s=;
 b=hnNKIpWzX+vS50XKwv1U8fAeMAmkmYbzx/oh7dv8x0WNAJEthmMP/Umi89bBvpf92VRJQ0
 AHibxwpdUZJ3ZPFBRwk2hpCxMr6sPUulyrXwdnO+cO2VA8SSU7/RO66D2MSOwcGTheqhcb
 9pBHpajlfzWXtFhTGbQFLqv7XjqckBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-vbFU01wAOTKLVHCURmOqHA-1; Fri, 22 Nov 2019 03:55:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D0C9800054;
 Fri, 22 Nov 2019 08:55:45 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96C0A67660;
 Fri, 22 Nov 2019 08:55:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 2/2] util/cutils: Fix incorrect integer->float
 conversion caught by clang
In-Reply-To: <20191122080039.12771-3-armbru@redhat.com> (Markus Armbruster's
 message of "Fri, 22 Nov 2019 09:00:39 +0100")
References: <20191122080039.12771-1-armbru@redhat.com>
 <20191122080039.12771-3-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Fri, 22 Nov 2019 09:55:42 +0100
Message-ID: <87v9rci92p.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: vbFU01wAOTKLVHCURmOqHA-1
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
> Clang does not like do_strtosz()'s code to guard against overflow:
>
>     qemu/util/cutils.c:245:23: error: implicit conversion from 'unsigned =
long' to 'double' changes value from 18446744073709550592 to 18446744073709=
551616 [-Werror,-Wimplicit-int-float-conversion]
>
> The warning will be enabled by default in clang 10. It is not
> available for clang <=3D 9.
>
> val * mul >=3D 0xfffffffffffffc00 is indeed wrong.  0xfffffffffffffc00
> is not representable exactly as double.  It's half-way between the
> representable values 0xfffffffffffff800 and 0x10000000000000000.
> Which one we get is implementation-defined.  Bad.
>
> We want val * mul > (the largest uint64_t exactly representable as
> double).  That's 0xfffffffffffff800.  Write it as nextafter(0x1p64, 0)
> with a suitable comment.
>
> Signed-off-by: Fangrui Song <i@maskray.me>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> [Patch split, commit message improved]
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Learning this *new* C99 float format O:-)


