Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD328C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773DA20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgnW9RVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773DA20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE584-0000h6-Ko
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 01:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jE57H-00083N-GL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jE57G-0004Q9-FS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:50:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jE57G-0004O6-AL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 01:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584424214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZg4UR4sHoUpLlV+Tm1k3ru2Hi0OSWFFR+b9/HKNFHs=;
 b=KgnW9RVQ+wpU4LwYOnyfFVmrK2kDXkmkd0UGR+kamBu7Wd2OClS7V5U/G6d+LOu971ZXtD
 qHYUfahQF6j/zgvRSsH8kbjq5Z/FB6tdE5hWPh6fuINIID68vSWdO3KplADwKLu534Ls2x
 RecYSDRY4YC7OlgN05kWpl/5ZQtzcF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-yfaec4AnPVan62vMFvCJrw-1; Tue, 17 Mar 2020 01:50:12 -0400
X-MC-Unique: yfaec4AnPVan62vMFvCJrw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC914149CB;
 Tue, 17 Mar 2020 05:50:10 +0000 (UTC)
Received: from [10.72.12.89] (ovpn-12-89.pek2.redhat.com [10.72.12.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AF285C1BB;
 Tue, 17 Mar 2020 05:50:07 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] net: tulip: add .can_recieve routine
To: P J P <ppandit@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <20200303104724.233375-1-ppandit@redhat.com>
 <20200303104724.233375-3-ppandit@redhat.com>
 <20200306130853.GM1335569@stefanha-x1.localdomain>
 <nycvar.YSQ.7.76.2003162325500.5086@xnncv>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <27df2e70-936f-f989-7b6b-a00772dea0cd@redhat.com>
Date: Tue, 17 Mar 2020 13:50:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.2003162325500.5086@xnncv>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Li Qiang <pangpei.lq@antfin.com>, Sven Schnelle <svens@stackframe.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/17 =E4=B8=8A=E5=8D=882:01, P J P wrote:
>    Hello Stefan, Jason,
>
> +-- On Fri, 6 Mar 2020, Stefan Hajnoczi wrote --+
> | > +static int
> | > +tulip_can_receive(NetClientState *nc)
> | > +{
> | > +    TULIPState *s =3D qemu_get_nic_opaque(nc);
> | > +
> | > +    if (s->rx_frame_len || tulip_rx_stopped(s)) {
> | > +        return false;
> | > +    }
> | > +
> | > +    return true;
> | > +}
> |
> | Are the required qemu_flush_queued_packets() calls in place so that
> | packet transfer wakes up again when .can_receive() transitions from
> | false to true?
>
>    Yes, qemu_flush_queued_packets() calls are in tulip_write(). Do we nee=
d to
> call tulip_can_receive() before each call?


Probably not, just need to make sure the check in tulip_rx_stopped(s)=20
matches the action that triggers qemu_flush_queued_packets() in=20
tulip_write() is sufficient.

This to make sure net core can restore the receiving.

Btw, what's the point of checking rx_frame_len here?

Thanks


>
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


