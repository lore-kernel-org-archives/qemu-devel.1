Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDA7C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2528A206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnvOKmZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2528A206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMtV-0006Zp-8e
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMIe-0002iQ-TC
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMIc-0004ga-Ks
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601649881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uykOgynNts6E/sSjfE5c4/k8sztkFS90XZIRLsJnFVQ=;
 b=OnvOKmZA9X/jQHdDBd2BF32wchg8NQRka8GUYq322zT6wXAnoNcuXgwzoK+GU8ZMFJHJeX
 XN9xbUj+9nl4XQAS0P6H/D/cCnfV9zPPn6r4Pr2JQSHIebIYAH4k97cX6t6o8+UlBJnnuG
 c7dFHaOCrIHuvULIlpwu5MDXeGO5VnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-j7mcX8nkP2uq9yC3TrjG5g-1; Fri, 02 Oct 2020 10:44:39 -0400
X-MC-Unique: j7mcX8nkP2uq9yC3TrjG5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 366B981CAFA;
 Fri,  2 Oct 2020 14:44:38 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-112-139.ams2.redhat.com
 [10.36.112.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43D255D9D3;
 Fri,  2 Oct 2020 14:44:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 33/37] iotests: Introduce qemu_nbd_list_log()
Date: Fri,  2 Oct 2020 16:43:41 +0200
Message-Id: <20201002144345.253865-34-kwolf@redhat.com>
In-Reply-To: <20201002144345.253865-1-kwolf@redhat.com>
References: <20201002144345.253865-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a function to list the NBD exports offered by an NBD server.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200924152717.287415-30-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index f7ad0c1395..9695c917e4 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -65,7 +65,8 @@ if os.environ.get('QEMU_IO_OPTIONS_NO_FMT'):
     qemu_io_args_no_fmt += \
         os.environ['QEMU_IO_OPTIONS_NO_FMT'].strip().split(' ')
 
-qemu_nbd_args = [os.environ.get('QEMU_NBD_PROG', 'qemu-nbd')]
+qemu_nbd_prog = os.environ.get('QEMU_NBD_PROG', 'qemu-nbd')
+qemu_nbd_args = [qemu_nbd_prog]
 if os.environ.get('QEMU_NBD_OPTIONS'):
     qemu_nbd_args += os.environ['QEMU_NBD_OPTIONS'].strip().split(' ')
 
@@ -280,6 +281,13 @@ def qemu_nbd_early_pipe(*args: str) -> Tuple[int, str]:
                                                    connect_stderr=False)
     return returncode, output if returncode else ''
 
+def qemu_nbd_list_log(*args: str) -> str:
+    '''Run qemu-nbd to list remote exports'''
+    full_args = [qemu_nbd_prog, '-L'] + list(args)
+    output, _ = qemu_tool_pipe_and_status('qemu-nbd', full_args)
+    log(output, filters=[filter_testfiles, filter_nbd_exports])
+    return output
+
 @contextmanager
 def qemu_nbd_popen(*args):
     '''Context manager running qemu-nbd within the context'''
@@ -413,6 +421,9 @@ def filter_qmp_imgfmt(qmsg):
         return value
     return filter_qmp(qmsg, _filter)
 
+def filter_nbd_exports(output: str) -> str:
+    return re.sub(r'((min|opt|max) block): [0-9]+', r'\1: XXX', output)
+
 
 Msg = TypeVar('Msg', Dict[str, Any], List[Any], str)
 
-- 
2.25.4


