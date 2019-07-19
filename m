Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E1EC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CDE2186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CDE2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoW4y-0003rD-Ni
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 12:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47467)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hoW4k-0003GA-96
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hoW4j-00084q-5q
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:49:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40470)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hoW4i-000822-6R
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:49:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 730E633656;
 Fri, 19 Jul 2019 16:49:39 +0000 (UTC)
Received: from work-vm (ovpn-117-245.ams2.redhat.com [10.36.117.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93227620A0;
 Fri, 19 Jul 2019 16:49:38 +0000 (UTC)
Date: Fri, 19 Jul 2019 17:49:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190719164936.GG3000@work-vm>
References: <20190709140924.13291-1-richardw.yang@linux.intel.com>
 <20190709140924.13291-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709140924.13291-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 19 Jul 2019 16:49:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] migration/savevm: split
 qemu_savevm_state_complete_precopy() into two parts
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
> This is a preparation patch for further cleanup.
> 
> No functional change, just wrap two major part of
> qemu_savevm_state_complete_precopy() into function.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/savevm.c | 66 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 49 insertions(+), 17 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index becedcc1c6..c41e13e322 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1246,23 +1246,12 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
>      qemu_fflush(f);
>  }
>  
> -int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
> -                                       bool inactivate_disks)
> +static
> +int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy,
> +                                                bool iterable_only)
>  {
> -    QJSON *vmdesc;
> -    int vmdesc_len;
>      SaveStateEntry *se;
>      int ret;
> -    bool in_postcopy = migration_in_postcopy();
> -    Error *local_err = NULL;
> -
> -    if (precopy_notify(PRECOPY_NOTIFY_COMPLETE, &local_err)) {
> -        error_report_err(local_err);
> -    }
> -
> -    trace_savevm_state_complete_precopy();
> -
> -    cpu_synchronize_all_states();
>  
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>          if (!se->ops ||
> @@ -1291,9 +1280,18 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
>          }
>      }
>  
> -    if (iterable_only) {
> -        goto flush;
> -    }
> +    return 0;
> +}
> +
> +static
> +int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
> +                                                    bool in_postcopy,
> +                                                    bool inactivate_disks)
> +{
> +    QJSON *vmdesc;
> +    int vmdesc_len;
> +    SaveStateEntry *se;
> +    int ret;
>  
>      vmdesc = qjson_new();
>      json_prop_int(vmdesc, "page_size", qemu_target_page_size());
> @@ -1353,6 +1351,40 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
>      }
>      qjson_destroy(vmdesc);
>  
> +    return 0;
> +}
> +
> +int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
> +                                       bool inactivate_disks)
> +{
> +    int ret;
> +    Error *local_err = NULL;
> +    bool in_postcopy = migration_in_postcopy();
> +
> +    if (precopy_notify(PRECOPY_NOTIFY_COMPLETE, &local_err)) {
> +        error_report_err(local_err);
> +    }
> +
> +    trace_savevm_state_complete_precopy();
> +
> +    cpu_synchronize_all_states();
> +
> +    ret = qemu_savevm_state_complete_precopy_iterable(f, in_postcopy,
> +                                                      iterable_only);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    if (iterable_only) {
> +        goto flush;
> +    }
> +
> +    ret = qemu_savevm_state_complete_precopy_non_iterable(f, in_postcopy,
> +                                                          inactivate_disks);
> +    if (ret) {
> +        return ret;
> +    }
> +
>  flush:
>      qemu_fflush(f);
>      return 0;
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

