Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61788C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 19:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8B920866
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 19:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvIznoWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8B920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCpAO-0008P0-AV
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 15:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kCp9p-0007lp-Hm
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 15:07:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24680
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kCp9n-0002Uy-S0
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 15:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598900874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+/pKY0nhiISGXGldNz0KfZWveXa0TVbJnM1YBpGRnX4=;
 b=YvIznoWYZXyNhdJTXiHuuh9fl84Nv705bGE44wZcEHnOr85GYax1QpUVIF6y4Ec4P9yiw7
 y6iJDmdoIQiMx+MnXwP8sZUHkuUllHjrtB4GWC3E9fhGcpBQpaW8PUluRjKgreG0z3GrXO
 sQ/Syx9HX4BQeDEY8bXMPwITU+ON8BU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-zP6j7sMnO4-VIYnS4ddJ9A-1; Mon, 31 Aug 2020 15:07:52 -0400
X-MC-Unique: zP6j7sMnO4-VIYnS4ddJ9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51D081888A18;
 Mon, 31 Aug 2020 19:07:49 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33BCE5C1BB;
 Mon, 31 Aug 2020 19:07:36 +0000 (UTC)
Date: Mon, 31 Aug 2020 15:07:35 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 00/74] qom: Automated conversion of type checking
 boilerplate
Message-ID: <20200831190735.GB4940@habkost.net>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200831172314.GA4940@habkost.net>
 <CAFEAcA8QawQfy1qOpf5T-Oqj_14cOCfPQVvEh5vL-FAug3pL1A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8QawQfy1qOpf5T-Oqj_14cOCfPQVvEh5vL-FAug3pL1A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:06:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>,
 Anthony PERARD <anthony.perard@citrix.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 31, 2020 at 07:52:39PM +0100, Peter Maydell wrote:
> On Mon, 31 Aug 2020 at 18:23, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > On Tue, Aug 25, 2020 at 03:19:56PM -0400, Eduardo Habkost wrote:
> > > git tree for this series:
> > > https://github.com/ehabkost/qemu-hacks/tree/work/qom-macros-autoconvert
> > >
> > > This is an extension of the series previously submitted by
> > > Daniel[1], including a script that will convert existing type
> > > checker macros automatically.
> >
> > I'm now queueing the following on machine-next:
> >
> > [PATCH v3 44/74] imx_ccm: Rename IMX_GET_CLASS macro
> > [PATCH v3 45/74] mos6522: Rename QOM macros
> > [PATCH v3 51/74] arm: Fix typo in AARCH64_CPU_GET_CLASS definition
> > [PATCH v3 52/74] rx: Rename QOM type check macros
> > [PATCH v3 53/74] rx: Move typedef RXCPU to cpu-qom.h
> 
> I've just sent reviewed-bys for these ones. (Wasn't sure enough
> about the other two.)

Thanks!  I will update the branch before sending a pull
request.

-- 
Eduardo


