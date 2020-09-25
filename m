Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABD4C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1040208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZoz/IM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1040208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjBW-0005iq-QC
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kLjAD-0004qt-DK
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kLjAA-0002xb-W1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:33:09 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601022784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJ96mL/0u02WPTL+V8DFTcs4iANZYSJxwbzQtIedfWs=;
 b=XZoz/IM9grTHcawonfrcAVdh3O8oo2vh7trL93gffKNLSnsCIx2F5fDwtlBYdl9NvQT3QP
 GILXTipJ7eojzndfQQ1pOopYf2VGNURIOSjEhvP+r+E74otlgR4SY6pFqtnxc+/AT0DsEm
 bR61R4LbWMjjEz+NVFZWaPBGQF71MFc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-JI7j2RDLN--2HjKHIKMQIw-1; Fri, 25 Sep 2020 04:33:02 -0400
X-MC-Unique: JI7j2RDLN--2HjKHIKMQIw-1
Received: by mail-wm1-f69.google.com with SMTP id m25so826640wmi.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 01:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=FJ96mL/0u02WPTL+V8DFTcs4iANZYSJxwbzQtIedfWs=;
 b=Vgq9LkuTupUACBGZTDDeJWLQWx4IMN+rF//aXk0h6QbwLcvKUOMdb4P8+NDp5/Cmi0
 GKNuftuQQY1thf0hwTGHItMbj+DDZcEAkUE5deak/XqVcEfrwgwrqOqnwid3e84WJVmf
 KPWbd5OL598Ijo2AJQJhLTVuVn+AaleO9lmIIWObqtpSusBIXYWVNTU5pd2dJU89fSc3
 Fphn9rHKnCDO2CpfBMh+WlbZk+n7oXQulIFV0r2G+0Y9GSu7KGTNgZtXbLZOaJB5nVZv
 d90LWedqhXfJZCQEol5KtbRqznlSDNLpplKIPGN1YqF8xX22FcGuMMyXc3Jb5UccR8xc
 UWjw==
X-Gm-Message-State: AOAM531CpcO+qGxxYz5w7TepSExF4WTUCSrFgVi+KN5rS8YPLKmw4xpG
 1s6OrmX7WHTd2jAGBpG2drFgOx6PymvS9Hjte1FG1qppWqVTLRoo5eYF26Qg6p5R1y+r62TIzPF
 ThRS4Nrx0gPk2QCs=
X-Received: by 2002:a5d:634e:: with SMTP id b14mr3077204wrw.190.1601022781614; 
 Fri, 25 Sep 2020 01:33:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuXa5x5mvTEyRy1W9wWcoaYB9ygPn3IhuIv2QgVbLYSAYwPBvXtgsUvvDpVmtAayRz82rHCg==
X-Received: by 2002:a5d:634e:: with SMTP id b14mr3077183wrw.190.1601022781347; 
 Fri, 25 Sep 2020 01:33:01 -0700 (PDT)
Received: from auriga.localdomain (ip-89-176-41-222.net.upcbroadband.cz.
 [89.176.41.222])
 by smtp.gmail.com with ESMTPSA id t203sm2052525wmg.43.2020.09.25.01.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 01:33:00 -0700 (PDT)
Date: Fri, 25 Sep 2020 10:32:58 +0200
From: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v2 0/3] qga: add command guest-get-disk
Message-ID: <20200925083258.7deatpkkuouofjur@auriga.localdomain>
References: <cover.1599470071.git.tgolembi@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1599470071.git.tgolembi@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tgolembi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=tgolembi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

gentle reminder

On Mon, Sep 07, 2020 at 11:14:39AM +0200, Tomáš Golembiovský wrote:
> Adds command to list disks of the VM.
> 
> The patch does compile on master but to work properly it requires changes to
> qemu-ga by Thomas Huth in series: Allow guest-get-fsinfo also for non-PCI
> devices.
> 
> v2:
> - added new struct in API to handle the information
> - split changes into several patches
> - for Linux list also slaves, partitions and virtual disks so that the disk
>   hierarchy is preserved
> - fixed issues pointed out by Michael
> 
> Tomáš Golembiovský (3):
>   qga: add command guest-get-disks
>   qga: add implementation of guest-get-disks for Linux
>   qga: add implementation of guest-get-disks for Windows
> 
>  qga/commands-posix.c | 241 ++++++++++++++++++++++++++++++++++++++++++-
>  qga/commands-win32.c |  91 ++++++++++++++++
>  qga/qapi-schema.json |  29 ++++++
>  3 files changed, 360 insertions(+), 1 deletion(-)
> 
> -- 
> 2.25.0
> 

-- 
Tomáš Golembiovský <tgolembi@redhat.com>


