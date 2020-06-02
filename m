Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D797C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 09:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0418E206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 09:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cncfsmuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0418E206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg3Ch-0006aq-8h
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 05:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jg3BX-0005ba-Kw
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 05:26:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22669
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jg3BW-0004Ah-5x
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 05:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591089972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kigvxwEFdrfb480LE3Uil2qUqZavpFEGe03R1WiZ37U=;
 b=cncfsmuG0mZz0Y00ip10BGDSuSlEs9OZWBkQIbd8bLxp6Hwn13b/GrZG2iC1WIhvgKSVOR
 sU/QZEQ4Zz7gh+aD2U8kBUX4g7KWo9z8RQ88Bl5aXzG6rECmZRhMmXgCbcxWNOhT4jX1s3
 OwOQGIrdjrtGPgFVQYRfzX3DWMC3new=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-8rIkR0iRNzSk885w5RVuLw-1; Tue, 02 Jun 2020 05:26:10 -0400
X-MC-Unique: 8rIkR0iRNzSk885w5RVuLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33D1C464;
 Tue,  2 Jun 2020 09:26:09 +0000 (UTC)
Received: from work-vm (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FE8D10013C1;
 Tue,  2 Jun 2020 09:26:04 +0000 (UTC)
Date: Tue, 2 Jun 2020 10:26:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL 04/12] hmp: Simplify qom-set
Message-ID: <20200602092601.GD2758@work-vm>
References: <20200601184004.272784-1-dgilbert@redhat.com>
 <20200601184004.272784-5-dgilbert@redhat.com>
 <87pnai7ymz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87pnai7ymz.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: mszeredi@redhat.com, lukasstraub2@web.de, quintela@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Simplify qom_set by making it use qmp_qom_set and the JSON parser.
> >
> > (qemu) qom-get /machine smm
> > "auto"
> > (qemu) qom-set /machine smm "auto"
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Message-Id: <20200520151108.160598-3-dgilbert@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >   With 's'->'S' type change suggested by Paolo and Markus
> 
> This is actually more than just simplification, it's disarming a bear
> trap: the string visitor is restricted to a subset of the QAPI types,
> and when you qom-set a property with a type it can't handle, QEMU
> aborts.  I mentioned this in the discussion of possible ways out of the
> qom-get impasse, but missed reraising it in patch review.
> 
> A suitably amended commit would be nice, but respinning the PR just for
> that may not be worthwhile.

A bit late; still as long as we're removing bear traps not adding them.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


