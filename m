Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DB7C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447C8207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPpoiyFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447C8207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMsHj-0004XJ-D9
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 08:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kMsFj-0002o7-VH
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kMsFd-0004Yz-5L
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:27:34 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601296048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/I3TNSxvMC7sqWjx9WaxzcRuCNK5DtIwaJL6RR87k+U=;
 b=gPpoiyFSuQF+FGtbTy46k/y0N/lGCRrBoa7X+jx/WvSX3G6uYOoyOh90mKG7Cc5AGpwKQn
 y9B4CIXkRGSAxrbrEpk0gNLds/p+OFrr3bru8hlB9akW1bbWvpz6pVja5Nx24DMPfowyCR
 HcrFKi6+S2gyOVjota5mWEx9ogHEsrQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-tz3vMmYPOXu3Cj_Cctn5-Q-1; Mon, 28 Sep 2020 08:27:26 -0400
X-MC-Unique: tz3vMmYPOXu3Cj_Cctn5-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DFCB1868415;
 Mon, 28 Sep 2020 12:27:25 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-97.ams2.redhat.com [10.36.115.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E107060CD0;
 Mon, 28 Sep 2020 12:27:18 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/9] s390x/tcg: Implement some z14 facilities
Date: Mon, 28 Sep 2020 14:27:08 +0200
Message-Id: <20200928122717.30586-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this patchset, I can boot a kernel compiled for z14 (requiring
Miscellaneous-Instruction-Extensions Facility 2) (using -cpu max).

I am currently working on "vector-enhancements facility 1", I have most
stuff in place except:
- VECTOR FP (MAXIMUM|MINIMUM): needs some manual work to cover all types of
                               comparisons.

Once we have that in place, we can convert the QEMU machine to a
stripped-down z14.

v1 -> v2:
- "s390x/cpu_model: S390_FEAT_MISC_INSTRUCTION_EXT ->
   S390_FEAT_MISC_INSTRUCTION_EXT2"
-- Added
- "s390x/tcg: Implement BRANCH INDIRECT ON CONDITION (BIC)"
-- Use new helper instead
- "s390x/tcg: Implement MULTIPLY SINGLE (MSC, MSGC, MSGRKC, MSRKC)"
-- Tune comparisons in CC computation

David Hildenbrand (9):
  s390x/cpu_model: S390_FEAT_MISC_INSTRUCTION_EXT ->
    S390_FEAT_MISC_INSTRUCTION_EXT2
  s390x/tcg: Implement ADD HALFWORD (AGH)
  s390x/tcg: Implement SUBTRACT HALFWORD (SGH)
  s390x/tcg: Implement MULTIPLY (MG, MGRK)
  s390x/tcg: Implement MULTIPLY HALFWORD (MGH)
  s390x/tcg: Implement BRANCH INDIRECT ON CONDITION (BIC)
  s390x/tcg: Implement MULTIPLY SINGLE (MSC, MSGC, MSGRKC, MSRKC)
  s390x/tcg: We support Miscellaneous-Instruction-Extensions Facility 2
  s390x/tcg: Implement CIPHER MESSAGE WITH AUTHENTICATION (KMA)

 target/s390x/cc_helper.c            | 32 +++++++++++++++++++
 target/s390x/cpu_features_def.h.inc |  2 +-
 target/s390x/gen-features.c         |  4 ++-
 target/s390x/helper.c               |  2 ++
 target/s390x/insn-data.def          | 12 ++++++++
 target/s390x/internal.h             |  2 ++
 target/s390x/translate.c            | 48 +++++++++++++++++++++++++++++
 7 files changed, 100 insertions(+), 2 deletions(-)

-- 
2.26.2


