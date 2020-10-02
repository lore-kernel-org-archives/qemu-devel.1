Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E83C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA97206C1
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6r3XwVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA97206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOFdq-0001L3-CS
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 03:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOFcF-0000Eg-Gy
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOFcD-0003n5-N4
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601624188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JqCLMkqBYj754181eZJ8yJ6p2u3RwNxOA4vmvwiEdvk=;
 b=P6r3XwVjTJk8ya9lVhitUCmuaJOzv101PqcAHFqT4nzZP+HZCLMDXtXo6bXgah84hz+0Wf
 nTGhzNQc7KHknPuMxCIYD4kgQqWIHDIGAPtNuJTvJVifC0anOYbeT0AKukJ4xmt5tSoof7
 gmXuXv7MhdWedJxHrjnLoNKzMVeQkh8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-AXBEoOE5PYOwMwMZfhy8RQ-1; Fri, 02 Oct 2020 03:36:25 -0400
X-MC-Unique: AXBEoOE5PYOwMwMZfhy8RQ-1
Received: by mail-wr1-f69.google.com with SMTP id b2so233412wrs.7
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 00:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JqCLMkqBYj754181eZJ8yJ6p2u3RwNxOA4vmvwiEdvk=;
 b=OCYFYuznA9hPr9HcLqQI0YzXbsFN+XzmPM7iEBDDv7Ydy6Ewk26IaN7uNCbJ8R1FhW
 9hHyngmzcqeq5NnoOz9LrzRxjxOPyIvNl/X9YbDdy0h1EfIeIHMez8BIwpwtIs/vnBXk
 cRFytDhVWWFz1H6RqZvrH4Nqnb+Z3IoGa16gvvh58L2i4NK17EHBs/qqB/dCOibVkyRu
 Du3L/SQS8ehrdms473nNraQytTQQ0615IzAEIjiY7K5dComS8UIJi030L1xjf/H07Q/c
 I8owPL/oLQqHcMQzVswn22bpauLXXjCpLftE4Bbul91TlJt/wMosI54BgJtC8X3K0Cf0
 xlxw==
X-Gm-Message-State: AOAM532BTp/HAvWzrjI91fKrL5TtEeQGk2Zfu2OudrimSCXvD9F963g6
 xTjNMPjhtYMI/Z9T6jsum3pqqIOuaXgxKRQsTzOvMNDKHn8uRBCfb+u1GWjHMbCipz5c2UTo0ZZ
 AevW93PtGYyqi/ZQ=
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr1301689wmh.106.1601624184224; 
 Fri, 02 Oct 2020 00:36:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUbu8NfvCw/b5dq3GOkswir7KxmzP46GOMWTlbV8aTHIeiY3Ky21awAKPL1KFgcI5Ie8fudw==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr1301662wmh.106.1601624183947; 
 Fri, 02 Oct 2020 00:36:23 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id q12sm725004wrs.48.2020.10.02.00.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 00:36:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/1] user-mode: Prune build dependencies (part 3)
Date: Fri,  2 Oct 2020 09:36:20 +0200
Message-Id: <20201002073621.1653924-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the third part of a series reducing user-mode
dependencies. By stripping out unused code, the build
and testing time is reduced (as is space used by objects).

Part 3:
- Reduce user-mode QAPI generated files

Since v3:
- Keep qdev.json in user-mode (no need for qdev-system
  stub for qapi_event_send_device_deleted, Paolo)
- Keep machine.json in user-mode (no need to restrict
  X86CPUFeatureWord to x86 architecture, Eduardo)

Since v2:
- Fixed UuidInfo placed in incorrect json
- Rebased on Meson
- Include X86CPUFeatureWord unmerged from part 2

Since v1:
- Addressed Richard and Paolo review comments

v3: https://www.mail-archive.com/qemu-devel@nongnu.org/msg746423.html
v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg688879.html
v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg688486.html

Based on https://github.com/ehabkost/qemu.git machine-next

Philippe Mathieu-Daudé (1):
  qapi: Restrict code generated for user-mode

 qapi/meson.build | 51 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 15 deletions(-)

-- 
2.26.2


