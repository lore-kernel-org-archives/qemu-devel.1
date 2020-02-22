Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17228C35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 11:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D08206EF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 11:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbC0Xo8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D08206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5T4H-00038U-3V
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 06:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j5T3d-0002bu-Oe
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 06:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j5T3c-0004Yr-Eu
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 06:34:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22825
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j5T3c-0004YV-A8
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 06:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582371291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=meCi4unRT5GyvsmQXwuEqpY5d68ZNwvWLUomfK2jkJE=;
 b=HbC0Xo8/pb3qx3q30IczJTsed8qwlAapWUs7MqvX6Jqo0Vt7bCpI4FPk71ZOEXSZ3sSbjF
 4YLk0YHMyuoKNuNXhpNKG3ZJJc9FrNHRyrc06onqqk24EIOcc0YvBKN42lticoM1YmGPJS
 Hz0nRPMYT/6s3hjmpasEaxxCqz8g6mA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-864v5AXcP5CsctlhBHnpkQ-1; Sat, 22 Feb 2020 06:34:49 -0500
X-MC-Unique: 864v5AXcP5CsctlhBHnpkQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72E45800D50;
 Sat, 22 Feb 2020 11:34:42 +0000 (UTC)
Received: from [10.3.116.90] (ovpn-116-90.phx2.redhat.com [10.3.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E1A060BE0;
 Sat, 22 Feb 2020 11:34:30 +0000 (UTC)
Subject: Re: [PULL 24/31] fuzz: support for fork-based fuzzing.
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200222085030.1760640-1-stefanha@redhat.com>
 <20200222085030.1760640-25-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6ffd74e1-d603-f479-e6e4-eb5ef4ce7050@redhat.com>
Date: Sat, 22 Feb 2020 05:34:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200222085030.1760640-25-stefanha@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Darren Kenny <darren.kenny@oracle.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/22/20 2:50 AM, Stefan Hajnoczi wrote:
> From: Alexander Bulekov <alxndr@bu.edu>
> 
> fork() is a simple way to ensure that state does not leak in between
> fuzzing runs. Unfortunately, the fuzzer mutation engine relies on
> bitmaps which contain coverage information for each fuzzing run, and
> these bitmaps should be copied from the child to the parent(where the
> mutation occurs). These bitmaps are created through compile-time
> instrumentation and they are not shared with fork()-ed processes, by
> default. To address this, we create a shared memory region, adjust its
> size and map it _over_ the counter region. Furthermore, libfuzzer
> doesn't generally expose the globals that specify the location of the
> counters/coverage bitmap. As a workaround, we rely on a custom linker
> script which forces all of the bitmaps we care about to be placed in a
> contiguous region, which is easy to locate and mmap over.
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> Message-id: 20200220041118.23264-16-alxndr@bu.edu
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Random drive-by observation:

> +++ b/tests/qtest/fuzz/fork_fuzz.ld
> @@ -0,0 +1,37 @@
> +/* We adjust linker script modification to place all of the stuff that needs to
> + * persist across fuzzing runs into a contiguous seciton of memory. Then, it is

section


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


