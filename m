Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8C7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 02:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 585D62065D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 02:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2Ozja1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585D62065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtMcS-0008O2-Fm
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 22:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jtMae-0006FQ-LG
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 22:47:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29544
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jtMac-00089i-9j
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 22:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594262829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Y5eZiMdEJ0SKo7WG2X6MchZqCGukcs0EJ8cVlQ9Iro=;
 b=f2Ozja1vgXw6nhok0fms98bwj4O7KAWzTpjN7pXeTHbRaACzASqvO0aGN4kinhfV5ZgTqA
 dJNRsgaEPkqALYN6fvvhL4jHuphQU9lE46s2wBmgmFRjzs0bZncXxG8Bbw8DnXp7JiSKqS
 JoR+x8rfwelE36q1tXBNbDB/QKAHI3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-IKeuzAlhOumGiqX-FFe-EQ-1; Wed, 08 Jul 2020 22:47:05 -0400
X-MC-Unique: IKeuzAlhOumGiqX-FFe-EQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 771B580183C;
 Thu,  9 Jul 2020 02:47:04 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37FCC61981;
 Thu,  9 Jul 2020 02:47:03 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/2] GitLab Gating CI: introduce pipeline-status contrib
 script
Date: Wed,  8 Jul 2020 22:46:56 -0400
Message-Id: <20200709024657.2500558-2-crosa@redhat.com>
In-Reply-To: <20200709024657.2500558-1-crosa@redhat.com>
References: <20200709024657.2500558-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This script is intended to be used right after a push to a branch.

By default, it will look for the pipeline associated with the commit
that is the HEAD of the *local* staging branch.  It can be used as a
one time check, or with the `--wait` option to wait until the pipeline
completes.

If the pipeline is successful, then a merge of the staging branch into
the master branch should be the next step.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/ci/gitlab-pipeline-status | 156 ++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100755 scripts/ci/gitlab-pipeline-status

diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pipeline-status
new file mode 100755
index 0000000000..4a9de39872
--- /dev/null
+++ b/scripts/ci/gitlab-pipeline-status
@@ -0,0 +1,156 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) 2019-2020 Red Hat, Inc.
+#
+# Author:
+#  Cleber Rosa <crosa@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+"""
+Checks the GitLab pipeline status for a given commit commit
+"""
+
+# pylint: disable=C0103
+
+import argparse
+import http.client
+import json
+import os
+import subprocess
+import time
+import sys
+
+
+def get_local_staging_branch_commit():
+    """
+    Returns the commit sha1 for the *local* branch named "staging"
+    """
+    result = subprocess.run(['git', 'rev-parse', 'staging'],
+                            stdin=subprocess.DEVNULL,
+                            stdout=subprocess.PIPE,
+                            stderr=subprocess.DEVNULL,
+                            cwd=os.path.dirname(__file__),
+                            universal_newlines=True).stdout.strip()
+    if result == 'staging':
+        raise ValueError("There's no local staging branch")
+    if len(result) != 40:
+        raise ValueError("Branch staging HEAD doesn't look like a sha1")
+    return result
+
+
+def get_pipeline_status(project_id, commit_sha1):
+    """
+    Returns the JSON content of the pipeline status API response
+    """
+    url = '/api/v4/projects/{}/pipelines?sha={}'.format(project_id,
+                                                        commit_sha1)
+    connection = http.client.HTTPSConnection('gitlab.com')
+    connection.request('GET', url=url)
+    response = connection.getresponse()
+    if response.code != http.HTTPStatus.OK:
+        raise ValueError("Failed to receive a successful response")
+    json_response = json.loads(response.read())
+    # afaict, there should one one pipeline for the same project + commit
+    # if this assumption is false, we can add further filters to the
+    # url, such as username, and order_by.
+    if not json_response:
+        raise ValueError("No pipeline found")
+    return json_response[0]
+
+
+def wait_on_pipeline_success(timeout, interval,
+                             project_id, commit_sha):
+    """
+    Waits for the pipeline to end up to the timeout given
+    """
+    start = time.time()
+    while True:
+        if time.time() >= (start + timeout):
+            print("Waiting on the pipeline success timed out")
+            return False
+
+        status = get_pipeline_status(project_id, commit_sha)
+        if status['status'] == 'running':
+            time.sleep(interval)
+            print('running...')
+            continue
+
+        if status['status'] == 'success':
+            return True
+
+        msg = "Pipeline ended unsuccessfully, check: %s" % status['web_url']
+        print(msg)
+        return False
+
+
+def main():
+    """
+    Script entry point
+    """
+    parser = argparse.ArgumentParser(
+        prog='pipeline-status',
+        description='check or wait on a pipeline status')
+
+    parser.add_argument('-t', '--timeout', type=int, default=7200,
+                        help=('Amount of time (in seconds) to wait for the '
+                              'pipeline to complete.  Defaults to '
+                              '%(default)s'))
+    parser.add_argument('-i', '--interval', type=int, default=60,
+                        help=('Amount of time (in seconds) to wait between '
+                              'checks of the pipeline status.  Defaults '
+                              'to %(default)s'))
+    parser.add_argument('-w', '--wait', action='store_true', default=False,
+                        help=('Wether to wait, instead of checking only once '
+                              'the status of a pipeline'))
+    parser.add_argument('-p', '--project-id', type=int, default=11167699,
+                        help=('The GitLab project ID. Defaults to the project '
+                              'for https://gitlab.com/qemu-project/qemu, that '
+                              'is, "%(default)s"'))
+    try:
+        default_commit = get_local_staging_branch_commit()
+        commit_required = False
+    except ValueError:
+        default_commit = ''
+        commit_required = True
+    parser.add_argument('-c', '--commit', required=commit_required,
+                        default=default_commit,
+                        help=('Look for a pipeline associated with the given '
+                              'commit.  If one is not explicitly given, the '
+                              'commit associated with the local branch named '
+                              '"staging" is used.  Default: %(default)s'))
+    parser.add_argument('--verbose', action='store_true', default=False,
+                        help=('A minimal verbosity level that prints the '
+                              'overall result of the check/wait'))
+
+    args = parser.parse_args()
+
+    try:
+        if args.wait:
+            success = wait_on_pipeline_success(
+                args.timeout,
+                args.interval,
+                args.project_id,
+                args.commit)
+        else:
+            status = get_pipeline_status(args.project_id,
+                                         args.commit)
+            success = status['status'] == 'success'
+    except Exception as error:      # pylint: disable=W0703
+        success = False
+        if args.verbose:
+            print("ERROR: %s" % error.args[0])
+
+    if success:
+        if args.verbose:
+            print('success')
+        sys.exit(0)
+    else:
+        if args.verbose:
+            print('failure')
+        sys.exit(1)
+
+
+if __name__ == '__main__':
+    main()
-- 
2.25.4


