Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643EFC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4AF2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoc9Uhcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4AF2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is5Ef-0003eG-1g
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 08:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1is5Da-0002hI-0y
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:29:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1is5DW-0006Na-D2
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:29:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57736
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1is5DW-0006NN-9J
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579181385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=kLYH5idgcfxeXPqfIOkh8MBOjpfYpTfwpfARPIyydx0=;
 b=eoc9UhcjTyDL4jIOErt02DegN+bmyw+Vqyg5W39sRAxWnmN5+CcOVhGSmlA+yh5Fk55C+s
 N4AxUbxkvI5yplq0mIIdd8copYSv5NpqndTM7DRWTbx0zNAExg1n+Hm0HF+VybjdOjI07u
 l7WCWpfs1Koz8eFeIP8copWSPF8h6sc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-vaoiJ1OTPiOXi9x5P-Ybug-1; Thu, 16 Jan 2020 08:29:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 955B7800EBF;
 Thu, 16 Jan 2020 13:29:43 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-204-105.brq.redhat.com [10.40.204.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82FE05D9C9;
 Thu, 16 Jan 2020 13:29:41 +0000 (UTC)
Subject: Re: [PATCH V2] vhost-user-test: fix a memory leak
From: Thomas Huth <thuth@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
References: <1576805214-2508-1-git-send-email-pannengyuan@huawei.com>
 <072970b5-b7cc-ad71-d3e4-933e888b7093@redhat.com>
 <3312978e-2bff-091a-b618-d9183b8c7252@redhat.com>
 <b0a705c0-c734-c431-f8de-475c293092d2@huawei.com>
 <c51b9011-9add-9dc3-6fdd-266ae4f81bc9@huawei.com>
 <126ca72f-6a3a-a3bf-1202-0acb631a9b5f@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c53b8605-b422-ead2-37b4-f3883668850f@redhat.com>
Date: Thu, 16 Jan 2020 14:29:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <126ca72f-6a3a-a3bf-1202-0acb631a9b5f@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: vaoiJ1OTPiOXi9x5P-Ybug-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: lvivier@redhat.com, pbonzini@redhat.com, zhang.zhanghailiang@huawei.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/01/2020 10.13, Thomas Huth wrote:
> On 15/01/2020 04.10, Pan Nengyuan wrote:
>>
>> On 1/13/2020 10:32 AM, Pan Nengyuan wrote:
>>>
>>> On 1/12/2020 6:39 PM, Thomas Huth wrote:
> [...]
>>>> ... and now I had to unqueue the patch again. It is reproducibly causing
>>>> one of the gitlab CI pipelines to fail with a timeout, e.g.:
>>>>
>>>>  https://gitlab.com/huth/qemu/-/jobs/400101552
>>>>
>>>> Not sure what is going on here, though, there is no obvious error
>>>> message in the output... this needs some more investigation... do you
>>>> have a gitlab account and could have a look?
>>>>
>>>
>>> OK, I will register a account and have a look.
>>>
>>
>> I'm sorry, I build and test with the same params, but I can't reproduce it.
>> Could you add "V=1 or V=2" params to get more information ?
> 
> It seems to hang forever in qos-test
> /arm/virt/virtio-mmio/virtio-bus/virtio-net-device/virtio-net/virtio-net-tests/announce-self
> :
> 
>  https://gitlab.com/huth/qemu/-/jobs/403472594
> 
> It's completely weird, I also added some fprintf statements:
> 
>  https://gitlab.com/huth/qemu/commit/8ae76c0cf37cf46d26620dd
> 
> ... but none of them show up in the output of the test run... so I'm
> currently completely puzzled what might be going wrong here... Any other
> ideas what we could try here?

I tried to add some more fprintfs here and there to see where it hangs,
but I did not succeed to get any further.

However, the CI build succeeds with this fix instead:

diff a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -707,9 +707,9 @@ static void test_read_guest_mem(void *obj, void
*arg, QGuestAllocator *alloc)
 static void test_migrate(void *obj, void *arg, QGuestAllocator *alloc)
 {
     TestServer *s = arg;
-    TestServer *dest = test_server_new("dest");
-    GString *dest_cmdline = g_string_new(qos_get_current_command_line());
-    char *uri = g_strdup_printf("%s%s", "unix:", dest->mig_path);
+    TestServer *dest;
+    GString *dest_cmdline;
+    char *uri;
     QTestState *to;
     GSource *source;
     QDict *rsp;
@@ -720,6 +720,10 @@ static void test_migrate(void *obj, void *arg,
QGuestAllocator *alloc)
         return;
     }

+    dest = test_server_new("dest");
+    dest_cmdline = g_string_new(qos_get_current_command_line());
+    uri = g_strdup_printf("%s%s", "unix:", dest->mig_path);
+
     size = get_log_size(s);
     g_assert_cmpint(size, ==, (256 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));

@@ -778,6 +782,7 @@ static void test_migrate(void *obj, void *arg,
QGuestAllocator *alloc)
     qtest_quit(to);
     test_server_free(dest);
     g_free(uri);
+    g_string_free(dest_cmdline, true);
 }


Here's a build with that patch that succeeded:

 https://gitlab.com/huth/qemu/-/jobs/405357307

So if you agree with that patch, I think we should simply use that
version instead, ok?

 Thomas


