Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FE3C433F4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2255521D95
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckLgjggt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2255521D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0KJz-0007XG-9m
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 03:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0KI0-0003lz-QT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:44:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29761
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0KHx-000409-Rc
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595922280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gu74tanMbGZL5yl/xiFaIHaeq2lqQKCNW2i6jBXI6Bk=;
 b=ckLgjggt9OkFluRytffGklJrsc4UZOCW5ds2JVLyhzSe/DXidW3igKP6a6IayrghcOuhyu
 /7EFoaJuTsShiCw01x7eGCFAq+2Vxm1CBbLB3zgA4XaB8qyIioQj5LuhQfuBFZy9IoYnsz
 yfjmNLZ862i2LE+CROoHQcqYTGS7Rp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-PlDJY7dXNlCfYwxtu-07Pg-1; Tue, 28 Jul 2020 03:44:38 -0400
X-MC-Unique: PlDJY7dXNlCfYwxtu-07Pg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 968EB100AA21;
 Tue, 28 Jul 2020 07:44:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 654A369323;
 Tue, 28 Jul 2020 07:44:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F351B1132FD2; Tue, 28 Jul 2020 09:44:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.2 v4] hw/core/qdev: Increase qdev_realize() kindness
References: <20200727175112.6820-1-f4bug@amsat.org>
Date: Tue, 28 Jul 2020 09:44:35 +0200
In-Reply-To: <20200727175112.6820-1-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 27 Jul 2020 19:51:12
 +0200")
Message-ID: <87d04gf5i4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 00:06:48
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Since commit 510ef98dca5, qdev_realize() aborts if bus-less
> device is realized on a bus. While commits 514db7710b..007d1dbf72
> took care of converting all mainstream uses, QEMU forks weren't
> converted.
>
> These forks are usually maintained by hobbyist with interest in
> following mainstream development, but with limited time, so usually
> rebase from time to time. To avoid them to spend time on debugging
> and reading git-log history, display a kind hint about what is wrong.
>
> Before:
>
>   qemu-system-mipsel: hw/core/qdev.c:376: qdev_realize: Assertion `!DEVIC=
E_GET_CLASS(dev)->bus_type' failed.
>   Aborted (core dumped)
>
> After:
>
>   Unexpected error in qdev_realize() at hw/core/qdev.c:376:
>   qemu-system-mipsel: Unexpected bus 'System' for bus-less device 'unimpl=
emented-device'
>   Aborted (core dumped)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/core/qdev.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 2131c7f951..a16f1270f1 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -392,8 +392,11 @@ bool qdev_realize(DeviceState *dev, BusState *bus, E=
rror **errp)
> =20
>      if (bus) {
>          qdev_set_parent_bus(dev, bus);
> -    } else {
> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
> +    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
> +        error_setg(errp, "Unexpected bus '%s' for bus-less device '%s'",
> +                   DEVICE_GET_CLASS(dev)->bus_type,
> +                   object_get_typename(OBJECT(dev)));
> +        return false;
>      }
> =20
>      object_property_set_bool(OBJECT(dev), true, "realized", &err);

Objection.  This turns an abort into something else unless the caller
passes &error_abort.  The caller in your commit message's example does,
others don't.

Keep the unconditional abort, please.  Feel free to print something kind
right before.  I doubt it's all that useful, as I believe whoever gets
to fix the bug will have to figure out the code anyway, but I could be
wrong.


