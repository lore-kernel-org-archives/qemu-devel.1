Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4FEC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 06:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73211221E8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 06:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpkeohIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73211221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNrvv-0006lB-Kd
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 02:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jfreimann@redhat.com>)
 id 1kNrtq-0003jW-FH
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 02:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jfreimann@redhat.com>)
 id 1kNrto-0003oT-4A
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 02:17:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601533022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mDdZmpl8jPsER4JHBLbpGGbk5Zu+2zI44eesLxjsBHU=;
 b=LpkeohIe/Dj/Jlah9etwSYlYzPdF9sp5a0WMG8tRIYDN+9eoboIg9EdUd+SNoXFaom78Uz
 BH/NTgixKckYeh9owGElyvMzeHul58veA27hEpHi3tw9wk96+xsYJ38KQfwvQK0wwW9R7s
 1QsP3DDS1V3Rfau+YjNHDzWjsv7MGQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-yn6HIPvmOIyfRU2YcEUbzw-1; Thu, 01 Oct 2020 02:15:28 -0400
X-MC-Unique: yn6HIPvmOIyfRU2YcEUbzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8FB1807350
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2020 06:15:27 +0000 (UTC)
Received: from localhost (ovpn-112-119.ams2.redhat.com [10.36.112.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04B155578E;
 Thu,  1 Oct 2020 06:15:20 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: dgilbert@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [RFC 0/1] tools/virtiofsd: don't create temporary directory in /
Date: Thu,  1 Oct 2020 08:15:18 +0200
Message-Id: <20201001061519.636959-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jfreimann@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jfreimann@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 00:27:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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

When running a Kata container with virtiofs in OpenShift/k8s I get a
"Operation not permitted" error from a mkdtemp() call in virtiofsd
because it is trying to create a directory like /virtiofsd.11RAND

To avoid this change in virtiofsd, I've tried to set the TMPDIR
environment variable for the virtiofsd process, hoping that mkdtemp()
would use it, but it does not. Looking at glibc code it seems to be used
by tmpfile() etc. only. 

I'm sending this as an RFC because:
Maybe just prepending "/tmp" is not generic enough and we should make it
somehow configurable or use $TMPDIR. Also there might be security
implications I'm not aware of.
The process is running with container_kvm_t context which also needs
a change to be allowed to create files in tmpfs to make it work.



Jens Freimann (1):
  tools/virtiofsd: create tmpdir in /tmp

 tools/virtiofsd/passthrough_ll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.26.2


