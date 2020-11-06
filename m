Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471F5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD42B2087E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJH51PEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD42B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb2o0-0003eo-Hv
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 09:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb2nR-0003D0-Tx
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:32:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kb2nQ-0006W4-5v
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604673174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j11K2kUfl4YvvTNCJ/9vNZAN9uA1v+X8/heRisVS7W0=;
 b=LJH51PEPUB1QIsC8+xfZGOuGT0EPa1aO7b78CPMCg5buZ+mB2qRlVnUpgE7BI2szeLnAJl
 k+b88vUpfYg7HH6qMslAzIiBHCcv/aDK8CrNJVxML4D2UEcywQKnNJTUkva+tb2WY/bmpR
 uPnsECHXTBSkvU+Bc85OyTmivDXn1ks=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-FTBWxVgtMQqvHIo-UobDqw-1; Fri, 06 Nov 2020 09:32:53 -0500
X-MC-Unique: FTBWxVgtMQqvHIo-UobDqw-1
Received: by mail-wm1-f72.google.com with SMTP id u207so507820wmu.4
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 06:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j11K2kUfl4YvvTNCJ/9vNZAN9uA1v+X8/heRisVS7W0=;
 b=C07Xl4wGDRtQCbbguZ9x/HZfXmHO62S3nNYFSNlBc8OJY49zwYeid6QRiqdQE6QKde
 QohleA/B2tfRA7ADc40gnB6hUtLLQjkV6HDIhkTMzoyBrySLmULBvwjlvGBnaocTgRim
 qcFcS4cRR2j3o65JkW3hfA5BIn2C6MWEXr8nBGrSBdYJkiZaj22PE7erUMN9dF/OWCWw
 M3+T22k8ZVQCbMT5PIS6WokQJRmk3J16b7e5PMNMJSWuE3GR9Tx2G5tzjjpQKMDtiVni
 CzRNAJilxtZHLtwkv8EeSbS8DIeq7WGUU7fygX4k7LPBQxHuGgvzukvEq7T1WJiEGzPi
 JajA==
X-Gm-Message-State: AOAM530TyMkmDfBLF/MHAcR/8y4Iq58LVCeljc9rWNouTs1hMEDsd30L
 rD71OiYM171fQNqYPji6I2PDYh7nrZBMeqadiKCY/FCYxxY977ekqXMtL0cYKg1WAXNdA+Qajvn
 Tl83WQi5gMPFa0Dc=
X-Received: by 2002:a1c:bbc4:: with SMTP id l187mr2975680wmf.133.1604673172228; 
 Fri, 06 Nov 2020 06:32:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNwCU4kYD5K5UGUsGdZKjfv7a2ZGZp7/He0RmpaRJ37abhbTULEvmBhqlDNzq5MqYSkUVjdQ==
X-Received: by 2002:a1c:bbc4:: with SMTP id l187mr2975663wmf.133.1604673172051; 
 Fri, 06 Nov 2020 06:32:52 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v67sm2746131wma.17.2020.11.06.06.32.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 06:32:51 -0800 (PST)
Subject: Re: [PATCH-for-5.2? v3 5/9] scsi: fix overflow in
 scsi_disk_new_request_dump
To: Daniele Buono <dbuono@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
 <20201105221905.1350-6-dbuono@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ad3594d4-3541-32fd-ad61-9b57f2d08e5b@redhat.com>
Date: Fri, 6 Nov 2020 15:32:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105221905.1350-6-dbuono@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 11:19 PM, Daniele Buono wrote:
> scsi_disk_new_request_dump is used to dump the content of a scsi request
> for tracing. It does that by decoding the command to get the size of the
> command buffer, and then printing the content of such buffer on a string.
> 
> When using gcc with link-time optimizations, it warns that the argument of
> malloc may be too large.
> 
> In function 'scsi_disk_new_request_dump',
>     inlined from 'scsi_new_request' at ../qemu-cfi-v3/hw/scsi/scsi-disk.c:2588:9:
> ../qemu-cfi-v3/hw/scsi/scsi-disk.c:2562:17: warning: argument 1 value '18446744073709551612' exceeds maximum object size 9223372036854775807 [-Walloc-size-larger-than=]
>      line_buffer = g_malloc(len * 5 + 1);
>                  ^
> ../qemu-cfi-v3/hw/scsi/scsi-disk.c: In function 'scsi_new_request':
> /usr/include/glib-2.0/glib/gmem.h:78:10: note: in a call to allocation function 'g_malloc' declared here
>  gpointer g_malloc         (gsize  n_bytes) G_GNUC_MALLOC G_GNUC_ALLOC_SIZE(1);
> 
> len is a signed integer filled up by scsi_cdb_length which can return -1
> if it can't decode the command. In this case, g_malloc would probably fail.
> However, an unknown command here is a possibility, and since this is used for
> tracing, we should try to print the command anyway, for debugging purposes.
> 
> Since knowing the size of the command in the buffer is impossible (could not
> decode the command), only print the header by setting len=1 if scsi_cdb_length
> returned -1
> 
> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
> ---
> If we had a way to know the (maximum) size of the buffer, we could
> alternatively dump the whole buffer, instead of dumping only the
> first byte. Not sure if this can be done, nor if it is considered
> a better option.
> 
> We could also produce an error instead/in addition to just dumping
> the buffer, if the command cannot be decoded.
> 
>  hw/scsi/scsi-disk.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index e859534eaf..d70dfdd9dc 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2559,6 +2559,10 @@ static void scsi_disk_new_request_dump(uint32_t lun, uint32_t tag, uint8_t *buf)
>      int len = scsi_cdb_length(buf);
>      char *line_buffer, *p;
>  
> +    if (len < 0) {
> +        len = 1;
> +    }
> +
>      line_buffer = g_malloc(len * 5 + 1);
>  
>      for (i = 0, p = line_buffer; i < len; i++) {
> 

I think scsi_cdb_length() should always return >=1,
and scsi_req_parse_cdb() return if len <= 1.


