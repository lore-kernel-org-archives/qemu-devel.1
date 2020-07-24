Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4FAC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 11:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8833D206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 11:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUcgbefB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8833D206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyw8t-0002Yb-Nk
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 07:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyw87-00026D-U4
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 07:44:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54721
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyw85-0003Pv-Dq
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 07:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595591083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uZ+/v0bulO2yZjMmhD6CMZfK6NjajQHza/hAj6xHUwY=;
 b=LUcgbefBhXG1FqUBt2xdCXUZer7SqADkjwF6M1OAiReayKEOGcQmP9K2Ljh/B323dU92/V
 QlCl7arr9Ws7+WF6t/BFoAib/AdPIEiWja3wZKI0JUyBmnA80vk12VAc+A5U8kolvZgXw4
 Tqi54FC4ZqIVjiJZ2ZLygxnO1PCrFsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-Buz196eRMJOWTJ257jD25g-1; Fri, 24 Jul 2020 07:44:41 -0400
X-MC-Unique: Buz196eRMJOWTJ257jD25g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 847AE8017FB;
 Fri, 24 Jul 2020 11:44:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4043910013D9;
 Fri, 24 Jul 2020 11:44:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CAE621138648; Fri, 24 Jul 2020 13:44:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.1? v2] qapi/error: Check format string argument in
 error_*prepend()
References: <20200723171205.14949-1-philmd@redhat.com>
Date: Fri, 24 Jul 2020 13:44:38 +0200
In-Reply-To: <20200723171205.14949-1-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 23 Jul 2020 19:12:05
 +0200")
Message-ID: <87r1t1b0ih.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
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
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> error_propagate_prepend() "behaves like error_prepend()", and
> error_prepend() uses "formatting @fmt, ... like printf()".
> error_prepend() checks its format string argument, but
> error_propagate_prepend() does not. Fix by addint the format
> attribute to error_propagate_prepend() and error_vprepend().
>
> This would have caught the bug fixed in the previous commit:
>
>     CC      hw/sd/milkymist-memcard.o
>   hw/sd/milkymist-memcard.c: In function =E2=80=98milkymist_memcard_reali=
ze=E2=80=99:
>   hw/sd/milkymist-memcard.c:284:70: error: format =E2=80=98%s=E2=80=99 ex=
pects a matching =E2=80=98char *=E2=80=99 argument [-Werror=3Dformat=3D]
>     284 |         error_propagate_prepend(errp, err, "failed to init SD c=
ard: %s");
>         |                                                                =
     ~^
>         |                                                                =
      |
>         |                                                                =
      char *
>
> Missed in commit 4b5766488f "error: Fix use of error_prepend() with
> &error_fatal, &error_abort".
>
> Inspired-by: Stefan Weil <sw@weilnetz.de>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Since v1:
> - Reword (Markus)
> - Add error_vprepend (Stefan)
> - Use local style to add the attribute *after* the declaration,
>   which is invalid on definition where we get (depending on the
>   toolchain):
>
>   . error: attributes should be specified before the declarator in a func=
tion definition
>
>   . error: attributes are not allowed on a function-definition
>
> Supersedes: <20200723091309.18690-1-philmd@redhat.com>

Queued with Stefan's R-by from v1.  Hope what's okay.  Thanks!


