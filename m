Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534E8C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0AE12396D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/9uiU2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AE12396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfbC-0005He-Rk
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKfaH-0003wo-17
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kKfaF-0006QU-9j
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600770698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SHG/AznOFCMT4rKY3pR9HG4Gd+sq0z+OmGOOHtPpKao=;
 b=G/9uiU2YvcNLguoo1t4txJirfCbX+f2Z7IOR9ullctTxSdmlGG4pqg1ple4+eUErQJHXXB
 ITxA1el8JWDnoCv27Ca19iYLSo5fuK0uJrZcqhWtpxBwlzoSBww8VChpFBHCysZ8quGMsD
 sLhZxJ7a/7LcIgmyPGL+mGIwffeOLFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-r-c3fOl7P16IKCIWLIz3Kg-1; Tue, 22 Sep 2020 06:31:36 -0400
X-MC-Unique: r-c3fOl7P16IKCIWLIz3Kg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17A8710BBEC0;
 Tue, 22 Sep 2020 10:31:35 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-20.ams2.redhat.com [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B87A027BD1;
 Tue, 22 Sep 2020 10:31:30 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/8] s390x/tcg: Implement some z14 facilities
Date: Tue, 22 Sep 2020 12:31:21 +0200
Message-Id: <20200922103129.12824-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
- VECTOR FP (NEGATIVE) MULTIPLY AND (ADD|SUBTRACT): needs float128_muladd()

Once we have that in place, we can convert the QEMU machine to a
stripped-down z14.

David Hildenbrand (8):
  s390x/tcg: Implement ADD HALFWORD (AGH)
  s390x/tcg: Implement SUBTRACT HALFWORD (SGH)
  s390x/tcg: Implement MULTIPLY (MG, MGRK)
  s390x/tcg: Implement MULTIPLY HALFWORD (MGH)
  s390x/tcg: Implement BRANCH INDIRECT ON CONDITION (BIC)
  s390x/tcg: Implement MULTIPLY SINGLE (MSC, MSGC, MSGRKC, MSRKC)
  s390x/tcg: We support Miscellaneous-Instruction-Extensions Facility 2
  s390x/tcg: Implement CIPHER MESSAGE WITH AUTHENTICATION (KMA)

 target/s390x/cc_helper.c    | 34 ++++++++++++++++++++++++++++
 target/s390x/gen-features.c |  2 ++
 target/s390x/helper.c       |  2 ++
 target/s390x/insn-data.def  | 12 ++++++++++
 target/s390x/internal.h     |  2 ++
 target/s390x/translate.c    | 45 +++++++++++++++++++++++++++++++++++++
 6 files changed, 97 insertions(+)

-- 
2.26.2


