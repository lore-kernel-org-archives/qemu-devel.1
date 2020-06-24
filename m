Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02BFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 18:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB4020738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 18:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2RqaAgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB4020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joA3e-0000Vh-8N
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 14:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joA27-0008Dr-I8
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 14:22:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joA25-0006q5-Ea
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 14:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593022919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWogS1QOQuWthMQu1cG8bG4zavB8I+hjefZaYX8YJMQ=;
 b=S2RqaAgG2cvZfvc80DwHDKjPqpHeV4qX9SwYWEJsXHbWATSjHLa/+y5wLWsr8+DesZwJFK
 cTQwe9hUJ+7KHOm9i+VUJaLTxmOmT47VUNUBfrzj19ot37h2T7XLLxTslSJq0xcWJF/WHq
 UnvegmtZtG1XJB7gIUHHrzK6231B+Cw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-FI-NZrZNNWyRq6A0YPzAEQ-1; Wed, 24 Jun 2020 14:21:46 -0400
X-MC-Unique: FI-NZrZNNWyRq6A0YPzAEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 582E0BFC2;
 Wed, 24 Jun 2020 18:21:45 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8320E58;
 Wed, 24 Jun 2020 18:21:35 +0000 (UTC)
Subject: Re: [PATCH 07/46] error: Avoid more error_propagate() when error is
 not used here
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-8-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <88bc4c25-4a47-4c28-4b96-b7ea6c14173d@redhat.com>
Date: Wed, 24 Jun 2020 13:21:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624164344.3778251-8-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
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
> When all we do with an Error we receive into a local variable is
> propagating to somewhere else, we can just as well receive it there
> right away.  The previous commit did that for simple cases with
> Coccinelle.  Do it for a few more manually.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   blockdev.c     |  5 +----
>   hw/core/numa.c | 44 ++++++++++++++------------------------------
>   qdev-monitor.c | 11 ++++-------
>   3 files changed, 19 insertions(+), 41 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index b66863c42a..73736a4eaf 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1009,13 +1009,10 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
>       }
>   
>       /* Actual block device init: Functionality shared with blockdev-add */
> -    blk = blockdev_init(filename, bs_opts, &local_err);
> +    blk = blockdev_init(filename, bs_opts, errp);
>       bs_opts = NULL;
>       if (!blk) {
> -        error_propagate(errp, local_err);
>           goto fail;
> -    } else {
> -        assert(!local_err);

Loses an assertion that blockdev_init() doesn't mis-use errp, but I 
think the goal of your cleanup work has been to make it easier to prove 
any function follows the rules, so the assertion doesn't add much at 
this point.

> +++ b/qdev-monitor.c
> @@ -600,7 +600,6 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>       const char *driver, *path;
>       DeviceState *dev = NULL;
>       BusState *bus = NULL;
> -    Error *err = NULL;
>       bool hide;
>   
>       driver = qemu_opt_get(opts, "driver");
> @@ -655,15 +654,14 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>       dev = qdev_new(driver);
>   
>       /* Check whether the hotplug is allowed by the machine */
> -    if (qdev_hotplug && !qdev_hotplug_allowed(dev, &err)) {
> +    if (qdev_hotplug && !qdev_hotplug_allowed(dev, errp)) {
>           /* Error must be set in the machine hook */
> -        assert(err);

Another such case.

>           goto err_del_dev;
>       }
>   
>       if (!bus && qdev_hotplug && !qdev_get_machine_hotplug_handler(dev)) {
>           /* No bus, no machine hotplug handler --> device is not hotpluggable */
> -        error_setg(&err, "Device '%s' can not be hotplugged on this machine",
> +        error_setg(errp, "Device '%s' can not be hotplugged on this machine",

Should we s/can not/cannot/ while touching this?

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


