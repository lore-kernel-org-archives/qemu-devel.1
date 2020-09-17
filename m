Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B88C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B2221973
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBdi+1la"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B2221973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIodh-0006vO-Dt
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIocn-00065t-QV
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIock-0004f9-6a
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600328793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7UiKX681eVJEkwcrx9iX7A0KuwietBbIREwmghk6uUI=;
 b=hBdi+1lawLLZ1CbMollafV9REFb+zET18zNoKnVrOMe3qTQqiTWS2tCsR4dAltMigS7KeR
 Y/3YoIMwISIEitvqrYWJ9neCZsU4B151DXrvgavgoIYxDAfeYWx0XiXuUZzbV0RMxokbZH
 wPDftjFyV53L2gnv31ihnkF2lyfQjio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-E9Vr2eFDPKCX-7JfHy_13w-1; Thu, 17 Sep 2020 03:46:31 -0400
X-MC-Unique: E9Vr2eFDPKCX-7JfHy_13w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7C8C186DD46;
 Thu, 17 Sep 2020 07:46:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 759C719D6C;
 Thu, 17 Sep 2020 07:46:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 07E3F113864A; Thu, 17 Sep 2020 09:46:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 04/37] qapi: move generator entrypoint into module
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-5-jsnow@redhat.com>
 <877dsuos1n.fsf@dusky.pond.sub.org>
 <5b42ff66-9bc3-ea2e-a3f7-5105628e2c43@redhat.com>
Date: Thu, 17 Sep 2020 09:46:29 +0200
In-Reply-To: <5b42ff66-9bc3-ea2e-a3f7-5105628e2c43@redhat.com> (John Snow's
 message of "Wed, 16 Sep 2020 10:24:03 -0400")
Message-ID: <87ft7gg816.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 9/16/20 7:54 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> As part of delinting and adding type hints to the QAPI generator, it's
>>> helpful for the entrypoint to be part of the module, only leaving a very
>>> tiny entrypoint shim outside of the module.
>>>
>>> As a result, all of the include statements are reworked to be module-aware,
>>> as explicit relative imports.
>> Should this be split into two commits, one for each of the
>> paragraphs
>> above?
>> 
>
> Hmm ... I hadn't considered it was possible, but actually ... I guess
> I can split those out, yeah.
>
>> PEP 8 recommends absolute imports, with one exception:
>>      However, explicit relative imports are an acceptable
>> alternative to
>>      absolute imports, especially when dealing with complex package
>>      layouts where using absolute imports would be unnecessarily verbose:
>>          from . import sibling
>>          from .sibling import example
>>      Standard library code should avoid complex package layouts and
>>      always use absolute imports.
>> Do you think it covers your use of relative imports?
>> 
>
> Admittedly I am going by trial and error; my experience is that the
> relative imports behave the nicest.
>
> There is a historical fear of explicit relative imports because they
> are "new" and years of Python2 compatibility

Having to struggle with that for years was bound to damage brains.

>                                              rendered many afraid of
> them. It is advice safely ignored in my opinion.
>
> Using absolute imports (e.g. from qapi.sibling import foo) gets messy
> in virtual environments when you have *installed* the module in
> question: it becomes ambiguous as to *which* qapi you meant: the one
> in this folder, or the one installed to the environment?
>
> Python, mypy, pylint, flake8 etc disagree sometimes, or can get
> confused; thinking there are two copies of each module.
>
> Just my experience that relative imports seem to give me the least trouble.
>
>>> This is done primarily for the benefit of python tooling (pylint, mypy,
>>> flake8, et al) which otherwise has trouble consistently resolving
>>> "qapi.x" to mean "a sibling file in this folder."
>> Can you give me an example of some tool having troube?
>> 
>
> I'd have to code up some examples. I have some hobby code unrelated to
> QEMU where I struggled to get flake8, mypy, and pylint all cooperating 
> with an import regime until I gave up and used explicit relative imports.

I'd make the switch when we actually do run into trouble.

But I'm willing to take your advice and switch now.

[...]


