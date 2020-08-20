Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE7CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA702075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOlSi1uP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA702075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8lUQ-0003ld-0G
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 10:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8lTk-0003Gh-6n
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:23:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24500
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8lTh-0000VU-BH
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597933420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QaonCDNY8vYY8bPFsr0MBdbm0zYZBM54vpwexWfFKiI=;
 b=iOlSi1uP1i4jHuJhJlNizVLUvkqk3Ohvea/BH2bAUln8Xv9cOMKR6Faa+Z9YdUdWUKbfo5
 CipP8HLGre0bK/6Jd5pwVR3WlgRMjkogDrTvhtelDjbWkMIQnY9JIOqr7AUcZhs2I2CSM7
 DIiJyYKJx+55yDCsWk6zPqcBVFfmS8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-X5tGqM1OOzGmY5sRI-SICg-1; Thu, 20 Aug 2020 10:23:35 -0400
X-MC-Unique: X5tGqM1OOzGmY5sRI-SICg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE97C425E7;
 Thu, 20 Aug 2020 14:23:34 +0000 (UTC)
Received: from work-vm (ovpn-114-2.ams2.redhat.com [10.36.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78805610F3;
 Thu, 20 Aug 2020 14:23:32 +0000 (UTC)
Date: Thu, 20 Aug 2020 15:23:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 2/4] iotests.py: Add wait_for_runstate()
Message-ID: <20200820142330.GF2664@work-vm>
References: <20200818133240.195840-1-mreitz@redhat.com>
 <20200818133240.195840-3-mreitz@redhat.com>
 <753a17ec-af13-326b-1dc8-2d9881c86cd8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <753a17ec-af13-326b-1dc8-2d9881c86cd8@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 8/18/20 8:32 AM, Max Reitz wrote:
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > ---
> >   tests/qemu-iotests/iotests.py | 4 ++++
> >   1 file changed, 4 insertions(+)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> > 
> > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> > index 717b5b652c..ee93cf22db 100644
> > --- a/tests/qemu-iotests/iotests.py
> > +++ b/tests/qemu-iotests/iotests.py
> > @@ -833,6 +833,10 @@ class VM(qtest.QEMUQtestMachine):
> >                      'Found node %s under %s (but expected %s)' % \
> >                      (node['name'], path, expected_node)
> > +    def wait_for_runstate(self, runstate: str) -> None:
> > +        while self.qmp('query-status')['return']['status'] != runstate:
> > +            time.sleep(0.2)
> 
> This looks like it could inf-loop if we have a bug where the status never
> changes as expected; but I guess CI bots have timeouts at higher layers that
> would detect if such a bug sneaks in.

Although it might be useful to make sure when such a timeout lands, you
know which state you thought you were waiting for.

Dave

> > +
> >   index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
> >   class QMPTestCase(unittest.TestCase):
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


