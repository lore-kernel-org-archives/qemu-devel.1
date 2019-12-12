Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A612C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 07:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D5022B48
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 07:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfumLUxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D5022B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifIdO-0002Ip-9x
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 02:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ifIcj-0001ta-PD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 02:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ifIcg-0005ry-Fg
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 02:10:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50370
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ifIcf-0005oJ-AD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 02:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576134652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Q3gWoke/Mmt2LdjTNxu5LxrutckF6bZ7hIcIermqnBo=;
 b=dfumLUxcyLcxCdWNI/EoyrCYzPXUrltIADuOQhTbBzDix14YUm49OYwlto7tFzXmDsAcum
 Kol+1LphMEP4c0HXYCyirefNPe0OnC4RvOdjPpGOj2OHfgUoN0ZEFfbMLhmT2UnDFft+4R
 QK0wtTfxVyNZMSFTllUbLG+YYXut6zA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-4KPQ5xJCPZ2RAz2r5XbUZg-1; Thu, 12 Dec 2019 02:10:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E32FDDB90
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 07:10:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBF3760BF1;
 Thu, 12 Dec 2019 07:10:45 +0000 (UTC)
Subject: Re: [PATCH v2] configure: simplify vhost condition with Kconfig
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576110624-33604-1-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c52c11d9-14bf-440a-3acf-e6a2c42baa81@redhat.com>
Date: Thu, 12 Dec 2019 08:10:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1576110624-33604-1-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 4KPQ5xJCPZ2RAz2r5XbUZg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/2019 01.30, Paolo Bonzini wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Kconfig.host            | 5 +++++
>  Makefile                | 1 +
>  hw/virtio/Kconfig       | 3 +++
>  hw/virtio/Makefile.objs | 4 ++--
>  4 files changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


