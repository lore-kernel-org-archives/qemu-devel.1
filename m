Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FB0C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D68F20833
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aagHF/O0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D68F20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibjlK-0006oE-9B
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 06:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ibjkG-00062U-Ku
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:20:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ibjkD-00035L-Gn
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:19:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56797
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ibjkD-0002zT-5p
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575285595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kSV1+41FnEe3A1jTZkiiLsSMjrLrkZwGrvL9iWVu7ok=;
 b=aagHF/O0RXI5ZrXt6LxCRkDrAGbJvSNZ4++FIr+GsuerE91Dwl4IoTpqZjJZYqQcww20+R
 EN/286q/ySiBMgfUAhoUzd/M1ldqbNfewInanIdBhzEflOW+8wO6rmF9/8rSQE4hA5QdPp
 t3nrfA+yFp478vNksL8GQ36/pPoNje8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-wKGId1-WMSaHcI8mf6NQWw-1; Mon, 02 Dec 2019 06:19:53 -0500
Received: by mail-wr1-f72.google.com with SMTP id z15so1470372wrw.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 03:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=kSV1+41FnEe3A1jTZkiiLsSMjrLrkZwGrvL9iWVu7ok=;
 b=EZkgkQ+npYcz1kGXmnVQX0LbOvtPOLkSzI4NZJiXWEGXwh1k1Ch4i6FBkiCE0eAB2l
 oYvfZROeDJKJYm4ml8G9JGbkviNuCH5hPCrovYM5nw8t5762YmnvsTqkSIUIfND/iz4D
 XuHQxQ2A78dK645eE7xbtPJcn6taVTiLqjrhQx/ZM37vdsPSlPQ4sYmvdX26DhAiSarA
 UY8dOvUE9mg0QrnKRiIgBzFn0MhQ4HMXEONwN1F8Fv5GNPcbqSV4biy82EKSUUk46JAD
 UKdAVIrw2Ljx/Ehjsr33wBjSMOa1rjzgHric5e+gpUdAHKH9k14dSPpkDKLetF/bwRe4
 UGkQ==
X-Gm-Message-State: APjAAAXCcuVH4TvFni75y+FQ/AJi8aiOGpL18y2uuLTAfOg07zC+BfFs
 sYmTaBBVXUISXawzoenb6zDfmeYgAEQ2+8UX5gPQaY/9/HoMJbRn3HDPpKAV5GWKtXp1qARMbYs
 rjEyHUPq2+WMzejM=
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr27071688wmj.11.1575285592357; 
 Mon, 02 Dec 2019 03:19:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHp81Nbu9dSWBGs9v/z/22j+jyFwifIKNlnMukttNAyxZWR0xLa5IRO871Mew0QF/f7WpR4Q==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr27071674wmj.11.1575285592194; 
 Mon, 02 Dec 2019 03:19:52 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id c1sm8769208wmk.22.2019.12.02.03.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 03:19:51 -0800 (PST)
To: Gerd Hoffmann <kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: iPXE: update submodule
Message-ID: <d33644db-ec7e-0b51-b6e6-b5fc15f37665@redhat.com>
Date: Mon, 2 Dec 2019 12:19:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Language: en-US
X-MC-Unique: wKGId1-WMSaHcI8mf6NQWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

Hi Gerd,

'make -C roms efirom' is failing on Fedora 30.

Can you update the iPXE submodule so we get these buildsys commits:

c742c576 [build] Move predefined all-drivers build shortcut to Makefile
a4f8c6e3 [build] Do not apply WORKAROUND_CFLAGS for host compiler
1dd56dbd [build] Workaround compilation error with gcc 9.1
412acd78 [build] Fix "'%s' directive argument is null" error

Thanks,

Phil.


