Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21DAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BA0206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFmEQ9iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BA0206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5VTt-0006wO-Ip
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5VTH-0006WP-Sk
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:41:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29537
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5VTF-0004lK-FO
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597156903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VMbV69N5FW/DmUxQwqtBt2WPknL4E2VE//JPxQh5uCA=;
 b=YFmEQ9iyX50BbJFEP2sgHDRg/w/h/tlufPmZT+k+iOxgQYKR/Pa04Df0oqxIcSd8UVQII5
 GdW8xGBHySwF25ehAKasnnVVIDKpg8krJ9KAAnFrqtIE2ic6KNJEwRG4qd3JZuNWWQJbRn
 c2PPyfQWIYeaG17Gud1oH9QS+OnHBxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-h_ym-CtyMmmWvd_9U-FuSg-1; Tue, 11 Aug 2020 10:41:42 -0400
X-MC-Unique: h_ym-CtyMmmWvd_9U-FuSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3376D101C8A6;
 Tue, 11 Aug 2020 14:41:40 +0000 (UTC)
Received: from localhost (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C3385F1EF;
 Tue, 11 Aug 2020 14:41:31 +0000 (UTC)
Date: Tue, 11 Aug 2020 15:41:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v8 17/20] multi-process: heartbeat messages to remote
Message-ID: <20200811144130.GC18223@stefanha-x1.localdomain>
References: <cover.1596217462.git.jag.raman@oracle.com>
 <93b7566e5d565b9e5d8127849bb5be65057e25cc.1596217462.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <93b7566e5d565b9e5d8127849bb5be65057e25cc.1596217462.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:41:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2020 at 02:20:24PM -0400, Jagannathan Raman wrote:
> @@ -343,3 +349,49 @@ static void probe_pci_info(PCIDevice *dev, Error **errp)
>          }
>      }
>  }
> +
> +static void hb_msg(PCIProxyDev *dev)
> +{
> +    DeviceState *ds = DEVICE(dev);
> +    Error *local_err = NULL;
> +    MPQemuMsg msg = { 0 };
> +
> +    msg.cmd = PROXY_PING;
> +    msg.bytestream = 0;
> +    msg.size = 0;
> +
> +    (void)mpqemu_msg_send_and_await_reply(&msg, dev->ioc, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        qio_channel_close(dev->ioc, &local_err);
> +        error_setg(&error_fatal, "Lost contact with device %s", ds->id);
> +    }
> +}

Here is my feedback from the last revision. Was this addressed?

  This patch seems incomplete since no action is taken when the device
  fails to respond. vCPU threads that access the device will still get
  stuck.

  The simplest way to make this useful is to close the connection when a
  timeout occurs. Then the G_IO_HUP handler for the UNIX domain socket
  should perform connection cleanup. At that point there are a few
  choices:

  1. Stop guest execution and wait for the host admin to restore the
     mplink so execution can resume. This is similar to how -drive
     rerror=stop pauses the guest when a disk I/O error is encountered.

  2. Stop guest execution but defer it until this stale device is actually
     accessed. This maximizes guest uptime. Guests that rarely access the
     device may not notice at all.

  3. Return 0 from MemoryRegion read operations and ignore writes. The
     guest continues executing but the device is broken. This is risky
     because device drivers inside the guest may not be ready to deal with
     this. The result could be data loss or corruption.

  4. Raise a bus-level event. Maybe PCI error reporting can be used to
     offline the device.

  5. Terminate the guest with an error message.

  6. ?

  Until the heartbeat is fully implemented and tested I suggest dropping
  it from this patch series. Remember the G_IO_HUP will happen anyway if
  the remote device process terminates.

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8yrhoACgkQnKSrs4Gr
c8iA5Af/Uxxwzs74IUpOXg5v04XpsRgcrkCBAzpBH4882Agq2GXmKlXr5UqSMVja
24pBXX14hZ7IvGQIpj2DpfrvXgWU54yyq5DeY6D2YaqqxvOBh+TgWFpqROBZjfPX
3m/er4uh+R8HCB4rtrNHyTSQ6U1spgHZPcCyB4hRncN+DI+rJs6xzqVciKhHLXqz
kwEwHXc5Fmj5ZvAp0IU7i/LDc0G7CWujaOzIH2tORsWwTJu647FyowWkKFSP5fUa
9dbVzQQPdyp/VJjeiXqJWK0HYIlK8+su5clJq9cdH7+xxsu/Yr0YKCgY5fxfGWLK
uXYcwMWFDxk84STB/TTd/WM60y9YsQ==
=OUWE
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--


