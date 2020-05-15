Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503F4C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF9C20709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJtk50Uv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF9C20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZXwr-0007YJ-5I
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 06:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZXw6-0006kR-AT
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:51:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47871
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZXw5-0004ly-9p
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589539883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1B0ECNxYRpDmsJsj55eMzBjAXwe0VMxMCOInEKzuc9g=;
 b=UJtk50UvWmuUgRiSiGSLmej1wZPOLXKlC08cuRiVnM4ELgObKKNalRNaQM5lRz1tjUQBJq
 hpb3JIF/dlkrG3l4TwJaRT7a0y/lB97nKUYyVZLRHYrneX0q1QGm8fiHvZEsSsGBY6hLuC
 ZAHaup8uDlaBtDpFUVTZTMzt2j3K8qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-OjAsHsZ2MFWa4GF3mybHtw-1; Fri, 15 May 2020 06:51:22 -0400
X-MC-Unique: OjAsHsZ2MFWa4GF3mybHtw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C21DF1005512;
 Fri, 15 May 2020 10:51:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF9EB26E41;
 Fri, 15 May 2020 10:51:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E76C016E16; Fri, 15 May 2020 12:51:18 +0200 (CEST)
Date: Fri, 15 May 2020 12:51:18 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: QEMU 5.1: Can we require each new device/machine to provided a
 test?
Message-ID: <20200515105118.zbslitc64hvjuhlt@sirius.home.kraxel.org>
References: <CAAdtpL7gSqz+R5LfbvsuxeeCzf1K-omHSeYo2eTOFYaMS1bp6A@mail.gmail.com>
 <96440c8b-7f38-8fc4-0e9c-07ad878211e2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <96440c8b-7f38-8fc4-0e9c-07ad878211e2@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-discuss@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 12:11:17PM +0200, Thomas Huth wrote:
> On 07/04/2020 12.59, Philippe Mathieu-Daudé wrote:
> > Hello,
> > 
> > Following Markus thread on deprecating unmaintained (untested) code
> > (machines) [1] and the effort done to gather the information shared in
> > the replies [2], and the various acceptance tests added, is it
> > feasible to require for the next release that each new device/machine
> > is provided a test covering it?
> > 
> > If no, what is missing?
> 
> If a qtest is feasible, yes, I think we should require one for new
> devices.

qtest is not feasible, at least not for all kinds of devices.  You can't
talk to usb devices for example, and changing that effectively requires
writing uhci/ohci/ehci/xhci drivers so one can submit usb transfers in
qtest.

The current qtests for usb devices is basically hot-plug and unplug it
and check qmp doesn't throw an error.  Better that nothing, but there is
zero functional testing and changing that is seriously non-trivial.

cheers,
  Gerd


