Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F21FC433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0B120709
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRKwRznX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0B120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyZ9u-0001BT-3z
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 07:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyZ9K-0000l7-Sn
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:12:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36277
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyZ9I-0005Tk-9w
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595502747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fPj4rORpQOyT0MafAPtla2gV0nREWnhoe4axb9BYMY=;
 b=eRKwRznX/F5+UgVG9bRECWqNKVfRZomRn0upW9C7zhyYBFFJ7eDkvBcDSWP2Ax0JWLeAv1
 MQuqFv0rTMkScWlJDxKTs6/l+KT7Pm8lvig3bKE9M1A4Xtw39hfE8+ZhHBl3xAM1GKdnR+
 qgrtWi6IO2RrDmKgbSUKThbtZ2QglsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-fGx2D78zOZC3hv8ppL4O2Q-1; Thu, 23 Jul 2020 07:12:25 -0400
X-MC-Unique: fGx2D78zOZC3hv8ppL4O2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 541A480046A;
 Thu, 23 Jul 2020 11:12:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EA7D5D9E8;
 Thu, 23 Jul 2020 11:12:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2B1A3111CA26; Thu, 23 Jul 2020 13:12:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: please try to avoid sending pullreqs late on release-candidate day
References: <CAFEAcA9+9ZQY2CxZ9V4bZrkAGR5eUapbwSk6sNyFGyyd39Y=1Q@mail.gmail.com>
 <20200722093621.GA4838@linux.fritz.box> <87r1t3u4me.fsf@linaro.org>
 <87o8o6pwwm.fsf@dusky.pond.sub.org>
 <16f1e661-edaa-2ee2-008d-3c9ad0e5e10d@redhat.com>
Date: Thu, 23 Jul 2020 13:12:18 +0200
In-Reply-To: <16f1e661-edaa-2ee2-008d-3c9ad0e5e10d@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 23 Jul 2020 12:26:57
 +0200")
Message-ID: <87eep2jxil.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/23/20 8:28 AM, Markus Armbruster wrote:
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>=20
>>> Kevin Wolf <kwolf@redhat.com> writes:
>>>
>>>> Am 21.07.2020 um 17:56 hat Peter Maydell geschrieben:
>>>>> It is not helpful if everybody sends their pullrequests late
>>>>> on the Tuesday afternoon, as there just isn't enough time in the
>>>>> day to merge test and apply them all before I have to cut the tag.
>>>>> Please, if you can, try to send pullrequests earlier, eg Monday.
>>>>
>>> <snip>
>>>>
>>>> So given that we _will_ have some late patches, what can we do to
>>>> improve the situation?
>>>>
>>>> Maybe I could send the pull request before testing it to save some tim=
e.
>>>> Your tests will take a while anyway, so if my own testing fails (e.g.
>>>> for the parts of iotests that you don't test), I would still have time
>>>> to NACK my own pull request. This wouldn't buy us more than an hour at
>>>> most and could lead to wasted testing effort on your side (which is
>>>> exactly the resource we want to save).
>>>>
>>>> Can you test multiple pull requests at once? The Tuesday ones tend to =
be
>>>> small (between 1 and 3 patches was what I saw yesterday), so they shou=
ld
>>>> be much less likely to fail than large pull requests. If you test two
>>>> pull requests together and it fails so you have to retest one of them =
in
>>>> isolation, you still haven't really lost time compared to testing both
>>>> individually. And if it succeeds, you cut the testing time in half.
>>>
>>> I've taken to just stacking up patches from my multiple trees to avoid
>>> sending more than one PR a week. Of course sometimes the stack grows a
>>> bit too tall and becomes unwieldy :-/
>>=20
>> You're right, stacking unrelated smaller pull requests makes sense when
>> pulling all the pull requests in flight races with a deadline.
>
> I tend to disagree, since few patches from the "candidate fixes for
> 5.1-rc1" series are still being discussed, and we are past rc1. Half
> of them could have been merged in for rc1.

That's a different issue, I think.

Picking patches that are ready and independent when the complete series
isn't often makes sense.  More so when a deadline is involved.


