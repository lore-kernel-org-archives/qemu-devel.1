Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F68C43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F1220758
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScBImx5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F1220758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKNHt-0007Nn-4S
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKNH2-0006uU-2y
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKNGz-0008Aa-V5
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600700312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rn1FO0BjwChzAznzPSY/P8voBploiKFl8e/QkGEHZOI=;
 b=ScBImx5SH80ut/v8cJ+Bmyy3o0DdZtcOdM5QVx9J+FG78HNg18pLQgCmwNMAM4gysJDYc/
 mmuGnE91Tvym0RQi3mLsPlnxSiaxAmTznqr2NPCaAFWfjMfBRlLGqUGDvtoBkRVW3FmBmK
 hOb17S5dlOQ94wJq+eueJ64trNZfm/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-2gy_uY2JNO6cT_3Qg1AJAA-1; Mon, 21 Sep 2020 10:58:28 -0400
X-MC-Unique: 2gy_uY2JNO6cT_3Qg1AJAA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 582DF801AEA;
 Mon, 21 Sep 2020 14:58:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CECB77366A;
 Mon, 21 Sep 2020 14:58:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5DC501132E9A; Mon, 21 Sep 2020 16:58:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 0/8] Configurable policy for handling deprecated
 interfaces
References: <20200914084802.4185028-1-armbru@redhat.com>
 <CAFEAcA9qPx=rtNcQ5FJk8a3YjZN7XyD1cJddQbD7Km9fBpm-0A@mail.gmail.com>
Date: Mon, 21 Sep 2020 16:58:19 +0200
In-Reply-To: <CAFEAcA9qPx=rtNcQ5FJk8a3YjZN7XyD1cJddQbD7Km9fBpm-0A@mail.gmail.com>
 (Peter Maydell's message of "Mon, 21 Sep 2020 13:56:52 +0100")
Message-ID: <875z8718j8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Libvirt <libvir-list@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 libguestfs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 14 Sep 2020 at 09:55, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> New option -compat lets you configure what to do when deprecated
>> interfaces get used.  This is intended for testing users of the
>> management interfaces.  It is experimental.
>>
>> -compat deprecated-input=<in-policy> configures what to do when
>> deprecated input is received.  Available policies:
>>
>> * accept: Accept deprecated commands and arguments (default)
>> * reject: Reject them
>> * crash: Crash
>>
>> -compat deprecated-output=<out-policy> configures what to do when
>> deprecated output is sent.  Available output policies:
>>
>> * accept: Emit deprecated command results and events (default)
>> * hide: Suppress them
>>
>> For now, -compat covers only deprecated syntactic aspects of QMP.  We
>> may want to extend it to cover semantic aspects, CLI, and experimental
>> features.
>
> Some bikeshedding on option naming...
>
> If this only covers QMP, should we make the argument to -compat
> have a name that expresses that? eg deprecated-qmp-input,
> deprecated-qmp-output ?

It's only implemented for QMP so far.  But we really want it for all
external interfaces for use by machines.  Today, that's QMP and CLI.

Naming the parameters deprecated-qmp-{input,output} leads to separate
settings for QMP and CLI.

Naming them just deprecated-{input,output} leads to a single set of
settings common to all externeal interfaces, or to sugar for setting all
the deprecated-*-{input,output} we may have.

I don't think getting it wrong now would be a big deal.  No excuse for
getting it wrong unthinkingly :)

> Also, it seems a bit repetitive to say 'deprecated' here all
> the time -- do you have a future use of -compat in mind which
> would be to adjust something that is *not* deprecated ? If
> not, maybe the 'deprecated' part should be in the option name
> rather than in every argument, eg
>
>   -deprecation-compat qmp-input=crash,qmp-output=hide,cli-option=reject
>
> ?

My cover letter hints at such future uses: "We may want to extend it to
cover [...] experimental features."  Something like

    -compat experimental-input=reject,experimental-output=hide


