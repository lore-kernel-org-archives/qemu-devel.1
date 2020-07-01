Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DC0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 05:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA8A20747
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 05:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4Tp+p9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA8A20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqVkT-0007sp-1V
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 01:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqVja-0007QA-6c
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 01:56:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55356
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqVjY-00062c-5U
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 01:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593582994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P9e6pxRlhLqdi/Qte6Z9/WWcMved/5ud2vMwKx50UFk=;
 b=V4Tp+p9TNU0fVWucigFi2KnoC8qnZluO5UMfkhosQmeBEHo1Y2yQ8Ku4I8YjWNRWJ8+7eq
 0o5mMrosoGd2z6hcOHg1dBn+KOJVG1Ag+nbOOxYIttN0J1zgcMEbLo3wd4w/sIdIhRaKV6
 lrfV6sCzzSLRfzeF6EhVoTL6hEXh9cc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-zcMumqTuPlySm6ML7C6EDw-1; Wed, 01 Jul 2020 01:56:30 -0400
X-MC-Unique: zcMumqTuPlySm6ML7C6EDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B91919067E0;
 Wed,  1 Jul 2020 05:56:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D68E612A5;
 Wed,  1 Jul 2020 05:56:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8BD5311384A6; Wed,  1 Jul 2020 07:56:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
References: <20200624121841.17971-1-paul@xen.org>
 <20200624121841.17971-3-paul@xen.org>
 <20200630150849.GA2110@perard.uk.xensource.com>
Date: Wed, 01 Jul 2020 07:56:24 +0200
In-Reply-To: <20200630150849.GA2110@perard.uk.xensource.com> (Anthony PERARD's
 message of "Tue, 30 Jun 2020 16:08:49 +0100")
Message-ID: <87eepvdbhz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <pdurrant@amazon.com>,
 Jason Andryuk <jandryuk@gmail.com>, qemu-devel@nongnu.org,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Anthony PERARD <anthony.perard@citrix.com> writes:

> On Wed, Jun 24, 2020 at 01:18:41PM +0100, Paul Durrant wrote:
>> From: Paul Durrant <pdurrant@amazon.com>
>> 
>> The generic pc_machine_initfn() calls pc_system_flash_create() which creates
>> 'system.flash0' and 'system.flash1' devices. These devices are then realized
>> by pc_system_flash_map() which is called from pc_system_firmware_init() which
>> itself is called via pc_memory_init(). The latter however is not called when
>> xen_enable() is true and hence the following assertion fails:
>> 
>> qemu-system-i386: hw/core/qdev.c:439: qdev_assert_realized_properly:
>> Assertion `dev->realized' failed
>> 
>> These flash devices are unneeded when using Xen so this patch avoids the
>> assertion by simply removing them using pc_system_flash_cleanup_unused().
>> 
>> Reported-by: Jason Andryuk <jandryuk@gmail.com>
>> Fixes: ebc29e1beab0 ("pc: Support firmware configuration with -blockdev")
>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
>> Tested-by: Jason Andryuk <jandryuk@gmail.com>
>
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
>
> I think I would add:
>
> Fixes: dfe8c79c4468 ("qdev: Assert onboard devices all get realized properly")
>
> as this is the first commit where the unrealized flash devices are an
> issue.

They were an issue before, but commit dfe8c79c4468 turned the minor
issue into a crash bug.  No objections.


