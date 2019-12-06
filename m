Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94BEC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:53:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728662464E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdp0FY3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728662464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idJfb-0002XH-L2
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 14:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1idJea-0001yB-8f
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1idJeY-00066r-Vj
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:52:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46540
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1idJeY-00063w-PN
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575661956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFeey+Cm4zctfKPSXMOHndeziaIISHty2K196N9AGjA=;
 b=bdp0FY3CcFKyi0N2Zv/TPR/ju6cIusSqCfYkXb3KmX5PA+FIxsrFM3ub+B34wg2NaoFxIu
 5O24Qas3G0HrAJRMLdUrwAwTD8r+7+HXpHu+4xxYNSHHOVuKWyaGiBxs2k4pEwnHzXce84
 XIvL9nbg6c4ypV/lpZ8KAkJ+3OopnNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-E4KGJv_gMtK049AjUFhPMg-1; Fri, 06 Dec 2019 14:52:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B9C2800D54
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 19:52:34 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F08FE60179;
 Fri,  6 Dec 2019 19:52:32 +0000 (UTC)
Date: Fri, 6 Dec 2019 19:52:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] runstate: ignore finishmigrate -> prelaunch transition
Message-ID: <20191206195230.GJ2878@work-vm>
References: <20191129115132.285988-1-lvivier@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191129115132.285988-1-lvivier@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: E4KGJv_gMtK049AjUFhPMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Laurent Vivier (lvivier@redhat.com) wrote:
> Commit 1bd71dce4bf2 tries to prevent a finishmigrate -> prelaunch
> transition by exiting at the beginning of the main_loop_should_exit()
> function if the state is already finishmigrate.
>=20
> As the finishmigrate state is set in the migration thread it can
> happen concurrently to the function. The migration thread and the
> function are normally protected by the iothread mutex and thus the
> state should no evolve between the start of the function and its end.
>=20
> Unfortunately during the function life the lock is released by
> pause_all_vcpus() just before the point we need to be sure we are
> not in finishmigrate state and if the migration thread is waiting
> for the lock it will take the opportunity to change the state
> to finishmigrate.

Ewww.
I hate those short wakeups for pause_all_vcpus; I'm sure there are loads
more corners that break.

Still, I _think_ this is an improvement, so:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> The only way to be sure we are not in the finishmigrate state when
> we need is to check the state after the pause_all_vcpus() function.
>=20
> Fixes: 1bd71dce4bf2 ("runstate: ignore exit request in finish migrate sta=
te")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  vl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/vl.c b/vl.c
> index 6a65a64bfd64..bf0a6345d239 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1745,9 +1745,6 @@ static bool main_loop_should_exit(void)
>      RunState r;
>      ShutdownCause request;
> =20
> -    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
> -        return false;
> -    }
>      if (preconfig_exit_requested) {
>          if (runstate_check(RUN_STATE_PRECONFIG)) {
>              runstate_set(RUN_STATE_PRELAUNCH);
> @@ -1776,8 +1773,13 @@ static bool main_loop_should_exit(void)
>          pause_all_vcpus();
>          qemu_system_reset(request);
>          resume_all_vcpus();
> +        /*
> +         * runstate can change in pause_all_vcpus()
> +         * as iothread mutex is unlocked
> +         */
>          if (!runstate_check(RUN_STATE_RUNNING) &&
> -                !runstate_check(RUN_STATE_INMIGRATE)) {
> +                !runstate_check(RUN_STATE_INMIGRATE) &&
> +                !runstate_check(RUN_STATE_FINISH_MIGRATE)) {
>              runstate_set(RUN_STATE_PRELAUNCH);
>          }
>      }
> --=20
> 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


