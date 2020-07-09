Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B95C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A6F2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDiNt+Nd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A6F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtW6e-0004M1-64
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 08:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jtW5u-0003wi-8N
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 08:56:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46583
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jtW5s-0006cp-7V
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 08:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594299362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l26DI+sTT5dhz0yqetdedWF0Ns5eRipuuwvDkK2wSIE=;
 b=gDiNt+NdDt3i4X2zjL8KOAFRb7vfyC+fZZEOnhP1NGZJjT+0TFjtiSSRBMUAmdGVbHLOXD
 KYN6C9dyCJtgTIzBVwNnTFWPUhnbRsO57C5Sqpn7ec9fCaXhLEGZMY1aUm0Qdm2xor4ZPG
 zgbVwGJ4kqKdm405RnucHJr/3jAV4c8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-WI4zPGPmP9G5JWmksSJ8VA-1; Thu, 09 Jul 2020 08:56:00 -0400
X-MC-Unique: WI4zPGPmP9G5JWmksSJ8VA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65D851800D42;
 Thu,  9 Jul 2020 12:55:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-200.ams2.redhat.com
 [10.36.112.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14B5E7F8C3;
 Thu,  9 Jul 2020 12:55:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 521C831E58; Thu,  9 Jul 2020 14:55:58 +0200 (CEST)
Date: Thu, 9 Jul 2020 14:55:58 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] ossaudio: fix out of bounds write
Message-ID: <20200709125558.obcbkkojnrl5u635@sirius.home.kraxel.org>
References: <20200707180836.5435-1-vr_qemu@t-online.de>
 <4591613b-067d-ac5d-99d0-d8b7a3cf0ce1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4591613b-067d-ac5d-99d0-d8b7a3cf0ce1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 QEMU <qemu-devel@nongnu.org>,
 =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> > index f88d076ec2..a7dcaa31ad 100644
> > --- a/audio/ossaudio.c
> > +++ b/audio/ossaudio.c
> > @@ -691,6 +691,7 @@ static size_t oss_read(HWVoiceIn *hw, void *buf, size_t len)
> >                             len, dst);
> >                  break;
> >              }
> > +            break;
> >          }
> >  
> >          pos += nread;
> 
> ... now pos += -1, then the size returned misses the last byte.

No, it doesn't.  break leaves the while loop, not the if condition.
From patch context it isn't obvious though, you need to look at the
source code ...

Patch queued.

thanks,
  Gerd


