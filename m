Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36FDC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D9D2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xh+/TDFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D9D2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEHYC-00071j-FU
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 15:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEHVE-0002kp-1V
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEHVC-0006Fn-HS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:03:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43769)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEHVC-0006DP-Cv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584471826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSilGJBkQuQvfYa1uNjEQdTyePhPldg/uLAw2E87cS8=;
 b=Xh+/TDFiSz4ZaxBOtgy8f5kagyIhPQomWyq32Biavxcau7UTcJuhS0CPfVIP/AZg308OhO
 SW/kXiwTTo2V9H0IehJKmxx2P85JDdAeFYOsgYUjypNpWbXAyiRZq4qcJ1Wm3aBUGZFp51
 +jp037P3vVkEAI8KjFWSRisFb3ZBSdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-hvi2SH3vPC--N2WAGpbn_A-1; Tue, 17 Mar 2020 15:03:42 -0400
X-MC-Unique: hvi2SH3vPC--N2WAGpbn_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0F4A801E72;
 Tue, 17 Mar 2020 19:03:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A4B219756;
 Tue, 17 Mar 2020 19:03:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C6C581138404; Tue, 17 Mar 2020 20:03:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 3/3] xen-block: Use one Error * variable instead of two
References: <20200313170517.22480-1-armbru@redhat.com>
 <20200313170517.22480-4-armbru@redhat.com>
 <d6497746-2ed5-02e0-1934-065db818c1c6@virtuozzo.com>
Date: Tue, 17 Mar 2020 20:03:38 +0100
In-Reply-To: <d6497746-2ed5-02e0-1934-065db818c1c6@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 17 Mar 2020 15:32:36 +0300")
Message-ID: <87y2ryls6t.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: alxndr@bu.edu, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 ashijeetacharya@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Uh, I failed to actually send this.  It's in my pull request now.

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 13.03.2020 20:05, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   hw/block/xen-block.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
>> index 3885464513..7b3b6dee97 100644
>> --- a/hw/block/xen-block.c
>> +++ b/hw/block/xen-block.c
>> @@ -998,14 +998,13 @@ static void xen_block_device_destroy(XenBackendIns=
tance *backend,
>>       XenBlockVdev *vdev =3D &blockdev->props.vdev;
>>       XenBlockDrive *drive =3D blockdev->drive;
>>       XenBlockIOThread *iothread =3D blockdev->iothread;
>> +    Error *local_err =3D NULL;
>>         trace_xen_block_device_destroy(vdev->number);
>>         object_unparent(OBJECT(xendev));
>>         if (iothread) {
>> -        Error *local_err =3D NULL;
>> -
>>           xen_block_iothread_destroy(iothread, &local_err);
>>           if (local_err) {
>>               error_propagate_prepend(errp, local_err,
>> @@ -1015,8 +1014,6 @@ static void xen_block_device_destroy(XenBackendIns=
tance *backend,
>>       }
>>         if (drive) {
>> -        Error *local_err =3D NULL;
>> -
>>           xen_block_drive_destroy(drive, &local_err);
>>           if (local_err) {
>>               error_propagate_prepend(errp, local_err,
>
> Hmm, no "return;" statement after this propagation. It's OK, as there no =
more code in the function after this "if", but I'd add it to be consistent =
and to avoid forgetting to add a return here when add more code to the func=
tion.
>
> (and if you do this, you may also fix indentation of string paramter of e=
rror_propagate_prepend...)
>
>
>
> Anyway,
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Like this, I guess:

xen-block: Use one Error * variable instead of two

While there, tidy up indentation, and add return just for consistency
and robustness.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200313170517.22480-4-armbru@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 3885464513..07bb32e22b 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -998,29 +998,27 @@ static void xen_block_device_destroy(XenBackendInstan=
ce *backend,
     XenBlockVdev *vdev =3D &blockdev->props.vdev;
     XenBlockDrive *drive =3D blockdev->drive;
     XenBlockIOThread *iothread =3D blockdev->iothread;
+    Error *local_err =3D NULL;
=20
     trace_xen_block_device_destroy(vdev->number);
=20
     object_unparent(OBJECT(xendev));
=20
     if (iothread) {
-        Error *local_err =3D NULL;
-
         xen_block_iothread_destroy(iothread, &local_err);
         if (local_err) {
             error_propagate_prepend(errp, local_err,
-                                "failed to destroy iothread: ");
+                                    "failed to destroy iothread: ");
             return;
         }
     }
=20
     if (drive) {
-        Error *local_err =3D NULL;
-
         xen_block_drive_destroy(drive, &local_err);
         if (local_err) {
             error_propagate_prepend(errp, local_err,
-                                "failed to destroy drive: ");
+                                    "failed to destroy drive: ");
+            return;
         }
     }
 }


