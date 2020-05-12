Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B83AC54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D340120675
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1/nbSV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D340120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYTm9-0007sl-0v
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYTlL-0007TO-Kx
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:11:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48306
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYTlK-0001ew-3N
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589285512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gqUMi9folTOZsxRe48JhegImpvA5SyrE/Vmi97tNlcI=;
 b=H1/nbSV2R712sjnCLZKFR0LwqaLAQCAQhLw6uDEyxVuUsG9tit8BHwqvVsff2SlCnF8F78
 RcgIECjUJUQ/RoXbcdoYqenfeZ34iETmvrXZRZ7/3TRWA2b8Wr7cdypuFAa4GwpzK8hilR
 P7C25Si6ovb+YCmGY6rH8Nq/rtR5PV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-6ax-OjvqPMmfXlPhKI-Muw-1; Tue, 12 May 2020 08:11:47 -0400
X-MC-Unique: 6ax-OjvqPMmfXlPhKI-Muw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 990DA873072;
 Tue, 12 May 2020 12:11:45 +0000 (UTC)
Received: from localhost (ovpn-112-75.ams2.redhat.com [10.36.112.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98CC01C9;
 Tue, 12 May 2020 12:11:38 +0000 (UTC)
Date: Tue, 12 May 2020 13:11:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 15/36] multi-process: setup memory manager for
 remote device
Message-ID: <20200512121137.GF300009@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <c16682b1ac3a660d8b5b751b6d5f904a25d17dc4.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <c16682b1ac3a660d8b5b751b6d5f904a25d17dc4.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:50PM -0700, elena.ufimtseva@oracle.com wrote:
> diff --git a/exec.c b/exec.c
> index 5b1e414099..1e02e00f00 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2371,6 +2371,23 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size=
, MemoryRegion *mr,
> =20
>      return block;
>  }
> +
> +void qemu_ram_init_from_fd(MemoryRegion *mr, int fd, uint64_t size,

This looks like a memory_region_init_*() function, not a qemu_ram_*()
function. Why is it being added to exec.c instead of memory.c?

> +                           ram_addr_t offset, Error **errp)

qemu_ram_alloc_from_fd()'s offset argument has the off_t type. Why is
ram_addr_t used here?

> +typedef struct {
> +    hwaddr gpas[REMOTE_MAX_FDS];
> +    uint64_t sizes[REMOTE_MAX_FDS];
> +    ram_addr_t offsets[REMOTE_MAX_FDS];

Should this be off_t because it's the file offset, not a RAMBlock
address?

> +} sync_sysmem_msg_t;

QEMU coding style would name this struct SyncSysMemMsg.

> +void remote_sysmem_reconfig(MPQemuMsg *msg, Error **errp)
> +{
> +    sync_sysmem_msg_t *sysmem_info =3D &msg->data1.sync_sysmem;
> +    MemoryRegion *sysmem, *subregion, *next;
> +    Error *local_err =3D NULL;
> +    int region;
> +
> +    sysmem =3D get_system_memory();
> +
> +    qemu_mutex_lock_iothread();
> +
> +    memory_region_transaction_begin();
> +
> +    QTAILQ_FOREACH_SAFE(subregion, &sysmem->subregions, subregions_link,=
 next) {
> +        if (subregion->ram) {
> +            memory_region_del_subregion(sysmem, subregion);
> +            qemu_ram_free(subregion->ram_block);

subregion is leaked. qemu_ram_free() shouldn't be called directly. It's
normally called from the MemoryRegion->destructor function but that
wasn't set up by qemu_ram_init_from_fd().

Please check how MemoryRegion lifecycles should work, update
qemu_ram_init_from_fd(), and update this function to avoid leaks.

> +        }
> +    }
> +
> +    for (region =3D 0; region < msg->num_fds; region++) {
> +        subregion =3D g_new(MemoryRegion, 1);
> +        qemu_ram_init_from_fd(subregion, msg->fds[region],
> +                              sysmem_info->sizes[region],
> +                              sysmem_info->offsets[region], &local_err);

Where are is msg->fds[region] closed?

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl66knkACgkQnKSrs4Gr
c8je0Af/R70bLsGU3UBKgADg1+pCAWdGbkX8XVO5vX0GvCYwAMSRPh4VMeysz5cJ
ChfGIb8f1+SGaA8lhDTBDgvJ6mHNVBg4tk3Wym9A3zuUC5TX4qcFMn03MhC+eulq
1KkA1/ApWVPaMxMbfn7EDZISQviGId05Xkvq6AORSkdKUFCnf1oIGxMjKlsnO4wF
V/7KyyUJ5MDTpZwjPVMcilgJaxdIHSsu3DaTFnJjXog2pFZsuxuQXnjnIhl0hi2u
wZmFxcKBlzKeQ62WVyOFJ3CdrJLxMDfPibqFRGA0MtdYY/rLXbWSeXCcKhH/tI3y
DbqMEjnTwcNYoMl++wVkJPZJoB72Tw==
=fWEA
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--


