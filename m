Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD68C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E793206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSNqi6PF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E793206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtcSQ-0006Y9-5l
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 15:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcRW-0005Tf-1q
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:42:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35009
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcRT-0000Ki-SP
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594323767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G1bd1SrYZiDgOSB0zDcF5RpXTAoSnowXHBTLRPspYhY=;
 b=BSNqi6PFWoRcINZ6NlKCRAsC0g3/ki/fXRAPVsHVxVWWAYY0pqk1Z6Rs9J5juwwVXekCPf
 yDUpprF8fz6lOeD4riekDQt78d0L52cdQ5UejW4IgXb0j4iUhvUepLvgP3qeesSfA2zkR4
 6q+1m9d55DFYZNwLKkVG9CbLVQJT3r8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-86YSRZvuMuidmc_BXF5CXg-1; Thu, 09 Jul 2020 15:42:43 -0400
X-MC-Unique: 86YSRZvuMuidmc_BXF5CXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 043FF100A61D;
 Thu,  9 Jul 2020 19:42:42 +0000 (UTC)
Received: from localhost (unknown [10.36.110.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C80537F8A5;
 Thu,  9 Jul 2020 19:42:37 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/13] RFC: use upcoming GUri for URI handling
Date: Thu,  9 Jul 2020 23:42:21 +0400
Message-Id: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 10:34:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

After years trying to add a glib API to handle URI, GLib 2.65.1 will finally
have one. As an exercice, I checked if the API fits qemu needs, and it seems to
be fine. It should be about as verbose as the current libxml based URI parser,
but the main benefit is that we will get rid of fairly complex URI
copied code in our tree.

The first few patches are code improvements mainly around g_auto, then the
patches to convert URI code over GUri. Obviously, it will take years before this
new API reaches old-stable distros. We may want to have a copy version of GUri,
instead of the current libxml copy as a fallback. Or we may want to keep both
current code and new GUri-based code side-by-side. I am more in favour of the
second approach, given that GUri is fresh, and may have subtle parsing
differences that better being spotted and fixed from unstable/newer distros
first. Maintaining the two side-by-side for some while shouldn't be a big
burdden, as they have a lot of similarities, and the code around it is pretty
stable.

thanks

Marc-André Lureau (13):
  uri: add g_auto macros for URI & QueryParams
  block/nbd: auto-ify URI parsing variables
  block/vxhs: auto-ify URI parsing variables
  block/sheepdog: auto-ify URI parsing variables
  block/ssh: auto-ify URI parsing variables
  block/nfs: auto-ify URI parsing variables
  block/gluster: auto-ify URI parsing variables
  build-sys: add HAVE_GLIB_GURI
  nbd: add GUri-based URI parsing version
  sheepdog: add GUri-based URI parsing
  nfs: add GUri-based URI parsing
  gluster: add GUri-based URI parsing
  ssh: add GUri-based URI parsing

 configure          |   7 +++
 include/qemu/uri.h |   3 +
 block/gluster.c    | 102 +++++++++++++++++++-----------
 block/nbd.c        | 109 +++++++++++++++++++++-----------
 block/nfs.c        | 126 ++++++++++++++++++++++---------------
 block/sheepdog.c   | 153 +++++++++++++++++++++++++++------------------
 block/ssh.c        |  94 +++++++++++++++++++---------
 block/vxhs.c       |  10 +--
 util/Makefile.objs |   2 +-
 9 files changed, 383 insertions(+), 223 deletions(-)

-- 
2.27.0.221.ga08a83db2b


