Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6D5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4C1206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCpfC45j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4C1206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2uUu-0001x3-OD
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2uUH-0001Fa-At
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:48:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42196
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2uUE-0003eV-Qu
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596538081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E22JtWMQsT+/b9ALET6YJFPimFU4ZE3pjf9PPszShCc=;
 b=YCpfC45jg7vfQsBnhYlqiaV1wbJq9zZL4FxByBhK1zkmS3P6x/anb5xmWtVa5H6tV0GFZ3
 Dr9/ueoBPz6TRVZ3cbXWScLiN1Dyc7FusmRMKMDKWtuYGLBSpELaC8rC+xEUQMRyStVhm5
 vZ3n6Y4eiOTQWVFZ70QXvLkGSSP+6JY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-w27KCv5-OxGvKlrxH8_D4Q-1; Tue, 04 Aug 2020 06:47:59 -0400
X-MC-Unique: w27KCv5-OxGvKlrxH8_D4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6E0D80183C;
 Tue,  4 Aug 2020 10:47:57 +0000 (UTC)
Received: from localhost (ovpn-112-116.ams2.redhat.com [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3C1810013C4;
 Tue,  4 Aug 2020 10:47:47 +0000 (UTC)
Date: Tue, 4 Aug 2020 11:47:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v8 03/20] multi-process: setup PCI host bridge for remote
 device
Message-ID: <20200804104746.GA1284674@stefanha-x1.localdomain>
References: <cover.1596217462.git.jag.raman@oracle.com>
 <cd3a20960062081d7c911879f509c26aedee89b4.1596217462.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <cd3a20960062081d7c911879f509c26aedee89b4.1596217462.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
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

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2020 at 02:20:10PM -0400, Jagannathan Raman wrote:
> + * This PCI host is purely a container for PCI devices. It's fake in the
> + * sense that the guest never sees this PCI host and has no way of
> + * accessing it. It's job is just to provide the environment that QEMU

s/It's/Its/ :)

> +static void remote_pcihost_realize(DeviceState *dev, Error **errp)
> +{
> +    char *busname = g_strdup_printf("remote-pci-%ld", (unsigned long)getpid());

Why is the pid used here? I don't understand why this helps. If
additional instances are created in this process then the name won't be
unique. The name isn't exposed outside the process, so there is no need
to uniquely identify the process either.

g_free(busname) is missing. A nice way to fix this is:

  g_autofree char *busname = ...

This avoids the need to manually call g_free().

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8pPNIACgkQnKSrs4Gr
c8ierQf+I5qMXzWopddSnB/Prw8ulh3v8u7uKt7s1cdmPUjJ4bMNH+5bC6bzRSjM
4Pf8yw6v5rzL+eiUHtsdKyQsqxLQTaXQexMojxxO0XsO9t7JbMduyKxP4eI2OYdh
oVxdRft9KBkQM4NWDG5WnYwEkx8iRqERX2moXBl2JoYtIUtrx3pVbvjfuPVxweks
KJa5aWIlqMA/a7riKVc8cECA/++UyS6GChReBZdJe8STp3fzbXGPRoUUNWNvYSta
+NYOqKBaj3fwwF9niaW1fFdbS3ZN+ZvlLFVlXcz4g83XNn1JrvZ0Fq1zWG9hkGwR
PLNhyMJTbhKN/NxWyTWYy9Sv4Q+PJQ==
=wKeR
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--


