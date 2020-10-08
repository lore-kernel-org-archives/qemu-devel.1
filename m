Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E281C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B7E21D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVOe7RAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B7E21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYPT-0006G5-Py
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 12:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQYC1-00070L-HK
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQYBy-0002jK-77
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602172253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6MTm9GZUU94JUI9HFeqfI2EzkRE/Yym1IGbvVhzy8w4=;
 b=YVOe7RAwTS2/sDRANQE+9eu43S+Q81jTUWgsNWwuwrbaeF9rF/AwiSopVwUBM+HmuNARSB
 alnH90hKlgMDzTBcWDSkZY19xPUP604ASivJVMvs8KKjRzXn+xEQmXCVZmtNiqJ6Gzx9th
 AZ/vsWmX1JKh/6aQ0wuR0sfor8TNI2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-6lJCEpcfO0SA18-KMS-3Bg-1; Thu, 08 Oct 2020 11:50:52 -0400
X-MC-Unique: 6lJCEpcfO0SA18-KMS-3Bg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79C618030A3;
 Thu,  8 Oct 2020 15:50:50 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7AF85C1BD;
 Thu,  8 Oct 2020 15:50:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 09/10] iotests: add support for capturing and matching QMP
 events
Date: Thu,  8 Oct 2020 16:50:00 +0100
Message-Id: <20201008155001.3357288-10-berrange@redhat.com>
In-Reply-To: <20201008155001.3357288-1-berrange@redhat.com>
References: <20201008155001.3357288-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using the _launch_qemu and _send_qemu_cmd functions from
common.qemu, any QMP events get mixed in with the output from
the commands and responses.

This makes it difficult to write a test case as the ordering
of events in the output is not stable.

This introduces a variable 'capture_events' which can be set
to a list of event names. Any events listed in this variable
will not be printed, instead collected in the $QEMU_EVENTS
environment variable.

A new '_wait_event' function can be invoked to collect events
at a fixed point in time. The function will first pull events
cached in $QEMU_EVENTS variable, and if none are found, will
then read more from QMP.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/common.qemu | 107 ++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qemu
index de680cf1c7..87d7a54001 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -53,6 +53,15 @@ _in_fd=4
 # If $mismatch_only is set, only non-matching responses will
 # be echoed.
 #
+# If $capture_events is non-empty, then any QMP event names it lists
+# will not be echoed out, but instead collected in the $QEMU_EVENTS
+# variable. The _wait_event function can later be used to received
+# the cached events.
+#
+# If $only_capture_events is set to anything but an empty string,
+# when an error will be raised if a QMP message is seen which is
+# not an event listed in $capture_events.
+#
 # If $success_or_failure is set, the meaning of the arguments is
 # changed as follows:
 # $2: A string to search for in the response; if found, this indicates
@@ -78,6 +87,32 @@ _timed_wait_for()
     QEMU_STATUS[$h]=0
     while IFS= read -t ${QEMU_COMM_TIMEOUT} resp <&${QEMU_OUT[$h]}
     do
+        if [ -n "$capture_events" ]; then
+            capture=0
+            local evname
+            for evname in $capture_events
+            do
+                grep -q "\"event\": \"${evname}\"" < <(echo "${resp}")
+                if [ $? -eq 0 ]; then
+                    capture=1
+                fi
+            done
+            if [ $capture = 1 ];
+            then
+                ev=$(echo "${resp}" | tr -d '\r' | tr % .)
+                QEMU_EVENTS="${QEMU_EVENTS:+${QEMU_EVENTS}%}${ev}"
+                if [ -n "$only_capture_events" ]; then
+                    return
+                else
+                    continue
+                fi
+            fi
+        fi
+        if [ -n "$only_capture_events" ]; then
+            echo "Only expected $capture_events but got ${resp}"
+            exit 1
+        fi
+
         if [ -z "${silent}" ] && [ -z "${mismatch_only}" ]; then
             echo "${resp}" | _filter_testdir | _filter_qemu \
                            | _filter_qemu_io | _filter_qmp | _filter_hmp
@@ -177,12 +212,82 @@ _send_qemu_cmd()
         let count--;
     done
     if [ ${QEMU_STATUS[$h]} -ne 0 ] && [ -z "${qemu_error_no_exit}" ]; then
-        echo "Timeout waiting for ${1} on handle ${h}"
+        echo "Timeout waiting for command ${1} response on handle ${h}"
         exit 1 #Timeout means the test failed
     fi
 }
 
 
+# Check event cache for a named QMP event
+#
+# Input parameters:
+# $1:       Name of the QMP event to check for
+#
+# Checks if the named QMP event that was previously captured
+# into $QEMU_EVENTS. When matched, the QMP event will be echoed
+# and the $matched variable set to 1.
+#
+# _wait_event is more suitable for test usage in most cases
+_check_cached_events()
+{
+    local evname=${1}
+
+    local match="\"event\": \"$evname\""
+
+    matched=0
+    if [ -n "$QEMU_EVENTS" ]; then
+        CURRENT_QEMU_EVENTS=$QEMU_EVENTS
+        QEMU_EVENTS=
+        old_IFS=$IFS
+        IFS="%"
+        for ev in $CURRENT_QEMU_EVENTS
+        do
+                grep -q "$match" < <(echo "${ev}")
+            if [ $? -eq 0 -a $matched = 0 ]; then
+                echo "${ev}" | _filter_testdir | _filter_qemu \
+                           | _filter_qemu_io | _filter_qmp | _filter_hmp
+                matched=1
+            else
+                QEMU_EVENTS="${QEMU_EVENTS:+${QEMU_EVENTS}%}${ev}"
+            fi
+        done
+        IFS=$old_IFS
+    fi
+}
+
+# Wait for a named QMP event
+#
+# Input parameters:
+# $1:       QEMU handle to use
+# $2:       Name of the QMP event to wait for
+#
+# Checks if the named QMP event that was previously captured
+# into $QEMU_EVENTS. If none are present, then waits for the
+# event to arrive on the QMP channel. When matched, the QMP
+# event will be echoed
+_wait_event()
+{
+    local h=${1}
+    local evname=${2}
+
+    while true
+    do
+        _check_cached_events $evname
+
+        if [ $matched = 1 ];
+        then
+            return
+        fi
+
+        only_capture_events=1 qemu_error_no_exit=1 _timed_wait_for ${h}
+
+        if [ ${QEMU_STATUS[$h]} -ne 0 ] ; then
+            echo "Timeout waiting for event ${evname} on handle ${h}"
+            exit 1 #Timeout means the test failed
+        fi
+    done
+}
+
 # Launch a QEMU process.
 #
 # Input parameters:
-- 
2.26.2


