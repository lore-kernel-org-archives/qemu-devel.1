Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31267C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA078206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iL0jeSc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA078206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5q9-00080B-5m
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY5pT-0007B8-VM
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:38:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24838
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY5pS-0006zY-DW
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589193513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D3xa1dQbgLMo2VAz2QhW2nrMfdtIvq7L92V9ori7On8=;
 b=iL0jeSc+ElfFFqjQdKrFiVKMeu+RdbYHVTVVNrBKorYkHyARLciyDYCNiBxl7Q+rcnHZRc
 qdZfpTVYGUIr9tNRxVyH4zMn2rWfubCE3XvWdonELELRYQWKLIGsSLjDbG96tD2Xr1W/sf
 AsgkvJ7maytqsbHluf/SI8gvTAVKgJI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-8O7c5Xp5MN6swn_l6efe8Q-1; Mon, 11 May 2020 06:38:29 -0400
X-MC-Unique: 8O7c5Xp5MN6swn_l6efe8Q-1
Received: by mail-wm1-f69.google.com with SMTP id j5so8126002wmi.4
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 03:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D3xa1dQbgLMo2VAz2QhW2nrMfdtIvq7L92V9ori7On8=;
 b=LPY/HxTMVh54kRRq40SxthZE77LnSPE+X/niKME8XuylQQQDJKnB4RS3UM7/dJSSrF
 ynRKBh1A0czS8aVWbhU2lZIr0pcyUKQALIrtwCsu6yYMoXJ1tuSVOiWY2kJkTIUEXh6U
 BD3KVOFUMxch0rfrYSNk8TvP37Hg6UutR/CbIqgBHjFvOIyfMprrPuzIzX++w2wx5ND5
 Ujnl18qI1o3ShAO2CLriITqipZ2LfaIObSk/eZJWdOzMFt+7DCRwZlmDUWQ0ZTOX+1a1
 sJkNfyYAQkwbTk0tACiv0FyBb22r779zYYIUaoxISxdoVSQ2fG38sEWBQ5vHNN5woGj7
 7V9w==
X-Gm-Message-State: AGi0Pub8GM0/+sjgpFgq1hthv/6B8WMGIE1A9n+QDDvGOt6t+pfwawFR
 poDtPYbKUo4E6IEtYwyG40FbTSzvB7TImW/QAYQ7BS/ANlNm8Az2TkqxD/tkfYZl0WGA0N37MBb
 yAkOUpqW1mtjZ3HY=
X-Received: by 2002:adf:8403:: with SMTP id 3mr17477708wrf.186.1589193507903; 
 Mon, 11 May 2020 03:38:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypKnHWcexBjEDq8E3IY3gEVWHGDxCrCIAlh04yhLF4t5BxE0wzkkZNw5ty9X4SJIX9AKrX1iNQ==
X-Received: by 2002:adf:8403:: with SMTP id 3mr17477686wrf.186.1589193507632; 
 Mon, 11 May 2020 03:38:27 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r11sm5506500wro.15.2020.05.11.03.38.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 03:38:27 -0700 (PDT)
Subject: Re: QEMU + HVF Fails to start OVMF.fd (hang before displaying logo)
To: LAHAYE Olivier <olivier.lahaye@cea.fr>,
 "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Cameron Esfahani <dirty@apple.com>
References: <1E2B87BF-BC9F-4A4A-962B-DC70B1232B37@cea.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6878b688-dd72-c4e4-bdbc-38d6af10f257@redhat.com>
Date: Mon, 11 May 2020 12:38:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1E2B87BF-BC9F-4A4A-962B-DC70B1232B37@cea.fr>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Olivier,

Cc'ing the HVF maintainers.

On 5/11/20 12:26 PM, LAHAYE Olivier wrote:
> Hi,
> 
> I’m facing a similar problem to this one, but I’m unable to find any 
> solution via google.
> 
> https://www.mail-archive.com/qemu-discuss@nongnu.org/msg04372.html
> 
> I’m trying to run an EFI BIOS using qemu.
> 
>   * It works fine without acceleration
>   * It hangs (display not initialized) when using -accel hvf
> 
> I’ve tested many OVMF.fd files from internet including the official one 
> of course whith no differences. (always work with no acceleration and 
> always fail with HVF acceleration).
> 
>   * OS: MacOS 10.14.6
>   * QEMU 5.0.0 monitor - type 'help' for more information
>   * (qemu) qemu-system-x86_64: warning: host doesn't support requested
>     feature: CPUID.80000001H:ECX.svm [bit 2]
>   * info roms
>   * fw=genroms/kvmvapic.bin size=0x002400 name="kvmvapic.bin"
>   * addr=00000000fff00000 size=0x100000 mem=rom
>     name="/Users/ol222822/data/OVMF.fd"
>   * /rom@etc/acpi/tables size=0x200000 name="etc/acpi/tables"
>   * /rom@etc/table-loader size=0x001000 name="etc/table-loader"
>   * /rom@etc/acpi/rsdp size=0x000014 name="etc/acpi/rsdp"
> 
> Is it a known issue?
> 
> Is there something I’m missing?
> 
> I’m running qemu in the following way:
> 
> qemu-system-x86_64 -machine q35 -bios ~/data/OVMF.fd -monitor stdio
> 
> If I add -accel hvf, it’ll hang before tiano core logo.
> 
> Best regards,
> 
> -- 
> 
> Olivier LAHAYE
> 


