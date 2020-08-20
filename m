Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E45C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 02:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D844207DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 02:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RstBmykx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D844207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Zs8-0004Fs-Fv
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 22:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8ZrL-0003q5-Tt
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 21:59:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56279
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8ZrJ-0005bR-Gu
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 21:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597888756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G96u0vkIPlqbldARBmecxhNdWLFNp1x5JbxhpJsYriw=;
 b=RstBmykxRe0zbM7xor2xNoMQHdYNwicbJVxj5ndwhEP+MQQzmEV+mnCQg5RZH1R4JzzrsD
 D2cKrpQ1vyF9l+NZfDvdORIR3ck0344F75MQ4KsBQzFuA4545Gpm6wSpLzdWEGRw2KiUQa
 y+IfOpynChGrP5JBnUi9K8+wOvaSMmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-Hk78k_TCPfW8vUw0qpflIg-1; Wed, 19 Aug 2020 21:59:01 -0400
X-MC-Unique: Hk78k_TCPfW8vUw0qpflIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12AEF8030A7;
 Thu, 20 Aug 2020 01:59:00 +0000 (UTC)
Received: from [10.3.112.136] (ovpn-112-136.phx2.redhat.com [10.3.112.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E1BE709DC;
 Thu, 20 Aug 2020 01:58:58 +0000 (UTC)
Subject: Re: [PATCH v4 4/4] iotests: Test node/bitmap aliases during migration
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200818133240.195840-1-mreitz@redhat.com>
 <20200818133240.195840-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <fe00acc5-a06f-5e65-63f6-5f0ed7ec3019@redhat.com>
Date: Wed, 19 Aug 2020 20:58:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818133240.195840-5-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:32 AM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/300     | 595 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/300.out |   5 +

Rather sparse output (I hate debugging those sorts of outputs when the 
test is failing).

>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 601 insertions(+)
>   create mode 100755 tests/qemu-iotests/300
>   create mode 100644 tests/qemu-iotests/300.out
> 

> +        # Dirty some random megabytes
> +        for _ in range(9):
> +            mb_ofs = random.randrange(1024)
> +            self.vm_a.hmp_qemu_io(self.src_node_name, f'write {mb_ofs}M 1M')

It turns out that the discard operation likewise dirties the bitmap, but 
slightly faster (see edb90bbd).  We could optimize it on top, but I'm 
not going to require a micro-optimizing to get it in.  The test takes 
about 12 seconds to run for me, but you didn't mark it as such in 
'group', so that's good; but it turns up a problem:

300      fail       [20:55:54] [20:56:06]                    output 
mismatch (see 300.out.bad)
--- /home/eblake/qemu-tmp2/tests/qemu-iotests/300.out	2020-08-19 
20:53:11.087791988 -0500
+++ /home/eblake/qemu-tmp2/tests/qemu-iotests/300.out.bad	2020-08-19 
20:56:06.092428756 -0500
@@ -1,5 +1,41 @@
-.....................................
+WARNING:qemu.machine:qemu received signal 11; command: 
"/home/eblake/qemu-tmp2/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 
-display none -vga none -chardev 
socket,id=mon,path=/tmp/tmp.qT831UThme/qemu-b-798452-monitor.sock -mon 
chardev=mon,mode=control -qtest 
unix:path=/tmp/tmp.qT831UThme/qemu-b-798452-qtest.sock -accel qtest 
-nodefaults -display none -accel qtest -blockdev 
node-name=node0,driver=null-co -incoming unix:/tmp/tmp.qT831UThme/mig_sock"
+.............FE.......................
+======================================================================
+ERROR: test_migratee_bitmap_is_not_mapped_on_dst 
(__main__.TestBlockBitmapMappingErrors)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File 
"/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/machine.py", 
line 435, in _do_shutdown
+    self._soft_shutdown(timeout, has_quit)
+  File 
"/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/machine.py", 
line 415, in _soft_shutdown
+    self._qmp.cmd('quit')
+  File 
"/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/qmp.py", 
line 266, in cmd
+    return self.cmd_obj(qmp_cmd)
+  File 
"/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/qmp.py", 
line 246, in cmd_obj
+    self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
+BrokenPipeError: [Errno 32] Broken pipe
+
+The above exception was the direct cause of the following exception:
+
+Traceback (most recent call last):
+  File "300", line 76, in tearDown
+    self.vm_b.shutdown()
+  File 
"/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/machine.py", 
line 465, in shutdown
+    self._do_shutdown(timeout, has_quit)
+  File 
"/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/machine.py", 
line 438, in _do_shutdown
+    raise AbnormalShutdown("Could not perform graceful shutdown") \
+qemu.machine.AbnormalShutdown: Could not perform graceful shutdown
+
+======================================================================
+FAIL: test_migratee_bitmap_is_not_mapped_on_dst 
(__main__.TestBlockBitmapMappingErrors)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "300", line 384, in test_migratee_bitmap_is_not_mapped_on_dst
+    self.migrate(False)
+  File "300", line 99, in migrate
+    self.assertEqual(self.vm_a.wait_migration('postmigrate'),
+AssertionError: False != True
+
  ----------------------------------------------------------------------
  Ran 37 tests

-OK
+FAILED (failures=1, errors=1)

I'm not sure why I'm seeing that, but it looks like you've got a bad 
deref somewhere in the alias code.

> +class TestLongBitmapNames(TestAliasMigration):
> +    # Giving long bitmap names is OK, as long as there is a short alias for
> +    # migration
> +    src_bmap_name = 'a' * 512
> +    dst_bmap_name = 'b' * 512

This part's new compared to v3 ;)  Looks like you've made several 
enhancements.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


