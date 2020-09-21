Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634CCC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD93220874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO9Wz9sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD93220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKGr5-0006e7-Sq
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKGpj-0005Ag-Rs
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKGph-00076b-SH
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600675557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T1U7u2vieqF7x2Au7Wvi4HzioVukpY6SIhvvNSFUr70=;
 b=CO9Wz9smdWvdlIncQTy3LJVACm1VR/QyqW3EfRpqJsnNm+HxUBauE+85MSQzqnFn9emHHC
 vBXK8cO+q3SAosJlt/e4ruW1MTqcmXdmGjkN/FXrWLE5afo9o4Tk4qXXt+5khh5wSi7t0L
 Z+3/7YbzNcWYOg2ppyIher4Y12amp9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-jO3wUq0fNjCrsGXPzFADqQ-1; Mon, 21 Sep 2020 04:05:53 -0400
X-MC-Unique: jO3wUq0fNjCrsGXPzFADqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 057C86414B;
 Mon, 21 Sep 2020 08:05:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C77AC60C13;
 Mon, 21 Sep 2020 08:05:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C1FD1132E9A; Mon, 21 Sep 2020 10:05:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 16/37] qapi: establish mypy type-checking baseline
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-17-jsnow@redhat.com>
 <874knvguzb.fsf@dusky.pond.sub.org>
 <d8faa68c-6900-5666-943c-98815348fc5b@redhat.com>
Date: Mon, 21 Sep 2020 10:05:50 +0200
In-Reply-To: <d8faa68c-6900-5666-943c-98815348fc5b@redhat.com> (John Snow's
 message of "Fri, 18 Sep 2020 15:03:41 -0400")
Message-ID: <87imc7a71d.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

> On 9/18/20 7:55 AM, Markus Armbruster wrote:
>> Ignorant question: why does this come after PATCH 13 "qapi/common.py:
>> add notational type hints", but before all the other patches adding type
>> hints?
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> Fix two very minor issues, and then establish a mypy type-checking
>>> baseline.
>>>
>>> Like pylint, this should be run from the folder above:
>>>
>>>   > mypy --config-file=qapi/mypy.ini qapi/
>> I get:
>>      $ mypy --config-file qapi/mypy.ini qapi
>>      qapi/mypy.ini: [mypy]: Strict mode is not supported in configuration files: specify individual flags instead (see 'mypy -h' for the list of flags enabled in strict mode)
>>      qapi/types.py:29: error: Need type annotation for 'objects_seen' (hint: "objects_seen: Set[<type>] = ...")
>>      Found 1 error in 1 file (checked 18 source files)
>> Is this expected?
>> In case it matters:
>>      $ mypy --version
>>      mypy 0.761
>> 
>
> (Warning; FiSH and stgit ahead)
>
> cd ~/src/qemu/scripts
> pipenv --python 3.6
> pipenv shell
> pip install pylint flake8
>
> ### Testing mypy 0.770
>
> pip install mypy==0.770
> stg goto qapi-establish-mypy-type
>
> while true; and flake8 qapi/; and pylint --rcfile=qapi/pylintrc qapi/;
> and mypy --config-file=qapi/mypy.ini qapi/; and stg push; end
>
> pip uninstall mypy
>
> ###
>
>
>
> 0.782 - OK
> 0.770 - OK
> 0.760 - FAIL, Fixable*
> 0.750 - OK*
> 0.740 - OK*
> 0.730 - OK*
> 0.720 - OK*
> 0.710 - OK** (Does not recognize 'no_implicit_reexport' option)
> 0.700 - OK*** (Not compatible with bleeding edge pylint/flake8)
> 0.670 - OK***
> 0.660 - OK***
> 0.650 - OK***
> 0.641 - OK***
> 0.630 - Fails again.
>
>
>
> 0.760 doesn't support strict in the config file (It needs component
> options), and it wants a few extra annotations where its inference
> power is weaker. Well, easy enough to fix up.
>
> 0.630 fails again and insists that __init__ should have a return type
> annotation of None. Modern mypy is smart enough to know that's what
> that type is supposed to be. Arbitrarily, this is my cutoff for what
> seems reasonable to even want to support.
>
> I still find the lack of "strict=true" in the config file irritating
> and might ask to target 0.770 or newer. There should be no reason we
> can't install that in a venv for CI to chew on.
>
> Humbly ask I take the lazy way out and document that we support mypy
> >= 0.770.

Our "supported build platforms" policy puts hard limits on the minimum
versions for tools the build requires.

Mypy is not such a tool.  I hope we get to the point where we can have
"make check" run it, but skipping the test when we don't have a
sufficiently modern mypy feels okay to me, as long as our gating CI
still guards the master branch.


