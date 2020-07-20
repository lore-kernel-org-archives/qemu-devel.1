Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A685DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 08:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BAA21775
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 08:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZrQDwy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BAA21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxR9c-0002O8-PP
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 04:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxR8v-0001Zb-Bq
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:27:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38101
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxR8t-000251-OB
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595233643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBJdrR2x2fyEHgSGgqSWmN4FdwnXf6nAlkoqJclmtH4=;
 b=BZrQDwy11J8QeJSxy0y/KVuAAgGrrbhiNalZeAa32OUcUu4jpOwh7GIDEQNgsOmwxCfJsk
 saiT6GcO24CguhD61Z/URHTDDMLGk2stZR2bTsWS3BaKOieSfV1KDkASz2Isj5/miQr1KV
 qImERwquHJBPCWRTH4F5iXI7F90MhaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-5WlHsrvUM3ytKOPWO6mfcA-1; Mon, 20 Jul 2020 04:27:21 -0400
X-MC-Unique: 5WlHsrvUM3ytKOPWO6mfcA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02D09800466;
 Mon, 20 Jul 2020 08:27:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6D6A5C240;
 Mon, 20 Jul 2020 08:27:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 620891141C54; Mon, 20 Jul 2020 10:27:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1] qdev: Allow to create hotplug device before
 plugging it to a bus
References: <20200719134329.21613-1-f4bug@amsat.org>
Date: Mon, 20 Jul 2020 10:27:18 +0200
In-Reply-To: <20200719134329.21613-1-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sun, 19 Jul 2020 15:43:29
 +0200")
Message-ID: <878sfeh9qx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Commit 510ef98dca made qdev_realize() support bus-less devices,
> asserting either the device is bus-less or the device is created
> on a bus. Commit 464a22c757 used qdev_realize() instead of
> object_property_set_bool(). Since qdev_realize() now checks for
> a bus, it is not possible to create hotplug devices unattached
> to any bus anymore.
>
> Fix by only asserting if the device is not hotpluggable.
>
> Fixes: 464a22c757 "qdev: Use qdev_realize() in qdev_device_add()"
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/core/qdev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 01796823b4..6c5540ecdc 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -393,7 +393,9 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Er=
ror **errp)
>      if (bus) {
>          qdev_set_parent_bus(dev, bus);
>      } else {
> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
> +        DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
> +
> +        assert(dc->hotpluggable || !dc->bus_type);
>      }
> =20
>      return object_property_set_bool(OBJECT(dev), "realized", true, errp)=
;

I think this is wrong.

Invariant about realized devices and their bus:

* realized "bus-full" devices are plugged into an appropriate bus, and

* realized bus-less devices are not plugged into any bus.

Since qdev_realize() goes from unrealized to realized, it needs to
establish the invariant, regardless of dc->hotpluggable.

I suspect the bug is in the caller.  Give me a concrete reproducer, and
I'll look.


