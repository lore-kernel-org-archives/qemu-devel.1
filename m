Received: from eggs.gnu.org ([2001:4830:134:3::10]:48039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eFMcv-0004tf-2X
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eFMcp-0005Rx-A3
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:02:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42814
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eFMcp-0005RR-47
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:02:47 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAGG1JkT096247
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 11:02:41 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e9bwhy5g7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 11:02:34 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 16 Nov 2017 16:02:29 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 16 Nov 2017 17:02:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c5a52fe7-b256-105b-df88-0c7c5e105207@de.ibm.com>
Subject: [Qemu-devel] 2 bytes of memory leaking due to MigrationParameters
 unshadowing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Markus,

valgrind complains about the following two 1 byte memory leaks during migration:


==40773== 1 bytes in 1 blocks are definitely lost in loss record 3 of 2,127
==40773==    at 0x4834E60: malloc (vg_replace_malloc.c:299)
==40773==    by 0x18B1A177: g_malloc (in /usr/lib64/libglib-2.0.so.0.5000.3)
==40773==    by 0x18B376E1: g_strdup (in /usr/lib64/libglib-2.0.so.0.5000.3)
==40773==    by 0x11B0B9B: migrate_params_test_apply (migration.c:864)
==40773==    by 0x11B0B9B: qmp_migrate_set_parameters (migration.c:989)
==40773==    by 0x11312D7: qmp_marshal_migrate_set_parameters (qmp-marshal.c:2032)
==40773==    by 0x12EA891: do_qmp_dispatch (qmp-dispatch.c:104)
==40773==    by 0x12EA891: qmp_dispatch (qmp-dispatch.c:131)
==40773==    by 0x106256F: handle_qmp_command (monitor.c:3840)
==40773==    by 0x12F0863: json_message_process_token (json-streamer.c:105)
==40773== 
==40773== 1 bytes in 1 blocks are definitely lost in loss record 4 of 2,127
==40773==    at 0x4834E60: malloc (vg_replace_malloc.c:299)
==40773==    by 0x18B1A177: g_malloc (in /usr/lib64/libglib-2.0.so.0.5000.3)
==40773==    by 0x18B376E1: g_strdup (in /usr/lib64/libglib-2.0.so.0.5000.3)
==40773==    by 0x11B0BC5: migrate_params_test_apply (migration.c:869)
==40773==    by 0x11B0BC5: qmp_migrate_set_parameters (migration.c:989)
==40773==    by 0x11312D7: qmp_marshal_migrate_set_parameters (qmp-marshal.c:2032)
==40773==    by 0x12EA891: do_qmp_dispatch (qmp-dispatch.c:104)
==40773==    by 0x12EA891: qmp_dispatch (qmp-dispatch.c:131)
==40773==    by 0x106256F: handle_qmp_command (monitor.c:3840)
==40773==    by 0x12F0863: json_message_process_token (json-streamer.c:105)


Looks like that commit 1bda8b3c6950f74482ba19e8529db72b511ba977 ("migration: Unshare 
MigrationParameters struct for now") created the _g_strdup leak.

It certainly is not important at all, but I wanted to report it nevertheless.

Christian
