Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086FDC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CAA20936
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arMw+9Y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CAA20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLLTd-0003XH-6m
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kLLSA-0002yV-7b
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kLLS8-0006YR-Jh
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600931643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q+GJ3r9zQj13cYL/OFnEQjMJzs/wgDvYCl+uJBiqZ48=;
 b=arMw+9Y4k3X5QgHeFBSyEDTHSBkl+CJYBrrxjs6a1wp0FNJfRslm+h0CXKXzytwhfERldI
 9DiUXZevtrbBcqvB40KH9rZ0JV7Sy+W+I1dhectXNzQdQzPZQHW+KZscRV5vzydoNBcL8r
 88SjcOm+KExzonMXYoqLsY7bxHhtQlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-O9H17lCYO6SG7Q7q_6Ae9A-1; Thu, 24 Sep 2020 03:13:59 -0400
X-MC-Unique: O9H17lCYO6SG7Q7q_6Ae9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67FF0800462;
 Thu, 24 Sep 2020 07:13:58 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-39.ams2.redhat.com
 [10.36.112.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D36451002C08;
 Thu, 24 Sep 2020 07:13:52 +0000 (UTC)
Subject: Re: [PATCH v3 2/3] hw/smbios: report error if table size is too large
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200923133804.2089190-1-berrange@redhat.com>
 <20200923133804.2089190-3-berrange@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a8943b74-e878-1104-c4cd-ae39d42f0da0@redhat.com>
Date: Thu, 24 Sep 2020 09:13:51 +0200
MIME-Version: 1.0
In-Reply-To: <20200923133804.2089190-3-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/23/20 15:38, Daniel P. Berrangé wrote:
> The SMBIOS 2.1 entry point uses a uint16 data type for reporting the
> total length of the tables. If the user passes -smbios configuration to
> QEMU that causes the table size to exceed this limit then various bad
> behaviours result, including
> 
>  - firmware hangs in an infinite loop
>  - firmware triggers a KVM crash on bad memory access
>  - firmware silently discards user's SMBIOS data replacing it with
>    a generic data set.
> 
> Limiting the size to 0xffff in QEMU avoids triggering most of these
> problems. There is a remaining bug in SeaBIOS which tries to prepend its
> own data for table 0, and does not check whether there is sufficient
> space before attempting this.
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/smbios/smbios.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index d993448087..8b30906e50 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -365,6 +365,13 @@ static void smbios_register_config(void)
>  
>  opts_init(smbios_register_config);
>  
> +/*
> + * The SMBIOS 2.1 "structure table length" field in the
> + * entry point uses a 16-bit integer, so we're limited
> + * in total table size
> + */
> +#define SMBIOS_21_MAX_TABLES_LEN 0xffff
> +
>  static void smbios_validate_table(MachineState *ms)
>  {
>      uint32_t expect_t4_count = smbios_legacy ?
> @@ -375,6 +382,13 @@ static void smbios_validate_table(MachineState *ms)
>                       expect_t4_count, smbios_type4_count);
>          exit(1);
>      }
> +
> +    if (smbios_ep_type == SMBIOS_ENTRY_POINT_21 &&
> +        smbios_tables_len > SMBIOS_21_MAX_TABLES_LEN) {
> +        error_report("SMBIOS 2.1 table length %zu exceeds %d",
> +                     smbios_tables_len, SMBIOS_21_MAX_TABLES_LEN);
> +        exit(1);
> +    }
>  }
>  
>  
> 

Tested-by: Laszlo Ersek <lersek@redhat.com>


