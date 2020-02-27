Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C481C3567B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A2524691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkpORp/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A2524691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7KO7-0006n6-Dc
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j7KNW-0006Hc-SF
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j7KNV-0007LW-W2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:43:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31476
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j7KNV-0007Hl-Rx
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582814583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmD2ZFPZZpk5XbvUVfPlx6Raqi4gaUWYGoD2SpPyCfU=;
 b=CkpORp/alxhXHKbrCpFFFPZjpokfZdWiGZBqP59kOmjMrNxw4F4874JYGTovoQsEK5nLu3
 OaQKlz7+H9tWIkpsncGZyGsZjzQt1AKCyvrUsR0Upijcr4coRL6xEtDAVnvPmkp9JGoGPn
 FglSAsVnmVEtZP5oR8/Ajk2T9OrddNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-IfPX7PbyNTG4F7DPSqQJMQ-1; Thu, 27 Feb 2020 09:42:58 -0500
X-MC-Unique: IfPX7PbyNTG4F7DPSqQJMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DDCA8017DF;
 Thu, 27 Feb 2020 14:42:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E3548C086;
 Thu, 27 Feb 2020 14:42:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B276911386A6; Thu, 27 Feb 2020 15:42:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/2] util/oslib-win32: Improve error report by calling
 error_setg_win32()
References: <20200227100250.20514-1-philmd@redhat.com>
 <20200227100250.20514-3-philmd@redhat.com>
Date: Thu, 27 Feb 2020 15:42:52 +0100
In-Reply-To: <20200227100250.20514-3-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 27 Feb 2020 11:02:50
 +0100")
Message-ID: <87zhd4ozv7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Use error_setg_win32() which adds a hint similar to strerror(errno)).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  util/oslib-win32.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index e9b14ab178..d2fca1808d 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -46,7 +46,8 @@
>  void *qemu_oom_check(void *ptr)
>  {
>      if (ptr =3D=3D NULL) {
> -        fprintf(stderr, "Failed to allocate memory: %lu\n", GetLastError=
());
> +        g_autofree gchar *emsg =3D g_win32_error_message(GetLastError())=
;

Since we're on a path to abort(), I wouldn't bother with g_autofree.

> +        fprintf(stderr, "Failed to allocate memory: %s\n", emsg);

Any particular reason not to use error_report()?

>          abort();
>      }
>      return ptr;


