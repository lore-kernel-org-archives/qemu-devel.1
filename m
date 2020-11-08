Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62C6C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 15:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5534120B1F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 15:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKZKYEdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5534120B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbn2F-0008M5-Bh
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 10:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbn1d-0007jR-HH
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 10:54:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbn1Y-0002Qa-Lm
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 10:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604850874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GgrWIO27EvOf/wiP0eEejTnIJLv7Nj22Xwh7b+WI680=;
 b=QKZKYEdfb9MuWq6PiCp6Wg76Wi3BVzTli8ottOM0STpP14AMGCqzzI9255cEdYMBM1R5R4
 fpqhUE4nErZIt1Dfy8nAc6AnlqiPalWW+KBf4IeLZ/3NjxGE1JNYWNkdDnecHQ6BYb2BUY
 48wKHBWt66sA85/6dHq7GaVYsIgYsDA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-5aNHkEITNMug0gYP_YJeUA-1; Sun, 08 Nov 2020 10:54:33 -0500
X-MC-Unique: 5aNHkEITNMug0gYP_YJeUA-1
Received: by mail-wr1-f71.google.com with SMTP id e3so3105228wrn.19
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 07:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GgrWIO27EvOf/wiP0eEejTnIJLv7Nj22Xwh7b+WI680=;
 b=rIQVxQvFfCYJqf9A7ID5jWCKVRejeYcT6ZhqgCw295o5VR8z6EMvy0WMhPLJkiwBKN
 jAmIecxiOtQ3bZcICBMNX/p9DBnnstvTrNetk43rK9m2DOpni087e1EF408AhH9SkXuB
 sUmrQKACZx+A74weJkumktU6/bWhigtDyXzU6v3lSnh6lXQ2v0Mwa4k6c4odY9aaD1KN
 mPTujnT0g1PwAOuxZisYWbdIIT9BDTgD8PFTQoSTnzTNclcOYETdYc7dKZHR+yF4YZ06
 MF73sgDphiLqy8OOT31OoPM//ADTFsq7q9/P1z+6dyxFerHB6sz+Ni6LZWuE15Kn1IqK
 uWGQ==
X-Gm-Message-State: AOAM530qJAmprQgBScuNWD7tOi1GlvpoqoZdljXHRfeqKYhwrD4Zfais
 SPwzKEhgWEeclqImJJ6Kb0smKRfQWplnsV5/d8xx3DpFLJ42blzUJwAYPMLBCoz5x46ara/zvaj
 vgTRYodsGPUJ6Vq4=
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr9715254wmd.1.1604850872333; 
 Sun, 08 Nov 2020 07:54:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzX9DSM57VISYDvnH33kUvPh8MHFxsjOnvoJxd6U8HAdEuD9FnWV5u5wfU2CpA1g29k/U3Nkg==
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr9715244wmd.1.1604850872151; 
 Sun, 08 Nov 2020 07:54:32 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id 35sm8104662wro.71.2020.11.08.07.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 07:54:31 -0800 (PST)
Subject: Re: [PATCH] meson: always include contrib/libvhost-user
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20201106210340.698771-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <21c2fe85-1715-772e-e1f6-fbbf8157fcbe@redhat.com>
Date: Sun, 8 Nov 2020 16:54:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201106210340.698771-1-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 09:02:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 10:03 PM, Stefan Hajnoczi wrote:
> libvhost-user is needed when CONFIG_LINUX is set. The CONFIG_VHOST_USER
> check in meson.build is incorrect.
> 
> In fact, no explicit check is needed since this dependency is not built
> by default. If something declares a dependency on libvhost-user then it
> will be built, otherwise it won't be built (i.e. on non-Linux hosts).
> 
> This fixes ./configure --disable-vhost-user && make.
> 
> Fixes: bc15e44cb2191bbb2318878acdf5038134e56394 ("configure: introduce --enable-vhost-user-blk-server")
> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  meson.build | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index f5175010df..b473620321 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1450,11 +1450,7 @@ trace_events_subdirs += [
>    'util',
>  ]
>  
> -vhost_user = not_found
> -if 'CONFIG_VHOST_USER' in config_host
> -  subdir('contrib/libvhost-user')
> -endif
> -
> +subdir('contrib/libvhost-user')

I haven't reviewed what this code does, but testing it I see:

 $ ../configure --disable-vhost-user

        vhost-user support: YES

which doesn't look correct...

>  subdir('qapi')
>  subdir('qobject')
>  subdir('stubs')
> 


