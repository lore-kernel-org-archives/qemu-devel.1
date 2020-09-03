Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5970BC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E212067C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+H/YyRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E212067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDiI2-0004mq-32
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 02:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDiGO-000498-K9
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:58:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45460
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDiGM-0008Vu-Fo
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599112700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5VwSrIVIz9D8spM0xDGSHbdw7OI8e2TK9wogAJ/Dsw=;
 b=W+H/YyRR5SEQq92RmMBLDwpjByRGpb35rfAHIhx5LsRL/OT/DlFqoAmnWpuMXQNwTeZjsz
 TGIkDHhAcMAUtF2Hw+8IFvxjNMyp7OgaKhy8/656rwESwmRzrsG+p8iigHORn7rz9Ww0py
 ZnizOFUWOOhTFtQe5aTkygbqCz4PRTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-QmR3uIoJOhSSAUV2fKMxPg-1; Thu, 03 Sep 2020 01:58:19 -0400
X-MC-Unique: QmR3uIoJOhSSAUV2fKMxPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 472A9801AE6;
 Thu,  3 Sep 2020 05:58:18 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-90.ams2.redhat.com [10.36.112.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68F4587B33;
 Thu,  3 Sep 2020 05:58:17 +0000 (UTC)
Subject: Re: [PATCH 5/6] tests: handling signal on win32 properly
To: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo
 <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-6-luoyonggang@gmail.com>
 <26c3fe4a-009e-dfa2-f824-515f470924b1@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c9e56ee7-1938-7fdc-f2fe-b905a7ede189@redhat.com>
Date: Thu, 3 Sep 2020 07:58:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <26c3fe4a-009e-dfa2-f824-515f470924b1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/2020 19.04, Paolo Bonzini wrote:
> On 02/09/20 19:00, Yonggang Luo wrote:
>> SIGABRT should use signal(SIGABRT, sigabrt_handler) to handle on win32
>>
>> The error:
>> E:/CI-Cor-Ready/xemu/qemu.org/tests/test-replication.c:559:33: error: invalid use of undefined type 'struct sigaction'
>>   559 |     sigact = (struct sigaction) {
>>       |                                 ^
>>
>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>> ---
>>  tests/test-replication.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tests/test-replication.c b/tests/test-replication.c
>> index e0b03dafc2..9ab3666a90 100644
>> --- a/tests/test-replication.c
>> +++ b/tests/test-replication.c
>> @@ -554,6 +554,9 @@ static void sigabrt_handler(int signo)
>>  
>>  static void setup_sigabrt_handler(void)
>>  {
>> +#ifdef _WIN32
>> +    signal(SIGABRT, sigabrt_handler);
>> +#else
>>      struct sigaction sigact;
>>  
>>      sigact = (struct sigaction) {
>> @@ -562,6 +565,7 @@ static void setup_sigabrt_handler(void)
>>      };
>>      sigemptyset(&sigact.sa_mask);
>>      sigaction(SIGABRT, &sigact, NULL);
>> +#endif
>>  }
>>  
>>  int main(int argc, char **argv)
>>
> 
> This is already fixed by a patch from Thomas.

Well, my patch was to simply disable test-replication on Windows ... if
it is working with this modification here, that's certainly better than
disabling it.

 Thomas


