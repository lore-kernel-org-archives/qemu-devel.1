Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BAAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA3D20734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBz83+l4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA3D20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jifHd-0002l9-Lh
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jifF5-0008QD-1B
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:28:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39707
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jifF3-00029J-JD
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591712919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=StRbbz8QSSbChcsm0dj0ZlPaoLySgYtZlFgY4dem344=;
 b=QBz83+l4KYJ9d0i86sned/2vP4WWl4Nna3J52uO+dtja/q+uDI8AAR6LsGYiQL9m3dNMT2
 G713YA0lYWxGolZ21bCubLuUlJQTXeFCpccuj0XcWlzueTY/8di+oODFgeHP0ytyfiqaKK
 jKAmZ00DfgUVKxmm2NWV3d+JNZnKvrE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-dSihsurFNn2NcL4TEQEfVQ-1; Tue, 09 Jun 2020 10:28:38 -0400
X-MC-Unique: dSihsurFNn2NcL4TEQEfVQ-1
Received: by mail-wr1-f70.google.com with SMTP id s17so8642986wrt.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 07:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=StRbbz8QSSbChcsm0dj0ZlPaoLySgYtZlFgY4dem344=;
 b=Sil+cY+sP4biphBvrFSBnN/kkHcU6OM+RNVVO3RLKbA9uPzYMicG98bUvJuoKyKpuD
 ZYTaTWCrYxOf97DfaJSaRx6YA+mD7FuvwilxuPojqIcMAnuxs8yWiAkqn8kQUwlSARxQ
 AUX4K+NhIF3rmMj89iCQtXo7cnJua15bvHcq7Xy/MFamio7/Ofs2o7KQ4M7jKdWGJtlq
 fsS+fbqyIj1KW9EpP7KeVaGcn8xIae3F+Pn8lRfVAXobxI/x3Kwo9dGjB5ft9mbmvUu4
 fe0h+76Bv1Cl/lDUbdRG4tW5W6ztTp5cYT7AUKovByom5WpI4BoaJbwwzVujujv4qsjK
 UIwA==
X-Gm-Message-State: AOAM532e87movWAy5/o1U659wy/E7a9Ar4ce1OHmDpfr96inANJlnRSc
 MHAJg2hiuh208mImjctlZ11rQo9MREizyktgBu0Hjwen6+cKBAb1790zEREiHBHwutNL/9dy1Yb
 vRBzQTXu719X/D8E=
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr4550499wme.154.1591712917004; 
 Tue, 09 Jun 2020 07:28:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdKN2o/Yqs1p4I/jvInuRV1XCPUiaCqapMZZXEzGINcHL5yD6CPpr7HxisLMwPpEdmcv3llQ==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr4550479wme.154.1591712916812; 
 Tue, 09 Jun 2020 07:28:36 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id c81sm3213456wmd.42.2020.06.09.07.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 07:28:36 -0700 (PDT)
Date: Tue, 9 Jun 2020 10:28:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 08/16] acpi: move aml builder code for floppy device
Message-ID: <20200609102659-mutt-send-email-mst@kernel.org>
References: <20200515150421.25479-1-kraxel@redhat.com>
 <20200515150421.25479-9-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200515150421.25479-9-kraxel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 05:04:13PM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/block/fdc.c       | 83 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c | 83 --------------------------------------------
>  stubs/cmos.c         |  7 ++++
>  stubs/Makefile.objs  |  1 +
>  4 files changed, 91 insertions(+), 83 deletions(-)
>  create mode 100644 stubs/cmos.c

...

> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 45be5dc0ed78..3cbe472d1c6c 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -3,6 +3,7 @@ stub-obj-y += bdrv-next-monitor-owned.o
>  stub-obj-y += blk-commit-all.o
>  stub-obj-y += blockdev-close-all-bdrv-states.o
>  stub-obj-y += clock-warp.o
> +stub-obj-y += cmos.o
>  stub-obj-y += cpu-get-clock.o
>  stub-obj-y += cpu-get-icount.o
>  stub-obj-y += dump.o


This seems to be based on some other tree.
Can you post based on pci tree or master pls?


> -- 
> 2.18.4


