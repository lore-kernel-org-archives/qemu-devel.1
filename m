Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A30C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82AAA20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHaJpXSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AAA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE4Z1-0006Sx-NX
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 01:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jE4YD-0005ec-4S
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jE4YB-000838-Df
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:14:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36895)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jE4YB-0007zg-9c
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584422035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIibpOF3Ybmhf5yYvoigml2Q0YIpZ0LKOGnhrcUNN14=;
 b=cHaJpXSI2Aa44kBi36BV3szttskGX+Ck5+M8O05lW1UQjh3MVBhLtNWJ/xSPo9H66pXTO+
 HJYB4jUqxEhzOojG8ZVzTR2lXGYftlROGtI0xDtEFR/VmsbpJoUtrzjrLGqfXhSeeppF4Y
 9L89aO1ssSCsxQfcBQD0+9s/0S6IiDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-QvHT6Uo3Ozyxb6hoqF_ddg-1; Tue, 17 Mar 2020 01:13:51 -0400
X-MC-Unique: QvHT6Uo3Ozyxb6hoqF_ddg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B62BE107ACC9;
 Tue, 17 Mar 2020 05:13:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F4B55D9E2;
 Tue, 17 Mar 2020 05:13:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF21A1138405; Mon, 16 Mar 2020 20:46:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v3 05/34] tests/test-qmp-cmds: Factor out qmp_dispatch()
 test helpers
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-6-armbru@redhat.com>
 <CAJ+F1C+c+d3WRPLmBsLm73k4dESHCC-czUe9ME4okQsyynSvuw@mail.gmail.com>
Date: Mon, 16 Mar 2020 20:46:57 +0100
In-Reply-To: <CAJ+F1C+c+d3WRPLmBsLm73k4dESHCC-czUe9ME4okQsyynSvuw@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 16 Mar 2020
 16:06:41 +0100")
Message-ID: <87a74gw09a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Sun, Mar 15, 2020 at 3:48 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Checking the value of qmp_dispatch() is repetitive.  Factor out
>> helpers do_qmp_dispatch() and do_qmp_dispatch_error().  Without this,
>> the next commit would make things even more repetitive.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/test-qmp-cmds.c | 72 +++++++++++++++++++++----------------------
>>  1 file changed, 35 insertions(+), 37 deletions(-)
>
> ASAN is unhappy:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D1870336=3D=3DERROR: LeakSanitizer: detected memory leaks
>
> Indirect leak of 4120 byte(s) in 1 object(s) allocated from:
>     #0 0x7fcdc9b8be56 in __interceptor_calloc (/lib64/libasan.so.5+0x10de=
56)
>     #1 0x7fcdc998e3b0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x573b0)
>     #2 0x560213f56dbb in test_dispatch_cmd_io
> /home/elmarco/src/qemu/tests/test-qmp-cmds.c:238
>     #3 0x7fcdc99b0a8d  (/lib64/libglib-2.0.so.0+0x79a8d)
[...]

Thanks!

Fixup to be squashed in here, with revert to be squashed into PATCH 07:

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index fb18475c7e..b31064b064 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -279,8 +279,6 @@ static void test_dispatch_cmd_io(void)
     g_assert(qnum_get_try_int(ret3, &val));
     g_assert_cmpint(val, =3D=3D, 66);
     qobject_unref(ret3);
-
-    qobject_unref(req);
 }
=20
 /* test generated dealloc functions for generated types */


