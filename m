Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0EFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F1320578
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZonlwFop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F1320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6xF-0007OY-Rs
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb6sn-0008Cu-PC
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:22:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40996
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb6sl-000099-Eo
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589912546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aqh3+9N8PY6/y647ATgV9RY59Fqq4O5O3US1M1LrEOk=;
 b=ZonlwFop0abm7E7VnM2jFawWDhrdWvlVduBK7oo+dxw/MOGBSRI4lrrYpamjTNkoY1AWy7
 USF3obBPoOyMZcySe+q+bPmHaD6daVH2rSVqvG2y16Y69ewo+SjxOT+rXgEIA1sJ1gvpbi
 /3ZI3BqRkWsskM7wyyXJT6DYGZ8de1A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-UteEeA8fN3qWg3OrXEWdJg-1; Tue, 19 May 2020 14:22:25 -0400
X-MC-Unique: UteEeA8fN3qWg3OrXEWdJg-1
Received: by mail-wr1-f72.google.com with SMTP id 90so185596wrg.23
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Aqh3+9N8PY6/y647ATgV9RY59Fqq4O5O3US1M1LrEOk=;
 b=MRWPSsLaF0OsgH+r/3XqwlNJVAtQlvgGykEyc5g3mjcAWttT6Bh20x3H1DbHVoMO3F
 dYHsSg6tTprNtPQ+/yUetk+hPdvlZrKtuSu8XYYawV9aMeocnopfCBJrzHBGuD4TZXU4
 qz1nTzXeYXFrknQvkguvmPl5c3Lko5BhX0xpnDL4ByGpyAA1iqlBea1tnt/yEBEwT7gH
 CeY+aBIEkXstNwqh8HGhu3/cdijJTZAT7UPniMX39xHTycTu1FHOjy9Vaqk7vBTJPuM3
 fNcSsjAgce8AW1rhFmetlSFzAQo1yb/Sm1VIdl25xPcIa4JjcCzrKMzojj845n7BsJXN
 pFcA==
X-Gm-Message-State: AOAM532hnEp054pslRKT0T/v/6jq/XBMdOL201F1cCJ+FeVmZwnjmJey
 pJb3Mo/A4an1Gwl0k0KabRQo6uMhIq2ZwXOf894lWWernRGwtu5JWyjGo+3b+s2mAia7RN5v2JC
 CNE7YxW7ZrdCL4pc=
X-Received: by 2002:a1c:307:: with SMTP id 7mr715623wmd.104.1589912542962;
 Tue, 19 May 2020 11:22:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxq6a73jNTiWQCQ9H3V1GnawOEpyqVFCW3d12wUawHmAZuzku6X3huOJq+TMmt9Cf+Q5QZ8Ug==
X-Received: by 2002:a1c:307:: with SMTP id 7mr715612wmd.104.1589912542806;
 Tue, 19 May 2020 11:22:22 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m23sm485601wmg.45.2020.05.19.11.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 11:22:22 -0700 (PDT)
Subject: Re: [RFC PATCH v6 3/5] softmmu/vl: Allow -fw_cfg 'blob_id' option to
 set any file pathname
To: qemu-devel@nongnu.org
References: <20200519182024.14638-1-philmd@redhat.com>
 <20200519182024.14638-4-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <441d422d-1812-02b3-f444-d68393899565@redhat.com>
Date: Tue, 19 May 2020 20:22:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519182024.14638-4-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
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
Cc: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 8:20 PM, Philippe Mathieu-Daudé wrote:
> This is to silent:
> 
>    $ qemu-system-x86_64 \
>      -object tls-cipher-suites,id=ciphersuite0,priority=@SYSTEM \
>      -fw_cfg name=etc/edk2/https/ciphers,blob_id=ciphersuite0
>    qemu-system-x86_64: -fw_cfg name=etc/edk2/https/ciphers,blob_id=ciphersuite0: warning: externally provided fw_cfg item names should be prefixed with "opt/"

Oops, this was supposed to be the last patch of the series. RFC anyway.

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   softmmu/vl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index f76c53ad2e..3b77dcc00d 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2052,7 +2052,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>                      FW_CFG_MAX_FILE_PATH - 1);
>           return -1;
>       }
> -    if (strncmp(name, "opt/", 4) != 0) {
> +    if (!nonempty_str(blob_id) && strncmp(name, "opt/", 4) != 0) {
>           warn_report("externally provided fw_cfg item names "
>                       "should be prefixed with \"opt/\"");
>       }
> 


