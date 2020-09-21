Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5A7C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC393221EC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1OIydOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC393221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKNBg-0004Ti-VJ
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKN8M-0001eg-8R
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKN8K-0006qH-9l
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600699775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s+svlnk7NA0CKsBAmsy9xPORizPjATc2TL13wdBWfSg=;
 b=a1OIydOBCRq0HAPoZHSvgUc8znUNeN8fF72PudD1BoroXg6U7iBH/Z+wDHwW0tZQlQimaG
 1PkElPyrGU0C+tOR87xBPzAmnW8lFkRroB1g2UYdfAhp5G2DNg/6d+xCa8/dtbJwk4H+wP
 jtTHzTJELcjLAVidt7eg5cNGCAER+Tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-_zeg38CDPmGf4lxY1vbZ8g-1; Mon, 21 Sep 2020 10:49:16 -0400
X-MC-Unique: _zeg38CDPmGf4lxY1vbZ8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 892A28015A5;
 Mon, 21 Sep 2020 14:49:14 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 187666115F;
 Mon, 21 Sep 2020 14:49:12 +0000 (UTC)
Subject: Re: Bottleneck problem to merge Python patches
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "crosa@redhat.com" <crosa@redhat.com>, Lukas Straub <lukasstraub2@web.de>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
 <20200828104102.4490-2-ahmedkhaledkaraman@gmail.com>
 <CAL1e-=iA95PR-mM9E+nfsvFRJLhQsj5Q9qPAM=7QS9mg-QvcbQ@mail.gmail.com>
 <6ad83ff4-1b4f-69f0-7dbe-85680e2f403e@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <524f04de-7d1c-ffba-0445-02f82ab6e2ca@redhat.com>
Date: Mon, 21 Sep 2020 10:49:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6ad83ff4-1b4f-69f0-7dbe-85680e2f403e@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: "ldoktor@redhat.com" <ldoktor@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Ben Widawsky <ben@bwidawsk.net>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 "aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/20 7:17 AM, Philippe Mathieu-Daudé wrote:
> Hi Aleksandar,
> 
> (extending the Cc list to broader audience)
> 
> On 9/18/20 10:33 PM, Aleksandar Markovic wrote:
>>
>> On Friday, August 28, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com
>> <mailto:ahmedkhaledkaraman@gmail.com>> wrote:
>>
>>      - Apply pylint and flake8 formatting rules to the script.
>>      - Use 'tempfile' instead of '/tmp' for creating temporary files.
>>
>>      ---
>>
>> Hello, folks.
>>
>> This series seems forgotten. Can some of you perhaps take a look,
>> review, and possibly integrate some patches in a pull request?
>>
>> Ahmed invested quite of time to improve the functionality and quality of
>> scripts, and they are truly useful for developers interested in
>> performance measurement.
> 

Hi, I will add it to my queue. I intended to take over Python 
maintenance but I have been busy refactoring the QAPI python code and 
haven't been reading my mail as regularly.

> The Python patches are indeed being merged slowly, but are not
> forgotten :) Eduardo sent just a pull request *yesterday* for
> patches he had queued *before* QEMU 5.1, that is more than 1 year
> ago!
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg742228.html
> 
> I hope he will be able to process the other Python patches sent
> the last 12 months. He raised the problem few month ago saying he
> was overwhelmed and was looking for help from the community.
> Cleber helped a pair of times, I helped once, but then nobody
> popped up volunteering.
> 
> I agree this is a community problem, nobody wants to become the
> de-facto Python maintainer. Current maintainers are already busy
> solving problem with low-level languages such C.
> As a project, QEMU is evolving, using more and more Python, switched
> to Meson, we might have Rust code too. Learning that for current
> maintainers takes time. I guess we lack new contributors/maintainers
> with interest in Python & QEMU.
> 

I'm volunteering, since I am doing so much work in Python. I could use a 
dedicated reviewer to help me, however. I prefer a maintainer policy 
where all patches get at least ONE review by someone other than the 
primary author.

In the case that I am writing so much Python, I still need a 
co-maintainer to help review *my* patches.

> This is my simple/rough analysis, as John had the same problem
> 2/3 months ago, his patches were on the list unreviewed for various
> weeks. Same problem with Avocado patches, Lukas sent a series a bit
> before Ahmed and it is still unreviewed:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg737272.html
> 
> Alex Bennée recently said:
> 
>   "review time is the currency of qemu-devel ;-)"
> 
> We might be failing at explaining new contributors the importance
> of peer-review, as this helps a lot maintainers. It is described
> in the wiki but maybe new contributors don't read it, we don't
> remember them to:
> https://wiki.qemu.org/Contribute/SubmitAPatch#Participating_in_Code_Review
> and:
> https://wiki.qemu.org/Contribute/SubmitAPatch#Return_the_favor
> 
> My 2 cents...
> 
> Regards,
> 
> Phil.
> 
>>
>> Thanks,
>> Aleksandar
> 


