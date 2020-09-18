Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1BFC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB989208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ik21iYOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB989208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBBh-0004PL-T5
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 03:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kJBAi-0003dc-VY
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kJBAg-0000YT-Li
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600415466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vkg1sXaxqYdJmLyiWgJuM8HayCaGafx+1EjYfRIFSYk=;
 b=ik21iYOxKzlOUbqfHuQCXC+8MQD+2EUZxCczew7kMNz0LpLtQji7OzFfYFJ5xAO9xLaNt9
 LP56lL4OwnR+elZ3QSqJ+aTc0or9X2qVrC8l5nH3zav8ScjYNmnhPh3hmXFnORsdrH1dQ0
 vI6paFVomNokgbBqmtTfQ+5tdXNKMrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-pYEsl4MLN9ahFQuJG7ba3A-1; Fri, 18 Sep 2020 03:51:01 -0400
X-MC-Unique: pYEsl4MLN9ahFQuJG7ba3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2C23800138;
 Fri, 18 Sep 2020 07:51:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 916793782;
 Fri, 18 Sep 2020 07:51:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 26F82113864A; Fri, 18 Sep 2020 09:50:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 00/37] qapi: static typing conversion, pt1
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <a35da596-fd10-5b34-589e-a5fc3f501451@redhat.com>
Date: Fri, 18 Sep 2020 09:50:59 +0200
In-Reply-To: <a35da596-fd10-5b34-589e-a5fc3f501451@redhat.com> (John Snow's
 message of "Thu, 17 Sep 2020 16:22:21 -0400")
Message-ID: <87k0wrldzw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 9/15/20 6:39 PM, John Snow wrote:
>> Hi, this series starts adding static type hints to the QAPI module. As
>> you can see, the series started getting quite a bit long, so this is
>> only a partial conversion that focuses on a handful of the easier files.
>> The tougher files -- schema.py, expr.py, parser.py -- will each
>> receive
>> their own series as a follow-up to this one.
>> Notes:
>> - This requires Python 3.6+. Python 3.5 is EOL, so let's do that.
>> - Any patch named "add notational type hints" changes ONLY
>> signatures,
>>    which have no runtime impact whatsoever. These are big patches,
>>    but fairly straightforward.
>> - Most other patches are as bite-sized as possible, generally fixing
>> one
>>    single warning.
>> - After patch 6, `flake8 qapi/` should pass 100% on this and every
>>    future commit.
>> - After patch 7, `pylint --rcfile=qapi/pylintrc qapi/` should pass
>> 100%
>>    on this and every future commit.
>> - After patch 16, `mypy --config-file=qapi/mypy.ini qapi/` should
>> pass
>>    100% on this and every future commit.
>> 
>
> Addressed today's feedback and pushed to gitlab.
> Let's call it "Version 1.3".
>
> https://gitlab.com/jsnow/qemu/-/commits/python-qapi-cleanup-pt1/
>
> Waiting on feedback for 16-37 before re-authoring to list.

If 03-12 don't actually depend on Python 3.6, you may want to respin
these for me to queue right away.


