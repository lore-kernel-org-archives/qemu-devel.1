Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C601CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F7621D81
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUma9zvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F7621D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6BR-0005QL-Lz
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iO680-00079Q-MU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iO67x-00032e-EL
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:24:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50114
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iO67x-00032R-AW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572035044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qFYjZNlZwALz1VsWfTNZ6uFLHasaACgRCkLY6ulXWm8=;
 b=cUma9zvF8CD6HoWMLHiUd4rOwvHs8ofnRcyCfyrReHyXOM8dlYlafF5bRUggl6RnORT4b5
 vqlZjePF+NHxsEhahLmqDq0vWATK0Xs/SgcXw7ud6QzXW/23nvK7Kq9LkQnEIITjOfB1aM
 NI57qG4nhwfkVhISmXhNMvXt0ORDOiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-BMs1tK2pNnCCiZqVkfE_zA-1; Fri, 25 Oct 2019 16:24:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFF74107AD31;
 Fri, 25 Oct 2019 20:23:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9E1B60C80;
 Fri, 25 Oct 2019 20:23:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2B3E01138619; Fri, 25 Oct 2019 22:23:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL v2 00/73] tcg plugins and testing updates
References: <20191025063713.23374-1-alex.bennee@linaro.org>
 <87lft9rnfs.fsf@dusky.pond.sub.org> <87lft8lvdh.fsf@linaro.org>
Date: Fri, 25 Oct 2019 22:23:54 +0200
In-Reply-To: <87lft8lvdh.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Fri, 25 Oct 2019 16:04:10 +0100")
Message-ID: <874kzw60bp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: BMs1tK2pNnCCiZqVkfE_zA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> I hate to interfere with the merging of working code for non-technical
>> reasons....
>>
>> This is a plugin interface.  As I wrote in reply to v4, I'd like to see
>> a pragmatic argument why abuse of the plugin interface to circumvent the
>> GPL is not practical.  This might include "not a stable interface", "you
>> have to link with a truckload of gpl code", "the set of things you can
>> do is deliberately extremely limited".
>
> I included a link to the description in lead patch of the following two
> revisions posted after v4 for this purpose. To repeat myself:

If you had cc'ed me, I might have even read it :)

>   QEMU TCG plugins provide a way for users to run experiments taking
>   advantage of the total system control emulation can have over a guest.
>   It provides a mechanism for plugins to subscribe to events during
>   translation and execution and optionally callback into the plugin
>   during these events. TCG plugins are unable to change the system state
>   only monitor it passively. However they can do this down to an
>   individual instruction granularity including potentially subscribing
>   to all load and store operations.
>
> So to summarise it is a deliberately limited set of passive observations
> that can be made by the plugins. You cannot implement a new device using
> this interface.
>
>> Perhaps such an argument is made somewhere in these 73 patches already.
>> I admit to not having read them all :)  In the TCG plugin design documen=
t
>> perhaps?  Assuming it exists...
>
> Indeed there is - docs/devel/plugins.rst

In 21/73.  I'll read it as soon as I can.

File contents is about *TCG* plugins, file name advertises plugins
without a qualifier.  We can rename when it bothers us.

> A high level tour of the design decisions and approaches is the subject
> of my talk on Friday morning.

Good move.

>> I proposed discussing the project's requirements for external interfaces
>> on GPL circumvention deterrence at the QEMU Summit next week.
>
> That should certainly be an agenda item for the summit. I don't think
> this provides a mechanism for GPL circumnavigation though.
>
>> If merging this could be delayed until the licensing ramifications have
>> become a bit more clear, I'd be obliged.
>
> I'd rather not unless we can make an exception for late merging of the
> PR. I've worked quite hard to make sure everything is ready for the 4.2
> window and I'd rather not miss a whole release cycle on a
> misunderstanding of what these plugins allow.

I think there are multiple ways to avoid the nuclear outcome.

Coming to a conclusion before the soft freeze is the nicest one.

Making an exception for late merging is another one, but Peter may
prefer not to.

Yet another one is merging the pull request before the soft freeze with
the understanding that it'll be reverted unless we come to a positive
conclusion before say -rc0 (Nov 5).  I'm confident we can work it out in
Lyon.


