Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8B5C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 16:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76AB5248C1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 16:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yu8rT/I6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76AB5248C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLUyI-00015B-GZ
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 12:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLUxV-0000QM-QU
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 12:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLUxU-0004qY-Q4
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 12:50:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20799
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLUxU-0004qR-NF
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 12:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586191848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orytk2Y2xJ8Iin2kpqW6vpjbDaz8+RpHVBd36rCh+ls=;
 b=Yu8rT/I6H85EkZlC+UsRG7E7sd5RfT45MprPegzbyRew1mMnIBfMvEAF2wmUqTqiZDRoW4
 KmmMQxxMDP90gI78fZUxqiHdbqDrqOHK1hVMG0BwDW8TmoW6jROqGH656ZsSCJ+31aiwUI
 XCsTP+uSChs1yd15qZFvLLU50wA8kL0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-LNB5GvnZNZu3UtsZjDricQ-1; Mon, 06 Apr 2020 12:50:44 -0400
X-MC-Unique: LNB5GvnZNZu3UtsZjDricQ-1
Received: by mail-wr1-f72.google.com with SMTP id h14so99195wrr.12
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 09:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=orytk2Y2xJ8Iin2kpqW6vpjbDaz8+RpHVBd36rCh+ls=;
 b=nPMOixx6j3hQj6iIN6rAxsGGL9pk0ZwTyvoK4GT+b9XrGf1VFqqhWTcpFDg6dUvV62
 U8ceSb16CgvOtOEywApJ2tHEipZZ0hUmX/Y4yzYaez8PEL6yWpmAjiWgvHKALyUfOXMd
 GC662SIUYfCnEEcqbjOKHZm4x1bFMRNPYMs0xoE+tnj9Fsq+8Xrp7mlhtsY3tOHlzJwk
 OVB3N6wAgOy9iw1w0twTU1smq0TkQK9UqMpZnXvkmHBKR7pNcfXimNYCjDRifbilYEHy
 103NeL1maXbbiHt7e0GgIkKgnmj+Dq2vjG1QQ0regzcFvN0/UY6fnPDlCEnKW92hZzkl
 NtUQ==
X-Gm-Message-State: AGi0PuZqkWK/Onuxi+Il4NM2YOer+yQ+RgpFGiTkWwqQ10CYkAzrD5sD
 EIKBT4GTSnUr3cjeTkZns7jMkwi8Beu4/V+bLICTZzSpK3vgEoQ/VBhT+Ey6IAmbDl3KTTfHsg5
 QOJlvJFDAgsjru1A=
X-Received: by 2002:a05:600c:2112:: with SMTP id
 u18mr90560wml.112.1586191843565; 
 Mon, 06 Apr 2020 09:50:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypIagRZGzpqiXca97dqed7Bqei3oXsmnxZYsP6eT1lEFxcv0AXz4A/MsQHGOCzuPNiPyb2Dwqg==
X-Received: by 2002:a05:600c:2112:: with SMTP id
 u18mr90541wml.112.1586191843333; 
 Mon, 06 Apr 2020 09:50:43 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id i97sm22827109wri.1.2020.04.06.09.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 09:50:42 -0700 (PDT)
Subject: Re: [PATCH for-5.0] xen-block: Fix uninitialized variable
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20200406164207.1446817-1-anthony.perard@citrix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <325e0ffb-2f1b-cbfd-6b24-0d912a9aabe2@redhat.com>
Date: Mon, 6 Apr 2020 18:50:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200406164207.1446817-1-anthony.perard@citrix.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Max Reitz <mreitz@redhat.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/6/20 6:42 PM, Anthony PERARD wrote:
> Since 7f5d9b206d1e ("object-add: don't create return value if
> failed"), qmp_object_add() don't write any value in 'ret_data', thus
> has random data. Then qobject_unref() fails and abort().
> 
> Fix by initialising 'ret_data' properly.

Or move qobject_unref() after the error check?

-- >8 --
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 07bb32e22b..f3f1cbef65 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -869,7 +869,6 @@ static XenBlockIOThread 
*xen_block_iothread_create(const char *id,
      qdict_put_str(opts, "id", id);
      qmp_object_add(opts, &ret_data, &local_err);
      qobject_unref(opts);
-    qobject_unref(ret_data);

      if (local_err) {
          error_propagate(errp, local_err);
@@ -878,6 +877,7 @@ static XenBlockIOThread 
*xen_block_iothread_create(const char *id,
          g_free(iothread);
          return NULL;
      }
+    qobject_unref(ret_data);

      return iothread;
  }
---

> 
> Fixes: 5f07c4d60d09 ("qapi: Flatten object-add")
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>   hw/block/xen-block.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index 07bb32e22b51..99cb4c67cb09 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -860,7 +860,7 @@ static XenBlockIOThread *xen_block_iothread_create(const char *id,
>       XenBlockIOThread *iothread = g_new(XenBlockIOThread, 1);
>       Error *local_err = NULL;
>       QDict *opts;
> -    QObject *ret_data;
> +    QObject *ret_data = NULL;
>   
>       iothread->id = g_strdup(id);
>   
> 


