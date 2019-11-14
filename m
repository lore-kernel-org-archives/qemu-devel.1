Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5EAC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9AD020672
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFMlqb+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AD020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVBJr-00028S-F5
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 04:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iVBIY-0000od-7y
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iVBIW-0008Ca-FQ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:20:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33266
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iVBIV-0008Be-5E
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:20:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573723213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GQc3L9q7us7ZfqtoN7r/gtMAJ84SXNa5SV69HVJ4O8c=;
 b=gFMlqb+LSsjYJ6XHOMk7b6LDqyHAW6FVSZIYwtnUcyvSC4PFZ1CbWignlw4apydFfsU6VV
 6TAaEwCBuo/nBxnrEj+H18dG07Psr9psSy25L1UZz1YzJgYQZ9p9Vt3YCVnaOzGyxY3TX4
 ju0LKsG8W9SCMsKzfvD8Yqwtbvm74Fs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-6TbhOjKDNemcTWw3fw4ZdQ-1; Thu, 14 Nov 2019 04:20:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9ABC9800580;
 Thu, 14 Nov 2019 09:20:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7146481C1E;
 Thu, 14 Nov 2019 09:20:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ECE0E1138648; Thu, 14 Nov 2019 10:20:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 02/14] qapi: Move to_c_string() to
 common.py
References: <20190624173935.25747-1-mreitz@redhat.com>
 <20190624173935.25747-3-mreitz@redhat.com>
Date: Thu, 14 Nov 2019 10:20:05 +0100
In-Reply-To: <20190624173935.25747-3-mreitz@redhat.com> (Max Reitz's message
 of "Mon, 24 Jun 2019 19:39:22 +0200")
Message-ID: <87imnmq0fu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 6TbhOjKDNemcTWw3fw4ZdQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max Reitz <mreitz@redhat.com> writes:

> This function will be useful for code generation once we allow default
> values, so move it to the other "C helper functions".  In the process,
> rewrite it so it supports all nonprintable and non-ASCII characters.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Please have a close look at commit 56a8caff92 "qapi: Restrict strings to
printable ASCII".  Do we still need the rewrite?

If yes: the commit message title promises code motion, but the patch is
anything but.  Adjust the title, please.


