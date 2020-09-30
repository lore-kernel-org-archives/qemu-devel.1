Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F2DC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90704206FC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IU7XY7Fk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90704206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdYA-0005nl-2M
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 10:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdW8-0003zg-5B
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdW4-0004Qy-GO
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:55:39 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YMlJkq8Z4aJfMjmJjchDs1gK/ZodpnpNf3wTU5ytBRg=;
 b=IU7XY7FkYVDoLTGanlHW0sWg2VuNHisw4OWZMqLMHjZy7/whTbCB2r4LFCSpULnvEb9IQ+
 wH4eB84VGmOBr8NPugilDZeHvVg4fPreW7r8JLgMsycx4Ekd0j2T/YEmdeCmvPH4gVxvTz
 DcYmz758mAsXbSnma6Gxxe3U9octNLs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-X2FJhjQSPZGfI9pKf31j1A-1; Wed, 30 Sep 2020 10:55:32 -0400
X-MC-Unique: X2FJhjQSPZGfI9pKf31j1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EADA1021203;
 Wed, 30 Sep 2020 14:55:30 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B11955C1C4;
 Wed, 30 Sep 2020 14:55:24 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 00/20] s390x/tcg: Implement Vector enhancements facility
 and switch to z14
Date: Wed, 30 Sep 2020 16:55:03 +0200
Message-Id: <20200930145523.71087-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds support for the "Vector enhancements facility" and bumps
the qemu CPU model tp to a stripped-down z14.

I yet have to find a way to get more test coverage - looks like some of
the functions aren't used anywhere yet (e.g., VECTOR FP MAXIMUM), writing
unit tests to cover all functions and cases is just nasty. But I might be
wrong - I'm planning to at least test basic functionality of all new added
instructions.

I have to make excessive use of c macros again to cover different element
sizes (32/64/128bit). Any advise to clean things up are welcome.

This is based on:
    "[PATCH v2 0/9] s390x/tcg: Implement some z14 facilities"
    "[PATCH v2 00/10] softfloat: Implement float128_muladd"

Based-on: 20200928122717.30586-1-david@redhat.com
Based-on: 20200925152047.709901-1-richard.henderson@linaro.org

David Hildenbrand (20):
  softfloat: Implement
    float128_(min|minnum|minnummag|max|maxnum|maxnummag)
  s390x/tcg: Implement VECTOR BIT PERMUTE
  s390x/tcg: Implement VECTOR MULTIPLY SUM LOGICAL
  s390x/tcg: Implement 32/128 bit for VECTOR FP ADD
  s390x/tcg: Implement 32/128 bit for VECTOR FP DIVIDE
  s390x/tcg: Implement 32/128 bit for VECTOR FP MULTIPLY
  s390x/tcg: Implement 32/128 bit for VECTOR FP SUBTRACT
  s390x/tcg: Implement 32/128 bit for VECTOR FP COMPARE (AND SIGNAL)
    SCALAR
  s390x/tcg: Implement 32/128 bit for VECTOR FP COMPARE *
  s390x/tcg: Implement 32/128 bit for VECTOR LOAD FP INTEGER
  s390x/tcg: Implement 64 bit for VECTOR FP LOAD LENGTHENED
  s390x/tcg: Implement 128 bit for VECTOR FP LOAD ROUNDED
  s390x/tcg: Implement 32/128 bit for VECTOR FP PERFORM SIGN OPERATION
  s390x/tcg: Implement 32/128 bit for VECTOR FP SQUARE ROOT
  s390x/tcg: Implement 32/128 bit for VECTOR FP TEST DATA CLASS
    IMMEDIATE
  s390x/tcg: Implement 32/128bit for VECTOR FP MULTIPLY AND
    (ADD|SUBTRACT)
  s390x/tcg: Implement VECTOR FP NEGATIVE MULTIPLY AND (ADD|SUBTRACT)
  s390x/tcg: Implement VECTOR FP (MAXIMUM|MINIMUM)
  s390x/tcg: We support Vector enhancements facility
  s390x/cpumodel: Bump up QEMU model to a stripped-down IBM z14 GA2

 fpu/softfloat.c                 |  100 +++
 hw/s390x/s390-virtio-ccw.c      |    2 +
 include/fpu/softfloat.h         |    6 +
 target/s390x/cpu_models.c       |    4 +-
 target/s390x/gen-features.c     |   14 +-
 target/s390x/helper.h           |   72 ++
 target/s390x/insn-data.def      |   12 +
 target/s390x/translate_vx.c.inc |  625 ++++++++++++---
 target/s390x/vec_fpu_helper.c   | 1302 ++++++++++++++++++++++---------
 target/s390x/vec_helper.c       |   22 +
 10 files changed, 1681 insertions(+), 478 deletions(-)

-- 
2.26.2


