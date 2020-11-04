Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D909AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CFE2063A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdGxVPWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CFE2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLD7-0007wy-QP
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLCK-0007UA-1M
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:59:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLCH-00055B-Ci
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xeN20FmHfppEdlFiLbFheQZKEiQ1KH/nJW1u18vDEDY=;
 b=MdGxVPWFByEu+GyFylYrjX6xiGhbpkgT9Rr/0e7DMSk6zh4KoJaNlKKDbbWJi+QSbz2QjN
 cJRDLpkdERdC27IT3ZF096SkTU4MPzQzE2GESIvq+yZAZBCp5jS2KcxwcyT0hDR4EwZzY1
 qROnCREuMy9yevkDyLbA2RrH2KiI5Uo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-M17FlrZGMV6oEc4xktOHnA-1; Wed, 04 Nov 2020 10:59:37 -0500
X-MC-Unique: M17FlrZGMV6oEc4xktOHnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D28C803F62;
 Wed,  4 Nov 2020 15:59:36 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4402473676;
 Wed,  4 Nov 2020 15:59:36 +0000 (UTC)
Date: Wed, 4 Nov 2020 10:59:35 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v3] qom: code hardening - have bound checking while
 looping with integer value
Message-ID: <20201104155935.GU5733@habkost.net>
References: <20200921093325.25617-1-ani@anisinha.ca>
 <20201015165215.GE5733@habkost.net>
 <CAARzgwwQAaJV=Mp=nB7FmCeZqmQO+gEBrkPiCWaVSESYYwGcbg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAARzgwwQAaJV=Mp=nB7FmCeZqmQO+gEBrkPiCWaVSESYYwGcbg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 31, 2020 at 09:51:38PM +0530, Ani Sinha wrote:
> On Thu, Oct 15, 2020 at 10:22 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > On Mon, Sep 21, 2020 at 03:03:25PM +0530, Ani Sinha wrote:
> > > Object property insertion code iterates over an integer to get an unused
> > > index that can be used as an unique name for an object property. This loop
> > > increments the integer value indefinitely. Although very unlikely, this can
> > > still cause an integer overflow.
> > > In this change, we fix the above code by checking against INT16_MAX and making
> > > sure that the interger index does not overflow beyond that value. If no
> > > available index is found, the code would cause an assertion failure. This
> > > assertion failure is necessary because the callers of the function do not check
> > > the return value for NULL.
> > >
> > > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> >
> > Queued on machine-next, thanks!  My apologies for the delay.
> 
> Any idea when this will be pulled?

I was planning to send a pull request before soft freeze,
(October 27) but this was the only patch in the queue at that
moment, so I decided to wait.

As we're beyond freeze now, the pull request will be sent
immediately after 5.2.0 is released.

-- 
Eduardo


