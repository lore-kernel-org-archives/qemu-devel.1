Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233A3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3418206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwqUrpLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3418206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrFhP-0000ti-Uq
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 03:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jrFg0-0007gl-VU
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:00:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50126
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jrFfz-0000uu-Hb
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593759598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLJpx+ZKymG1ki9bSYn4O2FA/0RYahaBKpEylAsxs2o=;
 b=GwqUrpLVdifuxHN9q/R2rZAFBZhlE6hdntkk5FHsRK/CChIzpIwNgDCj2qVH4A7f0iyzg5
 TlB+z7jHX7JPxIiU5YV4aRrxNBlM0t+uBkjMw58Sd3aNU0xuxq3mcw85s902SE9ozfudWd
 OK+d3WLwMiBFEJHWGOmXkAv3s6yHUNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-6lKcIXWQMEaDPWVNnpOUGg-1; Fri, 03 Jul 2020 02:59:55 -0400
X-MC-Unique: 6lKcIXWQMEaDPWVNnpOUGg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38B5610059A5;
 Fri,  3 Jul 2020 06:59:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA5A96FEF4;
 Fri,  3 Jul 2020 06:59:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 890841138648; Fri,  3 Jul 2020 08:59:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 36/44] error: Eliminate error_propagate() manually
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-37-armbru@redhat.com>
 <df44593d-02c1-fe9e-8da0-9522f090c5c7@redhat.com>
Date: Fri, 03 Jul 2020 08:59:52 +0200
In-Reply-To: <df44593d-02c1-fe9e-8da0-9522f090c5c7@redhat.com> (Eric Blake's
 message of "Thu, 2 Jul 2020 13:25:00 -0500")
Message-ID: <877dvlxevr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
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
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 7/2/20 10:49 AM, Markus Armbruster wrote:
>> When all we do with an Error we receive into a local variable is
>> propagating to somewhere else, we can just as well receive it there
>> right away.  The previous two commits did that for sufficiently simple
>> cases with Coccinelle.  Do it for several more manually.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/qdev-monitor.c
>> @@ -597,7 +597,6 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>>       const char *driver, *path;
>>       DeviceState *dev = NULL;
>>       BusState *bus = NULL;
>> -    Error *err = NULL;
>>       bool hide;
>>         driver = qemu_opt_get(opts, "driver");
>> @@ -652,15 +651,14 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>>       dev = qdev_new(driver);
>>         /* Check whether the hotplug is allowed by the machine */
>> -    if (qdev_hotplug && !qdev_hotplug_allowed(dev, &err)) {
>> +    if (qdev_hotplug && !qdev_hotplug_allowed(dev, errp)) {
>>           /* Error must be set in the machine hook */
>> -        assert(err);
>
> That comment could be deleted now.

Yes.

> Either way,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


