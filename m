Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D54C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8493A208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEw32lnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8493A208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQAbJ-0001w1-Gg
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 10:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQAY3-0007i8-9Z
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQAY1-0004b0-Km
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602081365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sVGM96qgYhfIvImvmMwk70cKAZRN3DPph2aVX9rihqk=;
 b=eEw32lnNPQeW94XN5xnkNHIhjd/Ym0yHi4AsnfBW9y5mVyYyClei09SnudlGXTlEIFU5h2
 bzsMCY3a6aRxZj46EEPvkBnTfmPgjf903iTPRy9bG47e+YKspyG5BM7TsebCo7LKzvi7pt
 IjDZczzKqD0MIefl6DGaUSNEDgWD19s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-9CEvt6H0POubPSg8dk9T0g-1; Wed, 07 Oct 2020 10:36:00 -0400
X-MC-Unique: 9CEvt6H0POubPSg8dk9T0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB671100F96C;
 Wed,  7 Oct 2020 14:34:46 +0000 (UTC)
Received: from localhost (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4299555760;
 Wed,  7 Oct 2020 14:34:45 +0000 (UTC)
Date: Wed, 7 Oct 2020 15:34:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v10 08/19] multi-process: Associate fd of a PCIDevice
 with its object
Message-ID: <20201007143445.GC113587@stefanha-x1.localdomain>
References: <cover.1601923020.git.elena.ufimtseva@oracle.com>
 <5d35602f436bb5b659f8ffba6be204aa1c3ab312.1601923020.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <5d35602f436bb5b659f8ffba6be204aa1c3ab312.1601923020.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2020 at 11:50:56AM -0700, elena.ufimtseva@oracle.com wrote:
> +static void remote_object_machine_done(Notifier *notifier, void *data)
> +{
> +    RemoteObject *o = container_of(notifier, RemoteObject, machine_done);
> +    DeviceState *dev = NULL;
> +    QIOChannel *ioc = NULL;
> +    Coroutine *co = NULL;
> +    RemoteCommDev *comdev = NULL;
> +    Error *err = NULL;
> +
> +    dev = qdev_find_recursive(sysbus_get_default(), o->devid);
> +    if (!dev || !object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        error_report("%s is not a PCI device", o->devid);
> +        return;
> +    }
> +
> +    ioc = qio_channel_new_fd(o->fd, &err);
> +    if (!ioc) {
> +        error_report_err(err);
> +        return;
> +    }
> +    qio_channel_set_blocking(ioc, false, NULL);
> +    qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS);

This flag is already set by qio_channel_socket_set_fd() from
qio_channel_new_fd() so the call to qio_channel_set_feature() can be
dropped.

You may want to check the presence of the feature in case a non-AF_UNIX
fd was passed though.

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl990gUACgkQnKSrs4Gr
c8hhVAf/Sw8VCf5adXcx1EGb5WQmswoVj4qvEfCv9JIK/1g8yLbbhe/TSan6OGZr
p6cqanbi0OE80suTuvfhpM600NDgmLExwV8+TE/DJGzcaMFy3uzKSbvtYsIqkwb1
VodBJ1vLxTweRocYHbkPL4bAxAkRR3gg29RBbm8PndRS09QjtbZeVIgTdHHy188M
K/z3fOW1HjzyjLIdg51zCy235B2k11Cc0hbuKxPaAwWQOUqm+w5Uk0riwhN5q8rS
DlqkWuaUU/1vtOQzq7xcIHfZ0cSQ5DcqSsTf92FyYHHSkCRKw5JIgZ/ukAn4gcy0
tFjypBw8jBYQaD9h4atOH+iooPcmjQ==
=+7EJ
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--


