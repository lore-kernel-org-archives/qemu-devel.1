Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9D4C388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B5D422277
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRa0waqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5D422277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZpmw-0004pW-JL
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 01:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZplT-0003jh-8d
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:25:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZplR-0008Us-NM
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604384752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Go4v/f8DFfdFKyYdp0RZkMpM7ZCt2QIZNAQ/hvrSDoQ=;
 b=DRa0waqr7qxsrAaUD1894GeYqte3xgA9vt0YbpCPe7joCBGO0k/+QheBbvMKRg+0wMInZ4
 hpU5vj3lJ2v45t3XeQYCgRU6CmrNxu7HfAGrjmCiAzYohzGTYL6S69yHtThYqIosiwfLjE
 lyO/O1k/6bWcsN4LjLKPmE9nGUfvt24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-1ZSF4eF-PVShg2yTQM6LJg-1; Tue, 03 Nov 2020 01:25:49 -0500
X-MC-Unique: 1ZSF4eF-PVShg2yTQM6LJg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 235A6809DE7;
 Tue,  3 Nov 2020 06:25:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E135D6198E;
 Tue,  3 Nov 2020 06:25:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8DD5A1132BD6; Tue,  3 Nov 2020 07:25:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Subject: Re: [PULL 09/12] qga: add ssh-{add,remove}-authorized-keys
References: <20201027055317.351868-1-michael.roth@amd.com>
 <20201027055317.351868-10-michael.roth@amd.com>
 <878sbju5bs.fsf@dusky.pond.sub.org>
 <20201103021122.thtfyhrnvpic22sr@vm0>
Date: Tue, 03 Nov 2020 07:25:43 +0100
In-Reply-To: <20201103021122.thtfyhrnvpic22sr@vm0> (Michael Roth's message of
 "Mon, 2 Nov 2020 20:11:22 -0600")
Message-ID: <87v9enot20.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: peter.maydell@linaro.org, Michal Privoznik <mprivozn@redhat.com>,
 "Daniel P . =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michael Roth <michael.roth@amd.com> writes:

> On Mon, Nov 02, 2020 at 04:49:27PM +0100, Markus Armbruster wrote:
[...]
>> checkpatch ERROR: Use g_assert or g_assert_not_reached
>> 
>> See commit 6e9389563e "checkpatch: Disallow glib asserts in main code"
>> for rationale.
>
> Thanks for the pointer, I couldn't figure out what the issue was and

You can always ask :)

> assumed it was just noise. Wish I noticed this message before I sent out
> v2... v3 incoming.

Thanks!

[...]


