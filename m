Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EC7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 06:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B37208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 06:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fl491Pbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B37208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeCUn-0000eU-C6
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 02:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeCTw-0008V7-PE
 for qemu-devel@nongnu.org; Thu, 28 May 2020 02:57:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21841
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeCTv-000535-Iy
 for qemu-devel@nongnu.org; Thu, 28 May 2020 02:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590649053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3JuN5FXZQE8KenMi4JAegsg/VxF0RZcuU1hc2Gt/SYU=;
 b=Fl491PboFZqb1buKkXUOg3f1wmtmzpHTm3zy/ayl5WBc48IAJxbHJCZzjovDelXI2lpt+8
 XIOLNoy1KUb1bSrf4zx9PMEFwdJC1BXzQEAVS3D/ZNFiOsO2xqfaCfv6vG90FrqPWhVl2Z
 XsRWcScsDW571ZK3tTWR9mBZt9XdjaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-ewdM6UzDMTqnZe0oIEoXYQ-1; Thu, 28 May 2020 02:57:31 -0400
X-MC-Unique: ewdM6UzDMTqnZe0oIEoXYQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C8251005510;
 Thu, 28 May 2020 06:57:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7C6D60C05;
 Thu, 28 May 2020 06:57:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7AC83113864A; Thu, 28 May 2020 08:57:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 09/24] macio: Fix to realize "mos6522-cuda" and
 "mos6522-pmu" devices
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-10-armbru@redhat.com>
 <CAFEAcA_S_JsuPG4UN-_zhhdZppBhiwm3-4bocO7O1XdjxC9bAw@mail.gmail.com>
 <87wo4xxya0.fsf@dusky.pond.sub.org>
 <CAFEAcA-9CU8QPeafAf_VSh-Gu2WxLpEoRdUZpv+TOF0Rpq-MXQ@mail.gmail.com>
 <d42145a1-2af7-a342-aaa7-d4f472c80e0b@redhat.com>
Date: Thu, 28 May 2020 08:57:28 +0200
In-Reply-To: <d42145a1-2af7-a342-aaa7-d4f472c80e0b@redhat.com> (Paolo
 Bonzini's message of "Wed, 27 May 2020 17:12:15 +0200")
Message-ID: <87367kwnqf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:10:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 27/05/20 17:05, Peter Maydell wrote:
>> I disagree with these. We're in a realize function, the API
>> says "on errors, report them via the Error* you got passed",
>> so we should do that, not blow up. &error_abort only makes
>> sense if (a) we have no better way to report errors than
>> to abort (which isn't the case here) or (b) if we can guarantee
>> that in fact the thing we're doing won't ever fail
>> (which we can't here without knowing more about the internal
>> implementation details of the MOS6522 device than we
>> really ought to).
>
> Note however that before replacing &error_abort with error propagation
> you need to make sure that you are "un-realizing" yourself properly.  So
> it may be better to have inferior (but clearly visible) error
> propagation behavior, than untested (and perhaps untestable) buggy code
> that looks great on the surface.

This is exactly why I have to stop at &error_abort in this series.  It's
24 patches of fixes to enable 50+ patches of refactoring, with more in
the pipeline.  If I stray even deeper into the weeds, my pipeline is
going to explode %-}


