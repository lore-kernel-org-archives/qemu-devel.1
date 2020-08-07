Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A6AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 907D021744
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IM+2Ry4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907D021744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k44qq-0000iV-RL
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 12:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k44q7-0008J7-MX
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:03:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54046
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k44q6-0007ZH-0J
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596816205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v2Mkj3GHElFgq576HPlxgWWUqfiFLLOB0AyrNX0Nq7I=;
 b=IM+2Ry4/KPNVFq1V7hD/E1GRfKHf1wad/PMiZ6Kw2nJvH3DCi3a6W9vo0GFprQJxDCQvov
 fqJBEt1D1D/7JnJ4OLnm8scxKC9tcdzKKQKMN3jPvjC2FvLNhfGsfKqWWr0PLceGQRf4U/
 XEfby9WrrI71xDbNGBu70teLrZuSdQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-laUCSuBdNzGtS-DbHeWOJg-1; Fri, 07 Aug 2020 12:03:23 -0400
X-MC-Unique: laUCSuBdNzGtS-DbHeWOJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C12328DFFCE;
 Fri,  7 Aug 2020 16:03:11 +0000 (UTC)
Received: from localhost (ovpn-114-16.ams2.redhat.com [10.36.114.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2ADB75DEBB;
 Fri,  7 Aug 2020 16:02:25 +0000 (UTC)
Date: Fri, 7 Aug 2020 17:02:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v8 09/20] multi-process: Associate fd of a PCIDevice with
 its object
Message-ID: <20200807160224.GE609387@stefanha-x1.localdomain>
References: <cover.1596217462.git.jag.raman@oracle.com>
 <c00243a3b4994e5f276e289f2b5f012bea275a9c.1596217462.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <c00243a3b4994e5f276e289f2b5f012bea275a9c.1596217462.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:53:14
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

--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2020 at 02:20:16PM -0400, Jagannathan Raman wrote:
> +static void remote_object_set_devid(Object *obj, const char *str, Error **errp)
> +{
> +    RemoteObject *o = REMOTE_OBJECT(obj);
> +
> +    o->devid = g_strdup(str);

Setter functions can be called multiple times so g_free(o->devid) is
needed to prevent memory leaks.

> +}
> +
> +static void remote_object_machine_done(Notifier *notifier, void *data)
> +{

Is UserCreatableClass->complete() called too early? If you can use it
instead of the machine init done notifier then that would make error
reporting cleaner. Both command-line and object_add monitor commands
would fail as expected if an error occurs, whereas this patch prints an
error and continues running.

> +    RemoteObject *o = container_of(notifier, RemoteObject, machine_done);
> +    DeviceState *dev = NULL;
> +    QIOChannel *ioc = NULL;
> +    Error *err = NULL;
> +
> +    dev = qdev_find_recursive(sysbus_get_default(), o->devid);
> +    if (!dev || !object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        error_report("%s is not a PCI device", o->devid);
> +        return;
> +    }

What happens when a "device_del" monitor command removes the device? I
guess a use-after-free will occur since this object isn't aware that the
device disappeared. QOM's Object has a reference count that you can use
to keep the object alive, but that still might not play well with hot
unplug where the device is being removed from its bus. One solution is
to refuse hot unplugging the device while the remote object exists.

> +
> +    ioc = qio_channel_new_fd(o->fd, &err);
> +    if (!ioc) {
> +        error_free(err);
> +        error_report("Failed to allocate IO channel");

Please print err, it contains a more detailed error message than "Failed
to allocate IO channel".

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8texAACgkQnKSrs4Gr
c8hvzQf/RiFnvWK3x9sy0t9RVvpzz0UXIeesLf+PftVz8nked68ceWdXyg5cJlfO
QHgaw2rfaSZ5TjM4xrL6bh47VRLPyLv+cx3A1sCq/a8DRr5P/nRATxJf0eHTVvbr
xe/CHfwNyFPoDABJg19CMMwipZL1ZFHSva2pKf/NUModEthCG+w+mm8MIKXY8SKi
ZHMroG1j2IIPO9jOFOycCLDwZzah7nSFcbS3ENWxuNepbupUppb7+gg/qgnIkPjX
YPIKfL0ZGWLwL/GdGxOcj6p+6mPoFpeyXfOVnMLGbuFb42/LpTx+6Agfyd5s6MsC
tPIyqRlQfJY1oWPuV5SmLqmMxOKyWw==
=LS4P
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--


