Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63978C33CB3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B342073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B342073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isFlC-00006L-Au
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 19:45:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1isFkM-00087h-Bv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1isFkK-00050F-W5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:44:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2735 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1isFkK-0004xY-LR
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:44:20 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id BBFED6ECD1802B13797D;
 Fri, 17 Jan 2020 08:44:14 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 17 Jan
 2020 08:44:07 +0800
Subject: Re: [PATCH V2] vhost-user-test: fix a memory leak
To: Thomas Huth <thuth@redhat.com>
References: <1576805214-2508-1-git-send-email-pannengyuan@huawei.com>
 <072970b5-b7cc-ad71-d3e4-933e888b7093@redhat.com>
 <3312978e-2bff-091a-b618-d9183b8c7252@redhat.com>
 <b0a705c0-c734-c431-f8de-475c293092d2@huawei.com>
 <c51b9011-9add-9dc3-6fdd-266ae4f81bc9@huawei.com>
 <126ca72f-6a3a-a3bf-1202-0acb631a9b5f@redhat.com>
 <c53b8605-b422-ead2-37b4-f3883668850f@redhat.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <19f0e2fe-356b-8910-7180-6a98dcc2e5f1@huawei.com>
Date: Fri, 17 Jan 2020 08:44:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c53b8605-b422-ead2-37b4-f3883668850f@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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



On 1/16/2020 9:29 PM, Thomas Huth wrote:
> On 15/01/2020 10.13, Thomas Huth wrote:
>> On 15/01/2020 04.10, Pan Nengyuan wrote:
>>>
>>> On 1/13/2020 10:32 AM, Pan Nengyuan wrote:
>>>>
>>>> On 1/12/2020 6:39 PM, Thomas Huth wrote:
>> [...]
>>>>> ... and now I had to unqueue the patch again. It is reproducibly causing
>>>>> one of the gitlab CI pipelines to fail with a timeout, e.g.:
>>>>>
>>>>>  https://gitlab.com/huth/qemu/-/jobs/400101552
>>>>>
>>>>> Not sure what is going on here, though, there is no obvious error
>>>>> message in the output... this needs some more investigation... do you
>>>>> have a gitlab account and could have a look?
>>>>>
>>>>
>>>> OK, I will register a account and have a look.
>>>>
>>>
>>> I'm sorry, I build and test with the same params, but I can't reproduce it.
>>> Could you add "V=1 or V=2" params to get more information ?
>>
>> It seems to hang forever in qos-test
>> /arm/virt/virtio-mmio/virtio-bus/virtio-net-device/virtio-net/virtio-net-tests/announce-self
>> :
>>
>>  https://gitlab.com/huth/qemu/-/jobs/403472594
>>
>> It's completely weird, I also added some fprintf statements:
>>
>>  https://gitlab.com/huth/qemu/commit/8ae76c0cf37cf46d26620dd
>>
>> ... but none of them show up in the output of the test run... so I'm
>> currently completely puzzled what might be going wrong here... Any other
>> ideas what we could try here?
> 
> I tried to add some more fprintfs here and there to see where it hangs,
> but I did not succeed to get any further.
> 
> However, the CI build succeeds with this fix instead:
> 
> diff a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -707,9 +707,9 @@ static void test_read_guest_mem(void *obj, void
> *arg, QGuestAllocator *alloc)
>  static void test_migrate(void *obj, void *arg, QGuestAllocator *alloc)
>  {
>      TestServer *s = arg;
> -    TestServer *dest = test_server_new("dest");
> -    GString *dest_cmdline = g_string_new(qos_get_current_command_line());
> -    char *uri = g_strdup_printf("%s%s", "unix:", dest->mig_path);
> +    TestServer *dest;
> +    GString *dest_cmdline;
> +    char *uri;
>      QTestState *to;
>      GSource *source;
>      QDict *rsp;
> @@ -720,6 +720,10 @@ static void test_migrate(void *obj, void *arg,
> QGuestAllocator *alloc)
>          return;
>      }
> 
> +    dest = test_server_new("dest");
> +    dest_cmdline = g_string_new(qos_get_current_command_line());
> +    uri = g_strdup_printf("%s%s", "unix:", dest->mig_path);
> +
>      size = get_log_size(s);
>      g_assert_cmpint(size, ==, (256 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
> 
> @@ -778,6 +782,7 @@ static void test_migrate(void *obj, void *arg,
> QGuestAllocator *alloc)
>      qtest_quit(to);
>      test_server_free(dest);
>      g_free(uri);
> +    g_string_free(dest_cmdline, true);
>  }
> 
> 
> Here's a build with that patch that succeeded:
> 
>  https://gitlab.com/huth/qemu/-/jobs/405357307
> 
> So if you agree with that patch, I think we should simply use that
> version instead, ok?

Ok, I agree with it.

Thanks.

> 
>  Thomas
> 
> .
> 

