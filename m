Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D57C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0C1206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yy95M8rE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0C1206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrGHt-0007dI-5b
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 03:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jrGHL-0007ES-Jy
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:38:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57052
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jrGHK-0001bY-1W
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 03:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593761912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3egHuNW7B59Xnb28NjzBJ+kMsciqf3h2+2qLpKMk2Y=;
 b=Yy95M8rEjzCGji+rgHoqg6xEjmzAFqorJ3GEQjVgwKKBkTrDhf4mcf8XQ/YyJrwc/J9hP/
 5+QsCaMquynfkhBLE7z0SKIMXwW+De0AGenNkbf5N6Skd57Q5bdvw/IEiZlQ8RdStt6JEN
 h7g5h4wy/Ih9WKX1+ZO0shBYnUCI4AY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-sqi4E35fO3S6_km1ifvQ5Q-1; Fri, 03 Jul 2020 03:38:31 -0400
X-MC-Unique: sqi4E35fO3S6_km1ifvQ5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5301110CE781;
 Fri,  3 Jul 2020 07:38:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B8AA7923E;
 Fri,  3 Jul 2020 07:38:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 89E511138648; Fri,  3 Jul 2020 09:38:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: Questionable aspects of QEMU Error's design
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <87blo7heag.fsf@dusky.pond.sub.org>
 <87blndey9c.fsf@dusky.pond.sub.org>
 <3b9d53fd-bdd0-c15b-292c-c4952fa24dfd@virtuozzo.com>
 <923ceeeb-1fc8-489e-a32d-4cebfa6eadae@virtuozzo.com>
 <87y2ptstxm.fsf@dusky.pond.sub.org>
Date: Fri, 03 Jul 2020 09:38:28 +0200
In-Reply-To: <87y2ptstxm.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Fri, 15 May 2020 06:28:37 +0200")
Message-ID: <87d05dqc97.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>
>> 28.04.2020 08:20, Vladimir Sementsov-Ogievskiy wrote:
>>> 27.04.2020 18:36, Markus Armbruster wrote:
>>>> FYI, I'm working on converting QemuOpts, QAPI visitors and QOM.=C2=A0 =
I keep
>>>> running into bugs.=C2=A0 So far:
[...]
>>>> I got another one coming for QOM and qdev before I can post the
>>>> conversion.
>>>>
>>>> Vladimir, since the conversion will mess with error_propagate(), I'd
>>>> like to get it in before your auto-propagation work.
>>>>
>>>
>>> OK, just let me know when to regenerate the series, it's not hard.
>>>
>>
>> Hi! Is all that merged? Should I resend now?
>
> I ran into many bugs and fell into a few rabbit holes.  I'm busy
> finishing and flushing the patches.

All merged except for the final series "[PATCH v2 00/44] Less clumsy
error checking".  v2 has a lot of change within the series, but in
aggregate it's really close to v1.  This makes be optimistic it can
serve as a base for your auto-propagation work.  To get it into 5.1, we
need a respin, a re-review, and a pull request.  Time is awfully short.
Sorry for taking so long!  If you want to try, I can give it priority on
my side.


