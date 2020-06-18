Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85443C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB0F2080D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJCLdy1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB0F2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jly77-0002uG-JY
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 13:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jly6M-0002M5-1B
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:13:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41121
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jly6J-00023P-6q
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592500397;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mgG1UXF1rW9HEOqhCZRfu7/hooD6k260bmNUtM4b3RA=;
 b=IJCLdy1ad636Bxb8fRmdiJkMj4aQKGOnhgUy/5h3Fjx7mzGLqgmq8nt5HUwRSy72tf/QCR
 6N1QRm+2g7RVze6ozAI+j6Mnjo/GrxB6coc2qJsXc6CV2WV0jsp9oEVYqOdsIGiiRJTsZG
 05+83hFYT7bTGHyvUTo4xgTQbDSnawQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-hTUB0mDWMDOhyq96dAaXdA-1; Thu, 18 Jun 2020 13:13:02 -0400
X-MC-Unique: hTUB0mDWMDOhyq96dAaXdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEF20107ACF3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 17:13:01 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C99501E2273;
 Thu, 18 Jun 2020 17:12:57 +0000 (UTC)
Date: Thu, 18 Jun 2020 18:12:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [question] qemu abort when object-add is called with an already
 used id
Message-ID: <20200618171254.GL671599@redhat.com>
References: <0f47e285-3811-ba08-297f-e3ff5bd5f2c3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0f47e285-3811-ba08-297f-e3ff5bd5f2c3@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu list <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 06:15:57PM +0200, Auger Eric wrote:
> Hi,
> 
> While testing PCDIMM hotplug/coldplug I noted qemu aborts if we attempt
> to add from the QMP monitor an object whose id is already in use.
> 
> for instance
> object-add qom-type=memory-backend-ram id=mem1 props.size=4294967296
> while mem1 is already used.
> 
> We get:
> Unexpected error in object_property_try_add() at qom/object.c:1167:
> attempt to add duplicate property 'mem1' to object (type 'container')
> 
> This is due to the fact &error_abort is passed to object_property_try_add().
> 
> Is it the expected behavior?

No, this is highly undesirable. A user/mgmt app mistake in reusing a
property ID shouldn't result in loss of the entire running VM and the
user's live data within.

We must gracefully report the error back to the QMP client.

error_abort should really only be used in scenarios which are
not expected to happen in real world. eg it is more like an
assert() in terms of where it should be used.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


