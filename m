Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1B4C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296E62072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nk5NN5bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296E62072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFFba-0006dx-Bn
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 07:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jFFam-00061s-EB
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jFFal-0002wm-EY
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:13:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54811)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jFFal-0002wQ-AU
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584702811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/4sXJnGDIkbdErcRz5yhbhnTdsM0zFC4+DVBDV7v4Qw=;
 b=Nk5NN5bs4Zgu0PpWO+HFiNJS9fzXKR8MdMRiYG7HEmaJZS80SZF6zvCrSMNPnCcOEiAUug
 f9uoLWlWyqKHOMeFQ49hYExzfuejKD8QeTao+cZag5u/U1TmTptvXdrsZhzIYSi2pGELNQ
 2GPvRWAiU89r+oIilgYvvT4d/I65LN4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-X0WXOUwcM6WdL6g_7seFxw-1; Fri, 20 Mar 2020 07:13:29 -0400
X-MC-Unique: X0WXOUwcM6WdL6g_7seFxw-1
Received: by mail-wm1-f71.google.com with SMTP id f207so1671250wme.6
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 04:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/4sXJnGDIkbdErcRz5yhbhnTdsM0zFC4+DVBDV7v4Qw=;
 b=OQ1EV7wIBX5NHE2tOu+YIl4h+VIezf+ruX96/nh7/Az98Q4281H8SK4uGr4urL6boR
 qzY9WTaI0GdIAweEkfLjXh24wQ6kEyajQdzqHXssO5XupYFr+FF02TyJaqEg+YJU6xD9
 JRmvHLqZxTuZ7zQx5Fekk7Qf74NQKgyzvzYivR55MkqHx895deNoWarazLfbZLv1Y176
 PhAIBJeK8o8hHXO3gQX7KHnt/cPHTHw5/kDIOassiaSl3KBM2vnlQ90Id0Ej3fENZi5n
 +ssNIgHFJc06AbKUxOR1fFPNbBWZislXfMHvKJTzsU5Sk/y6qDJUZ5kGfTAL9jE8souZ
 QK6A==
X-Gm-Message-State: ANhLgQ1GoYltrHd738ouE+2o/4AKM99B/8xIl/eTHJaYTF88EAAb+53g
 EvTPIjkXkHn7ccFr9hqvUnrDcFhVZvkQXb/jnAiuXiWb9tyZG3rHkL4mxWF3qLeRUSpgxULFBAe
 aWoxYeSqdSf5f7bk=
X-Received: by 2002:adf:cf09:: with SMTP id o9mr10008907wrj.74.1584702808066; 
 Fri, 20 Mar 2020 04:13:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vubYeLFC4O+UZTo39ljxbrzlK5Lt3QfS4W746sOMhwg8SptUJPqJdnK5nJOWAtyoSWHtwfwfA==
X-Received: by 2002:adf:cf09:: with SMTP id o9mr10008890wrj.74.1584702807902; 
 Fri, 20 Mar 2020 04:13:27 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id d18sm7742078wrq.22.2020.03.20.04.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 04:13:27 -0700 (PDT)
Subject: Re: [PATCH] virtio-iommu: depend on PCI
To: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org
References: <20200320104147.643941-1-pbonzini@redhat.com>
 <61c1af7a-fb94-4c84-50bc-f509621f07e4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <827768ca-7f43-042d-18fd-27f08a31e9f3@redhat.com>
Date: Fri, 20 Mar 2020 12:13:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <61c1af7a-fb94-4c84-50bc-f509621f07e4@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/03/20 11:54, Auger Eric wrote:
>> The virtio-iommu device attaches itself to a PCI bus, so it makes
>> no sense to include it unless PCI is supported---and in fact
>> compilation fails without this change.
> with the --- cleanup (?)

Fails if PCI is not included but virtio-iommu is.

Paolo

> Acked-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks


