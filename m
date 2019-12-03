Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C93C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6433C2068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IH+ePVYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6433C2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic82j-0006n3-5r
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ic7pw-0006os-5N
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ic7pi-0008Rs-6S
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:03:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24541
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ic7ph-0008Ju-TI
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575378191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DsczsJ0GwPBiXFehnkR0bCjNxg1MxtTkH7JL3pt4hMk=;
 b=IH+ePVYWILyw7gNjWYhs3sr2VZ2EEBSrMttwQFDy3Ew3cNPbdbEA6XRO5VoccRWu+TCF1M
 bcwa5URlLuqL5CFDbxcAQYQCfA/bOS2+B3IKICf+GyAGqyHsYgVEFh6EDt/UVftBdqeKvQ
 eqs8DKguYIyhKSTLo7UeRuOSBrvqiFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-L76qWnsjNy6T3lOo-9iLWw-1; Tue, 03 Dec 2019 08:03:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 860961883540
 for <qemu-devel@nongnu.org>; Tue,  3 Dec 2019 13:03:08 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 072295D6A7;
 Tue,  3 Dec 2019 13:02:53 +0000 (UTC)
Date: Tue, 3 Dec 2019 13:02:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: virtiofsd: Where should it live?
Message-ID: <20191203130250.GD3078@work-vm>
References: <20191125185021.GB3767@work-vm>
 <20191126102600.GG556568@redhat.com>
 <20191126121416.GE2928@work-vm>
 <db27af39-62a8-46e5-fccd-f09ed497b7bd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <db27af39-62a8-46e5-fccd-f09ed497b7bd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: L76qWnsjNy6T3lOo-9iLWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: mszeredi@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 26/11/19 13:14, Dr. David Alan Gilbert wrote:
> >> IOW, if we did decide we want it in QEMU, then instead of
> >> '$GIT/contrib/virtiofsd', I'd prefer to see '$GIT/virtiofsd'.
> >
> > I'm not sure it deserves a new top level for such a specific tool.
> >=20
>=20
> It could be in fsdev/virtiofsd,

fsdev is currently all 9p stuff, so that would seem very confusing.

> but I agree with Daniel that at this
> point the QEMU build system introduces baggage that you may not want for
> virtiofsd.

I've already got it wired up in contrib with qemu's build system
so that doesn't seem to be an issue.   The question is purely a 'where'.

Dave

> Paolo
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


