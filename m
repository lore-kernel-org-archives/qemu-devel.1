Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF64C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318F720748
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5cKuz/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318F720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbHzz-0000T6-BH
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 02:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbHyn-00082z-UR
 for qemu-devel@nongnu.org; Wed, 20 May 2020 02:13:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57393
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbHym-0003eB-89
 for qemu-devel@nongnu.org; Wed, 20 May 2020 02:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589955200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=r83td15sC0ga/UCcxcWpsKHlDwmvxbTByAY9HXv8oh8=;
 b=K5cKuz/6x6bnOjKRO3+lN55hL9YIjAFjeUlvWDHTxFU8Qk+hVXyvzpjSa+A6+t+YkhlxuB
 iscEznNAiXrn9z/bZ7aMMZd1QEu7QLKT0YZGuGM5PdFpdRAmEIq7j6SIdCqIBbtj4usUIQ
 WfeDp4iHosNcryUZ22+S4Z3nn5T5EzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-mZCTI-J8Nkez9Nh7puBqXQ-1; Wed, 20 May 2020 02:13:17 -0400
X-MC-Unique: mZCTI-J8Nkez9Nh7puBqXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DC098005AA;
 Wed, 20 May 2020 06:13:16 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-114.ams2.redhat.com [10.36.112.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 104BB1001920;
 Wed, 20 May 2020 06:13:08 +0000 (UTC)
Subject: Re: QEMU 5.1: Can we require each new device/machine to provided a
 test?
To: John Snow <jsnow@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <CAAdtpL7gSqz+R5LfbvsuxeeCzf1K-omHSeYo2eTOFYaMS1bp6A@mail.gmail.com>
 <96440c8b-7f38-8fc4-0e9c-07ad878211e2@redhat.com>
 <20200515102321.GH1300305@redhat.com>
 <613f5cf5-7019-7447-6ba1-8050ab05303a@redhat.com>
 <20200519090441.GD2003821@redhat.com>
 <166b5fd7-2583-fdb1-6fb6-fd6b64e92d7f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a2ea3cf1-fbc0-2525-742d-11d6633160ad@redhat.com>
Date: Wed, 20 May 2020 08:13:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <166b5fd7-2583-fdb1-6fb6-fd6b64e92d7f@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-discuss@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/05/2020 01.06, John Snow wrote:
> 
> 
> On 5/19/20 5:04 AM, Daniel P. Berrangé wrote:
>> On Mon, May 18, 2020 at 03:56:36PM -0400, John Snow wrote:
>>>
>>>
>>> On 5/15/20 6:23 AM, Daniel P. Berrangé wrote:
>>>> On Fri, May 15, 2020 at 12:11:17PM +0200, Thomas Huth wrote:
>>>>> On 07/04/2020 12.59, Philippe Mathieu-Daudé wrote:
>>>>>> Hello,
>>>>>>
>>>>>> Following Markus thread on deprecating unmaintained (untested) code
>>>>>> (machines) [1] and the effort done to gather the information shared in
>>>>>> the replies [2], and the various acceptance tests added, is it
>>>>>> feasible to require for the next release that each new device/machine
>>>>>> is provided a test covering it?
>>>>>>
>>>>>> If no, what is missing?
>>>>>
>>>>> If a qtest is feasible, yes, I think we should require one for new
>>>>> devices. But what about machines - you normally need a test image for
>>>>> this. In that case, there is still the question where testing images
>>>>> could be hosted. Not every developer has a web space where they could
>>>>> put their test images onto. And what about images that contain non-free
>>>>> code?
>>>>
>>>> Yep, it isn't feasible to make this a hard rule.
>>>>
>>>> IMHO this is where a support tier classification comes into play
>>>>
>>>>  - Tier 1: actively maintained, qtest coverage available. Expected
>>>>            to work reliably at all times since every commit is CI
>>>> 	   tested
>>>>
>>>>   - Tier 2: actively maintained, no qtest coverage. Should usually
>>>>            work but regression may creep in due to reliance on the
>>>> 	   maintainer to manually test on adhoc basis
>>>>
>>>>   - Tier 3: not actively maintained, unknown state but liable to
>>>>             be broken indefinitely
>>>>
>>>> Tier 1 is obviously the most desirable state we would like everthing to
>>>> be at. Contributors will have to fix problems their patches cause as
>>>> they will be blocked by CI.
>>>>
>>>> Tier 2 is an admission that reality gets in the way. Ideally stuff in
>>>> this tier will graduate to Tier 1 at some point. Even if it doesn't
>>>> though, it is still valid to keep it in QEMU long term. Contributors
>>>> shouldn't gratuitously break stuff in these board, but if they do,
>>>> then the maintainer is ultimately responsible for fixing it, as the
>>>> contributors don't have a test rig for it.
>>>>
>>>> Tier 3 is abandonware. If a maintainer doesn't appear, users should
>>>> not expect it to continue to exist long term. Contributors are free
>>>> to send patches which break this, and are under no obligation to
>>>> fix problems in these boards. We may deprecate & delete it after a
>>>> while
>>>>
>>>>
>>>> Over time we'll likely add more criteria to stuff in Tier 1. This
>>>> could lead to some things dropping from Tier 1 to Tier 2. This is
>>>> OK, as it doesn't make those things worse than they already were.
>>>> We're just saying that Tier 2 isn't as thoroughly tested as we
>>>> would like it to be in an ideal world.
>>>
>>> I really like the idea of device support tiers codified directly in the
>>> QEMU codebase, to give upstream users some idea of which devices we
>>> expect to work and which we ... don't, really.
>>>
>>> Not every last device we offer is enterprise production ready, but we
>>> don't necessarily do a good job of explaining which devices fall into
>>> which categories, and we've got quite a few of them.
>>>
>>> I wonder if a 2.5th tier would be useful; something like a "hobbyist"
>>> tier for pet project SoC boards and the like -- they're not abandoned,
>>> but we also don't expect them to work, exactly.
>>>
>>> Mild semantic difference from Tier 3.
>>
>> I guess I was thinking such hobbyist stuff would fall into tier 2  if the
>> hobbyist maintainer actually responds to fixing stuff, or tier 3 if they
>> largely aren't active on the mailing list responding to issues/questions.
>>
>> We add have a 4 tier system overall and put hobbyist stuff at tier 3,
>> and abandonware at tier 4.
>>
>> Probably shouldn't go beyond 4 tiers though, as the more criteria we add
>> the harder it is to clearly decide which tier something should go into.
>>
>> The tier 1 vs 2 divison is clearly split based on CI which is a simple
>> classification to decide on.
>>
>> The tier 2 vs 3 division is moderately clearly split based on whether
>> there is a frequently active maintainer.
>>
>> We can probably squeeze in the 4th tier without too much ambiguity in
>> the classisfication if we think it is adding something worthwhile either
>> from our POV as maintainers, or for users consuming it.
> 
> Yes, I didn't mean to start watering it down into a 1,380 tier system
> that we're never able to properly utilize.
> 
> I was thinking more along the lines of:
> 
> - Device works and is well loved
> - Device works and is well loved (but we have to test manually)
> - Device doesn't work, but is well loved
>   (Use at your own peril, please file a bug report)
> - Device doesn't work, and is unloved
> 
> Perhaps it'd be clearer to name these Tier 1A, 1B, 2, and 3; where
> things can shift from 1A to 1B as their test coverage allows, but it's
> not meant to indicate general status otherwise.

All that sounds somewhat similar to the classification that we already
use in our MAINTAINERS file - Supported, Maintained, Odd-Fixes, Orphan,
Obsolete ... maybe we can avoid to introduce yet another classification
system and merge the two (e.g. by also changing the classification
system in MAINTAINERS a little bit?).

 Thomas


