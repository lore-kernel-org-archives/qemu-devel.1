Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985D2C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB0E2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRw8QEBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB0E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLo6M-0002ae-Pt
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLo50-0001IL-OM
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:48:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLo4z-0000gL-2v
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:48:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601041684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nm1MVESNeeXQFKYle+erIhXHp4I8+k6l2IuItRrQOcc=;
 b=VRw8QEBq2U2C1hcs0jmFXCYmCgV59L6bNZ75qo/HQnRgWw4nF2eLDrDo+gL+fypK68bh7B
 KtNNSUjLMxWmNdZuLcxm53BEg/8aRnmmcTBL62KSLSiMk7MX+Xoytb/8yzghw+O6ZqvN3Q
 vWfAc6kctmPs5i4MbKJXuq1/lPUDuEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-mhflANFfOauKhwTP-Ht9PA-1; Fri, 25 Sep 2020 09:48:00 -0400
X-MC-Unique: mhflANFfOauKhwTP-Ht9PA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BE3564091;
 Fri, 25 Sep 2020 13:47:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8F6E55788;
 Fri, 25 Sep 2020 13:47:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 56854113865F; Fri, 25 Sep 2020 15:47:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 09/38] qapi/common.py: Add indent manager
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-10-jsnow@redhat.com>
 <20200922222232.GK2044576@habkost.net>
 <c57afb75-3db9-abec-dd21-c32f9f918104@redhat.com>
 <87sgb6t6p1.fsf@dusky.pond.sub.org>
 <20200925131321.GO3717385@habkost.net>
Date: Fri, 25 Sep 2020 15:47:57 +0200
In-Reply-To: <20200925131321.GO3717385@habkost.net> (Eduardo Habkost's message
 of "Fri, 25 Sep 2020 09:13:21 -0400")
Message-ID: <878scyq86q.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Sep 25, 2020 at 01:51:54PM +0200, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> > On 9/22/20 6:22 PM, Eduardo Habkost wrote:
> [...]
>> > Yeah, there's only one user right now, so ... I just kinda wanted to
>> > get rid of the global usage. Maybe if we make the code generator
>> > fancier we'll find out what form is best.
>> 
>> You don't get rid of the global variable, you just change it from
>> integer to a class.  A class can be handier when generating multiple
>> things interleaved, because you can have one class instance per thing.
>
> To be fair, John doesn't claim to be getting rid of a global
> variable.  He's getting rid of usage of the 'global' keyword to
> make linters happier.

True.

>                        There are ways to do that without changing
> the code too much, though.

Let's do something easy and cheap, because ...

>> Note that we already have a class instance per thing we generate:
>> instances of subtypes of QAPIGen.  The thought of moving the indentation
>> machinery into QAPIGen or or maybe QAPIGenCCode crossed my mind many
>> moons ago, but I had bigger fish to fry, and then I forgot :)

... we'll probably want to move this stuff into QAPIGen later, and
that's when we should make it pretty.

>> John, I suggest you don't try to make this pretty just yet.  Do what
>> needs to be done for the type hint job.  We can make it pretty later.


