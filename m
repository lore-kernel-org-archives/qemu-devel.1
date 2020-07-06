Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DBCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 12:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA13720720
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 12:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfujsIW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA13720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsPqq-0005M8-1v
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 08:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsPq2-0004tD-NF
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 08:03:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22540
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsPpz-0006UN-Ih
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 08:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594036986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYEhYetH61HiRvDFMbo2+VwJClh2WeNROkJ2o1unudg=;
 b=CfujsIW48PO5ow1w+6U+u+QojdEE7MfcLJj6Hjux2iquRdnUTbU4feTKsQ95WH35eQXTci
 cVo7VXy7jTMDwct8pblQy6+eukZNp0XA895H703vSbH3+Kt/b6v1SBuEGQRw0AvD56P9Ud
 b0cGoBYQX9cR8xROlbc2i9oZVxCU4rM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-q0JIdfPSPOCyLHfqoyd4HA-1; Mon, 06 Jul 2020 08:03:04 -0400
X-MC-Unique: q0JIdfPSPOCyLHfqoyd4HA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C77B380040A;
 Mon,  6 Jul 2020 12:03:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EF8560CC0;
 Mon,  6 Jul 2020 12:03:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0AAA31132FD2; Mon,  6 Jul 2020 14:03:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PULL 36/37] qdev: remove QDEV_PROP_PTR
References: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
 <20200107150442.1727958-37-marcandre.lureau@redhat.com>
 <13c91f97-a7e6-adbd-9c23-2464f2b1b46e@amsat.org>
 <CAMxuvaxx0bM5yhZcmc7LPmpMt-qvuB+zjhRR1mpUiNm=DyasoQ@mail.gmail.com>
 <9b2cfb05-ce65-7356-fe78-718e39138093@amsat.org>
Date: Mon, 06 Jul 2020 14:03:01 +0200
In-Reply-To: <9b2cfb05-ce65-7356-fe78-718e39138093@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 6 Jul 2020 12:13:47
 +0200")
Message-ID: <875zb0am16.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 7/6/20 12:01 PM, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>=20
>> On Mon, Jul 6, 2020 at 12:44 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org> wrote:
[...]
>>> Yet another sneaky way to force forks to either update to QOM or die...
>>=20
>> You can't blame upstream from doing cleanups and modernization, or
>> stagnating. Forks are forks, with all the pain they carry. If they
>> want to avoid the maintenance cost, they have to do the extra effort
>> to get it upstream. This is also a "sneaky way" to remind them that
>> effort is better spent in this direction.
>
> I totally understand, but at the same time we are excluding hobbyist
> contributors with mainstream exigency.
>
> This is unfortunate. I'd like to suggest ideas how to keep the QEMU
> project open to non-corporate contributors, but I don't have any.

Anyone with a fork to rebase continuosly is in an unenviable position.
Rebasing will never be painless, and the only way to win the game is to
stop playing it, ideally by getting your stuff merged upstream.

I think this is related to hobbyist vs. corporation only insofar a
well-heeled corporation can fund folly for much longer than a hobbyist.

That said, helping forks bear the rebase pain while they work towards a
merge is certainly a laudable goal.

> Well, maybe this one: better document API changes, if possible with
> examples (example can be as simple as pointing to a particular commit
> sha1). At least for each release, because forks usually try to rebase
> after releases.

Yes, release notes for developers would be nice.


