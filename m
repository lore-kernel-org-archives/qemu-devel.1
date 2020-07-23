Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF77C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D856D207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmgC5VFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D856D207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyctZ-0002bf-5j
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 11:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jycrV-000163-Oy
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:10:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31653
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jycrU-0005fy-3r
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595517019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QJ+ChbuScgdOhztfXP1kQ+9GsbzReBPTsaq9WW+ai3I=;
 b=UmgC5VFugIF5bLEVnXR+RNS6VCdwot9Qeg/81A0xs8BYuEz5s4ZaVfEEcgNnhwJ+lbx9GH
 VlrKVDE/MFeZU4NIo0fGEBTBK/VD0TWTq2S3BB3/VdSjTw3+vXydMgtX/twNJNZMVDTn3v
 4QzwvIjlMNiFAW/SxUnmrmuQkDjoKBI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-2epF0JDINW68H6N1jSFbNg-1; Thu, 23 Jul 2020 11:10:17 -0400
X-MC-Unique: 2epF0JDINW68H6N1jSFbNg-1
Received: by mail-wr1-f70.google.com with SMTP id h4so1505098wrh.10
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 08:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QJ+ChbuScgdOhztfXP1kQ+9GsbzReBPTsaq9WW+ai3I=;
 b=AeN1jEk6OSIUXpv7WXV16lZ3BDxxHKJGtLPhZmldwRqXDFpRw+HuI3uU9QEDMirEJy
 lOcsyElKjdK51+rGCHVyeEpatZSEdzDDOQIVknUOne9AwRKJmKO0Nz486cgIzOwqek7u
 /5vImh09ijoDrrdqZj5tAzYqyUKKb4U2GTD0Gkm/b+tmWv4Yi/X+rjvcSOMTug6ClEqr
 5Bd5OMVOwiVNNCsNse7QU/3LuTNBnXVP6D3gevPjeOzNX00RAwJW8kJ+mndRS7l8tIO+
 VKVim9EAP+99so8Ai/Ol9U3qK8i4Pm+Xj+JJm1AFchi+g76VI0OwpebrZoCShtiZz8sE
 j+pw==
X-Gm-Message-State: AOAM530XcgcTHeM6EZUU/XNIGee8voh76yh4LywJSfKdPc2HIAj1zW9l
 ZwQuBDkbg1hzbM6q+MRqcNro2GIhkII1Q26nW2W6S3J5jL3y/aEESAa1XezqdwDHueRRKcBRZcf
 F8+dD4HiaDxIWYGM=
X-Received: by 2002:adf:f847:: with SMTP id d7mr4276737wrq.328.1595517016565; 
 Thu, 23 Jul 2020 08:10:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxugImgohjF2T9W+p7l87wMSDqOiBfhu+fb2ns5EsWTJ5hj2bCMazQ2PV3F6/7FebRrjI7Klg==
X-Received: by 2002:adf:f847:: with SMTP id d7mr4276674wrq.328.1595517015671; 
 Thu, 23 Jul 2020 08:10:15 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t7sm4099650wmg.41.2020.07.23.08.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 08:10:15 -0700 (PDT)
Subject: Re: [PATCH 3/3] scripts/qmp/qom-fuse: Fix getattr(), read() for files
 in /
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200723142738.1868568-1-armbru@redhat.com>
 <20200723142738.1868568-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <7850b7db-d1ec-638c-c044-3cc0e6d2a1a0@redhat.com>
Date: Thu, 23 Jul 2020 17:10:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200723142738.1868568-4-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
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
Cc: jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 4:27 PM, Markus Armbruster wrote:
> path, prop = "type".rsplit('/', 1) sets path to "", which doesn't
> work.  Correct to "/".
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qmp/qom-fuse | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
> index 405e6ebd67..7c7cff8edf 100755
> --- a/scripts/qmp/qom-fuse
> +++ b/scripts/qmp/qom-fuse
> @@ -45,8 +45,10 @@ class QOMFS(Operations):
>              return False
>  
>      def is_property(self, path):
> +        path, prop = path.rsplit('/', 1)
> +        if path == '':
> +            path = '/'
>          try:
> -            path, prop = path.rsplit('/', 1)

Maybe worth adding an tiny root_path_split() helper?

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>              for item in self.qmp.command('qom-list', path=path):
>                  if item['name'] == prop:
>                      return True
> @@ -55,8 +57,10 @@ class QOMFS(Operations):
>              return False
>  
>      def is_link(self, path):
> +        path, prop = path.rsplit('/', 1)
> +        if path == '':
> +            path = '/'
>          try:
> -            path, prop = path.rsplit('/', 1)
>              for item in self.qmp.command('qom-list', path=path):
>                  if item['name'] == prop:
>                      if item['type'].startswith('link<'):
> @@ -71,6 +75,8 @@ class QOMFS(Operations):
>              return -ENOENT
>  
>          path, prop = path.rsplit('/', 1)
> +        if path == '':
> +            path = '/'
>          try:
>              data = self.qmp.command('qom-get', path=path, property=prop)
>              data += '\n' # make values shell friendly
> 


