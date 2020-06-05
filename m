Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A4DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9B1206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mkx4nHc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9B1206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8mg-0007Ta-Cu
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jh8ke-0003Nd-Ky
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:35:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32069
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jh8kd-0004hb-VN
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591349699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FC0ZAw+CAtmmvWLf4JTzR+T7++PvqxGrKihKuHkg04Q=;
 b=Mkx4nHc02xc+AY1Og+M8cDXDW6gzjb1Wzw9cx328Tr0N7YzlE6bHrxirI9wHFLR+ds8ent
 r/aW9di/bWmmbU4m/fVysMLKjdsVKHM5Cqd2qvqrnGsQKXa3kgSdsYMkQyV2c1VXeLu05G
 MXpbtqiB3DbFqbWU1FuOH1yl2Jf+Kpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-awnWdbxnNTirsK9DETqccw-1; Fri, 05 Jun 2020 05:34:57 -0400
X-MC-Unique: awnWdbxnNTirsK9DETqccw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6476C800685
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2020 09:34:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-112.ams2.redhat.com [10.36.113.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18F375C541;
 Fri,  5 Jun 2020 09:34:54 +0000 (UTC)
Date: Fri, 5 Jun 2020 11:34:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 0/3] python/machine.py: refactor shutdown
Message-ID: <20200605093453.GF5869@linux.fritz.box>
References: <20200604195252.20739-1-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200604195252.20739-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 04.06.2020 um 21:52 hat John Snow geschrieben:
> v3:
>  - Split _post_shutdown refactor into own patch (now 1/3)

Feels much easier to read now!

>  - Re-add sigkill warning squelch (now 3/3)
> 
> NOTE: I re-added the squelch in its own patch for review purposes, but
> for the purposes of avoiding temporary breakage, a maintainer may wish
> to squash patches 2 and 3 if they are accepted.

As I found in the v2 review that we don't even have a single user of
hard=True, I don't think it matters. A separate patch makes things
easier to understand, so I would leave it as you have it in this series.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


