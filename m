Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E74CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A042072C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjYuXkFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A042072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jClmg-00056R-09
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jCllx-0004Tr-Pw
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jCllv-00024w-Tl
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:58:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48095
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jCllv-0001ys-Do
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584111526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AnEEI9lRDz1igZrOmLkKBnx2/JAww6P0U4b/hLUgobw=;
 b=OjYuXkFQHjHWewSqlL6X9eocC2352Aj3mH8GF8+K9qsVwcPa8az25qJnNxSvec4VzQ9Lw1
 NQCg/FSRVOI4OidQtQ+2UI8VhKHe9OnYco/z2+7oPZTQS96c/8k6Bh0JSsyRm8fv31i6a4
 iS559XfxJVNeoMZ0wL12q8qIz8fWIwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-mA0yGK7PPCOUnLaQKR1RbQ-1; Fri, 13 Mar 2020 10:58:44 -0400
X-MC-Unique: mA0yGK7PPCOUnLaQKR1RbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A43FA0CC0;
 Fri, 13 Mar 2020 14:58:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 262718B570;
 Fri, 13 Mar 2020 14:58:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A73E511386A6; Fri, 13 Mar 2020 15:58:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v9 02/10] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <20200312085936.9552-3-vsementsov@virtuozzo.com>
Date: Fri, 13 Mar 2020 15:58:35 +0100
In-Reply-To: <20200312085936.9552-3-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 12 Mar 2020 11:59:28 +0300")
Message-ID: <87imj8i9no.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, armbru@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I tried this script on the whole tree.  Observations:

* $ git-diff --shortstat \*.[ch]
   333 files changed, 3480 insertions(+), 4586 deletions(-)

* Twelve functions have "several definitions of Error * local variable".

  Eight declare such a variable within a loop.  Reported because
  Coccinelle matches along control flow, not just along text.  Ignore.

  Remaining four:

  * ivshmem_common_realize()

    Two variables (messed up in commit fe44dc91807), should be replaced
    by one.

  * qmp_query_cpu_model_expansion() two times

    Three declarations in separate blocks; two should be replaced by
    &error_abort, one moved to the function block.

  * xen_block_device_destroy()

    Two declarations in seperate blocks; should be replaced by a single
    one.

  Separate manual cleanup patches, ideally applied before running
  Coccinelle to keep Coccinelle's changes as simple and safe as
  possible.  I'll post patches.  Only the one for
  xen_block_device_destroy() affects by this series.

* No function "propagates to errp several times"

  I tested the rule does detect this as advertized by feeding it an
  obvious example.  We're good.

* ERRP_AUTO_PROPAGATE() inserted 744 times, always right at the
  beginning of a function.

* As far as I can tell, all changed functions have ERRP_AUTO_PROPAGATE()
  inserted.  Good.

* Almost 1100 error propagations dropped:error_propagate() removed,
  error_propagate_prepend() replaced by just error_prepend().

* Four error_propagate() are transformed.  Two instances each in
  aspeed_soc_ast2600_realize() and aspeed_soc_realize().  Pattern:

     {
    +    ERRP_AUTO_PROPAGATE();
         ...
    -    Error *err =3D NULL, *local_err =3D NULL;
    +    Error *local_err =3D NULL;
         ...

             object_property_set_T(...,=20
    -                              &err);
    +                              errp);
             object_property_set_T(...,
                                   &local_err);
    -        error_propagate(&err, local_err);
    -        if (err) {
    -            error_propagate(errp, err);
    +        error_propagate(errp, local_err);
    +        if (*errp) {
                 return;
             }

  This is what error.h calls "Receive and accumulate multiple errors
  (first one wins)".

  Result:

        ERRP_AUTO_PROPAGATE();
        ...
        Error *local_err =3D NULL;
        ...

            object_property_set_T(..., errp);
            object_property_set_T(..., &local_err);
            error_propagate(errp, local_err);
            if (*errp) {
                return;
            }

  Could be done without the accumulation:

        ERRP_AUTO_PROPAGATE();
        ...

            object_property_set_T(..., errp);
            if (*errp) {
                return;
            }
            object_property_set_T(..., errp);
            if (*errp) {
                return;
            }

  I find this a bit easier to understand.  Matter of taste.  If we want
  to change to this, do it manually and separately.  I'd do it on top.

* Some 90 propagations remain.

  Some of them could use cleanup, e.g. file_memory_backend_set_pmem(),
  css_clear_io_interrupt().  Out of scope for this series.

  Some move errors around in unusual ways, e.g. in block/nbd.c.  Could
  use review.  Out of scope for this series.

  I spotted three that should be transformed, but aren't:

  - qcrypto_block_luks_store_key()

    I believe g_autoptr() confuses Coccinelle.  Undermines all our
    Coccinelle use, not just this patch.  I think we need to update
    scripts/cocci-macro-file.h for it.

  - armsse_realize()

    Something in this huge function confuses Coccinelle, but I don't
    know what exactly.  If I delete most of it, the error_propagate()
    transforms okay.  If I delete less, Coccinelle hangs.

  - apply_cpu_model()

    Gets transformed fine if I remove the #ifndef CONFIG_USER_ONLY.  I
    have no idea why the #if spooks Coccinelle here, but not elsewhere.

  None of these three affects this series.  No need to hold it back for
  further investigation.

* 30 error_free() and two warn_reportf_err() are transformed.  Patterns:

    -    error_free(local_err);
    -    local_err =3D NULL;
    +    error_free_errp(errp);

  and

    -    error_free(local_err);
    +    error_free_errp(errp);

  and

    -    warn_report_err(local_err);
    -    local_err =3D NULL;
    +    warn_report_errp(errp);

  Good.

* Many error_free(), error_reportf_err() and warn_reportf_err() remain.
  None of them have an argument of the form *errp.  Such arguments would
  have to be reviewed for possible interference with
  ERRP_AUTO_PROPAGATE().

* Almost 700 Error *err =3D NULL removed.  Almost 600 remain.

* Error usage in rdma.c is questionable / wrong.  Out of scope for this
  series.

As far as I can tell, your Coccinelle script is working as intended,
except for three missed error propagations noted above.  We can proceed
with this series regardless, if we want.  I'd prefer to integrate my
forthcoming cleanup to xen_block_device_destroy(), though.


