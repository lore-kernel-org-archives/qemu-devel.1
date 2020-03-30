Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD3BC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26011206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhkA+y+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26011206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIva0-0004W8-BB
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 10:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jIvZJ-00041d-0s
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jIvZH-0001hl-V1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:39:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32739)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jIvZH-0001hT-Qq
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585579151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ydDpRuvF0uJ1mN/99ik4zriyRwH+aOcrPe/wsSEZ2do=;
 b=bhkA+y+4kLVN1+BXszN4eesezgx7/O6LfqoL2eSIoFx//dWkn+mJGh1EFAHHx7XejvrdWV
 hYJJT5UnBLawowi+JVJI8q2qHEBVrSCjVypo89JFcKKOAe3+O6QBu6FBfw718huiNlh9nn
 iJSAvNh/PPw3BkQMLfM2dws2waG1W0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-FD--B0lINWSAVloqt9JSCA-1; Mon, 30 Mar 2020 10:39:10 -0400
X-MC-Unique: FD--B0lINWSAVloqt9JSCA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A703713FB;
 Mon, 30 Mar 2020 14:39:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 715DC6031F;
 Mon, 30 Mar 2020 14:39:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 034B411385E2; Mon, 30 Mar 2020 16:39:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v9 01/14] iotests: do a light delinting
References: <20200324232103.4195-1-jsnow@redhat.com>
 <20200324232103.4195-2-jsnow@redhat.com>
Date: Mon, 30 Mar 2020 16:39:05 +0200
In-Reply-To: <20200324232103.4195-2-jsnow@redhat.com> (John Snow's message of
 "Tue, 24 Mar 2020 19:20:50 -0400")
Message-ID: <87d08tvree.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> This doesn't fix everything in here, but it does help clean up the
> pylint report considerably.
>
> This should be 100% style changes only; the intent is to make pylint
> more useful by working on establishing a baseline for iotests that we
> can gate against in the future.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 83 ++++++++++++++++++-----------------
>  1 file changed, 43 insertions(+), 40 deletions(-)
>
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 7bc4934cd2..886ae962ae 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
[...]
> @@ -1062,6 +1063,7 @@ def func_wrapper(test_case: QMPTestCase, *args, **k=
wargs):
>              if usf_list:
>                  test_case.case_skip('{}: formats {} are not whitelisted'=
.format(
>                      test_case, usf_list))
> +                return None
>              else:
>                  return func(test_case, *args, **kwargs)
>          return func_wrapper
> @@ -1073,6 +1075,7 @@ def skip_if_user_is_root(func):
>      def func_wrapper(*args, **kwargs):
>          if os.getuid() =3D=3D 0:
>              case_notrun('{}: cannot be run as root'.format(args[0]))
> +            return None
>          else:
>              return func(*args, **kwargs)
>      return func_wrapper

Observation, not demand: this trades one kind of pylint report for
another: inconsistent-return-statements for no-else-return.  PATCH 05
suppresses no-else-return.


