Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995E2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 07:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F082073E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 07:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUBsoCvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F082073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqXej-0005Hw-LH
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 03:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqXeB-0004ja-Jo
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 03:59:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23187
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqXe9-00071V-CT
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 03:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593590347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zPmbV7hbpGr02uQ9m23pYPnUg+HpUVjnyR52y7JANnQ=;
 b=DUBsoCvrHpTM18Kta3fnJ3wPkbRMbOb2GRMq0m5EmFhl8WO0xL7KcRiXsditZIGddn+sco
 KB4otfXsDUPjIDimDmWVHDzj28xyNVsiXcubZ9b2rvZ5kvxF4q+viNwabybHtmL33yr/At
 0oRnVw1qfnGzgCz4zw0WQL10nHPF59E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-P3KBbHnRO365CjZsMWW-Pg-1; Wed, 01 Jul 2020 03:59:05 -0400
X-MC-Unique: P3KBbHnRO365CjZsMWW-Pg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81C2E8DFFED;
 Wed,  1 Jul 2020 07:58:56 +0000 (UTC)
Received: from localhost (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8787899019;
 Wed,  1 Jul 2020 07:58:38 +0000 (UTC)
Date: Wed, 1 Jul 2020 08:58:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 10/21] multi-process: setup memory manager for remote
 device
Message-ID: <20200701075837.GC126613@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <fbeac5ec471787c06b6f2656b6bcea091aed929a.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <fbeac5ec471787c06b6f2656b6bcea091aed929a.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
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

--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 27, 2020 at 10:09:32AM -0700, elena.ufimtseva@oracle.com wrote:
> +void remote_sysmem_reconfig(MPQemuMsg *msg, Error **errp)
> +{
> +    SyncSysmemMsg *sysmem_info = &msg->data1.sync_sysmem;
> +    MemoryRegion *sysmem, *subregion, *next;
> +    static unsigned int suffix;
> +    Error *local_err = NULL;
> +    char *name;
> +    int region;
> +
> +    sysmem = get_system_memory();
> +
> +    memory_region_transaction_begin();
> +
> +    QTAILQ_FOREACH_SAFE(subregion, &sysmem->subregions, subregions_link, next) {
> +        if (subregion->ram) {
> +            memory_region_del_subregion(sysmem, subregion);
> +            qemu_ram_free(subregion->ram_block);

Why is qemu_ram_free() called explicitly? Normally the only caller is
memory_region_destructor_ram().

MemoryRegions are reference counted. The qemu_ram_free() call should
probably be replaced with memory_region_unref(subregion). This also
solves the subregion memory leak.

That said, I haven't read the MemoryRegion lifecycle code so please
check that what I'm suggesting is correct.

> +typedef struct {
> +    hwaddr gpas[REMOTE_MAX_FDS];
> +    uint64_t sizes[REMOTE_MAX_FDS];
> +    off_t offsets[REMOTE_MAX_FDS];
> +} SyncSysmemMsg;

It's safer to use fixed-width types like uint64_t for external
communication, but in this case we expect the client and server to
match.

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl78QiwACgkQnKSrs4Gr
c8iDGAgAhNXjnc2ZzkOKEvyoKjkTZ3JrbMOW8iXFTT9zoIS4xPw6joBxctgSyxmV
GOSvmWjnXv8nGXT15acwJzr8EKE7tGVUXX2XUV6Wy6prDLSKyWRIcfpp2In8CdGW
bP1cpdYDgfIs2UdPmrkFZqb9KRiR78qtbfON6p529YResjXCYMYftorKjCGNkqkG
5mWTNG4aEHC8pGq47O9qC5/UUO+sSf1N7ycAVYmlz1nCSd69PjdJSfuMLaJupoJ+
85/mDMB3p/ap9IV55BzWhpma2OdlaetEiXfqhhcEI3wjc8zigzZU1MvO/uKoIhRq
NnNfcYLpkS6KbBHHBorkgA1ACNzpzw==
=VOx9
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--


