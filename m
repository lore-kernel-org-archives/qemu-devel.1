Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD3C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD36720678
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjbabePV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD36720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUJg-0005kK-4V
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 04:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ipUIV-0004X8-DI
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ipUIU-0002Pa-CU
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:40:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21745
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ipUIT-0002IP-4P
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578562808;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gzDXN04f0v5UeBcLhH+xo7iBWofgVpbDdoWwOz5JAjo=;
 b=EjbabePVlYl8qDlcFuRSblc5ydgrm/rWamrLQMp8EBrPN5c0NYk9u48wucynBU1LSm1SRH
 SQyzZCc8MYOeCE5cO/InHZgMj+B52/+qRoU16t6O7DcgCjo7HvrKcK0Gqf6c0wprRmRUe1
 oVoNZHlwb5Kw8VYYTQgJsOFBbGvqvW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-88be1gg1Pve2y-XyxM_HSA-1; Thu, 09 Jan 2020 04:40:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59B73107ACC5;
 Thu,  9 Jan 2020 09:40:04 +0000 (UTC)
Received: from redhat.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0068272CC;
 Thu,  9 Jan 2020 09:40:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [Patch v2 2/6] migration/postcopy: wait for decompress thread in
 precopy
In-Reply-To: <20191107123907.29791-3-richardw.yang@linux.intel.com> (Wei
 Yang's message of "Thu, 7 Nov 2019 20:39:03 +0800")
References: <20191107123907.29791-1-richardw.yang@linux.intel.com>
 <20191107123907.29791-3-richardw.yang@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 09 Jan 2020 10:40:01 +0100
Message-ID: <87h8150xzi.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 88be1gg1Pve2y-XyxM_HSA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wei Yang <richardw.yang@linux.intel.com> wrote:
> Compress is not supported with postcopy, it is safe to wait for
> decompress thread just in precopy.
>
> This is a preparation for later patch.
>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


