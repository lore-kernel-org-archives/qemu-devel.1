Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E340AC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B6321A49
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1iv6INl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B6321A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvPx-0003vR-QV
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUvPG-0003EF-P0
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUvPD-0007Nt-OU
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:22:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29716
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUvPD-0007NV-Cm
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573662126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6rNetjWE6Pudhzve4zbq3pyRMaxN5XkUT6KfLU7p7SU=;
 b=K1iv6INllDFIJaGMRg8+zQ4rVc3IfMKWd/dJe80QIw9zL/MrS6pHmhrB9eTKlI0sUIrWuh
 geTWAETel3T9TZcaSOpTHLW9ygJhbC5eayEnltRz/P/v7ptJfFb0lVj6vlxXDDvvEZIbYW
 Y7mmgLGQvREFrLVMdpz+cdaGZ9hoK0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-pmv3Io1APPiZAaC77vcpNg-1; Wed, 13 Nov 2019 11:22:05 -0500
X-MC-Unique: pmv3Io1APPiZAaC77vcpNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 440F56C614;
 Wed, 13 Nov 2019 16:22:03 +0000 (UTC)
Received: from localhost (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96C6360317;
 Wed, 13 Nov 2019 16:22:02 +0000 (UTC)
Date: Wed, 13 Nov 2019 16:22:01 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 10/49] multi-process: setup a machine object for
 remote device process
Message-ID: <20191113162201.GE563983@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <6df05bbf3cba4611b462879a7b937f40486cea0a.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <6df05bbf3cba4611b462879a7b937f40486cea0a.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 kanth.ghatraju@oracle.com, kraxel@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, liran.alon@oracle.com, marcandre.lureau@gmail.com,
 mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 05:08:51AM -0400, Jagannathan Raman wrote:
> +static NotifierList machine_init_done_notifiers =
> +    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
> +
> +bool machine_init_done;
> +
> +void qemu_add_machine_init_done_notifier(Notifier *notify)
> +{
> +    notifier_list_add(&machine_init_done_notifiers, notify);
> +    if (machine_init_done) {
> +        notify->notify(notify, NULL);
> +    }
> +}
> +
> +void qemu_remove_machine_init_done_notifier(Notifier *notify)
> +{
> +    notifier_remove(notify);
> +}
> +
> +void qemu_run_machine_init_done_notifiers(void)
> +{
> +    machine_init_done = true;
> +    notifier_list_notify(&machine_init_done_notifiers, NULL);
> +}

qemu_add_machine_init_done_notifier() is already defined in vl.c.
Please share the implementation instead of duplicating it into the
remote program.

> +
> +static void remote_machine_init(Object *obj)
> +{
> +    RemMachineState *s = REMOTE_MACHINE(obj);
> +    RemPCIHost *rem_host;
> +    MemoryRegion *system_memory, *system_io, *pci_memory;
> +
> +    Error *error_abort = NULL;
> +
> +    qemu_mutex_init(&ram_list.mutex);

Please keep global initialization separate from RemMachineState (e.g. do
it in main() or a function called by main()).  This function should only
initialize RemMachineState.

> +
> +    object_property_add_child(object_get_root(), "machine", obj, &error_abort);
> +    if (error_abort) {
> +        error_report_err(error_abort);
> +    }
> +
> +    memory_map_init();

This is global init, please move it elsewhere.

> +
> +    system_memory = get_system_memory();
> +    system_io = get_system_io();
> +
> +    pci_memory = g_new(MemoryRegion, 1);
> +    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
> +
> +    rem_host = REMOTE_HOST_DEVICE(qdev_create(NULL, TYPE_REMOTE_HOST_DEVICE));
> +
> +    rem_host->mr_pci_mem = pci_memory;
> +    rem_host->mr_sys_mem = system_memory;
> +    rem_host->mr_sys_io = system_io;
> +
> +    s->host = rem_host;

Both s and rem_host are QOM objects.  There should be a child property
relationship between them here.  It will ensure that rem_host is cleaned
up when s is cleaned up.  Please use that instead of a regular C
pointer.

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3MLakACgkQnKSrs4Gr
c8jwsAgAqDm8qaVr2QVm8z/93T+wQqaqSlwlxgTWpjDQuk987vS2VIHWkISbn4nR
p5KumtCPDJDpJGdWgzgNnEoKXdVwOCmQ1TGq11pZ7ygjvvBNmPHT8XuhcGUMafFe
VMsmLShZ7sA1c6rMtxoZThvpYLwd7Wn9QcEjgg0uDlndby+/7Ok2De/NrtTylyxc
ED1ix43ItWHSm5okdt4/OIMb2lIaiRqYiHr1ajGuOHsv6vj3B8CtfKRbbzPEps1t
td1U2kfLLwXmHGHSGi1dim2saunFVF9y5iFIrA4gIkix6oYarH2WViYoVLgeD2UF
BB/PN1Z6DG8QQVfWgIRfA//cDHVCLg==
=PkEO
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--


