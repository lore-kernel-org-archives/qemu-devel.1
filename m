Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18534C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB97206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB97206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Lr5-0003tD-3q
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8LpT-0001n2-3a
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8LpP-0006ZW-Ay
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:55:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10785)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8LpN-0006YI-Tj
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:55:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A127307D853;
 Thu, 12 Sep 2019 09:55:47 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C5AA600C4;
 Thu, 12 Sep 2019 09:55:46 +0000 (UTC)
Date: Thu, 12 Sep 2019 10:55:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190912095543.GB7230@work-vm>
References: <20190819032804.8579-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819032804.8579-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 12 Sep 2019 09:55:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] migration: cleanup check on ops in
 savevm.handlers iterations
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
> During migration, there are several places to iterate on
> savevm.handlers. And on each iteration, we need to check its ops and
> related callbacks before invoke it.
> 
> Generally, ops is the first element to check, and it is only necessary
> to check it once.
> 
> This patch clean all the related part in savevm.c to check ops only once
> in those iterations.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Queued

> 
> ---
> v2: rebase on latest upstream
> ---
>  migration/savevm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 4a86128ac4..35426d1db8 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1100,7 +1100,7 @@ void qemu_savevm_state_setup(QEMUFile *f)
>          if (!se->ops || !se->ops->save_setup) {
>              continue;
>          }
> -        if (se->ops && se->ops->is_active) {
> +        if (se->ops->is_active) {
>              if (!se->ops->is_active(se->opaque)) {
>                  continue;
>              }
> @@ -1131,7 +1131,7 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
>          if (!se->ops || !se->ops->resume_prepare) {
>              continue;
>          }
> -        if (se->ops && se->ops->is_active) {
> +        if (se->ops->is_active) {
>              if (!se->ops->is_active(se->opaque)) {
>                  continue;
>              }
> @@ -1227,7 +1227,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
>          if (!se->ops || !se->ops->save_live_complete_postcopy) {
>              continue;
>          }
> -        if (se->ops && se->ops->is_active) {
> +        if (se->ops->is_active) {
>              if (!se->ops->is_active(se->opaque)) {
>                  continue;
>              }
> @@ -1264,7 +1264,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>              continue;
>          }
>  
> -        if (se->ops && se->ops->is_active) {
> +        if (se->ops->is_active) {
>              if (!se->ops->is_active(se->opaque)) {
>                  continue;
>              }
> @@ -1413,7 +1413,7 @@ void qemu_savevm_state_pending(QEMUFile *f, uint64_t threshold_size,
>          if (!se->ops || !se->ops->save_live_pending) {
>              continue;
>          }
> -        if (se->ops && se->ops->is_active) {
> +        if (se->ops->is_active) {
>              if (!se->ops->is_active(se->opaque)) {
>                  continue;
>              }
> @@ -2334,7 +2334,7 @@ static int qemu_loadvm_state_setup(QEMUFile *f)
>          if (!se->ops || !se->ops->load_setup) {
>              continue;
>          }
> -        if (se->ops && se->ops->is_active) {
> +        if (se->ops->is_active) {
>              if (!se->ops->is_active(se->opaque)) {
>                  continue;
>              }
> -- 
> 2.17.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

