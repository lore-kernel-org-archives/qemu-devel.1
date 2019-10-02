Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1014FC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:01:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C280221783
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C280221783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFdJn-0005N9-S9
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 08:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iFdHw-0004Ka-I5
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iFdHv-0003wp-Mx
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:59:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iFdHs-0003v7-4c; Wed, 02 Oct 2019 07:59:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DD8543082149;
 Wed,  2 Oct 2019 11:59:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D57C608C0;
 Wed,  2 Oct 2019 11:58:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9AF9A113864A; Wed,  2 Oct 2019 13:58:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 00/31] error: auto propagated local_err
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
Date: Wed, 02 Oct 2019 13:58:58 +0200
In-Reply-To: <20191001155319.8066-1-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 1 Oct 2019 18:52:48 +0300")
Message-ID: <875zl7uznh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 02 Oct 2019 11:59:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: fam@euphon.net, pburton@wavecomp.com, peter.maydell@linaro.org,
 codyprime@gmail.com, jasowang@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, quintela@redhat.com, arikalo@wavecomp.com,
 mst@redhat.com, mdroth@linux.vnet.ibm.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, joel@jms.id.au, marcandre.lureau@redhat.com,
 david@gibson.dropbear.id.au, farman@linux.ibm.com, ehabkost@redhat.com,
 sw@weilnetz.de, groug@kaod.org, yuval.shaia@oracle.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, clg@kaod.org,
 stefanha@redhat.com, david@redhat.com, jsnow@redhat.com, rth@twiddle.net,
 kwolf@redhat.com, integration@gluster.org, berrange@redhat.com,
 andrew@aj.id.au, cohuck@redhat.com, qemu-s390x@nongnu.org,
 sundeep.lkml@gmail.com, qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewing this series is finally getting close to the head of my work
queue.  I apologize for the delay.

