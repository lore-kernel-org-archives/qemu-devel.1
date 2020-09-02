Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E85C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D292072A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sv4tNHqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D292072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDcCx-0001w5-JH
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDcBr-0008Oo-Da
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:29:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51265
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDcBo-0004yx-HB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599089354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eKBjtufo+Py/5PKR+EIdvGL5nBDyYHKVHUGRciUcxGA=;
 b=Sv4tNHqGEHdjXjWXrIlrmLd0weclJNrMp+yrhmrEvC09mVjFRCHnR3FDG8H/ZyIvICq3l9
 8pUVWPbl6S+QhjnSRKfFCtIyHBSGpY64tZ72WJPWWDqgB6yBKjuGRQHN/YqTdl0xvuTJAn
 9tGzL0VmdfvMUry8Y9Xd3Do/cFKFBXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-DdgvsyTjPyGO_LnKR7PfHg-1; Wed, 02 Sep 2020 19:29:09 -0400
X-MC-Unique: DdgvsyTjPyGO_LnKR7PfHg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F10A1074644;
 Wed,  2 Sep 2020 23:29:07 +0000 (UTC)
Received: from [10.3.113.128] (ovpn-113-128.phx2.redhat.com [10.3.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E25165C1C4;
 Wed,  2 Sep 2020 23:29:06 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] nbd: disable signals and forking on Windows builds
To: luoyonggang@gmail.com, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20200825103850.119911-1-berrange@redhat.com>
 <20200825103850.119911-4-berrange@redhat.com>
 <CAE2XoE_8E0gYBnPn9GtB94zQ4Rr+ihOi1gvw4mvnNj5CRxv6DA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7d2408f0-a0c3-ab1a-b836-90938cbe6f7b@redhat.com>
Date: Wed, 2 Sep 2020 18:29:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_8E0gYBnPn9GtB94zQ4Rr+ihOi1gvw4mvnNj5CRxv6DA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:54:07
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 5:07 PM, 罗勇刚(Yonggang Luo) wrote:
> On Tue, Aug 25, 2020 at 6:40 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
>> Disabling these parts are sufficient to get the qemu-nbd program
>> compiling in a Windows build.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   meson.build | 7 ++-----
>>   qemu-nbd.c  | 5 +++++
>>   2 files changed, 7 insertions(+), 5 deletions(-)

>> +++ b/qemu-nbd.c
>> @@ -899,6 +899,7 @@ int main(int argc, char **argv)
>>   #endif
>>
>>       if ((device && !verbose) || fork_process) {
>> +#ifndef WIN32
>>           int stderr_fd[2];
>>           pid_t pid;
>>           int ret;
>> @@ -962,6 +963,10 @@ int main(int argc, char **argv)
>>                */
>>               exit(errors);
>>           }
>> +#else /* WIN32 */
>> +        error_report("Unable to fork into background on Windows hosts");
>> +        exit(EXIT_FAILURE);
>> +#endif /* WIN32 */
>>       }
>>
> May us replace fork with alternative such as spawn?

You're certainly welcome to propose a patch along those lines, if 
spawning a task is a common Windows counterpart to the Unix notion of 
forking off a daemon.  But even requiring qemu-nbd to run in the 
foreground is already an improvement over what we had previously, so any 
change to use spawn will be a separate series, and will not hold up this 
one.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


