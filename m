Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C322AC4363D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:00:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C69820848
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnvuJdNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C69820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPR2e-0002lM-Av
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 10:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jfreimann@redhat.com>)
 id 1kPR0h-0001LK-4r
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jfreimann@redhat.com>)
 id 1kPR0d-0000gI-Pv
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601906313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fCjqS97KrKdJlyRAjY1r3ymDq972TEKHfO5NaWWjPno=;
 b=AnvuJdNhjvEwlVZc/1WQ34nGyg5H3rffPZ4R7DPgN5q8kyLLCs1YVmt0E+NreHAnO5io6B
 VT60dygwjTfBblzJlAMrEwy1pcDgVB+NfDMxGmS81e+2EuddJ1d4Lx41XFLp9SwkvQ+Xun
 wGxOm2IqHQetH6NRkauSqbv/Viw5amo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-JzMHV3xINQGaJ68X0gUH-Q-1; Mon, 05 Oct 2020 09:58:31 -0400
X-MC-Unique: JzMHV3xINQGaJ68X0gUH-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FCDC80365F
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2020 13:58:30 +0000 (UTC)
Received: from localhost (ovpn-113-34.ams2.redhat.com [10.36.113.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BFA15D9F3;
 Mon,  5 Oct 2020 13:58:23 +0000 (UTC)
Date: Mon, 5 Oct 2020 15:58:22 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: dgilbert@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org
Subject: Re: [RFC 0/1] tools/virtiofsd: don't create temporary directory in /
Message-ID: <20201005135822.GE1625193@linux.fritz.box>
References: <20201001061519.636959-1-jfreimann@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201001061519.636959-1-jfreimann@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jfreimann@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jfreimann@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: fidencio@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 01, 2020 at 08:15:18AM +0200, Jens Freimann wrote:
>I'm sending this as an RFC because:
>Maybe just prepending "/tmp" is not generic enough and we should make it
>somehow configurable or use $TMPDIR. Also there might be security
>implications I'm not aware of.
>The process is running with container_kvm_t context which also needs
>a change to be allowed to create files in tmpfs to make it work.

Fabiano had the idea to use a glib function to create the
temporary directory. It would be good because it uses the $TMPDIR env
variable. 

But before we decide about glib or not: the change is in the call
chain of setup_sandbox() and there was a question what other implications
that has. What do you think?

regards,
Jens  


