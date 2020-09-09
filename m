Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214B3C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 01:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78EEA216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 01:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhTuZ7vO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EEA216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFpJF-0001ZZ-Lz
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 21:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kFpIe-00018v-K2
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 21:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kFpIc-0004eg-SS
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 21:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599616405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0rFs6hRZZhMyU2O26Eu2GqiM3+cBj4X9GF2sNHeaa0=;
 b=AhTuZ7vOyGFCZI1NgJZW1ZLPQroGnwO3XWpsRvxeS5gZr91BBKNwwH6aKvsvLVvrwSyOX2
 3zP/NfVL3r1Hezwgw0fhVZjCdDw/D0gSPv/t8cTwsR0QXlEv6a8HBUAgPBfcwcN1Thh/A/
 skHrTz5NS4mVqivM0XQQfUzuDjmVyEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-WJWXEMshN8SkxCnakYKlqQ-1; Tue, 08 Sep 2020 21:53:23 -0400
X-MC-Unique: WJWXEMshN8SkxCnakYKlqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27C6A1074642
 for <qemu-devel@nongnu.org>; Wed,  9 Sep 2020 01:53:23 +0000 (UTC)
Received: from [10.72.12.24] (ovpn-12-24.pek2.redhat.com [10.72.12.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E529760C15;
 Wed,  9 Sep 2020 01:53:21 +0000 (UTC)
Subject: Re: [PATCH 2/2] vhost-vdpa: improve error reporting
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200903185327.774708-1-lvivier@redhat.com>
 <20200903185327.774708-3-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <38c8862b-e033-1b8c-33bd-5b1f0cd37a01@redhat.com>
Date: Wed, 9 Sep 2020 09:53:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903185327.774708-3-lvivier@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 20:56:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/4 上午2:53, Laurent Vivier wrote:
> Use Error framework to report the id of the device and the details of
> the error (vhostdev name and errno).
>
> For instance:
>
>   qemu-system-x86_64 ... -netdev vhost-vdpa,id=hostnet1 ...
>   hostnet1: Cannot open '/dev/vhost-vdpa-0': No such file or directory
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   net/vhost-vdpa.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)


Hi Laurent:

If you don't mind I will add this patch to v2 of my series[1]

Thanks

[1] 
https://lore.kernel.org/qemu-devel/20200831082737.10983-1-jasowang@redhat.com/


> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 24103ef241e4..8260902334ae 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -176,7 +176,8 @@ static NetClientInfo net_vhost_vdpa_info = {
>   };
>   
>   static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
> -                               const char *name, const char *vhostdev)
> +                               const char *name, const char *vhostdev,
> +                               Error **errp)
>   {
>       NetClientState *nc = NULL;
>       VhostVDPAState *s;
> @@ -189,11 +190,15 @@ static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
>       s = DO_UPCAST(VhostVDPAState, nc, nc);
>       vdpa_device_fd = qemu_open(vhostdev, O_RDWR);
>       if (vdpa_device_fd == -1) {
> -        return -errno;
> +        error_setg_errno(errp, errno, "%s: Cannot open '%s'", name, vhostdev);
> +        return -1;
>       }
>       s->vhost_vdpa.device_fd = vdpa_device_fd;
>       ret = vhost_vdpa_add(nc, (void *)&s->vhost_vdpa);
> -    assert(s->vhost_net);
> +    if (ret == -1) {
> +        error_setg(errp, "%s: Cannot add vhost-vdpa '%s'", name, vhostdev);
> +        return -1;
> +    }
>       return ret;
>   }
>   
> @@ -229,5 +234,6 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
>       }
>       return net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
>                                  opts->has_vhostdev ?
> -                               opts->vhostdev : VHOST_VDPA_DEFAULT_VHOSTDEV);
> +                               opts->vhostdev : VHOST_VDPA_DEFAULT_VHOSTDEV,
> +                               errp);
>   }


