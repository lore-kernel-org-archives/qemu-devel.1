Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C0CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F43A2065F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dw2XMD6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F43A2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahJw-0000aI-P7
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jahIv-00086R-Fw
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:03:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50725
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jahIu-00031u-0e
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589814221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qiN/G7vuO3RG17w17TGmMafEFYO76u44tXr7JAIoAqY=;
 b=dw2XMD6gb5eezf+aL4T/g0v5mecto25bJU9CQ5PVo1njvJp8JyR0XC9arOg1HCNIxyqAN0
 TXVhngz/iK7lJXMjaedRJ9JxoDHnfRSbwHUi7oEqMG2ok7y6iXdCcygKYm901z8Xq/wnfO
 MoY+eSMMwowCAAydS8QLQVzYhhfovTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-VfBrlEPzMZSOELUZ9yxSfw-1; Mon, 18 May 2020 11:03:37 -0400
X-MC-Unique: VfBrlEPzMZSOELUZ9yxSfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7550835B8D
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 15:03:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A693D5799C;
 Mon, 18 May 2020 15:03:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 363E711358BC; Mon, 18 May 2020 17:03:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 22/24] qdev: Assert devices are plugged into a bus that
 can take them
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-23-armbru@redhat.com>
Date: Mon, 18 May 2020 17:03:35 +0200
In-Reply-To: <20200518050408.4579-23-armbru@redhat.com> (Markus Armbruster's
 message of "Mon, 18 May 2020 07:04:06 +0200")
Message-ID: <871rnh9tfc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> This would have caught some of the bugs I just fixed.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/core/qdev.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 9e5538aeae..0df995eb94 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -97,6 +97,11 @@ static void bus_add_child(BusState *bus, DeviceState *child)
>  void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
>  {
>      BusState *old_parent_bus = dev->parent_bus;
> +    DeviceClass *dc = DEVICE_GET_CLASS(dev);
> +
> +    assert(dc->bus_type
> +           ? bus && object_dynamic_cast(OBJECT(bus), dc->bus_type)
> +           : !bus);
>  
>      if (old_parent_bus) {
>          trace_qdev_update_parent_bus(dev, object_get_typename(OBJECT(dev)),

Actually, !bus crashes below in bus_add_child().  Simpler assertion:

       assert(dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type));


