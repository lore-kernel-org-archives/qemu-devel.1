Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5A3C4727F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A2820672
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6Ufcsny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A2820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOFsu-0006q1-Kg
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 03:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOFrh-0005uN-SX
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOFrc-00064w-IN
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601625143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TkILCR1CRVsYh7TQQoV8aZKTCV+2sw6l0sf93MG0UtQ=;
 b=Z6UfcsnyzorsnwjWtncYItK3MdYJtoZnR/nxj9AMsN76aPkvJT9F+PEND9cbeBAu3QMXM9
 sPW+jCalvugYKmYTMpyjjkPUDxFdfoCbgVRU4vugmCS30fJYwrAYsMpkLtw1XYnu/AxE9E
 VfHxfPpslwKLfXVa3fU5l5jExOsvKYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-hJlYBTNrOtKcV0V81FnfMw-1; Fri, 02 Oct 2020 03:52:22 -0400
X-MC-Unique: hJlYBTNrOtKcV0V81FnfMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7458186DD2C;
 Fri,  2 Oct 2020 07:52:20 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-139.ams2.redhat.com [10.36.112.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB22B5D9D3;
 Fri,  2 Oct 2020 07:52:19 +0000 (UTC)
Date: Fri, 2 Oct 2020 09:52:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH] qcow2: Use L1E_SIZE in qcow2_write_l1_entry()
Message-ID: <20201002075218.GA4996@linux.fritz.box>
References: <20200928162333.14998-1-berto@igalia.com>
MIME-Version: 1.0
In-Reply-To: <20200928162333.14998-1-berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.09.2020 um 18:23 hat Alberto Garcia geschrieben:
> We overlooked these in 02b1ecfa100e7ecc2306560cd27a4a2622bfeb04
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin


