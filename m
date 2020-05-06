Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEBCC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EA2206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXi/i/5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EA2206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWHh8-0003AF-SV
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 06:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWHgY-0002jS-IA
 for qemu-devel@nongnu.org; Wed, 06 May 2020 06:53:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53778
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWHgX-0006g2-3X
 for qemu-devel@nongnu.org; Wed, 06 May 2020 06:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588762431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQpQgHGCbvFInTEG+zGRWnWElMgXgQufWBIFIQv5wCs=;
 b=SXi/i/5uBnJLQZHsAfgcqfETcIn6hl946CA5uFT7poeE2rIPGY7m3XChGijg1XdK9nSTlL
 5BEbtfSUG/k+16X7VXDgxK641RsrUv2W86DhLZhiFmL0IWQridWos0oWVY/DWhnYWpakad
 4a05u61lvNIsFxCL6trOeB/uA4pW0zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-_pHbuoXsPWKdSgKzHVm-iw-1; Wed, 06 May 2020 06:53:47 -0400
X-MC-Unique: _pHbuoXsPWKdSgKzHVm-iw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C68D7835B45;
 Wed,  6 May 2020 10:53:46 +0000 (UTC)
Received: from work-vm (ovpn-114-245.ams2.redhat.com [10.36.114.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7962660BEC;
 Wed,  6 May 2020 10:53:42 +0000 (UTC)
Date: Wed, 6 May 2020 11:53:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC 3/4] vl: Sync dirty bits for system resets during
 precopy
Message-ID: <20200506105340.GH2743@work-vm>
References: <20200428194219.10963-1-peterx@redhat.com>
 <20200428194219.10963-4-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200428194219.10963-4-peterx@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tian Kevin <kevin.tian@intel.com>,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> System resets will also reset system memory layout.  Although the memory =
layout
> after the reset should probably the same as before the reset, we still ne=
ed to
> do frequent memory section removals and additions during the reset proces=
s.
> Those operations could accidentally lose per-mem-section information like=
 KVM
> memslot dirty bitmaps.
>=20
> Previously we keep those dirty bitmaps by sync it during memory removal.
> However that's hard to make it right after all [1].  Instead, we sync dir=
ty
> pages before system reset if we know we're during a precopy migration.  T=
his
> should solve the same problem explicitly.
>=20
> [1] https://lore.kernel.org/qemu-devel/20200327150425.GJ422390@xz-x1/

I think the problem is knowing whether this is sufficient or whether you
definitely need to do it for other cases of removal/readd.

However, assuming we need to do it during reset, how do we know this is
the right point to do it, and not something further inside the reset
process?  Is this just on the basis that vcpus are stopped?

Dave

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  softmmu/vl.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 32c0047889..8f864fee43 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -1387,6 +1387,22 @@ void qemu_system_reset(ShutdownCause reason)
> =20
>      cpu_synchronize_all_states();
> =20
> +    /*
> +     * System reboot could reset memory layout.  Although the final stat=
us of
> +     * the memory layout should be the same as before the reset, the mem=
ory
> +     * sections can still be removed and added back frequently due to th=
e reset
> +     * process.  This could potentially drop dirty bits in track for tho=
se
> +     * memory sections before the reset.
> +     *
> +     * Do a global dirty sync before the reset happens if we are during =
a
> +     * precopy, so we don't lose the dirty bits during the memory shuffl=
es.
> +     */
> +    if (migration_is_precopy()) {
> +        WITH_RCU_READ_LOCK_GUARD() {
> +            migration_bitmap_sync_precopy();
> +        }
> +    }
> +
>      if (mc && mc->reset) {
>          mc->reset(current_machine);
>      } else {
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


