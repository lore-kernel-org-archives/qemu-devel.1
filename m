Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DD7C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D852C2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yz5OJimB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D852C2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZVlz-0001Ar-1G
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 04:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZVkj-0007oF-HR
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:31:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49261
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZVki-0001Bp-HY
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589531490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wwNgXYhhmY/8BWRz8sIHPYWmoDl8j5qmpuI5ndILTtg=;
 b=Yz5OJimBTKSuoYNHhtfT2390eDesjNlKJRK9sJPHMuEHbavZ+/hdFXCViFfjsOiC7S+/F/
 TTQNfLP+QJTUr5As8lVHUEtPp8LraBl3pROUsmAHzSbpC3+CDkLYkUfPqS8AFB6bPnzs/v
 3oTbxoWf5ASthpkDUqMMNgR9vqBo+Lw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-b3n8aqTzPoeHyHsYYE6WYg-1; Fri, 15 May 2020 04:31:27 -0400
X-MC-Unique: b3n8aqTzPoeHyHsYYE6WYg-1
Received: by mail-wm1-f71.google.com with SMTP id 23so815719wma.8
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 01:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wwNgXYhhmY/8BWRz8sIHPYWmoDl8j5qmpuI5ndILTtg=;
 b=gN4+ys5OEMNer/hV7ID+1DM50DssppdGN0SayF1VSMkmmpYCLOxisq9FrV8Tn7xWZ4
 KJuGHW5+za2p+XWQSq1AT9Ajz5hL9K/TOtmGUREHNhLbl2eKUc/sfFhfltGTH6co4giZ
 5ydKznghGqVQGy0go91YONR2ZfwEKbBh159HQOeo9EisO+5c4foAAn6h0zjk5dlrEPyp
 1W3JIzZBTYRjdE9q2JaJcT/FzU2mW61wbbVUDfh7tMLwT0THA+m9W8eVgQITLg+h77yQ
 5UCkQDWUAY03+YfksEQ/+g7P3NAVU/4Sgil3fVdRnmXHVG2dofJuCfn5T8EmW+rO4+mf
 RYnw==
X-Gm-Message-State: AOAM5333tR9H+JE9kOy+Df81JB+9sLmEVpvllEoGVy7SsAYFhdjlSsLA
 8yXgnSsG1g+qV2f+enuowr17/j2qK/VLjAGmWq7vhvkfpgcq6Z8liP9oFdenvPK2C1vv3e38dzo
 g4AqHYseAB/4W/Xg=
X-Received: by 2002:a1c:7407:: with SMTP id p7mr2947922wmc.114.1589531485995; 
 Fri, 15 May 2020 01:31:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQpEF4io0ucyyRRKxBSnez7Gkl40pumTtRn1RG0QPb+19eHrTsIkaUBSaXgLqh9xqS4VQEeg==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr2947903wmc.114.1589531485790; 
 Fri, 15 May 2020 01:31:25 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id n17sm2452313wrr.42.2020.05.15.01.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 01:31:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] tests: Remove unused bison/flex packages
Date: Fri, 15 May 2020 10:31:22 +0200
Message-Id: <20200515083124.5536-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I was misguided by libdtc warnings, and thought bison/flex
were required to build QEMU, so installed them in docker
(and they also ended in the VM scripts).

Claudio's series "libfdt: build only the strict necessary"
even silents the warnings.

Based-on: <20200514193811.6798-1-cfontana@suse.de>

Philippe Mathieu-Daudé (2):
  tests/docker: Remove flex/bison packages
  tests/vm: Remove flex/bison packages

 tests/docker/dockerfiles/centos7.docker             | 2 --
 tests/docker/dockerfiles/centos8.docker             | 2 --
 tests/docker/dockerfiles/debian-xtensa-cross.docker | 2 --
 tests/docker/dockerfiles/debian10.docker            | 2 --
 tests/docker/dockerfiles/debian9.docker             | 2 --
 tests/docker/dockerfiles/fedora.docker              | 2 --
 tests/docker/dockerfiles/ubuntu.docker              | 2 +-
 tests/docker/dockerfiles/ubuntu1804.docker          | 2 +-
 tests/vm/fedora                                     | 1 -
 tests/vm/freebsd                                    | 1 -
 tests/vm/netbsd                                     | 1 -
 tests/vm/ubuntu.i386                                | 2 +-
 12 files changed, 3 insertions(+), 18 deletions(-)

-- 
2.21.3


