Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238ACC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CBC20725
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3BuqkEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CBC20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1Lg-0005f3-Pv
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amorenoz@redhat.com>)
 id 1kL1KV-0004as-LH
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <amorenoz@redhat.com>)
 id 1kL1KT-00074o-F7
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600854286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P/7T/4JxjbU4RM4QDLjtRIVhPgsawxmcFdZoMNDAIis=;
 b=N3BuqkECfw9j7gV5K5ehTig9OzVDxxXQ/F9Lq9ry5seCah1iHympPZYYd3QYKemRFgUZyb
 qYvSb5ItPDARAiWAIliv46aMbY3BXCIEb2Cc+Vb0YvMYg8BF4i66+NQxG0FiX2hh2q8GGF
 J5nDTb4Z5GgHn7LH1fEeo8195GnCjZI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-AZEeIg-NN26xCtB_q5dbMg-1; Wed, 23 Sep 2020 05:44:44 -0400
X-MC-Unique: AZEeIg-NN26xCtB_q5dbMg-1
Received: by mail-wm1-f71.google.com with SMTP id b14so1166191wmj.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 02:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=P/7T/4JxjbU4RM4QDLjtRIVhPgsawxmcFdZoMNDAIis=;
 b=jLUgksKkObM9iXJCkUMzamet0EAudouVvXs/OgKL4cZmkS1IbQkoFqUApTo0xo8DEs
 T6j6Z68OhX77WxNRiuP94fcdcr+LViJOxzduYA/R12gJFmr/QY0gK8HgviP9EVzFzeXD
 nTQ07y65QYuEPDO3c96UP3bDVhQU0xWNoTRGXBd0SETV9/fV96brvAwqv1oJFZqHK7w0
 9ta93UDy31S5W24YayqqCBz8jd98nCPMmNQUTY5YlsTPakLtsNmXKRjoG+Vg3kaOi/vE
 djSkKy+pA1zEfa6vApfCnzDS67HiRO29FGLuAdiyFT8+t4YZ2uDNXGz/VQk/Q2TUFX/i
 JZXg==
X-Gm-Message-State: AOAM533k+upFklPqdD4xPD8ugRqWqpyi+E7WQ8WJraIO0KQTD3QuHBuR
 /FjiPe693F0GC3g8UK5GhFWUbsIhBpbBwQfyRreAZAEYY2Xx/gTVrxLeT6dV5wclPXJxFQFFUhJ
 ifgR/5cJeCfEqc+A=
X-Received: by 2002:a7b:c8cc:: with SMTP id f12mr5310939wml.169.1600854282760; 
 Wed, 23 Sep 2020 02:44:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwV4Qr5WfEoMe1WvH5ynWfG5h2z0FKEiE3rPGFi1MKuG5ZSyJoCy/5uhvOi721L4kvtlIbm5Q==
X-Received: by 2002:a7b:c8cc:: with SMTP id f12mr5310919wml.169.1600854282552; 
 Wed, 23 Sep 2020 02:44:42 -0700 (PDT)
Received: from amorenoz.users.ipa.redhat.com ([94.73.56.18])
 by smtp.gmail.com with ESMTPSA id e13sm34011399wre.60.2020.09.23.02.44.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 02:44:41 -0700 (PDT)
Subject: Re: [PATCH] vhost-user: save features of multiqueues if chardev is
 closed
To: =?UTF-8?B?aGFpYmluemhhbmco5byg5rW35paMKQ==?= <haibinzhang@tencent.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <46CBC206-E0CA-4249-81CD-10F75DA30441@tencent.com>
From: Adrian Moreno <amorenoz@redhat.com>
Autocrypt: addr=amorenoz@redhat.com; prefer-encrypt=mutual; keydata=
 mDMEX1iJRRYJKwYBBAHaRw8BAQdA9XK4r7431HtX+egvecRuaWTqF3VdWszR6pK3IyLHFW20
 I0FkcmlhbiBNb3Jlbm8gPGFtb3Jlbm96QHJlZGhhdC5jb20+iJYEExYIAD4WIQTCvo3bo2x3
 f+vPxWuVGptW5xa95gUCX1iJRQIbAwUJCWYBgAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
 CRCVGptW5xa95hNyAQDGrMiGEiW/RgXzO+UgmZeuGOhl2Jo0m7XKCyM4E281eQEAlJ/5Nr16
 IdnEqtoYGbKE2WknEEAAx2oOGldEm5N+/Qi4OARfWIlFEgorBgEEAZdVAQUBAQdAkc5hZG7i
 IpK4cjpZYqrw7W5UbePUuaFbf+1oyDGofncDAQgHiH4EGBYIACYWIQTCvo3bo2x3f+vPxWuV
 GptW5xa95gUCX1iJRQIbDAUJCWYBgAAKCRCVGptW5xa95t7NAQDQ45Y5xAbZ/X6W05G0VeCA
 xDRcmRnbPXbrfuXSdBI57gEA9pDtbcYXFEXvZaNc4JSwYC6sIa51ohTRuAfoJ26Amgc=
Message-ID: <31d9f70a-f4b8-bc83-aa5d-c71e2b31e3f5@redhat.com>
Date: Wed, 23 Sep 2020 11:44:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <46CBC206-E0CA-4249-81CD-10F75DA30441@tencent.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=amorenoz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=amorenoz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: "xtay.haibin@gmail.com" <xtay.haibin@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks Haibin,


On 9/22/20 5:27 AM, haibinzhang(张海斌) wrote:
> Fore-commit(c6beefd674) only saves features of queue0,
> this makes wrong features of other queues in multiqueues
> situation.
> For examples:
>   qemu-system-aarch64 ... \
>   -chardev socket,id=charnet0,path=/var/run/vhost_sock \
>   -netdev vhost-user,chardev=charnet0,queues=2,id=hostnet0 \
>   ...
> There are two queues in nic assocated with one chardev.
> When chardev is reconnected, it is necessary to save and
> restore features of all queues.
> 
> Signed-of-by: Haibin Zhang <haibinzhang@tencent.com>
> 


Indeed, this fixes the issue of vhost-user reconnection on multiqueue that I've
also reproduced, thanks for posting it.

However, I'd like to ask some questions to the experts:
- Why do we need a feature negotiation per queue-pair on vhost-user?
- Maybe I'm missing something but, isn't the problem that vhost-user device is
reusing vhost_net layer (which forces nqueues = 2)?
- Won't we have the same issue with vdpa?

---
>  net/vhost-user.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 17532daaf3..ffbd94d944 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -226,7 +226,7 @@ static void chr_closed_bh(void *opaque)
>      NetClientState *ncs[MAX_QUEUE_NUM];
>      NetVhostUserState *s;
>      Error *err = NULL;
> -    int queues;
> +    int queues, i;
>  
>      queues = qemu_find_net_clients_except(name, ncs,
>                                            NET_CLIENT_DRIVER_NIC,
> @@ -235,8 +235,12 @@ static void chr_closed_bh(void *opaque)
>  
>      s = DO_UPCAST(NetVhostUserState, nc, ncs[0]);
>  
> -    if (s->vhost_net) {
> -        s->acked_features = vhost_net_get_acked_features(s->vhost_net);
> +    for (i = queues -1; i >= 0; i--) {
> +        s = DO_UPCAST(NetVhostUserState, nc, ncs[i]);
> +
> +        if (s->vhost_net) {
> +            s->acked_features = vhost_net_get_acked_features(s->vhost_net);
> +        }
>      }
>  
>      qmp_set_link(name, false, &err);
> 

Thanks
-- 
Adrián Moreno


