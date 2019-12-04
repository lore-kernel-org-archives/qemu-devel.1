Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85857C2BC73
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51742205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdnmHjdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51742205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41413 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icXyH-0007GN-B1
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 11:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1icXoO-0001P8-Tq
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1icXoF-0000Uz-1F
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:47:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28753
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1icXoE-0008U9-Sm
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575478042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gkdz9zCrg5+rKW2tpkKgmrXPlUFjqa6TN971PSlCWEo=;
 b=LdnmHjdkNS4wBnBWCmx7f9LAEQJx4NryFfl7TV3YPG/dzqMLm00NtSdXdG/fCEDOPTWDBc
 8COlar9hLikJLeHyYIx5/A7jt4T4+3w2CXvqGXMkVhml56iTPssyHW1K/JFLANrXHyzFPx
 tPhrP36WgV0dF41uOqLWDPyXGMlM2CE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-57GVIpf8OrG_ngIFq5U2Tg-1; Wed, 04 Dec 2019 11:47:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54D5DDB61;
 Wed,  4 Dec 2019 16:47:20 +0000 (UTC)
Received: from work-vm (ovpn-117-217.ams2.redhat.com [10.36.117.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66C6C691A7;
 Wed,  4 Dec 2019 16:47:19 +0000 (UTC)
Date: Wed, 4 Dec 2019 16:47:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Scott Cheloha <cheloha@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] migration: savevm_state_handler_insert:
 constant-time element insertion
Message-ID: <20191204164717.GL3325@work-vm>
References: <20191017205953.13122-1-cheloha@linux.vnet.ibm.com>
 <20191017205953.13122-3-cheloha@linux.vnet.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20191017205953.13122-3-cheloha@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 57GVIpf8OrG_ngIFq5U2Tg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Scott Cheloha (cheloha@linux.vnet.ibm.com) wrote:
> savevm_state's SaveStateEntry TAILQ is a priority queue.  Priority
> sorting is maintained by searching from head to tail for a suitable
> insertion spot.  Insertion is thus an O(n) operation.
>=20
> If we instead keep track of the head of each priority's subqueue
> within that larger queue we can reduce this operation to O(1) time.
>=20
> savevm_state_handler_remove() becomes slightly more complex to
> accomodate these gains: we need to replace the head of a priority's
> subqueue when removing it.
>=20
> With O(1) insertion, booting VMs with many SaveStateEntry objects is
> more plausible.  For example, a ppc64 VM with maxmem=3D8T has 40000 such
> objects to insert.
>=20
> Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>

OK, it took me a while to figure out why you didn't just
turn handlers into handlers[MIG_PRI_MAX]; but I guess the problem is
you would have to change all the foreach's scattered around that walk
the list.  So


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/savevm.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b2e3b7222a..f7a2d36bba 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -250,6 +250,7 @@ typedef struct SaveStateEntry {
> =20
>  typedef struct SaveState {
>      QTAILQ_HEAD(, SaveStateEntry) handlers;
> +    SaveStateEntry *handler_pri_head[MIG_PRI_MAX + 1];
>      int global_section_id;
>      uint32_t len;
>      const char *name;
> @@ -261,6 +262,7 @@ typedef struct SaveState {
> =20
>  static SaveState savevm_state =3D {
>      .handlers =3D QTAILQ_HEAD_INITIALIZER(savevm_state.handlers),
> +    .handler_pri_head =3D { [MIG_PRI_DEFAULT ... MIG_PRI_MAX] =3D NULL }=
,
>      .global_section_id =3D 0,
>  };
> =20
> @@ -709,24 +711,42 @@ static void savevm_state_handler_insert(SaveStateEn=
try *nse)
>  {
>      MigrationPriority priority =3D save_state_priority(nse);
>      SaveStateEntry *se;
> +    int i;
> =20
>      assert(priority <=3D MIG_PRI_MAX);
> =20
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> -        if (save_state_priority(se) < priority) {
> +    for (i =3D priority - 1; i >=3D 0; i--) {
> +        se =3D savevm_state.handler_pri_head[i];
> +        if (se !=3D NULL) {
> +            assert(save_state_priority(se) < priority);
>              break;
>          }
>      }
> =20
> -    if (se) {
> +    if (i >=3D 0) {
>          QTAILQ_INSERT_BEFORE(se, nse, entry);
>      } else {
>          QTAILQ_INSERT_TAIL(&savevm_state.handlers, nse, entry);
>      }
> +
> +    if (savevm_state.handler_pri_head[priority] =3D=3D NULL) {
> +        savevm_state.handler_pri_head[priority] =3D nse;
> +    }
>  }
> =20
>  static void savevm_state_handler_remove(SaveStateEntry *se)
>  {
> +    SaveStateEntry *next;
> +    MigrationPriority priority =3D save_state_priority(se);
> +
> +    if (se =3D=3D savevm_state.handler_pri_head[priority]) {
> +        next =3D QTAILQ_NEXT(se, entry);
> +        if (next !=3D NULL && save_state_priority(next) =3D=3D priority)=
 {
> +            savevm_state.handler_pri_head[priority] =3D next;
> +        } else {
> +            savevm_state.handler_pri_head[priority] =3D NULL;
> +        }
> +    }
>      QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
>  }
> =20
> --=20
> 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


