Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01209C43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D69E22261
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwoj0R52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D69E22261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQuGt-0002B4-F9
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 11:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQuE5-0007k0-6h
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQuDy-0004wH-Cw
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602256945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zEtrKVkyVcnLDWYWPVfyhb4VWtNaAryli6FKjCIho/M=;
 b=iwoj0R52bqc4kmLZnR7iVFH7QMBIt6oPYyTu3K21qvQWQW1QJqPOPe54jifIc7Y6jNw1cX
 E5OHrAQZiK3NmqsAfQbZkl5QVtg83lpyNrMeTNKcy9nvWGGuyb8m3DOR7EWgtFLfS/K51L
 XNhGceaH4zzkjwy3uFyDHakv642MFmU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-SzcpWPYJNDm7OQyPjt-Rqg-1; Fri, 09 Oct 2020 11:22:23 -0400
X-MC-Unique: SzcpWPYJNDm7OQyPjt-Rqg-1
Received: by mail-wr1-f72.google.com with SMTP id l15so5381727wro.10
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 08:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zEtrKVkyVcnLDWYWPVfyhb4VWtNaAryli6FKjCIho/M=;
 b=SHd/NiToKDxVbSTeaUXoiEKN4CRvpc47k+aXiAcbXxr78rpiyVIdkbbfK3S33kyfq2
 VvDcr2j0ocn+JAHJfXxnA3J0lgnP2NSfn+X//m9GUrG1rL2ciPusNe/NGyACdUDwXgiR
 4wL2f7DDPNZ4yQ3qlmSZN+wl75Kk8XtTW7/5T4ch5Ohd0WOK/YQg/iKMvMBn+hA1RMei
 2cTLm/UHG3Bh8Z2uNuQ6zb9z5tZjQultZlmghQtV7h/6o0HUm+5DMAdEpqeoXirD1Z/9
 1rLZ2OwZ8LUvbW8cCLCgkcipTcgvSLc+OEHh3xYPMofPP9x1O9S4ZdnkbTKu798DPQeg
 7zkg==
X-Gm-Message-State: AOAM533CWYWbh1NCw3RA69VqdLuPAdvO4lSJ7teZM16Hl6dTf6fzb94z
 deGE80fyQk6EZ+FPxuo6w6T5WsnBIOdJkFltJYT3MZnKfDXyQXcHQ8mNiCStx2XFNmdt87OxWCF
 ubSKNN06NkkmxTTk=
X-Received: by 2002:adf:bc14:: with SMTP id s20mr16499789wrg.220.1602256942166; 
 Fri, 09 Oct 2020 08:22:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyB7DSs+VI1I3kGy0tGjMcXOr24yREWm93zSVxmbRNQhr1vNDAbDOZ7uG//yBmLO/lpiO6G+w==
X-Received: by 2002:adf:bc14:: with SMTP id s20mr16499773wrg.220.1602256941965; 
 Fri, 09 Oct 2020 08:22:21 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x15sm14049845wrr.36.2020.10.09.08.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 08:22:21 -0700 (PDT)
Subject: Re: [PATCH 2/4] linux-user: update mips/syscall-args-o32.c.inc to
 Linux 5.9-rc7
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200930003033.554124-1-laurent@vivier.eu>
 <20200930003033.554124-3-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <117ceb41-f1de-3f86-8154-c9f3e667a0ae@redhat.com>
Date: Fri, 9 Oct 2020 17:22:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200930003033.554124-3-laurent@vivier.eu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 2:30 AM, Laurent Vivier wrote:
> Updated running scripts/update-mips-syscall-args.sh
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/mips/syscall-args-o32.c.inc | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/linux-user/mips/syscall-args-o32.c.inc b/linux-user/mips/syscall-args-o32.c.inc
> index 0ad35857b4e4..92ee4f921ec7 100644
> --- a/linux-user/mips/syscall-args-o32.c.inc
> +++ b/linux-user/mips/syscall-args-o32.c.inc
> @@ -434,3 +434,7 @@
>       [ 433] = 3, /* fspick */
>       [ 434] = 2, /* pidfd_open */
>       [ 435] = 2, /* clone3 */
> +    [ 436] = 3, /* close_range */
> +    [ 437] = 4, /* openat2 */
> +    [ 438] = 3, /* pidfd_getfd */
> +    [ 439] = 4, /* faccessat2 */
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


