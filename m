Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94282C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B986B2173E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OW6BdFKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B986B2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQNn-0006BZ-60
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQQMy-0005dH-Fp
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQQMw-0006MO-Sd
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602142181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CMUf15vvJNr41biUcJ/clpbRPbuzwEttKHNtYW6nB54=;
 b=OW6BdFKOzfm+/s5PL2Gm4QveOQC4ycg09UpS2wtB71CNZ0Th92Fm9Fu4WCV72U60L7nX2o
 RSS5fFON5ikRO8Zwe9r0aGO1D+50G4fyHaN4bfhtgSSKkgP9erNKZCw1XD+AcsftEiYKbz
 4fFnv+yG8l3exad7mT8pvwSLWCcYV+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-Mbhtf7sPPMG3TPYl2hweJg-1; Thu, 08 Oct 2020 03:29:39 -0400
X-MC-Unique: Mbhtf7sPPMG3TPYl2hweJg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 579671054F90
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2020 07:29:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FCDE60BFA;
 Thu,  8 Oct 2020 07:29:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8746511329C1; Thu,  8 Oct 2020 09:29:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 18/36] qapi: establish mypy type-checking baseline
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-19-jsnow@redhat.com>
 <87pn5ugzgn.fsf@dusky.pond.sub.org>
 <cf40ddac-4e60-1e1f-1a6a-7e8efaac1602@redhat.com>
Date: Thu, 08 Oct 2020 09:29:36 +0200
In-Reply-To: <cf40ddac-4e60-1e1f-1a6a-7e8efaac1602@redhat.com> (John Snow's
 message of "Wed, 7 Oct 2020 11:33:37 -0400")
Message-ID: <87v9fl2n1b.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 10/7/20 5:25 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> Fix two very minor issues,
>> What are the two issues?  I'm asking because I can see only one.
>> 
>
> Bitrot! The other one got fixed elsewhere and rebase didn't conflict,
> so I didn't update the commit message.
>
>>>                             and then establish a mypy type-checking
>>> baseline.
>> Any particular reason this can't go before PATCH 15 "qapi/common.py: add
>> type hint annotations".
>> 
>
> Just the way the chips fell. common.py does not check until this very
> commit.
>
> Adding a mypy config can be shuffled up earlier and earlier by
> determining which checks to ignore and adding them, but I'm not sure
> who that benefits.

I like symmetry, but it's okay as is.  I asked to make sure I'm not
missing something more subtle.

[...]


