Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604DCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3B820663
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRZ1wtX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3B820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqI5S-0006gI-GX
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqI3s-0005au-HR
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:20:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31989
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqI3l-00086n-KK
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593530432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3Q68uV4NKCffVlEx9DmYr8Tcy2UpV4TM2zGQR62nl10=;
 b=NRZ1wtX5pu9BB21lmk5cShEnO4TUS3K7uZ5upKWry+ZEkC+O4HFjjKWyVhzHSnYAn67PkC
 j6EuBS/JJr4b1UjmULLP35vDTwJ6PMIayfPC+tjlQC88iKhk9wLzBYI1dtnv6WPkm4j2yi
 2kPvN0F7YkKMtqrFCykRh+pgaE65G48=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-eRWCQcDQNH6BGk7hSlkWmw-1; Tue, 30 Jun 2020 11:19:56 -0400
X-MC-Unique: eRWCQcDQNH6BGk7hSlkWmw-1
Received: by mail-ed1-f72.google.com with SMTP id cn4so13011068edb.9
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 08:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3Q68uV4NKCffVlEx9DmYr8Tcy2UpV4TM2zGQR62nl10=;
 b=H+6Nwtb2GHU2yK9kGDOcrpqtzhSCHi9WFqa0Zw0OXrSfcWyFGIcX/ombGWvDN+gRHF
 Dtx8i7I++dNoBh9QFzH0jR++PqlVt5Q69cbztm4GO0bRVonjYnXZ788WIIRs1iXO59mS
 WiAmNu9Hstm8QLv8MfsKMpgTgfBNwx/2kdpg6yAzTbzC+XAv5982StVdwC22KvdPEACE
 G6jBIioBf1fSKZ9+nCzWbhdaK8w2NR/RFDXXzhm1B1/sLSBsmznHuLLHVLvPDicV1I0+
 xpVnlWO2b/Wl35aoGJFPWPNe5ivh2Ev/i5sK0vTtsagdzORnv9i8Kwf9NctH8MYO9HxC
 Ikuw==
X-Gm-Message-State: AOAM531NzEzGQnHvtJcI6WMMe3twKV8btEkr+pyYuTR1IHhfMjHAPfhV
 e78ky9pq7NrwfnKcB28yV8V1EAudnv0Snwlckzrr95VAViobSBPnUNznrZxdwugF1GFJ41AGpZR
 atvV7v0s//rE1Pdk=
X-Received: by 2002:a17:906:4086:: with SMTP id
 u6mr20093274ejj.9.1593530395530; 
 Tue, 30 Jun 2020 08:19:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx968WRLbUisR+Ua1av2ZFZrg5txPJ4uxePXOJef4L9Vgi/0Ql6VBEd7JzAxiIPxCPm9IU36A==
X-Received: by 2002:a17:906:4086:: with SMTP id
 u6mr20093262ejj.9.1593530395330; 
 Tue, 30 Jun 2020 08:19:55 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id k15sm2231802eji.49.2020.06.30.08.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 08:19:54 -0700 (PDT)
Subject: Re: [PATCH 1/2] xen: fix legacy 'xen-sysdev' and 'xen-backend' bus
 types
To: Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 qemu-devel@nongnu.org
References: <20200624121841.17971-1-paul@xen.org>
 <20200624121841.17971-2-paul@xen.org>
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
Message-ID: <ee15f95a-ef85-8246-f10d-2778baa343c7@redhat.com>
Date: Tue, 30 Jun 2020 17:19:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200624121841.17971-2-paul@xen.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <pdurrant@amazon.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 2:18 PM, Paul Durrant wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> 'xen-sysdev' plugs into the 'System' bus type, not 'xen-sysbus. That bus type
> is what 'xen-backend' plugs into.
> 'xen-sysdev' is drived form 'sys-bus-device' so the bus type need not be
> overridden. 'xen-backend' is derived from 'device', which plugs into the
> generic 'bus' type, so its bus type should be overridden to 'xen-sysbus'.
> 
> Without this patch, the following assertion will fail:
> 
> qemu-system-i386: hw/core/qdev.c:102: qdev_set_parent_bus: Assertion
> `dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type)'
> failed.
> 
> Reported-by: Jason Andryuk <jandryuk@gmail.com>
> Fixes: 81cb05732efb ("qdev: Assert devices are plugged into a bus that can take them")
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> ---
>  hw/xen/xen-legacy-backend.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
> index 2335ee2e65..c5c75c0064 100644
> --- a/hw/xen/xen-legacy-backend.c
> +++ b/hw/xen/xen-legacy-backend.c
> @@ -789,11 +789,12 @@ static void xendev_class_init(ObjectClass *klass, void *data)
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      /* xen-backend devices can be plugged/unplugged dynamically */
>      dc->user_creatable = true;
> +    dc->bus_type = TYPE_XENSYSBUS;
>  }
>  
>  static const TypeInfo xendev_type_info = {
>      .name          = TYPE_XENBACKEND,
> -    .parent        = TYPE_XENSYSDEV,
> +    .parent        = TYPE_DEVICE,
>      .class_init    = xendev_class_init,
>      .instance_size = sizeof(struct XenLegacyDevice),
>  };
> @@ -824,7 +825,6 @@ static void xen_sysdev_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      device_class_set_props(dc, xen_sysdev_properties);
> -    dc->bus_type = TYPE_XENSYSBUS;
>  }
>  
>  static const TypeInfo xensysdev_info = {
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


