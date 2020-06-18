Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362FEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0097C20897
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjGaFiBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0097C20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlnEC-0006va-9e
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jlnDY-0005gk-6q
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 01:36:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56434
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jlnDW-0005YB-PA
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 01:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592458561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=gOhh8X7SEBSSBoeApoZOQtp3japGxENiuZHJhTMWe3A=;
 b=gjGaFiBBmRcFrq/ycbw7bxd+J2ocD4+j+G4a+vBadj6gDtlvswa11qjr+wZVXl4q99o6Gm
 J8lpEDaeWHIq0/0Qw0UAIf0+/CAx5aDdM90R/Y8gXYg1yuQ/pKMdkS2PAfUiII7c+j3C0S
 mHDD7HqLRT8eyhvni6cL149rLT63ibU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-0WiuFN4qNpOoNqGe8ByGzA-1; Thu, 18 Jun 2020 01:36:00 -0400
X-MC-Unique: 0WiuFN4qNpOoNqGe8ByGzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 079BCA0C00;
 Thu, 18 Jun 2020 05:35:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCA2910013D6;
 Thu, 18 Jun 2020 05:35:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 27B4D1132BD7; Thu, 18 Jun 2020 07:35:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Subject: Memory leak in transfer_memory_block()?
Date: Thu, 18 Jun 2020 07:35:57 +0200
Message-ID: <87h7v9szpe.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We appear to leak an Error object when ga_read_sysfs_file() fails with
errno != ENOENT unless caller passes true @sys2memblk:

    static void transfer_memory_block(GuestMemoryBlock *mem_blk, bool sys2memblk,
                                      GuestMemoryBlockResponse *result,
                                      Error **errp)
    {
        [...]
        if (local_err) {

We have an Error object.

            /* treat with sysfs file that not exist in old kernel */
            if (errno == ENOENT) {

Case 1: ENOENT; we free it.  Good.

                error_free(local_err);
                if (sys2memblk) {
                    mem_blk->online = true;
                    mem_blk->can_offline = false;
                } else if (!mem_blk->online) {
                    result->response =
                        GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
                }
            } else {

Case 2: other than ENOENT

                if (sys2memblk) {

Case 2a: sys2memblk; we pass it to the caller.  Good.

                    error_propagate(errp, local_err);
                } else {

Case 2b: !sys2memblk; ???

                    result->response =
                        GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
                }
            }
            goto out2;
        }
        [...]
    out2:
        g_free(status);
        close(dirfd);
    out1:
        if (!sys2memblk) {
            result->has_error_code = true;
            result->error_code = errno;
        }
    }

What is supposed to be done with @local_err in case 2b?


