Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EB7C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12EA12083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfScY/8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EA12083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWlmU-0005hh-A1
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 15:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWllJ-0004z3-Qn
 for qemu-devel@nongnu.org; Thu, 07 May 2020 15:00:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49612
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWllI-0005Lo-0h
 for qemu-devel@nongnu.org; Thu, 07 May 2020 15:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588878046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VD+nov8O2NOuFyFaNEepr2Eo9CKau2eXJqZn2K6MFG8=;
 b=GfScY/8e7cJfJozxYJapfVDrCE25qo6EMmDcT9HD9beneOLmQnIEP73Yq8HbEDaz60cf/J
 s7OCgrZihFtdlsPNNj50cj1WWEsUcnQP3yENT/uESUSaUl0Ku4AfgDQNp0LEWx+zHWzYdM
 fiJ0E3kx+OffGog+gfYO8YpJSiwYvt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-fX8tZLlcMdeCKw2TJ4d0fQ-1; Thu, 07 May 2020 15:00:42 -0400
X-MC-Unique: fX8tZLlcMdeCKw2TJ4d0fQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CED711005510;
 Thu,  7 May 2020 19:00:41 +0000 (UTC)
Received: from work-vm (ovpn-114-224.ams2.redhat.com [10.36.114.224])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DCF970545;
 Thu,  7 May 2020 19:00:31 +0000 (UTC)
Date: Thu, 7 May 2020 20:00:28 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 09/13] migration/ram: Consolidate variable reset after
 placement in ram_load_postcopy()
Message-ID: <20200507190028.GH2699@work-vm>
References: <20200421085300.7734-1-david@redhat.com>
 <20200421085300.7734-10-david@redhat.com>
 <20200424102514.GD3106@work-vm> <20200507154245.GF17348@work-vm>
 <e6df0abf-2993-7dfe-eeaa-164f0eabc9db@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e6df0abf-2993-7dfe-eeaa-164f0eabc9db@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> On 07.05.20 17:42, Dr. David Alan Gilbert wrote:
> > * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> >> * David Hildenbrand (david@redhat.com) wrote:
> >>> Let's consolidate resetting the variables.
> >>>
> >>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >>> Cc: Juan Quintela <quintela@redhat.com>
> >>> Cc: Peter Xu <peterx@redhat.com>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>
> >> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >=20
> > Queued this one only; I had to do manual patch application due to some
> > renaming in 91ba442; but I think it's still OK.
>=20
> Thanks, how to best proceed with the other 12 patches in this series?

Yeh I need to look at some of them; but they're buried in the other ~200
outstanding mails in my inbox.

Dave

>=20
> --=20
> Thanks,
>=20
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


