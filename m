Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5B3C55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677B220575
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwC1sFZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677B220575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT1Ac-0004jC-Jj
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 06:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jT19x-0004AQ-Dm
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jT19w-000101-S6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:38:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44326
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jT19w-0000t1-E8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587983923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUulwsEpKevjayz1bGYj31B0m/S9LzkEBVzf57YWmiU=;
 b=UwC1sFZkqlQRhKQIHIGcYGXPskTUcoy9kCZoKvJi/zqX10A59oBt5N70/5U/GLXHVztkho
 8QQb0JBsNFf0haQx4HwMF0k8dbkrEAgYbPY/i0urYYCsAmBJ2BXnpMQp2oXgRIUF4KHWt/
 De0bM1ICm+slDLNopSkouQRdFIK1Egg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-JlzHdqquMDSd1AWUpAvV0g-1; Mon, 27 Apr 2020 06:38:41 -0400
X-MC-Unique: JlzHdqquMDSd1AWUpAvV0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3031A45F;
 Mon, 27 Apr 2020 10:38:40 +0000 (UTC)
Received: from gondolin (ovpn-112-184.ams2.redhat.com [10.36.112.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C65161374;
 Mon, 27 Apr 2020 10:38:36 +0000 (UTC)
Date: Mon, 27 Apr 2020 12:38:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: VIRTIO_NET_HDR_F_RSC_INFO in virtio-net vs headers update
Message-ID: <20200427123833.52ef442a.cohuck@redhat.com>
In-Reply-To: <CAOEp5OdSnxMO-BY+8NLwntjpr3CGvfh0ECHHB0w7PVAZ7OArog@mail.gmail.com>
References: <20200427093345.4111acd9.cohuck@redhat.com>
 <8a559698-fb15-1f38-2fad-ee5db27f81f4@redhat.com>
 <20200427111029.703f8703.cohuck@redhat.com>
 <20200427051713-mutt-send-email-mst@kernel.org>
 <CAOEp5OdSnxMO-BY+8NLwntjpr3CGvfh0ECHHB0w7PVAZ7OArog@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:32:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Apr 2020 12:52:26 +0300
Yuri Benditovich <yuri.benditovich@daynix.com> wrote:

> I'd suggest to do the single change in virtio-net.c with RSC definitions
> from updated linux headers.
> I can send respective patch if you want

Hm, I already sent something out before I saw your mail... can you
please look at that one?


