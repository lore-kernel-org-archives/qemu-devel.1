Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B10C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202EE206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgkfgrvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202EE206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9po-0002a0-8v
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jE9lY-0004Ov-Vx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jE9lW-0005go-Qb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:48:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32611)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jE9lW-0005eL-L4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584442086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0n1YYL4/APPQLsGPtIEHuML+/kO9dUi6LIEEAe8m3E=;
 b=SgkfgrvL384kz4Tla0z8mXdqPnDPNR8udde0+6kEGSfHHdkDZ6f0WmfAfCPzCDd6ws21Fb
 t/qaYVO8JvcrZirXUG0OdWNIte8bJqxmgxSU90cyIs6k9UQ70+jp15EqKF8Z3YAVe7i/IO
 dsvnh+7dlcBr6IAYFNWRIvOn/HzVHZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-g3JwkAMfNXmwP-DGEnmyEg-1; Tue, 17 Mar 2020 06:48:02 -0400
X-MC-Unique: g3JwkAMfNXmwP-DGEnmyEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F27D687181E;
 Tue, 17 Mar 2020 10:47:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BB3F8AC30;
 Tue, 17 Mar 2020 10:47:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 003521138404; Tue, 17 Mar 2020 11:47:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH] qom-qmp-cmds: Fix another memory leak in qmp_object_add()
References: <20200317092241.31660-1-armbru@redhat.com>
 <7412CDE03601674DA8197E2EBD8937E83B69E58A@dggemm531-mbx.china.huawei.com>
Date: Tue, 17 Mar 2020 11:47:53 +0100
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B69E58A@dggemm531-mbx.china.huawei.com>
 (Chenqun's message of "Tue, 17 Mar 2020 10:15:39 +0000")
Message-ID: <87k13jqmue.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Kevin Wolf <kwolf@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 Pannengyuan <pannengyuan@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Chenqun (kuhn)" <kuhn.chenqun@huawei.com> writes:

>>-----Original Message-----
>>From: Qemu-devel [mailto:qemu-devel-
>>bounces+kuhn.chenqun=3Dhuawei.com@nongnu.org] On Behalf Of Markus
>>Armbruster
>>Sent: Tuesday, March 17, 2020 5:23 PM
>>To: qemu-devel@nongnu.org
>>Cc: Kevin Wolf <kwolf@redhat.com>; pbonzini@redhat.com;
>>berrange@redhat.com; ehabkost@redhat.com
>>Subject: [PATCH] qom-qmp-cmds: Fix another memory leak in
>>qmp_object_add()
>>
>>When user_creatable_add_type() fails, qmp_object_add() returns both its
>>error and the usual empty QDict success value.  The QMP core handles the
>>error, and ignores the success value, leaking it.  Exposed by qmp-cmd-tes=
t
>>case /x86_64/qmp/object-add-without-props, and duly reported both by
>>ASan and valgrind.
>>
>>To plug the leak, set the success value only on success.
>>
>>Fixes: 5f07c4d60d091320186e7b0edaf9ed2cc16b2d1e
>>Cc: Kevin Wolf <kwolf@redhat.com>
>>Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>---
> Hi,  Markus
>
>         Looks like the same patch that has been reported already here:
> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg03928.html

That patch has an additional hunk:

  diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
  index 3885464513..041866b846 100644
  --- a/hw/block/xen-block.c
  +++ b/hw/block/xen-block.c
  @@ -860,7 +860,7 @@ static XenBlockIOThread *xen_block_iothread_create(co=
nst=20
  char *id,
       XenBlockIOThread *iothread =3D g_new(XenBlockIOThread, 1);
       Error *local_err =3D NULL;
       QDict *opts;
  -    QObject *ret_data;
  +    QObject *ret_data =3D NULL;

       iothread->id =3D g_strdup(id);

       opts =3D qdict_new();
       qdict_put_str(opts, "qom-type", TYPE_IOTHREAD);
       qdict_put_str(opts, "id", id);
       qmp_object_add(opts, &ret_data, &local_err);
       qobject_unref(opts);
       qobject_unref(ret_data);

       if (local_err) {
           error_propagate(errp, local_err);

           g_free(iothread->id);
           g_free(iothread);
           return NULL;
       }

       return iothread;

> Maybe we should initialize ret_data in xen-block to avoid a possible unin=
itialized error =EF=BC=9F

Yes, because xen_block_iothread_create() passes @ret_data to
qobject_unref() even after qmp_object_add() failed.

In short, Pan Nengyuan's patch is more complete.


