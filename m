Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07119C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C5D206CB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVgvrBTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C5D206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqaRS-0000aA-4G
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqaOq-0005NF-19
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:55:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39741
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqaOn-0002bj-GN
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593600928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nj8BTxlguEF+YIEDiZdOzSLLLKwaG2+rHKwYIYM6uDE=;
 b=QVgvrBTQSd/ceb8sCmAbQNVjdqtN3ihfP5PDBVsqQjA4PfnM6szLkTTLiUGp4R5CADvtSK
 QEyDOfdOFJGrClQgRRQA1f50wwkCgnPaiF2gc7cJjvwwYkRlexPoA87GIELCrI7V1jUm53
 sb7PTY7zWGCvz/5HhVbWCvJBphTI1Ww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449--AUX9dE7Pt29ff_ZwD5T6A-1; Wed, 01 Jul 2020 06:55:24 -0400
X-MC-Unique: -AUX9dE7Pt29ff_ZwD5T6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4425818A0763;
 Wed,  1 Jul 2020 10:55:22 +0000 (UTC)
Received: from localhost (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 482F060C81;
 Wed,  1 Jul 2020 10:55:13 +0000 (UTC)
Date: Wed, 1 Jul 2020 11:55:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 15/21] multi-process: Synchronize remote memory
Message-ID: <20200701105512.GH126613@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <f9eb12b75572e91e7e0e530dbc9b8efae41f449e.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <f9eb12b75572e91e7e0e530dbc9b8efae41f449e.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
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

--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 27, 2020 at 10:09:37AM -0700, elena.ufimtseva@oracle.com wrote:
> +static bool try_merge(RemoteMemSync *sync, MemoryRegionSection *section)
> +{
> +    uint64_t mrs_size, mrs_gpa, mrs_page;
> +    MemoryRegionSection *prev_sec;
> +    bool merged = false;
> +    uintptr_t mrs_host;
> +    RAMBlock *mrs_rb;
> +
> +    if (!sync->n_mr_sections) {
> +        return false;
> +    }
> +
> +    mrs_rb = section->mr->ram_block;
> +    mrs_page = (uint64_t)qemu_ram_pagesize(mrs_rb);
> +    mrs_size = int128_get64(section->size);
> +    mrs_gpa = section->offset_within_address_space;
> +    mrs_host = (uintptr_t)memory_region_get_ram_ptr(section->mr) +
> +               section->offset_within_region;
> +
> +    if (get_fd_from_hostaddr(mrs_host, NULL) < 0) {
> +        return true;
> +    }
> +
> +    mrs_host = mrs_host & ~(mrs_page - 1);
> +    mrs_gpa = mrs_gpa & ~(mrs_page - 1);
> +    mrs_size = ROUND_UP(mrs_size, mrs_page);
> +
> +    if (sync->n_mr_sections) {

The check is unnecessary because of the if statement above:

  if (!sync->n_mr_sections) {
     return false;
  }

> +static void proxy_ml_commit(MemoryListener *listener)
> +{
> +    RemoteMemSync *sync = container_of(listener, RemoteMemSync, listener);
> +    MPQemuMsg msg;
> +    MemoryRegionSection section;
> +    ram_addr_t offset;
> +    uintptr_t host_addr;
> +    int region;
> +
> +    memset(&msg, 0, sizeof(MPQemuMsg));
> +
> +    msg.cmd = SYNC_SYSMEM;
> +    msg.bytestream = 0;
> +    msg.num_fds = sync->n_mr_sections;
> +    msg.size = sizeof(msg.data1);
> +    assert(msg.num_fds <= REMOTE_MAX_FDS);
> +
> +    for (region = 0; region < sync->n_mr_sections; region++) {
> +        section = sync->mr_sections[region];

Why is section copied here? It's conventional to take a pointer to a
struct instead of copying its value.

> +        msg.data1.sync_sysmem.gpas[region] =
> +            section.offset_within_address_space;
> +        msg.data1.sync_sysmem.sizes[region] = int128_get64(section.size);
> +        host_addr = (uintptr_t)memory_region_get_ram_ptr(section.mr) +
> +                    section.offset_within_region;
> +        msg.fds[region] = get_fd_from_hostaddr(host_addr, &offset);
> +        msg.data1.sync_sysmem.offsets[region] = offset;
> +    }
> +    mpqemu_msg_send(&msg, sync->ioc);
> +}
> +
> +void deconfigure_memory_sync(RemoteMemSync *sync)
> +{

Missing proxy_ml_begin() call to free sync->mr_sections[] and unref
sections.

> +    memory_listener_unregister(&sync->listener);
> +}

This function isn't called. It's good practice to implement the object
lifecycle from the start.

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl78a5AACgkQnKSrs4Gr
c8ic4wf/X9CdnRnbCS4WhA9L0L2Q445ZGIOrahapAfbsrbnHeazrzdw1gsW1n5Oa
4mwnP/JRR5K7W+dETQ677VJLILXmfi3nckZh/EFXJeSIudLeoYPXvEPtrfbPOoCl
SyApENaW7Ei0IgBcEpwUwTNYM+ZX/IEXw1ADbMNpMUuJEtSEOBwT34CxP3M5mPUo
EWxvF/9HFj5+YjUiznDpQN6S3iCpum5n7ExE5ZzTLih3u/9BUlSOoCzGPYUCz4HH
+/pMG4UsAvHak6Fz+2RwQKr4nF0GsO1Ikduak9rR1Le7xiZioln9MtExwmcDBJcw
UhYHDfKScbF0TKCCVPPuXNzwyPodyQ==
=c4+q
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--


