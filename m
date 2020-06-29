Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30375C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A1423CD1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Owuec2Dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A1423CD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsDX-0002zI-96
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jpsBF-0000Mw-Hz
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:42:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27845
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jpsBC-0005Lq-K0
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593430949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z/RkuIQuzK49gSskXus4OhUcVxCD4MLmT/3nETTyv/s=;
 b=Owuec2DdrjKp/JfadbIEt55XrdK/FTrJvRpDbEVKTfifHoGqlj+vwOQVRqz3moin40bzjy
 X1wiIk2D6Hm2AAmj7LzZmjpW8tApjL2x7Uykgx0yBepMbfFtWpz29m6StPErEVYfFVnaFV
 zwliuOzQ2z0XMN6Tutw9qxhL0c/bemQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-n2nuKfjHPUONQ-yRA55Vog-1; Mon, 29 Jun 2020 07:42:24 -0400
X-MC-Unique: n2nuKfjHPUONQ-yRA55Vog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54C8764AD4;
 Mon, 29 Jun 2020 11:42:23 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-140.ams2.redhat.com [10.36.112.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97645CF920;
 Mon, 29 Jun 2020 11:42:21 +0000 (UTC)
Subject: Re: [PATCH v3 29/30] gitlab: limit re-builds of the containers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
 <20200626181357.26211-30-alex.bennee@linaro.org>
 <20200629100350.GF1298906@redhat.com> <87pn9irxjz.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7240239e-813c-3c4b-7886-fe5e87c9b092@redhat.com>
Date: Mon, 29 Jun 2020 13:42:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87pn9irxjz.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 f4bug@amsat.org, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/06/2020 12.11, Alex Bennée wrote:
> 
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Fri, Jun 26, 2020 at 07:13:56PM +0100, Alex Bennée wrote:
>>> Most of the time we are just rebuilding the same things. We can skip
>>> this although currently there is no mechanism for picking up new
>>> distro releases.
>>>
>>> Rather than try to be too fine grained allow any change to trigger all
>>> the images being rebuilt.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>   .gitlab-ci.d/containers.yml | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
>>> index 20b2fb1de5d..f56aa44f711 100644
>>> --- a/.gitlab-ci.d/containers.yml
>>> +++ b/.gitlab-ci.d/containers.yml
>>> @@ -19,6 +19,10 @@
>>>       - docker push "$TAG"
>>>     after_script:
>>>       - docker logout
>>> +  only:
>>> +    changes:
>>> +      - .gitlab-ci.d/containers.yml
>>> +      - tests/docker/*
>>
>> How does this work for a person who forks the QEMU git repo and pushes
>> a change which doesn't touch the containers.yml file ?  AFAICT, all
>> their jobs will fail due to not having previously built any container
>> images in their brand new fork.
> 
> Hmm what we really need is a condition check to see if there is a local
> registry with images in it.

Maybe it would be good enough to do something like this instead:

   rules:
     - if: '$CI_COMMIT_BRANCH == "master"'
     - changes:
       - .gitlab-ci.d/containers.yml
       - tests/docker/*

... so that the pipeline is certainly run the first time when the master 
branch gets initialized? (I did not try it out, just had the idea after 
looking at the gitlab CI docs)

  Thomas


