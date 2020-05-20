Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C60BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516E12072C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ms62q3oW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516E12072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbQGt-0003eL-Gf
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 11:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbQFF-0001VG-GI
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:02:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30951
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbQFD-0005zM-Um
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589986973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ENzz94L/o8ytsVx12JNcM7t1M7UTcH+sYxTluDO0kqE=;
 b=Ms62q3oWG23RGUUuVGnbPdBWuBF/TaDDtRuJwwH8MJ9V6xgbz3msjYwqwsqgDtm+118XgJ
 vRuWafFG+q3yEB6mQRukIpH6GBo8s5hEknYHvgo98l87uiAct5nOJa45eiU0atEw1ZKND2
 hErlqG6v+2ra8Fm++bfiVL0jNSs9bt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-KLkzjSnXMveDn1WMP2GbKQ-1; Wed, 20 May 2020 11:02:50 -0400
X-MC-Unique: KLkzjSnXMveDn1WMP2GbKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56A4A1800738
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 15:02:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F36E2E17D;
 Wed, 20 May 2020 15:02:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 82D9211358BC; Wed, 20 May 2020 17:02:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 51/55] qdev: Make qdev_realize() support bus-less devices
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-52-armbru@redhat.com>
 <b0188311-e138-cf55-c0e9-52313b5aa906@redhat.com>
Date: Wed, 20 May 2020 17:02:47 +0200
In-Reply-To: <b0188311-e138-cf55-c0e9-52313b5aa906@redhat.com> (Paolo
 Bonzini's message of "Wed, 20 May 2020 08:43:14 +0200")
Message-ID: <87lflmps2w.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 19/05/20 16:55, Markus Armbruster wrote:
>> So far, qdev_realize() supports only devices that plug into a bus:
>> argument @bus cannot be null.  Extend it to support bus-less devices,
>> too.
>> 
>> qdev_realize_and_unref() remains restricted, because its reference
>> counting would become rather confusing for bus-less devices.
>
> I think it would be fine, you would just rely on the reference held by
> the QOM parent (via the child property).

I took one look at the contract I wrote for it, and balked :)

qdev_realize()'s contract before this patch:

    /*
     * Realize @dev.
     * @dev must not be plugged into a bus.
     * Plug @dev into @bus.  This takes a reference to @dev.
     * If @dev has no QOM parent, make one up, taking another reference.
     * On success, return true.
     * On failure, store an error through @errp and return false.
     */
    bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)

Simple enough.

This patch merely adds "If @bus, " before "plug".  Still simple enough.

qdev_realize_and_unref()'s contract:

    /*
     * Realize @dev and drop a reference.
     * This is like qdev_realize(), except it steals a reference rather
     * than take one to plug @dev into @bus.  On failure, it drops that
     * reference instead.  @bus must not be null.  Intended use:
     *     dev = qdev_new();
     *     [...]
     *     qdev_realize_and_unref(dev, bus, errp);
     * Now @dev can go away without further ado.
     */
    bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)

If @bus is null, who gets to hold the stolen reference?

You seem to suggest the QOM parent.  What if @dev already has a parent?

Oh, sod it, let's go shopping.


