Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C6DC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 02:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C132B20724
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 02:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehagMjL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C132B20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEO86-0004EU-UH
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 22:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jEO7Y-0003pe-8M
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 22:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jEO7X-0006yX-Ad
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 22:07:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jEO7X-0006wf-5e
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 22:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584497266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUU1HuVstjOPX/uBOLxUGP6H8lViSDP60G5UcEUhkI4=;
 b=ehagMjL2imHUeOKB9lw4jPRsTRG3XvyGX6Dm5i5RGgennQK8eMiKDDFRW/O1YgBhQWJD6K
 MBkd8fzckPl5z8O6E7iqwqFI6GpEMpQAseQ/dLuntHNjXvO++eim9+18yZcBefYL7UCYPo
 Ww3MiRFRNFv4qVOLCqLd6zFE8/ucYJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-uuVb6Ql7PnuqjiN2SU6kSQ-1; Tue, 17 Mar 2020 22:07:42 -0400
X-MC-Unique: uuVb6Ql7PnuqjiN2SU6kSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6587B13F9;
 Wed, 18 Mar 2020 02:07:41 +0000 (UTC)
Received: from [10.72.13.166] (ovpn-13-166.pek2.redhat.com [10.72.13.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58E8190814;
 Wed, 18 Mar 2020 02:07:36 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] net: tulip: add .can_recieve routine
To: P J P <ppandit@redhat.com>
References: <20200303104724.233375-1-ppandit@redhat.com>
 <20200303104724.233375-3-ppandit@redhat.com>
 <20200306130853.GM1335569@stefanha-x1.localdomain>
 <nycvar.YSQ.7.76.2003162325500.5086@xnncv>
 <27df2e70-936f-f989-7b6b-a00772dea0cd@redhat.com>
 <nycvar.YSQ.7.76.2003171543480.5086@xnncv>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <976adb02-5653-2f57-555d-c41b8d392fc1@redhat.com>
Date: Wed, 18 Mar 2020 10:07:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.2003171543480.5086@xnncv>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Sven Schnelle <svens@stackframe.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Ziming Zhang <ezrakiez@gmail.com>,
 Li Qiang <pangpei.lq@antfin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/17 =E4=B8=8B=E5=8D=886:49, P J P wrote:
> +-- On Tue, 17 Mar 2020, Jason Wang wrote --+
> | > +-- On Fri, 6 Mar 2020, Stefan Hajnoczi wrote --+
> | > | > +static int
> | > | > +tulip_can_receive(NetClientState *nc)
> | > | > +{
> | > | > +    TULIPState *s =3D qemu_get_nic_opaque(nc);
> | > | > +
> | > | > +    if (s->rx_frame_len || tulip_rx_stopped(s)) {
> | > | > +        return false;
> | > | > +    }
> |
> | Btw, what's the point of checking rx_frame_len here?
>
> tulip_can_recive() is called from tulip_receive(). IIUC non zero(0)
> 'rx_frame_len' hints that s->rs_frame[] buffer still has unread data byte=
s and
> it can not receive new bytes. The check was earlier in tulip_receive().


Right, so need to make sure qemu_flush_ququed_packets() was called when=20
rx_frame_len is zero.

Thanks



>
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


