Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F4DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C89320826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jI/N/BMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C89320826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrKbR-0006GU-M9
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 08:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jrKao-0005hj-C1
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:14:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41028
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jrKal-0002Nf-DH
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593778494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuMu68QEruiZpytF/vXpbuWpZHvA5b2Q0aHSCGLYiu0=;
 b=jI/N/BMa7R/7ob7xY7Wd0TTz0+FZxrGkLgMvRiDwTh+a18TTOsN0xfw+6d9abQVPFILyfw
 YTNSkgviiNMdOFdBXikPTRuc9bq4QLzOD1jCGzEA0EoxNGvGZFH7AwezwtGCwsgz1jydWR
 WjvEMnDwgwJ+KwFyAnmKqPxQUl9H8cQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-iO4Dk4rxOJyFNygjv0LhKQ-1; Fri, 03 Jul 2020 08:14:51 -0400
X-MC-Unique: iO4Dk4rxOJyFNygjv0LhKQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48986800400;
 Fri,  3 Jul 2020 12:14:49 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-90.ams2.redhat.com [10.36.114.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B6847FEBD;
 Fri,  3 Jul 2020 12:14:46 +0000 (UTC)
Date: Fri, 3 Jul 2020 14:14:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 01/25] iotests: Fix 051 output after
 qdev_init_nofail() removal
Message-ID: <20200703121445.GE5285@linux.fritz.box>
References: <20200624140446.15380-1-alex.bennee@linaro.org>
 <20200624140446.15380-2-alex.bennee@linaro.org>
 <20200703080728.GC5285@linux.fritz.box>
 <b91984af-ca2f-1cb2-905a-ba26212df208@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b91984af-ca2f-1cb2-905a-ba26212df208@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, f4bug@amsat.org,
 John Snow <jsnow@redhat.com>, cota@braap.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.07.2020 um 11:52 hat Max Reitz geschrieben:
> On 03.07.20 10:07, Kevin Wolf wrote:
> > Am 24.06.2020 um 16:04 hat Alex Bennée geschrieben:
> >> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> >>
> >> Commit 96927c744 replaced qdev_init_nofail() call by
> >> isa_realize_and_unref() which has a different error
> >> message. Update the test output accordingly.
> >>
> >> Gitlab CI error after merging b77b5b3dc7:
> >> https://gitlab.com/qemu-project/qemu/-/jobs/597414772#L4375
> >>
> >> Reported-by: Thomas Huth <thuth@redhat.com>
> >> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >> Reviewed-by: John Snow <jsnow@redhat.com>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> Message-Id: <20200616154949.6586-1-philmd@redhat.com>
> > 
> > Thanks, applied (this individual patch) to the block branch.
> 
> Hm, I’ve already included it in my pull request from last week:
> 
> https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg01159.html
> 
> Unfortunately, the request got no response so far.

I see. But as long as the patch is present in unchanged form in both
trees, git will sort it out.

Kevin


