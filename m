Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9445C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:04:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA65206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwP687BX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA65206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONXL-0004lt-7E
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kONQo-00080a-Sq
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kONQh-0006Ti-NP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601654227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jD08GHLw1dN5FJ/1MiB6++eGHLu7lu6c2UpUB2upZAU=;
 b=FwP687BXh4ccp2mzEXx4zI38fkzXkqLxSZyz670qLr0RJKupil/OloBz/C0BPB/PaVSgXF
 0qGj60cA+Vhqiih0iz6IcQlU5eWEGCgxEt1HsIJ1yy3TVU4Ngt1w3l9s5sQ1K0Vk1kDwdV
 QK4IG3MH25kJMc2QImiz7wbj5WTd9vc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-Mk9apIXfPw-Nk4I3OIx6Sg-1; Fri, 02 Oct 2020 11:57:05 -0400
X-MC-Unique: Mk9apIXfPw-Nk4I3OIx6Sg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 540AE18B9EC3;
 Fri,  2 Oct 2020 15:57:04 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-90.ams2.redhat.com [10.36.112.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2E6C5DF58;
 Fri,  2 Oct 2020 15:56:55 +0000 (UTC)
Subject: Re: [PATCH] gitlab-ci.yml: Only run one test-case per fuzzer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20201002143524.56930-1-alxndr@bu.edu>
 <6564a712-71e5-460b-c9d6-1d2c245ff6ea@redhat.com>
 <746477ee-01db-e52b-8348-c42aad18e9da@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <aec1f5d0-1d2f-5d20-cd11-a4c5c30ffb61@redhat.com>
Date: Fri, 2 Oct 2020 17:56:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <746477ee-01db-e52b-8348-c42aad18e9da@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/2020 17.53, Philippe Mathieu-Daudé wrote:
> On 10/2/20 5:15 PM, Thomas Huth wrote:
>> On 02/10/2020 16.35, Alexander Bulekov wrote:
>>> With 1000 runs, there is a non-negligible chance that the fuzzer can
>>> trigger a crash. With this CI job, we care about catching build/runtime
>>> issues in the core fuzzing code. Actual device fuzzing takes place on
>>> oss-fuzz. For these purposes, only running one input should be
>>> sufficient.
>>>
>>> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>>> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>  .gitlab-ci.yml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index a51c89554f..075c15d45c 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -303,7 +303,7 @@ build-oss-fuzz:
>>>                        | grep -v slirp); do
>>>          grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || continue ;
>>>          echo Testing ${fuzzer} ... ;
>>> -        "${fuzzer}" -runs=1000 -seed=1 || exit 1 ;
>>> +        "${fuzzer}" -runs=1 -seed=1 || exit 1 ;
>>
>> ... but we're apparently already using a fixed seed for running the
>> test, so it should be pretty much deterministic, shouldn't it? So the
>> chance that the fuzzer hits a crash here for a pre-existing problem
>> should be close to zero? ... so I'm not quite sure whether we really
>> need this?
> 
> You are right, "non-negligible chance that the fuzzer can trigger a
> crash" shouldn't be a problem. What matters is we don't waste CI
> resources, 1 run is enough to test the fuzzer is working.

Ok, considering that gitlab is currently thinking about limiting the
free CI minutes, that's a valid reason, indeed.

 Thomas


