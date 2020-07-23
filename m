Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3341DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 06:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20DD206E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 06:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fB/WNHDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20DD206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyUjw-0007TE-9u
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 02:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyUj5-00070b-DX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 02:29:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30951
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyUj3-0007uD-Nf
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 02:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595485745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tWjpTPc8YJbUZPP5INmjIjPDig/+hsfvKiWZZBatP1M=;
 b=fB/WNHDS2JE56WRscGq/TMMhYqZ0AIaXzxFArCgMGTbDkQjST04gcrnzCle2Vzd4G4CD9f
 XqftCn75T/e4nAS/O4NVL//yxAf7t/CKdxA57DN5Qj/HHqxZ5i0ReXExenFtzw1bpPMds0
 0c/IxCAsGUZhKdz18VzMejVEQ2CvuMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-6xvJ0T99PrCqY9Y3__WaNQ-1; Thu, 23 Jul 2020 02:29:03 -0400
X-MC-Unique: 6xvJ0T99PrCqY9Y3__WaNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C7D910059A2;
 Thu, 23 Jul 2020 06:29:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C1122C2BC;
 Thu, 23 Jul 2020 06:28:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B952C111CA26; Thu, 23 Jul 2020 08:28:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: please try to avoid sending pullreqs late on release-candidate day
References: <CAFEAcA9+9ZQY2CxZ9V4bZrkAGR5eUapbwSk6sNyFGyyd39Y=1Q@mail.gmail.com>
 <20200722093621.GA4838@linux.fritz.box> <87r1t3u4me.fsf@linaro.org>
Date: Thu, 23 Jul 2020 08:28:57 +0200
In-Reply-To: <87r1t3u4me.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Wed, 22 Jul 2020 13:16:25 +0100")
Message-ID: <87o8o6pwwm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Kevin Wolf <kwolf@redhat.com> writes:
>
>> Am 21.07.2020 um 17:56 hat Peter Maydell geschrieben:
>>> It is not helpful if everybody sends their pullrequests late
>>> on the Tuesday afternoon, as there just isn't enough time in the
>>> day to merge test and apply them all before I have to cut the tag.
>>> Please, if you can, try to send pullrequests earlier, eg Monday.
>>
> <snip>
>>
>> So given that we _will_ have some late patches, what can we do to
>> improve the situation?
>>
>> Maybe I could send the pull request before testing it to save some time.
>> Your tests will take a while anyway, so if my own testing fails (e.g.
>> for the parts of iotests that you don't test), I would still have time
>> to NACK my own pull request. This wouldn't buy us more than an hour at
>> most and could lead to wasted testing effort on your side (which is
>> exactly the resource we want to save).
>>
>> Can you test multiple pull requests at once? The Tuesday ones tend to be
>> small (between 1 and 3 patches was what I saw yesterday), so they should
>> be much less likely to fail than large pull requests. If you test two
>> pull requests together and it fails so you have to retest one of them in
>> isolation, you still haven't really lost time compared to testing both
>> individually. And if it succeeds, you cut the testing time in half.
>
> I've taken to just stacking up patches from my multiple trees to avoid
> sending more than one PR a week. Of course sometimes the stack grows a
> bit too tall and becomes unwieldy :-/

You're right, stacking unrelated smaller pull requests makes sense when
pulling all the pull requests in flight races with a deadline.


