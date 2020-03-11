Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63475C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 07:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1F2208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 07:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU2FJrdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1F2208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvt9-0008Ok-Bb
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 03:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBvsZ-0007t6-AW
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBvsX-0000nn-R7
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:34:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50313
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBvsX-0000ls-Hj
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583912048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h907t8wwigYS7lJ8QYc8oV9fKQ3hNZzoy7H6td3knRY=;
 b=LU2FJrdGawkb8NlxVgf7MBbj4IetQFie7N2uA6qCyQ7+EPVKobiBp5bwYD7dLowt7vVz3w
 W9zC2PU4sLpVCzhIyOv9BSgH/BbQEXpp8TGPeawHUUcSYK0aKyn2CIWM/HcGnSYRcsHrdo
 OiD7OcznTIiDTuqDGj5NJIAD2IdjvyA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-Lho3QD0vP8iqWpKKHokrJA-1; Wed, 11 Mar 2020 03:34:07 -0400
X-MC-Unique: Lho3QD0vP8iqWpKKHokrJA-1
Received: by mail-qk1-f200.google.com with SMTP id z124so850922qkd.20
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 00:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wWmmjN2emBrQuRUTWFYu4uTZ/7qeOfJXpRTcVLsfP6Y=;
 b=lJdJmFoRFkFAMRS1Ky6d4woG6wxRx4wpb5c9pCAKOk+fBZHmTc8wzFa+ZDF0kPRtKD
 LEmi+ygHWIIAuEDN3clpBZRwVKbt8T65QzkOXlSv+xxx7LH3E3OOJcr/70/eOuZ62Gat
 ZHM71DDDbRH91x0pQFSUQJ18rSzECzvz4IV+pg4fRJxQpzdRNEzqZmu2MykgO9otOosZ
 AoGynAi/Z2EHaP6BqCr5kv4joOy+a36njjEnb0As94aIBr1AHxexpZSRrIN57y9SuLtk
 +8p2cwe8em/kKusjB41ugFFSFaWdFZtP75OzDV0PDMqF0f4VGdb3eLIS3pJW8xpME6IH
 QUig==
X-Gm-Message-State: ANhLgQ2EdBxB+jxNLMmh7jlSvD9yibEN/ja95b9doQ6LiNo+nN+0XdTq
 3FGJqzW4pYEBxRs3lvSP+6NkrAc/KLgQK4YbaajYIlwX2DC6Dy7Y2bbqfAFwPwcFUQHnINO37G9
 idMXhC+kAEvFUKNI=
X-Received: by 2002:ac8:7511:: with SMTP id u17mr1407574qtq.316.1583912046620; 
 Wed, 11 Mar 2020 00:34:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsy2memkrwIer82GpXu0X5zuMEo40sPu5pmORyGZKQO3pej2yyOLcMPnmsnvOh53JEvHqEByw==
X-Received: by 2002:ac8:7511:: with SMTP id u17mr1407560qtq.316.1583912046343; 
 Wed, 11 Mar 2020 00:34:06 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id h47sm6659299qtb.75.2020.03.11.00.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 00:34:05 -0700 (PDT)
Date: Wed, 11 Mar 2020 03:33:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Upstream QEMU guest support policy ? Re: [PATCH v3 0/2] spapr:
 Use vIOMMU translation for virtio by default
Message-ID: <20200311031202-mutt-send-email-mst@kernel.org>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200310114343.GD3234052@redhat.com>
 <20200311011247.GT660117@umbus.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200311011247.GT660117@umbus.fritz.box>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: pair@us.ibm.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, aik@ozlabs.ru,
 groug@kaod.org, qemu-devel@nongnu.org, paulus@samba.org, clg@kaod.org,
 mdroth@us.ibm.com, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 12:12:47PM +1100, David Gibson wrote:
> I am wondering if we have to introduce an "svm=3Don" flag anyway.  It's
> pretty ugly, since all it would be doing is changing defaults here and
> there for compatibilty with a possible future SVM transition, but
> maybe it's the best we can do :/.

Frankly I'm surprised there's no way for the hypervisor to block VM
transition to secure mode. To me an inability to disable DRM looks like
a security problem. Does not the ultravisor somehow allow
enabling/disabling this functionality from the hypervisor? It would be
even better if the hypervisor could block the guest from poking at the
ultravisor completely but I guess that would be too much to hope for.




