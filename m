Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA162C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 17:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A772084D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 17:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A772084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoWtB-0002qQ-RW
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 13:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57271)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hoWt2-0002Qt-7S
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hoWt0-0001qs-2B
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:41:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hoWsx-0001kK-Lq
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 13:41:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD2053082B4B;
 Fri, 19 Jul 2019 17:41:31 +0000 (UTC)
Received: from work-vm (ovpn-117-245.ams2.redhat.com [10.36.117.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF33C5C219;
 Fri, 19 Jul 2019 17:41:30 +0000 (UTC)
Date: Fri, 19 Jul 2019 18:41:28 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190719174128.GI3000@work-vm>
References: <20190710081111.10302-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190710081111.10302-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 19 Jul 2019 17:41:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration/postcopy: use static
 PostcopyDiscardState instead of allocating it for each block
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> Even we need to do discard for each RAMBlock, we still can leverage the
> same memory space to store the information.
>=20
> By doing so, we avoid memory allocation and deallocation to the system
> and also avoid potential failure of memory allocation which breaks the
> migration.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  migration/postcopy-ram.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 9faacacc9e..2e6b076bb7 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1377,8 +1377,7 @@ void postcopy_fault_thread_notify(MigrationIncoming=
State *mis)
>   *   asking to discard individual ranges.
>   *
>   * @ms: The current migration state.
> - * @offset: the bitmap offset of the named RAMBlock in the migration
> - *   bitmap.
> + * @offset: the bitmap offset of the named RAMBlock in the migration bit=
map.
>   * @name: RAMBlock that discards will operate on.
>   *
>   * returns: a new PDS.
> @@ -1386,13 +1385,14 @@ void postcopy_fault_thread_notify(MigrationIncomi=
ngState *mis)
>  PostcopyDiscardState *postcopy_discard_send_init(MigrationState *ms,
>                                                   const char *name)
>  {
> -    PostcopyDiscardState *res =3D g_malloc0(sizeof(PostcopyDiscardState)=
);
> +    static PostcopyDiscardState res =3D {0};

Do you think it would be better to make this a static at the top of
migration/postcopy-ram.c and then we could remove the pds parameters
=66rom postcopy_discard_send_range and friends?
If there's only one pds then we don't need to pass the pointer around.

Dave

> -    if (res) {
> -        res->ramblock_name =3D name;
> -    }
> +    res.ramblock_name =3D name;
> +    res.cur_entry =3D 0;
> +    res.nsentwords =3D 0;
> +    res.nsentcmds =3D 0;
> =20
> -    return res;
> +    return &res;
>  }
> =20
>  /**
> @@ -1449,8 +1449,6 @@ void postcopy_discard_send_finish(MigrationState *m=
s, PostcopyDiscardState *pds)
> =20
>      trace_postcopy_discard_send_finish(pds->ramblock_name, pds->nsentwor=
ds,
>                                         pds->nsentcmds);
> -
> -    g_free(pds);
>  }
> =20
>  /*
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

