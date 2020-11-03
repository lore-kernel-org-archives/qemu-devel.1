Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B520DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DC020731
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JA5a2tMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DC020731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvu2-00010a-3M
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZvsd-0008SZ-Rj
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:57:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZvsb-0004En-QK
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604408261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cc1svOEIc5pb8myGGysYDT4ZTuzE6gFfPK80YeeNmBg=;
 b=JA5a2tMdBCf4/b1NFAAG0Yc1YUX5GNK4gA8FxwUJCJBZjxoXpGGaSEFFtCSq180ZUmw79l
 3YgV3vXN1TBgbc1y1Nt55Iu73hRVV0ljgabvUbebBfM8g57KajNXeDg2i8b3HWEwrM3gMa
 tqOFrRf4Y3YHJZzkygrXDbqhX6/QdCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-qBRVbsMGO9Cg9qRlZ8uQQQ-1; Tue, 03 Nov 2020 07:57:39 -0500
X-MC-Unique: qBRVbsMGO9Cg9qRlZ8uQQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFF7B1084C80
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 12:57:38 +0000 (UTC)
Received: from localhost (unknown [10.40.208.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E03A55C5FD;
 Tue,  3 Nov 2020 12:57:37 +0000 (UTC)
Date: Tue, 3 Nov 2020 13:57:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 00/37] cleanup qemu_init and make sense of
 command line processing
Message-ID: <20201103135735.029c9b6d@redhat.com>
In-Reply-To: <6c08fbaa-57aa-b2da-c90a-6b53f628806a@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
 <20201102165756.69540720@redhat.com>
 <6c08fbaa-57aa-b2da-c90a-6b53f628806a@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 17:34:00 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 02/11/20 16:57, Igor Mammedov wrote:
> >> The main improvements with respect to v1 are:  
> > series no longer applies to master
> > what commit if was based on?
> >   
> 
> It's based on 20201026143028.3034018-1-pbonzini@redhat.com (which you
> should be able to get through patchew).

Not sure what you mean and how to do that.
Is it possible to share v2 as a git tree somewhere?

> 
> Paolo
> 


