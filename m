Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFBBC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 04:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8481021534
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 04:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ev6t9tz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8481021534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ8Re-0002K3-C5
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 00:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kJ8QG-0001p3-Ni
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 00:55:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60807
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kJ8QE-0000kD-Jc
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 00:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600404897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kVLlGhD+2Khoqj/6Z4qTl7eIQV2a4uGKrDURMlC6RJc=;
 b=Ev6t9tz4GkXSmo7pm0JI9Hq3nrfPnFpkWSdx/qQbaEasJYYAoeSLKKZlAsdZ+CbiEGrxfq
 60MitH1MNHYJugMGENYgKjSu1PyBVTnqXOP2WZXji4vpX+xOHOAArnssgbk610QngkrduJ
 CsYh6AffGnGWdYKB9vwN0F1tW41S5Lc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-KRFeHM1xM92Ii_ty4Ma3Jg-1; Fri, 18 Sep 2020 00:54:51 -0400
X-MC-Unique: KRFeHM1xM92Ii_ty4Ma3Jg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3C751084C92;
 Fri, 18 Sep 2020 04:54:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7499155772;
 Fri, 18 Sep 2020 04:54:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 43D8816E16; Fri, 18 Sep 2020 06:54:43 +0200 (CEST)
Date: Fri, 18 Sep 2020 06:54:43 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] tests/acceptance: Disable tests dependent of unreliable
 apt.armbian.com
Message-ID: <20200918045443.ecedbqhkkg4c2wjq@sirius.home.kraxel.org>
References: <20200917163954.50514-1-philmd@redhat.com>
 <308aaf63-a9a4-256e-a29f-9d0bd1c53532@redhat.com>
 <450f5b49-6309-5806-9ab2-4fad6a06e180@redhat.com>
MIME-Version: 1.0
In-Reply-To: <450f5b49-6309-5806-9ab2-4fad6a06e180@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:54:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 07:01:22PM +0200, Philippe Mathieu-Daudé wrote:
> On 9/17/20 6:53 PM, Thomas Huth wrote:
> > On 17/09/2020 18.39, Philippe Mathieu-Daudé wrote:
> >> Armbian servers are not very reliable and confused the GitLab CI
> >> users a few times this month (path updated, archives moved, and
> >> now the SSL: CERTIFICATE_VERIFY_FAILED "certificate has expired"
> >> error). Time to disable these tests.
> >> Users can still use the artifacts from the cache (or manually add
> >> them to the cache).
> >>
> >> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> >> ---
> >>  tests/acceptance/boot_linux_console.py | 10 ++++++++++
> >>  tests/acceptance/replay_kernel.py      |  2 ++
> >>  2 files changed, 12 insertions(+)
> > 
> > These failures in the Gitlab-CI are quite annoying, indeed.
> 
> I'd rather not go via this path, but since we don't save the
> artifacts cache, I can't find a better way to not block all
> the other developers using GitLab CI.

Well, we would need to cache them somewhere, either on qemu.org,
or maybe have a download job in ci which publishes them on
qemu.gitlab.io (gitlab pages).

> But I prefer we disable the tests until something better
> emerge, rather that having the developers stopping running
> these tests. So this is a quick band-aid patch.

Yep, lets disable them until we have a solution.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd


