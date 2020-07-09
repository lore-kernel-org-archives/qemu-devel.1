Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625B6C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30CDA206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFWhY8m+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CDA206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtVFV-0000y6-DW
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 08:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtVCt-0007At-Hx
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:59:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43617
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtVCr-00072a-Sl
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594295953;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMYsX07kgK0tXzoO41Z9EgIIEKfU/OK8Ry4KKY3n3KA=;
 b=WFWhY8m+WTV/ezzDndjMp8WuyG6d4aabclM2X0P0TSm4AfrxROXKywwnZRQO2TfNwte6FV
 WyhJ9Ei/cRvDkV1NBXu0lmQsucekDy55YtrjgRRSB1oLurpIJxajcW6zGCTXQYHoezodyd
 TpIhHFin3DroNroPbRo1K7YBXs/qQwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-hAnD4DbNNG2Nb0n-eG2xOQ-1; Thu, 09 Jul 2020 07:59:11 -0400
X-MC-Unique: hAnD4DbNNG2Nb0n-eG2xOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B633E18FF669
 for <qemu-devel@nongnu.org>; Thu,  9 Jul 2020 11:59:10 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 050501002382;
 Thu,  9 Jul 2020 11:59:08 +0000 (UTC)
Date: Thu, 9 Jul 2020 12:59:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] tests: improve performance of device-introspect-test
Message-ID: <20200709115906.GM3753300@redhat.com>
References: <20200709112857.3760116-1-berrange@redhat.com>
 <1b401730-4a54-d42f-a069-2125bd71e1f1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1b401730-4a54-d42f-a069-2125bd71e1f1@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 09, 2020 at 01:44:45PM +0200, Laurent Vivier wrote:
> On 09/07/2020 13:28, Daniel P. Berrangé wrote:
> > Total execution time with "-m slow" and x86_64 QEMU, drops from 3
> > minutes 15 seconds, down to 54 seconds.
> > 
> > Individual tests drop from 17-20 seconds, down to 3-4 seconds.
> > 
> > The cost of this change is that any QOM bugs resulting in the test
> > failure will not be directly associated with the device that caused
> > the failure. The test case is not frequently identifying such bugs
> > though, and the cause is likely easily visible in the patch series
> > that causes the failure. So overall the shorter running time is
> > considered the more important factor.
> 
> You don't report the test to test_device_intro_none() and
> test_device_intro_abstract(): is it intended ?

Since neither of those tests will result in any device being created there
didn't seem any point in chceking the qtree output.

IIUC, both of those tests should result in an error being reported from
the device_add command, but I see nothing actually validates that is the
case. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


