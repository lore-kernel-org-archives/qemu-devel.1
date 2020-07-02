Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40601C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08998206E2
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyopDuP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08998206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr0VD-0000cS-B6
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 10:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jr0Uc-0008TZ-OB
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:47:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38666
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jr0Ua-00037s-J1
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593701231;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=eWPQgJ6prxYRJPsbRgwOAP1yeEiLzQQQn0RUD+BiLKU=;
 b=MyopDuP/FiUqSbAmqndiF8JV0DeA3sTk0wC3Enob75dbcwoXfBAwoFdL6b1gzJl8OUF8a+
 7+5sMrL0ds2kY+PUrJuYdvXb9XX6I+D3qDcVU2HVnlOaoIJfmoksS/9Z9U0dm/4JwMV7rz
 fWv5Z6HNrAYDc2o5xNHahL/PDSXggqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-rm0lo5BTNpeaoXDx3E88nA-1; Thu, 02 Jul 2020 10:46:56 -0400
X-MC-Unique: rm0lo5BTNpeaoXDx3E88nA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C940100A8FB;
 Thu,  2 Jul 2020 14:46:55 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8EE56198A;
 Thu,  2 Jul 2020 14:46:53 +0000 (UTC)
Date: Thu, 2 Jul 2020 15:46:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] configure / util: Auto-detect the availability of
 openpty()
Message-ID: <20200702144650.GM1888119@redhat.com>
References: <20200702143955.678-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200702143955.678-1-thuth@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Tribble <peter.tribble@gmail.com>, qemu-devel@nongnu.org,
 Michele Denber <denber@mindspring.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 02, 2020 at 04:39:55PM +0200, Thomas Huth wrote:
> Recent versions of Solaris (v11.4) now feature an openpty() function,
> too, causing a build failure since we ship our own implementation of
> openpty() for Solaris in util/qemu-openpty.c so far. Since there are
> now both variants available in the wild, with and without this function,
> let's introduce a proper HAVE_OPENPTY define for this to fix the build
> failure.

11.4 has been out since Aug 2018

The previous verison of solaris  11.3 was from Oct 2015, with EOL
in Oct 2020 [1].

Solaris isn't an officially supported platform for QEMU, but if it
was, then we'd probably consider it a long life distro, and thus
consider 11.3 to be out of scope for QEMU by now.

IOW, instead of checking for openpty being missing, I think there's
a decent argument to be made that we can just assume openpty exists,
and delete the old solaris compat code entirely.

Regards,
Daniel

[1] https://en.wikipedia.org/wiki/Solaris_(operating_system)

-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


