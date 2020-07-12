Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB24DC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 18:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8175206E2
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 18:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhCS54N8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8175206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jugyO-0001bf-W6
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 14:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jugxR-0000le-77
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 14:44:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50856
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jugxO-0008QB-HZ
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 14:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594579448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=5rowCU0d8dy8CT3fvR8s8OIjg5s+LA7nX8tMMp+CnKA=;
 b=hhCS54N8My9jWif+X0Gom7ODqljvVpl3QKTzj7GCHPJXFljO1jELMf/8nFOXkQF2JHzTAD
 SVH7401O54cDmXIW7KMwQ64hhVbbbjIvLikdy2x7WlfknZKgz2hYqe5t5Y3ZaMTf9hCDET
 fb/qCefEYJhQOxisudVqsCy2pPDqkNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-t4hd5M1YP5GC7baZ1l9D0w-1; Sun, 12 Jul 2020 14:44:06 -0400
X-MC-Unique: t4hd5M1YP5GC7baZ1l9D0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8C7D106B77D
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 18:44:05 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28C595D9EF;
 Sun, 12 Jul 2020 18:44:00 +0000 (UTC)
Subject: Re: [PATCH] tests: improve performance of device-introspect-test
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200709112857.3760116-1-berrange@redhat.com>
 <87mu47gms3.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c353a610-6989-331c-cb65-a893602a376a@redhat.com>
Date: Sun, 12 Jul 2020 20:43:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87mu47gms3.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 14:44:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/2020 22.03, Markus Armbruster wrote:
[...]
>   With -m slow, we test 2 * #machines * #devices introspections,
>   i.e. from 132 (tricore) to over 10k (ppc 13046, ppc64 23426, arm
>   82708, aarch64 89760).  Median is ~1600, sum is ~260k.
> 
>   Except we actually test just 89k now, because the test *fails* for arm
>   and aarch64 after some 500 introspections: introspecting device
>   msf2-soc with machine ast2600-evb makes QEMU terminate unsuccessfully
>   with "Unsupported NIC model: ftgmac100".  Cause: m2sxxx_soc_initfn()
>   calls qemu_check_nic_model().  Goes back to commit 05b7374a58 "msf2:
>   Add EMAC block to SmartFusion2 SoC", merged some ten weeks ago.  This
>   is exactly the kind of mistake the test is designed to catch.  How
>   come it wasn't?  Possibly due to unlucky combination with the slowdown
>   discussed in the next item (but that was less than four weeks ago).

Well, the explanation is simpler: Nobody ran the
device-introspection-test with the arm target in slow mode! Hardly
anybody runs the tests with SPEED=slow, and in the CI, we currently only
run the test in slow mode for the i386-softmmu, ppc64-softmmu and
mips64-softmmu targets. Simply because testing with arm was toooo slow
when I wrote that CI script, I didn't want to wait endlessly here.

But now with the speedup patch from Daniel, and maybe with some smarter
checks in the YML file (I now know that there are things like "only:
changes:" keywords so we could e.g. only run that test if something in
hw/arm/* has changed), I think it should be feasible to get this
included in the CI, too.

 Thomas


