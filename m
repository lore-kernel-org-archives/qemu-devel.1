Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04DCC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F3A2074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyAcnKsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F3A2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR5d-0002a4-L6
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR07-0002IB-Ku
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35292
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR06-0006qU-NW
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7aysy7LnzzU/PowJNv/vyjVqjvAz/h8eLbGuZ+OSeO4=;
 b=OyAcnKsyHIEC+qIaQGyWnUeA2mc8+DHPl7cODUexvoc4KdTvCxg8uUaZdOXmi54q28FUTF
 g0i1tijkl6IdB6t+Qg+SaheupCBU1bDLr1ANEUZKRXiGKfzxlCrJPTRSFLIUdValYYg7Lg
 4gqy7Y1U+Cia326+WnEEpYIhl0tw2is=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-8CTkyKwTN3-RV-OIcULHpQ-1; Sun, 31 May 2020 12:39:52 -0400
X-MC-Unique: 8CTkyKwTN3-RV-OIcULHpQ-1
Received: by mail-wr1-f70.google.com with SMTP id p10so3619681wrn.19
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7aysy7LnzzU/PowJNv/vyjVqjvAz/h8eLbGuZ+OSeO4=;
 b=SScVdRbmzbJD6aUuH6pvvAHlAa8uCcsrAqHKPnEc94eB/kLNQeAOcqGKEwUam8exWx
 kyTUEl8kyA2NdyAJrt26vSwj3uibC+rPU8Ie76pi2rQ9lo4hw6AyiA71Gc9AAevqvCo1
 zxTocw5iUJdMtGgkD03eZ4Pue56bYL1kO1V1NvZg9XGB82XoZ5JGPLsLKtDcvDElBwdB
 F51JggJUAaGMDzdzetx2soS4a2dZAXuOk3zlyBfEbEJFAgqpcyfp+PFahVPgzBEaD9aN
 KLhBZBE1/ZMmkl+GoGNXKyFDADkMX3+7SWMWumiYGgLN8uZArqqDTG/1Ab9g7XRNRKr+
 JsZA==
X-Gm-Message-State: AOAM531KDTPx46SXuFyf5qgH2CvyxOjAUJvbJvO7X71SrvJDmSgD6vac
 Uo9AOpBv2N5GX6ZMCGZgpld3B6TpBHPUSUu4ubsc7bWIBbhMZ0aO+XJlBglg43fBrPOeid89Gim
 fGqV6K7yYbXAzreo=
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr18047619wml.150.1590943190881; 
 Sun, 31 May 2020 09:39:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyk81obw3iwl5cmks4QKQu+FzG80vqvlMOpxZsa5rTowYPRYxGfXszL5E/IQCa/DUJwBl8aug==
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr18047608wml.150.1590943190702; 
 Sun, 31 May 2020 09:39:50 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id q1sm5415572wmc.15.2020.05.31.09.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:39:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/25] python/qemu: remove Python2 style super() calls
Date: Sun, 31 May 2020 18:38:33 +0200
Message-Id: <20200531163846.25363-13-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:39:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Use the Python3 style instead.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200514055403.18902-12-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py |  2 +-
 python/qemu/qtest.py   | 15 +++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 187790ce9e..95a20a17f9 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -55,7 +55,7 @@ def __init__(self, reply):
             desc = reply["error"]["desc"]
         except KeyError:
             desc = reply
-        super(MonitorResponseError, self).__init__(desc)
+        super().__init__(desc)
         self.reply = reply
 
 
diff --git a/python/qemu/qtest.py b/python/qemu/qtest.py
index 53d814c064..7943487c2b 100644
--- a/python/qemu/qtest.py
+++ b/python/qemu/qtest.py
@@ -101,29 +101,28 @@ def __init__(self, binary, args=None, name=None, test_dir="/var/tmp",
             name = "qemu-%d" % os.getpid()
         if sock_dir is None:
             sock_dir = test_dir
-        super(QEMUQtestMachine,
-              self).__init__(binary, args, name=name, test_dir=test_dir,
-                             socket_scm_helper=socket_scm_helper,
-                             sock_dir=sock_dir)
+        super().__init__(binary, args, name=name, test_dir=test_dir,
+                         socket_scm_helper=socket_scm_helper,
+                         sock_dir=sock_dir)
         self._qtest = None
         self._qtest_path = os.path.join(sock_dir, name + "-qtest.sock")
 
     def _base_args(self):
-        args = super(QEMUQtestMachine, self)._base_args()
+        args = super()._base_args()
         args.extend(['-qtest', 'unix:path=' + self._qtest_path,
                      '-accel', 'qtest'])
         return args
 
     def _pre_launch(self):
-        super(QEMUQtestMachine, self)._pre_launch()
+        super()._pre_launch()
         self._qtest = QEMUQtestProtocol(self._qtest_path, server=True)
 
     def _post_launch(self):
-        super(QEMUQtestMachine, self)._post_launch()
+        super()._post_launch()
         self._qtest.accept()
 
     def _post_shutdown(self):
-        super(QEMUQtestMachine, self)._post_shutdown()
+        super()._post_shutdown()
         self._remove_if_exists(self._qtest_path)
 
     def qtest(self, cmd):
-- 
2.21.3


