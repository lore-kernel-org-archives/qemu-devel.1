Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A898C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2F7224D4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6uKuva3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2F7224D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIahi-0002tY-LZ
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIaef-0007n6-HW
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIaed-0004sG-IL
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600275094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYbXhRFv2/Q7VE3eohs7gSTwE1mbBL5ziN+DOPHxong=;
 b=U6uKuva3S115+7Y5PWd8OeRT9/y8TLs9KJaHj/C6/riY+FctL9wHFAIDvf8QTZ7N2nAf0W
 aNQRkEQIf7Z0QZYA4zkELle6RcEVJjwPb+6AnLhwyyDX5Zlc4ILjFFvASrqX3/hTYcVDIH
 BPNncwhID+l1YbxjiGdl6nUDWIQaL1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-9ENHTE95PXK7IQI4t4EdVQ-1; Wed, 16 Sep 2020 12:51:31 -0400
X-MC-Unique: 9ENHTE95PXK7IQI4t4EdVQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E18B8015A3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:51:30 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23AD667CEF;
 Wed, 16 Sep 2020 16:51:24 +0000 (UTC)
Message-ID: <5e03a19f14ef4d3c41721323a95fdb4be0aa81fc.camel@redhat.com>
Subject: [RFC DOCUMENT 06/12] kubevirt-and-kvm: Add Live Migration page
From: Andrea Bolognani <abologna@redhat.com>
To: libvir-list@redhat.com, qemu-devel@nongnu.org
Date: Wed, 16 Sep 2020 18:51:21 +0200
In-Reply-To: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
References: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: vromanso@redhat.com, rmohr@redhat.com, crobinso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Live-Migration.md

# Live Migration

There are two scenarios where live migration is triggered in KubeVirt

* As per user request, by posting a `VirtualMachineInstanceMigration`
  to the cluster
* As per cluster request, for instance on a Node eviction (due lack
  of resources or maintenance of given Node)

In both situations, KubeVirt will use libvirt to handle logic and
coordination with QEMU while KubeVirt's components manage the
Kubernetes control plane and the cluster's limitations.

In short, KubeVirt:

* Checks if the target host is capable of migration of the given VM;
* Handles single network namespace per Pod by proxying migration data
  (more at [Networking][])
* Handles cluster resources usage (e.g: bandwidth usage);
* Handles cross-version migration;

![Live migration between two nodes][Live-Migration-Flow]

## Limitations

Live migration is not possible if:

* The VM is configured with cpu-passthrough;
* The VM has local or non-shared volume
* The Pod is using bridge binding for network access (right side of
  image below)

![Kubevirt's Pod][Live-Migration-Network]

## More on KubeVirt's Live migration

This blog [post on live migration][] explains how to have live
migration enabled in KubeVirt's VMs and describes some of its
caveats.

[Live-Migration-Flow]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Images/Live-Migration-Flow.png
[Live-Migration-Network]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Images/Live-Migration-Network.png
[Networking]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Networking.md
[post on live migration]: https://kubevirt.io/2020/Live-migration.html


