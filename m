Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949F4C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 05:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DAD1206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 05:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brVQC9fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAD1206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTfbl-0004mO-J1
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 01:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTfaj-00040M-TK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTfai-0007cd-Nj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:49:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24291
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTfai-0007cP-9J
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 01:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588139343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HmW2vLbhLurlVohyVKvZrq0+70fmkVlDb+QAD99GkFc=;
 b=brVQC9frLlaAG6QwY6mUijxDwYefsAaTa5/GwDQEqmu9LgFWGwtqzGGMlbk9qY/ySQ4iQ1
 JSk7z4Q/1xKhpqtniNvLJgcB37oG1DIfWjdMvqGXPUZES+b5iGXySJmdn43a5tTPwIye9U
 6IXDj5tH4eXGfLxN+30ph8BhM+8noFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-_W6aP5KmPouk2XvqZk6Hpg-1; Wed, 29 Apr 2020 01:49:01 -0400
X-MC-Unique: _W6aP5KmPouk2XvqZk6Hpg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F13CD107ACCA;
 Wed, 29 Apr 2020 05:48:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F178F1002395;
 Wed, 29 Apr 2020 05:48:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7520211358BC; Wed, 29 Apr 2020 07:48:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paul Durrant <xadimgnik@gmail.com>
Subject: Re: [PATCH 02/11] xen: Fix and improve handling of device_add
 usb-host errors
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-3-armbru@redhat.com>
 <000501d61c65$2a65af30$7f310d90$@xen.org>
Date: Wed, 29 Apr 2020 07:48:55 +0200
In-Reply-To: <000501d61c65$2a65af30$7f310d90$@xen.org> (Paul Durrant's message
 of "Mon, 27 Apr 2020 08:26:26 +0100")
Message-ID: <87a72ux2ns.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: 'Stefano Stabellini' <sstabellini@kernel.org>, paul@xen.org,
 qemu-devel@nongnu.org, 'Gerd Hoffmann' <kraxel@redhat.com>,
 'Anthony Perard' <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paul Durrant <xadimgnik@gmail.com> writes:

>> -----Original Message-----
>> From: Markus Armbruster <armbru@redhat.com>
>> Sent: 24 April 2020 20:20
>> To: qemu-devel@nongnu.org
>> Cc: Stefano Stabellini <sstabellini@kernel.org>; Anthony Perard <anthony=
.perard@citrix.com>; Paul
>> Durrant <paul@xen.org>; Gerd Hoffmann <kraxel@redhat.com>; xen-devel@lis=
ts.xenproject.org
>> Subject: [PATCH 02/11] xen: Fix and improve handling of device_add usb-h=
ost errors
>>=20
>> usbback_portid_add() leaks the error when qdev_device_add() fails.
>> Fix that.  While there, use the error to improve the error message.
>>=20
>> The qemu_opts_from_qdict() similarly leaks on failure.  But any
>> failure there is a programming error.  Pass &error_abort.
>>=20
>> Fixes: 816ac92ef769f9ffc534e49a1bb6177bddce7aa2
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Anthony Perard <anthony.perard@citrix.com>
>> Cc: Paul Durrant <paul@xen.org>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: xen-devel@lists.xenproject.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/usb/xen-usb.c | 18 ++++++++----------
>>  1 file changed, 8 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
>> index 961190d0f7..42643c3390 100644
>> --- a/hw/usb/xen-usb.c
>> +++ b/hw/usb/xen-usb.c
>> @@ -30,6 +30,7 @@
>>  #include "hw/usb.h"
>>  #include "hw/xen/xen-legacy-backend.h"
>>  #include "monitor/qdev.h"
>> +#include "qapi/error.h"
>>  #include "qapi/qmp/qdict.h"
>>  #include "qapi/qmp/qstring.h"
>>=20
>> @@ -755,13 +756,15 @@ static void usbback_portid_add(struct usbback_info=
 *usbif, unsigned port,
>>      qdict_put_int(qdict, "port", port);
>>      qdict_put_int(qdict, "hostbus", atoi(busid));
>>      qdict_put_str(qdict, "hostport", portname);
>> -    opts =3D qemu_opts_from_qdict(qemu_find_opts("device"), qdict, &loc=
al_err);
>> -    if (local_err) {
>> -        goto err;
>> -    }
>> +    opts =3D qemu_opts_from_qdict(qemu_find_opts("device"), qdict,
>> +                                &error_abort);
>>      usbif->ports[port - 1].dev =3D USB_DEVICE(qdev_device_add(opts, &lo=
cal_err));
>>      if (!usbif->ports[port - 1].dev) {
>> -        goto err;
>> +        qobject_unref(qdict);
>> +        xen_pv_printf(&usbif->xendev, 0,
>> +                      "device %s could not be opened: %s\n",
>> +                      busid, error_get_pretty(local_err));
>> +        error_free(local_err);
>
> Previously the goto caused the function to bail out. Should there not be =
a 'return' here?

Owww, of course.  Thanks!

>
>>      }
>>      qobject_unref(qdict);
>>      speed =3D usbif->ports[port - 1].dev->speed;
>> @@ -793,11 +796,6 @@ static void usbback_portid_add(struct usbback_info =
*usbif, unsigned port,
>>      usbback_hotplug_enq(usbif, port);
>>=20
>>      TR_BUS(&usbif->xendev, "port %d attached\n", port);
>> -    return;
>> -
>> -err:
>> -    qobject_unref(qdict);
>> -    xen_pv_printf(&usbif->xendev, 0, "device %s could not be opened\n",=
 busid);
>>  }
>>=20
>>  static void usbback_process_port(struct usbback_info *usbif, unsigned p=
ort)
>> --
>> 2.21.1


