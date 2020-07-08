Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A8420708
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdOgXVHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A8420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIJd-0000WQ-5b
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jtHlK-0005v7-P7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:37:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jtHlI-0003Ls-QE
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yt7m2kqSaXPvwE8XugjXNjsKEjPT/tiPJCT5i+NZ8Qk=;
 b=MdOgXVHF2STBrwHEuOPT7bHd0DkBMzBA+iKNtp7Vi9SCDjlZoy56mIPmFCDEWzC+C1GjQt
 EFFCnQLtfp86ImQIvFRkYs194B5nQ2ZfPHAGG2GZ2qwnVnhLAy35SvtcM3Y71k6agSXTbA
 3vv97HhvGjETpBsTHg+wtHpNOqhMQ0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481--ao7au6vM2ea7ZB5gBjcSA-1; Wed, 08 Jul 2020 16:37:10 -0400
X-MC-Unique: -ao7au6vM2ea7ZB5gBjcSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 041788014D7;
 Wed,  8 Jul 2020 20:37:09 +0000 (UTC)
Received: from [10.3.115.46] (ovpn-115-46.phx2.redhat.com [10.3.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54E8B1001B0B;
 Wed,  8 Jul 2020 20:37:08 +0000 (UTC)
Subject: Re: [PATCH v7 00/47] block: Deal with filters
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <4d7fa326-ef87-5753-cc2a-bb26fc555864@virtuozzo.com>
 <e51d9c26-bd94-bf8e-cfed-82db15243188@redhat.com>
 <54c4b18b-b6ee-b506-b153-b44eb3879da2@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d866ace7-09c9-430e-53f8-ecf12d08b0a4@redhat.com>
Date: Wed, 8 Jul 2020 15:37:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <54c4b18b-b6ee-b506-b153-b44eb3879da2@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 2:46 PM, Andrey Shinkevich wrote:
> 
> On 08.07.2020 20:32, Eric Blake wrote:
>> On 7/8/20 12:20 PM, Andrey Shinkevich wrote:
>>> On 25.06.2020 18:21, Max Reitz wrote:
>>>> v6: 
>>>> https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg01715.html
>>>>
>>>> Branch: https://github.com/XanClic/qemu.git child-access-functions-v7
>>>> Branch: https://git.xanclic.moe/XanClic/qemu.git 
>>>> child-access-functions-v7
>>>>
>>>>
>>> I cloned the branch from the github and built successfully.
>>>
>>> Running the iotests reports multiple errors of such a kind:
>>>
>>> 128: readarray -td '' formatting_line < <(sed -e 's/, fmt=/\x0/')
>>>
>>> "./common.filter: line 128: readarray: -d: invalid option"
>>>
>>
>> Arrgh. If I'm reading bash's changelog correctly, readarray -d was 
>> introduced in bash 4.4, so I'm guessing you're still on 4.3 or 
>> earlier? What bash version and platform are you using?
>>
> My bash version is 4.2.46.
> 
> It is the latest in the virtuozzolinux-base repository. I should install 
> the 4.4 package manually.

Well, if bash 4.2 is the default installed version on any of our 
platforms that meet our supported criteria, then we should instead fix 
the patch in question to avoid non-portable use of readarray.

Per https://repology.org/project/bash/versions (hinted from 
docs/system/build-platforms.rst), at least CentOS 7 still ships bash 
4.2, and per 'make docker', centos7 is still a viable build target.  So 
we do indeed need to fix our regression.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


