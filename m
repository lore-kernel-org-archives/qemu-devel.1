Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F11C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 18:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF70A20738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 18:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLmMZw4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF70A20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joADk-0006NN-6W
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 14:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joACd-0005ZA-2K
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 14:32:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59699
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joACa-0002Ch-6T
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 14:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593023571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjCZ4OlVYiwO+9V1faaAdjoudryf7+cBMrwrmKdSZd0=;
 b=bLmMZw4L4M+ciaNwxrOOiSv9EKIzRiyU51RhdcOrtGbf2JOgl46h0ztxGI3yt1fZut4j7o
 Pr1ERrxbf4wa9IGss1PyiSUhVIjTBDczmdIW8RknYabCMp0Ds93GbMFqyGUNE3HySqdjvm
 LtOULsmXJvcWCKEt7VW7q7kfkn1iW9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-Hc-7qI70MgWFG-mRXY6NTw-1; Wed, 24 Jun 2020 14:32:49 -0400
X-MC-Unique: Hc-7qI70MgWFG-mRXY6NTw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B05187950B;
 Wed, 24 Jun 2020 18:32:48 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13B8C2B47C;
 Wed, 24 Jun 2020 18:32:44 +0000 (UTC)
Subject: Re: [PATCH 08/46] error: Avoid unnecessary error_propagate() after
 error_setg()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-9-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f8a0cce6-11ba-6182-6f90-b94594cd8b39@redhat.com>
Date: Wed, 24 Jun 2020 13:32:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624164344.3778251-9-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 11:43 AM, Markus Armbruster wrote:
> Replace
> 
>      error_setg(&err, ...);
>      error_propagate(errp, err);
> 
> by
> 
>      error_setg(errp, ...);
> 
> Related pattern:

Nice explanation.

> Bonus: the elimination of gotos will make later patches in this series
> easier to review.
> 
> Candidates for conversion tracked down with this Coccinelle script:
> 
>      @@
>      identifier err, errp;
>      expression list args;
>      @@
>      -    error_setg(&err, args);
>      +    error_setg(errp, args);
> 	 ... when != err
> 	 error_propagate(errp, err);
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   backends/cryptodev.c        | 11 +++---
>   backends/hostmem-file.c     | 19 +++-------
>   backends/hostmem-memfd.c    | 15 ++++----
>   backends/hostmem.c          | 27 ++++++--------
>   block/throttle-groups.c     | 22 +++++------
>   hw/hyperv/vmbus.c           |  5 +--
>   hw/i386/pc.c                | 35 ++++++------------
>   hw/mem/nvdimm.c             | 17 ++++-----
>   hw/mem/pc-dimm.c            | 14 +++----
>   hw/misc/aspeed_sdmc.c       |  3 +-
>   hw/ppc/rs6000_mc.c          |  9 ++---
>   hw/ppc/spapr.c              | 73 ++++++++++++++++---------------------
>   hw/ppc/spapr_pci.c          | 14 +++----
>   hw/s390x/ipl.c              | 23 +++++-------
>   hw/s390x/sclp.c             | 12 ++----
>   hw/xen/xen_pt_config_init.c |  3 +-
>   iothread.c                  | 12 +++---
>   net/colo-compare.c          | 20 ++++------
>   net/dump.c                  | 10 ++---
>   net/filter-buffer.c         | 10 ++---
>   qga/commands-win32.c        | 16 +++-----
>   21 files changed, 151 insertions(+), 219 deletions(-)

A bit bigger, and starts to be too complex to ask Coccinelle to directly 
fix it (but at least using it for identification is nice).  But the 
patch is still manageable, and hopefully not too many instances creep 
back in during the meantime while waiting for this series to land.

> @@ -140,7 +138,6 @@ static void file_memory_backend_set_pmem(Object *o, bool value, Error **errp)
>       HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
>   
>       if (host_memory_backend_mr_inited(backend)) {
> -
>           error_setg(errp, "cannot change property 'pmem' of %s.",
>                      object_get_typename(o));
>           return;

Unrelated cleanup.  Does it belong in a different patch?

> @@ -148,13 +145,9 @@ static void file_memory_backend_set_pmem(Object *o, bool value, Error **errp)
>   
>   #ifndef CONFIG_LIBPMEM
>       if (value) {
> -        Error *local_err = NULL;
> -
> -        error_setg(&local_err,
> -                   "Lack of libpmem support while setting the 'pmem=on'"
> +        error_setg(errp, "Lack of libpmem support while setting the 'pmem=on'"
>                      " of %s. We can't ensure data persistence.",

Pre-existing - doesn't follow our usual error message content 
conventions regarding trailing '.'.

> +++ b/hw/ppc/spapr_pci.c
> @@ -1517,15 +1517,16 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
>        */
>       if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)] &&
>           PCI_FUNC(pdev->devfn) != 0) {
> -        error_setg(&local_err, "PCI: slot %d function 0 already ocuppied by %s,"
> +        error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
>                      " additional functions can no longer be exposed to guest.",

Another one.  Also, s/ocuppied/occupied/ while touching it.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


