Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42396C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122812078B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhAsivyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122812078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jndsy-0000hb-9H
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jndrv-0007qq-DJ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:01:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25175
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jndrt-0007h8-7b
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592899279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g9A41gXSHBekuAZBKlyRF1tjqiShsTmNHyInAZGqj70=;
 b=dhAsivyAdG16Eh9cKTj2YYbA4sztLwbztSMDHFA75yv/jcz2s7eXWbxBzv+AxLyJjFoUAY
 gTMac19UAnSumK1cOAN02UFG4o44HCtzdC+KPPmF5NLEo7VcpsKs7ik17/2mk5QT4JsDqb
 QI/Z01fwqLBfmaPItN8+VscrfIZ01ho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-VWgkAppnNQib4u2upeGNOA-1; Tue, 23 Jun 2020 04:01:17 -0400
X-MC-Unique: VWgkAppnNQib4u2upeGNOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5B7A8031CB;
 Tue, 23 Jun 2020 08:01:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61CD67CAA3;
 Tue, 23 Jun 2020 08:01:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D1A00113846D; Tue, 23 Jun 2020 10:01:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v5 1/9] hw/i2c/core: Add i2c_try_create_slave() and
 i2c_realize_and_unref()
References: <20200622183428.12255-1-f4bug@amsat.org>
 <20200622183428.12255-2-f4bug@amsat.org>
Date: Tue, 23 Jun 2020 10:01:13 +0200
In-Reply-To: <20200622183428.12255-2-f4bug@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 22 Jun 2020 20:34:20
 +0200")
Message-ID: <875zbimcs6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?utf-8?Q?C=C3=A9d?= =?utf-8?Q?ric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Extract i2c_try_create_slave() and i2c_realize_and_unref()
> from i2c_create_slave().
> We can now set properties on a I2CSlave before it is realized.
>
> This is in line with the recent qdev/QOM changes merged
> in commit 6675a653d2e.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Cc: Markus Armbruster <armbru@redhat.com>
> ---
>  include/hw/i2c/i2c.h |  2 ++
>  hw/i2c/core.c        | 18 ++++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index 4117211565..d6e3d85faf 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -80,6 +80,8 @@ int i2c_send(I2CBus *bus, uint8_t data);
>  uint8_t i2c_recv(I2CBus *bus);
> =20
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r);
> +DeviceState *i2c_try_create_slave(const char *name, uint8_t addr);
> +bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp);
> =20
>  /* lm832x.c */
>  void lm832x_key_event(DeviceState *dev, int key, int state);
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index 1aac457a2a..acf34a12d6 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -267,13 +267,27 @@ const VMStateDescription vmstate_i2c_slave =3D {
>      }
>  };
> =20
> -DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r)
> +DeviceState *i2c_try_create_slave(const char *name, uint8_t addr)
>  {
>      DeviceState *dev;
> =20
>      dev =3D qdev_new(name);
>      qdev_prop_set_uint8(dev, "address", addr);
> -    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
> +    return dev;
> +}
> +
> +bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
> +{
> +    return qdev_realize_and_unref(dev, &bus->qbus, errp);
> +}
> +
> +DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r)
> +{
> +    DeviceState *dev;
> +
> +    dev =3D i2c_try_create_slave(name, addr);
> +    i2c_realize_and_unref(dev, bus, &error_fatal);
> +
>      return dev;
>  }

We use "create_simple" names for functions that allocate, initialize,
configure and realize device objects: pci_create_simple(),
isa_create_simple(), usb_create_simple().  Calling this one
i2c_create_slave() is okay with me.  I'd prefer
i2c_slave_create_simple(), though.

We use "new" names for functions that allocate and initialize device
objects: pci_new(), isa_new(), usb_new().  Let's call this one
i2c_slave_new().

Your use of "realize_and_unref" matches existing names elsewhere:
pci_realize_and_unref(), isa_realize_and_unref(),
usb_realize_and_unref().  However, the other two i2c functions are
called i2c_slave_FOO(), not i2c_FOO().  You could name this one
i2c_slave_realize_and_unref().  Another path to consistency: drop the
slave_ from all three names.

Ideally with my naming suggestions considered:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


