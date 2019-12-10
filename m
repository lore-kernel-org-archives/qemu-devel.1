Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7326DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F50620637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cft5IDNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F50620637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iekyf-0004Yy-9A
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 14:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iekxs-000439-HH
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:14:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iekxq-0007jA-IL
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:14:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47259
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iekxq-0007im-Ek
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576005269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QYz/6hrb7cqbBbeqZPE4uGuRtTwhiU/auYfMMLJF+NI=;
 b=Cft5IDNLAi4HU75RJ8atiBcGTWLrnWSnsnw2zxZj1Erz+0LFDHOqCdyINhCSF/7IUB1zEI
 uQtH6iRaXqWvc1R86D6uCFPpE7sD/s6Fz3NQOthmPnovrWw6ZQTIFkD10agRF4aykZeglO
 ub+U97BUCYYcbyu/7Cxt7LjUlGesDi0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-hWWhZvOhM6yv3A8rFWH4Xg-1; Tue, 10 Dec 2019 14:14:26 -0500
Received: by mail-qv1-f70.google.com with SMTP id r8so7498915qvp.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 11:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=t5NRopCXac/TaVRyYxckA1Ih+aNBJ6X1xXjY0vMyIYY=;
 b=WxIG3Y7tzK+qRF/iglAtT7Qu6F0SKXJMnvIe8Ka+poud3EHsYPzxxfj0lGAzDzfg9n
 1oaXP37eMjcx8CFEV/EWHTT/xru/tjVjQdM3iGrFsAj8AsRg9ooQ5L8viUkW70CqPiic
 zVECIMCixxs95EQwjHPBFgqM/IT0Rytl1PthdSRyxLTkLnqw3tQsGnRA09G1Ow7Fdf7r
 uk9JAorVsC61Xy11xIWz5UBtVy3f4KzYUsyKwJqIbgpIWfzLb8dI579kVXpfiV8RwgqF
 aSpJyQRVdlPjUC08EgPIK81SVDP9GG40tCK8lU+BvKoYK8ignxzwYGzIva3nbxAjalnd
 oA5w==
X-Gm-Message-State: APjAAAVKVQVDcc6H5j3w8DwNlrUklDSMC3FHyGE0p+3zz5GE8/wo+eC5
 cT0zaB14JmBbLwG1ljXH148pBKaeQJo4CYIWCp1PnzG0K86Sr/gaVTkmVUPP9bNHl0QxVPKuWuV
 ovvz64YgWMMzK/gY=
X-Received: by 2002:a05:620a:2010:: with SMTP id
 c16mr33446201qka.386.1576005265883; 
 Tue, 10 Dec 2019 11:14:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzLgHPu+HZpHBt7nfHOD0/Jgw6wPXTMskIpbGw97FKu4VzSaxBGLM63tD2FV7Gx0R0faTKS6w==
X-Received: by 2002:a05:620a:2010:: with SMTP id
 c16mr33446170qka.386.1576005265597; 
 Tue, 10 Dec 2019 11:14:25 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id e2sm1211935qkb.112.2019.12.10.11.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 11:14:24 -0800 (PST)
Date: Tue, 10 Dec 2019 14:14:23 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 03/20] virtio-iommu: Decode the command payload
Message-ID: <20191210191423.GH3352@xz-x1>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-4-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191122182943.4656-4-eric.auger@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-MC-Unique: hWWhZvOhM6yv3A8rFWH4Xg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 07:29:26PM +0100, Eric Auger wrote:
> This patch adds the command payload decoding and
> introduces the functions that will do the actual
> command handling. Those functions are not yet implemented.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

I would simply squash this into previous patch to avoid removing lines
from newly introduced, but this is ok too so to keep Jean's r-b:

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


