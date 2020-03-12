Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37052C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38DC206EB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWZunL/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38DC206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTfr-0004yh-2p
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jCTdd-00074e-HK
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jCTdc-0007sH-0k
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:37:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29622
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jCTdb-0007s9-TE
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584041819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPizTgORafpKHefddcD0j2V6GIQK6ROg5iFW9mvYRmY=;
 b=KWZunL/mgmAdT4QLGEYaSq91VGy1VIGKhlh1k0WhuN35EGfWVL9RNo5xocRyQ2c8PGnsnM
 HhZHPPvZgZpYTHTI1EMALTUNmExOTVhyesjlfWbYVi4C+A7PVWjc8RWYpHhsQiS3f8sK46
 Rwc9R5NhTHuyvz7H492HQgjBY8XpbdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-mwYTm12SOric2lx0YNd8zA-1; Thu, 12 Mar 2020 15:36:56 -0400
X-MC-Unique: mwYTm12SOric2lx0YNd8zA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C31E19251A9;
 Thu, 12 Mar 2020 19:36:55 +0000 (UTC)
Received: from dhcp-17-173.bos.redhat.com (dhcp-17-173.bos.redhat.com
 [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5D075C1B5;
 Thu, 12 Mar 2020 19:36:53 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH 4/5] GitLab Gating CI: introduce pipeline-status contrib script
Date: Thu, 12 Mar 2020 15:36:15 -0400
Message-Id: <20200312193616.438922-5-crosa@redhat.com>
In-Reply-To: <20200312193616.438922-1-crosa@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
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
 contrib/ci/scripts/gitlab-pipeline-status | 148 ++++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100755 contrib/ci/scripts/gitlab-pipeline-status

diff --git a/contrib/ci/scripts/gitlab-pipeline-status b/contrib/ci/scripts=
/gitlab-pipeline-status
new file mode 100755
index 0000000000..83d412daec
--- /dev/null
+++ b/contrib/ci/scripts/gitlab-pipeline-status
@@ -0,0 +1,148 @@
+#!/usr/bin/env python3
+
+"""
+Checks the GitLab pipeline status for a given commit commit
+"""
+
+# pylint: disable=3DC0103
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
+    result =3D subprocess.run(['git', 'rev-parse', 'staging'],
+                            stdin=3Dsubprocess.DEVNULL,
+                            stdout=3Dsubprocess.PIPE,
+                            stderr=3Dsubprocess.DEVNULL,
+                            cwd=3Dos.path.dirname(__file__),
+                            universal_newlines=3DTrue).stdout.strip()
+    if result =3D=3D 'staging':
+        raise ValueError("There's no local staging branch")
+    if len(result) !=3D 40:
+        raise ValueError("Branch staging HEAD doesn't look like a sha1")
+    return result
+
+
+def get_pipeline_status(project_id, commit_sha1):
+    """
+    Returns the JSON content of the pipeline status API response
+    """
+    url =3D '/api/v4/projects/{}/pipelines?sha=3D{}'.format(project_id,
+                                                        commit_sha1)
+    connection =3D http.client.HTTPSConnection('gitlab.com')
+    connection.request('GET', url=3Durl)
+    response =3D connection.getresponse()
+    if response.code !=3D http.HTTPStatus.OK:
+        raise ValueError("Failed to receive a successful response")
+    json_response =3D json.loads(response.read())
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
+    start =3D time.time()
+    while True:
+        if time.time() >=3D (start + timeout):
+            print("Waiting on the pipeline success timed out")
+            return False
+
+        status =3D get_pipeline_status(project_id, commit_sha)
+        if status['status'] =3D=3D 'running':
+            time.sleep(interval)
+            print('running...')
+            continue
+
+        if status['status'] =3D=3D 'success':
+            return True
+
+        msg =3D "Pipeline ended unsuccessfully, check: %s" % status['web_u=
rl']
+        print(msg)
+        return False
+
+
+def main():
+    """
+    Script entry point
+    """
+    parser =3D argparse.ArgumentParser(
+        prog=3D'pipeline-status',
+        description=3D'check or wait on a pipeline status')
+
+    parser.add_argument('-t', '--timeout', type=3Dint, default=3D7200,
+                        help=3D('Amount of time (in seconds) to wait for t=
he '
+                              'pipeline to complete.  Defaults to '
+                              '%(default)s'))
+    parser.add_argument('-i', '--interval', type=3Dint, default=3D60,
+                        help=3D('Amount of time (in seconds) to wait betwe=
en '
+                              'checks of the pipeline status.  Defaults '
+                              'to %(default)s'))
+    parser.add_argument('-w', '--wait', action=3D'store_true', default=3DF=
alse,
+                        help=3D('Wether to wait, instead of checking only =
once '
+                              'the status of a pipeline'))
+    parser.add_argument('-p', '--project-id', type=3Dint, default=3D111676=
99,
+                        help=3D('The GitLab project ID. Defaults to the pr=
oject '
+                              'for https://gitlab.com/qemu-project/qemu, t=
hat '
+                              'is, "%(default)s"'))
+    try:
+        default_commit =3D get_local_staging_branch_commit()
+        commit_required =3D False
+    except ValueError:
+        default_commit =3D ''
+        commit_required =3D True
+    parser.add_argument('-c', '--commit', required=3Dcommit_required,
+                        default=3Ddefault_commit,
+                        help=3D('Look for a pipeline associated with the g=
iven '
+                              'commit.  If one is not explicitly given, th=
e '
+                              'commit associated with the local branch nam=
ed '
+                              '"staging" is used.  Default: %(default)s'))
+    parser.add_argument('--verbose', action=3D'store_true', default=3DFals=
e,
+                        help=3D('A minimal verbosity level that prints the=
 '
+                              'overall result of the check/wait'))
+
+    args =3D parser.parse_args()
+
+    try:
+        if args.wait:
+            success =3D wait_on_pipeline_success(
+                args.timeout,
+                args.interval,
+                args.project_id,
+                args.commit)
+        else:
+            status =3D get_pipeline_status(args.project_id,
+                                         args.commit)
+            success =3D status['status'] =3D=3D 'success'
+    except Exception as error:      # pylint: disable=3DW0703
+        success =3D False
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
+if __name__ =3D=3D '__main__':
+    main()
--=20
2.24.1


