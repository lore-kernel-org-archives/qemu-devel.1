Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5580C43141
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8AC204EF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQ2pS8xn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8AC204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvb1-0000Us-Mu
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUvZz-0008FD-Hm
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUvZy-0003Yf-7u
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:33:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32354
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUvZy-0003YT-43
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573662793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aV7aW7e+dZhaghHwln3l1mSz/SjcA88O0mnaAZ5G2Mo=;
 b=QQ2pS8xnM8CZnE+Gip1luAR09nCOwBhuNNjeFA19+1WBocBF+Ki3TOPQV++ntUFFL6zZ0t
 7ceszKbQVBE2WTBKNNrgwunvofksKkYmaYl9oZwDqpVb/FO37W6KMYThd8DoJr7oo6MxU8
 z3xMnItRPJfBIZWJuYy8a5lEh2F5fsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-Zp_4L1wWOQiB30zYZu0eww-1; Wed, 13 Nov 2019 11:33:10 -0500
X-MC-Unique: Zp_4L1wWOQiB30zYZu0eww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65098802880;
 Wed, 13 Nov 2019 16:33:07 +0000 (UTC)
Received: from localhost (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F309B1077D95;
 Wed, 13 Nov 2019 16:33:01 +0000 (UTC)
Date: Wed, 13 Nov 2019 16:33:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 11/49] multi-process: setup memory manager for
 remote device
Message-ID: <20191113163300.GF563983@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <5bfab4fa2f7f12137d0030e08a494d9ac3e11f04.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <5bfab4fa2f7f12137d0030e08a494d9ac3e11f04.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JcvBIhDvR6w3jUPA"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

--JcvBIhDvR6w3jUPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 05:08:52AM -0400, Jagannathan Raman wrote:
> +static void remote_ram_destructor(MemoryRegion *mr)
> +{
> +    qemu_ram_free(mr->ram_block);
> +}
> +
> +static void remote_ram_init_from_fd(MemoryRegion *mr, int fd, uint64_t size,
> +                                    ram_addr_t offset, Error **errp)
> +{
> +    char *name = g_strdup_printf("%d", fd);
> +
> +    memory_region_init(mr, NULL, name, size);
> +    mr->ram = true;
> +    mr->terminates = true;
> +    mr->destructor = NULL;
> +    mr->align = 0;
> +    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, RAM_SHARED, fd, offset,
> +                                           errp);
> +    mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
> +
> +    g_free(name);
> +}

This is not specific to remote/memory.c and could be shared in case
something else in QEMU wants to initialize from an fd.

> +
> +void remote_sysmem_reconfig(MPQemuMsg *msg, Error **errp)
> +{
> +    sync_sysmem_msg_t *sysmem_info = &msg->data1.sync_sysmem;

A possible security issue with MPQemuMsg: was the message size
validatedb before we access msg->data1.sync_sysmem?

If not, then we might access uninitialized data.  I didn't see if there
is a single place in the code that always zeroes msg, but I think the
answer is no.  Accessing uninitialized data could expose the old
contents of the stack/heap to the other process.  Information leaks like
this can be used to defeat address-space randomization because the other
process may learn about our memory layout if there are memory addresses
in the uninitialized data.

--JcvBIhDvR6w3jUPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3MMDwACgkQnKSrs4Gr
c8jlCgf+MIh6V0G/2YZ8kaHYEQKdJIuOrSEL/jixbWpDabyjYfLJNo1eGSHLQaZx
FbUgS6uje339cUyLqKwlaDRPUVnY10T74KRRTqC39uMPTxn7lG839FnNsTjXIY1w
hLov+VxZV16CS6OTK1AGBFwkPxfdmaHAdVrWmepDX1mDZaQ7yFJKIofq98QPlXRl
h3Um0qVwtHiNGhYbEOB1Ig7GnvOgX/UWgIRRabcvIutNrqyQ7CN2zFrGNbzZdcuG
xpaZYYA+TDVOgnD1vPxIzLdQcTMk/ESGHLqhA1hP/H3ZcOhp/IWmHayVuNZMs+J+
RPWYFvihmk8odNkbP/ZoU3ozlirHdw==
=oacJ
-----END PGP SIGNATURE-----

--JcvBIhDvR6w3jUPA--


