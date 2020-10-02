Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433C2C47425
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98D32053B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWTox/IM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98D32053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOG5G-0000PL-IZ
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 04:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOG3S-0007aI-Hc
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOG3O-0007jd-AQ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601625872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zc1SUcJRimhAfLsJiL/bcfHJP3rIiAU0qw3VDqo/jbI=;
 b=EWTox/IMQOnmwwa21APsFQRtmpZ4ZChEioFwGxRWbU4EEsmhcOMGs9JxVPFGaEWeYS+thA
 cKJGUS/MIqGZHdTJ7TcMfgw42f5cG7r8ky5uE4gCsgUY+mPSpNrEDZI1RTGtYrJcWPXWjq
 RZ1Cv/0/PuewTZExgwBStMBrDg7pn3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-F-hsCoZ7PDeY8dYXHTKKpg-1; Fri, 02 Oct 2020 04:04:31 -0400
X-MC-Unique: F-hsCoZ7PDeY8dYXHTKKpg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C98C21029D21;
 Fri,  2 Oct 2020 08:04:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41F57196FD;
 Fri,  2 Oct 2020 08:04:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B7B8B1132784; Fri,  2 Oct 2020 10:04:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 06/13] qmp: Call monitor_set_cur() only in
 qmp_dispatch()
References: <20200909151149.490589-7-kwolf@redhat.com>
 <877dswo0mf.fsf@dusky.pond.sub.org>
 <20200925151304.GE5731@linux.fritz.box>
 <87ft72i0v8.fsf@dusky.pond.sub.org>
 <20200928143052.GH5451@linux.fritz.box>
 <87h7rfehtr.fsf@dusky.pond.sub.org>
 <20200930112903.GA9292@linux.fritz.box>
 <87o8ln9zl3.fsf@dusky.pond.sub.org>
 <20200930140051.GC9292@linux.fritz.box>
 <20200930172020.GE2783@work-vm>
 <20201001101403.GA6673@linux.fritz.box>
 <87imbux7f4.fsf@dusky.pond.sub.org>
Date: Fri, 02 Oct 2020 10:04:25 +0200
In-Reply-To: <87imbux7f4.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Thu, 01 Oct 2020 18:00:47 +0200")
Message-ID: <871rihoxyu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Kevin Wolf <kwolf@redhat.com> writes:
[...]
>> I'll just change this one in the next version. Changing a single
>> well-known instance not a big problem. It's just unfortunate that there
>> are "A few more in PATCH 08-11" and I don't know how to identify them.
>
> When I do that, and you'd rather have a complete list, just ask.  Out of
> time for today, but I can get it for you first thing tomorrow.
>
> [...]

Done, with the detail level cranked up to "lots" ;)


