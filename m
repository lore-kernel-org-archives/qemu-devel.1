Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4A9C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE402076B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMiVptFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE402076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdBe-0006em-Pm
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 10:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kNd8u-0004fQ-AF
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kNd8p-0002D7-Vn
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601476295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QsXpqg/37aKlZIvkdFb2+sFW5FG0DI77hACwT+DgyPI=;
 b=cMiVptFt+eBCd9BXbuLXqTJH+sMsfoCMPUaQc0i3PstWW0qd6WzdpEBQ56WNpt14OfblfH
 p4IbQElH3QgYOaXNcESjnXOnDWMuiaaUMQ5+8t02Y3UcI5/EbvZ92wwffQPBZbq6An9Ip2
 Eku6ZPIn83MSvtluidmQiZaSWcNsvW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-Tj3NyIYvPWuQsc17ngCOAQ-1; Wed, 30 Sep 2020 10:31:33 -0400
X-MC-Unique: Tj3NyIYvPWuQsc17ngCOAQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC2AF1891E93
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 14:31:31 +0000 (UTC)
Received: from starship (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C442C619B5;
 Wed, 30 Sep 2020 14:31:27 +0000 (UTC)
Message-ID: <9182aa173b31989e07668194e18f4dcb31981388.camel@redhat.com>
Subject: Re: [PATCH 06/10] device-core: use atomic_set on .realized property
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Date: Wed, 30 Sep 2020 17:31:26 +0300
In-Reply-To: <20200925172604.2142227-7-pbonzini@redhat.com>
References: <20200925172604.2142227-1-pbonzini@redhat.com>
 <20200925172604.2142227-7-pbonzini@redhat.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-09-25 at 13:26 -0400, Paolo Bonzini wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Some code might race with placement of new devices on a bus.
> We currently first place a (unrealized) device on the bus
> and then realize it.
> 
> As a workaround, users that scan the child device list, can
> check the realized property to see if it is safe to access such a device.
> Use an atomic write here too to aid with this.
> 
> A separate discussion is what to do with devices that are unrealized:
> It looks like for this case we only call the hotplug handler's unplug
> callback and its up to it to unrealize the device.
> An atomic operation doesn't cause harm for this code path though.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-Id: <20200913160259.32145-6-mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/core/qdev.c         | 19 ++++++++++++++++++-
>  include/hw/qdev-core.h |  3 +++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 59e5e710b7..fc4daa36fa 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -946,7 +946,25 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>              }
>         }
>  
> +       qatomic_store_release(&dev->realized, value);
> +
>      } else if (!value && dev->realized) {
> +
> +        /*
> +         * Change the value so that any concurrent users are aware
> +         * that the device is going to be unrealized
> +         *
> +         * TODO: change .realized property to enum that states
> +         * each phase of the device realization/unrealization
> +         */
> +
> +        qatomic_set(&dev->realized, value);
> +        /*
> +         * Ensure that concurrent users see this update prior to
> +         * any other changes done by unrealize.
> +         */
> +        smp_wmb();
I''l probably never fully understand where to use read/write/full barrier.
If I understand corrctly, read barrier prevents reads done by this thread to be reordered,
by the CPU and write barrier prevents writes done by this CPU to be re-ordered.
Both (depending on the macro) usually imply compiler barrier (to avoid compilier re-ordering
stuff...)



> +
>          QLIST_FOREACH(bus, &dev->child_bus, sibling) {
>              qbus_unrealize(bus);
>          }
> @@ -961,7 +979,6 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>      }
>  
>      assert(local_err == NULL);
> -    dev->realized = value;
>      return;
>  
>  child_realize_fail:
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 8067497074..39490e76ee 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -163,6 +163,9 @@ struct NamedClockList {
>  /**
>   * DeviceState:
>   * @realized: Indicates whether the device has been fully constructed.
> + *            When accessed without the iothread mutex, consider using
> + *            qatomic_load_acquire() before accessing any other field in
> + *            the device.
This sounds way better that what I wrote. As you probably noticed recently
(but not this patchset yet) I started to review the spelling/comments
more throughfully, so hopefully we see less of stuff that I myself read
and wonder why I did that many spelling/grammar mistakes.... :-)

>   * @reset: ResettableState for the device; handled by Resettable interface.
>   *
>   * This structure should not be accessed directly.  We declare it here


Best regards,
	Maxim Levitsky


