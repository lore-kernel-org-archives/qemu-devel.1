Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B086CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7043220748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIxo6vF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7043220748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmSw-0007v2-Ka
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmRO-0004mK-VW
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:44:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45316
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbmRO-0001wj-4c
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590072297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CxP7efAYWwlJqHzIjOSIoQCioa0T8ULLFZya0tdwFFw=;
 b=QIxo6vF9iwGIvrSG2vjcTDTaqT/JhdEvPWHc/qbGzkFyRgx5Tz/55+TaoogTIAM9XJWNM5
 QiJOvnzLuKO1tu9db9nhnzjSphewClfKk+0fDXn/VNpIjG4c/sjf/mUrt6pogoMLR40gpE
 dGhuyKuQlrOKrGggGFQiqGJ23N0jbns=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-EbthRlfuOOiH9zw0O3LHRQ-1; Thu, 21 May 2020 10:44:55 -0400
X-MC-Unique: EbthRlfuOOiH9zw0O3LHRQ-1
Received: by mail-wm1-f72.google.com with SMTP id q6so1940063wme.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CxP7efAYWwlJqHzIjOSIoQCioa0T8ULLFZya0tdwFFw=;
 b=bXVKKShzkCXjsTXc+nCW3btk1Qn+2N62X/V4ist783ZkuQyADfJ1AS0C/W/flNu2gB
 WR/Ie3PYtOMQdfXed1ywzeUMcURzXUxVn+zCidY1uT27RII8jd9hSAWolQnio6CZkj+G
 LATmQ1LpXbHL1EpNkWNLvT+OW0fiF8ul02A2E57XruvO4nQVpyGjhYLteiWGALOEssny
 thE/rPLej9T0NuMhQdBsgzfd6EaLfMkgElnIT/FkQi76NsuQhr3UZYugWVBBO/NNcea3
 fOjqvAg5vZquxzJzyt9AiOgxhgtq6qIXk6j4tv25QtxeFGW574ZOczsuMltPR+vnFd3y
 YSwg==
X-Gm-Message-State: AOAM530pjQxwVq/9in3LnAXnEi8SmkcmJ9YQ7QlQrHfAsqL/t3uUDmAn
 Sv/qTLc2WlKWXNXQMUXIqr2xEJG0JvZEJfAG0lt9CPkHGqXTDmRNlsxpKfB9kAn1Zw/T07ewWj7
 JmyHdHI+AZbwyvZc=
X-Received: by 2002:adf:806e:: with SMTP id 101mr8866347wrk.225.1590072294041; 
 Thu, 21 May 2020 07:44:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYe504Dgn+dCvonNWQi54MKe7YzaLzHgZ+cJZSc0rO/fR+N0TaoW5g11yKyPxQLR4zgVn5Ug==
X-Received: by 2002:adf:806e:: with SMTP id 101mr8866334wrk.225.1590072293833; 
 Thu, 21 May 2020 07:44:53 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id x22sm6539633wmi.32.2020.05.21.07.44.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:44:53 -0700 (PDT)
Subject: Re: [PATCH] qom/object: factor out the initialization of hash table
 of properties
To: Masahiro Yamada <masahiroy@kernel.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200512172615.2291999-1-masahiroy@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3d70df37-106c-ddfc-d642-18c39ee754d3@redhat.com>
Date: Thu, 21 May 2020 16:44:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200512172615.2291999-1-masahiroy@kernel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/20 19:26, Masahiro Yamada wrote:
> Properties are not related to the initialization of interfaces.
> 
> The initialization of the hash table can be moved after the if-block,
> and unified.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  qom/object.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index a3ee968b12..e4085d8ae2 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -316,8 +316,6 @@ static void type_initialize(TypeImpl *ti)
>          g_assert(parent->instance_size <= ti->instance_size);
>          memcpy(ti->class, parent->class, parent->class_size);
>          ti->class->interfaces = NULL;
> -        ti->class->properties = g_hash_table_new_full(
> -            g_str_hash, g_str_equal, NULL, object_property_free);
>  
>          for (e = parent->class->interfaces; e; e = e->next) {
>              InterfaceClass *iface = e->data;
> @@ -347,11 +345,11 @@ static void type_initialize(TypeImpl *ti)
>  
>              type_initialize_interface(ti, t, t);
>          }
> -    } else {
> -        ti->class->properties = g_hash_table_new_full(
> -            g_str_hash, g_str_equal, NULL, object_property_free);
>      }
>  
> +    ti->class->properties = g_hash_table_new_full(g_str_hash, g_str_equal, NULL,
> +                                                  object_property_free);
> +
>      ti->class->type = ti;
>  
>      while (parent) {
> 

Queued, thanks.

Paolo


