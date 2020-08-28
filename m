Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923B3C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F56120872
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfgqu1vS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F56120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBiAm-0005UO-UD
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBiA6-0004jf-OE
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:27:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48924
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBiA4-0005uX-De
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598635654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCVy++E7Qs3toEG3a72PngLCiqJ7+u+SlNHW5O1TuAs=;
 b=cfgqu1vSezam9cZa68uFxsyMn2e7+puwkwk5MLbOciLuNRpHVmOHpX813yu71AMOKLW3Fg
 LvTKl1gdSArvlV/7Dwr9k1DumtxVfg3klPZh6k6GWRosN13VwtFk53Mc9sYi+2Ui1HUTfV
 4Ewitw3e1dh+Z4r37On9CxRvud5lpuU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-cSvcP67wOhGsXrgPyIlMKw-1; Fri, 28 Aug 2020 13:27:32 -0400
X-MC-Unique: cSvcP67wOhGsXrgPyIlMKw-1
Received: by mail-ej1-f72.google.com with SMTP id e15so857226ejk.10
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dCVy++E7Qs3toEG3a72PngLCiqJ7+u+SlNHW5O1TuAs=;
 b=GuZRcL6U+wSBM3yi0T2vS9Xbx0kDRl2IebVbtXkfTscILIvFduPYxKwVlSlmJ4Ftz6
 cIaA8DU5geNHZlxjSOqm68CMH5dGtukd/WamRWxRYG82rCSTMeJoVCXhAmkxP0hZSy1A
 gv/ZPmRFGzVQGeOWziveSdSMEY5LwByXHjktUulPpdX5L8r7mokn5aXGKztrhhtYQ2Yk
 XSvlg7tl5qJb/Tq18gRk0n8KOhoWlm+G3KQkhGk56NE7WLeQiiEeUHlq4pRRMBRL02fq
 BwTBxuLUgnKcgZde3ygfITfJEXZs1rZzOQogBOy0GUlpngjSLrEi07RRIpBnu9X/CqqZ
 KyDw==
X-Gm-Message-State: AOAM531uXxjdo4R6I40LDAI7fMTlMBhmCcpoPw58WM2diIPeEYBTxawl
 H2DXa6WNjFtOxGqJtt4qiUPvdjBCY7UrwmyHarJrP9xO2RcsjljlBRdXI08xVgGPTp1Wdq8/Flp
 KfFwp3IaCJ4vUrak=
X-Received: by 2002:a50:f40a:: with SMTP id r10mr3078602edm.137.1598635651740; 
 Fri, 28 Aug 2020 10:27:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXR0T7jO8Uy/rOcud+rXvv3yI2lJ2ttLYMBBdzaHntxeReVu8+JXCnHpA5uJyODg2pHmP0aA==
X-Received: by 2002:a50:f40a:: with SMTP id r10mr3078577edm.137.1598635651482; 
 Fri, 28 Aug 2020 10:27:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:287e:2203:f280:c08?
 ([2001:b07:6468:f312:287e:2203:f280:c08])
 by smtp.gmail.com with ESMTPSA id k13sm1472854edh.37.2020.08.28.10.27.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 10:27:30 -0700 (PDT)
Subject: Re: QEMU build error with --disable-qcow1
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <5e1817af-afde-2839-98b2-c7a50678756a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a3c48d9-cc5e-844b-f3ea-b3917237615d@redhat.com>
Date: Fri, 28 Aug 2020 19:27:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5e1817af-afde-2839-98b2-c7a50678756a@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 12:34:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/08/20 18:34, Thomas Huth wrote:
> 
> Linking target qemu-nbd
> libblock.fa(block_qcow2-threads.c.o): In function `qcow2_zlib_compress':
> /tmp/qemu-test/../../home/thuth/devel/qemu/block/qcow2-threads.c:101:
> undefined reference to `deflateInit2_'
> /tmp/qemu-test/../../home/thuth/devel/qemu/block/qcow2-threads.c:116:
> undefined reference to `deflate'
> /tmp/qemu-test/../../home/thuth/devel/qemu/block/qcow2-threads.c:123:
> undefined reference to `deflateEnd'
> libblock.fa(block_qcow2-threads.c.o): In function `qcow2_zlib_decompress':
> /tmp/qemu-test/../../home/thuth/devel/qemu/block/qcow2-threads.c:152:
> undefined reference to `inflateInit2_'
> /tmp/qemu-test/../../home/thuth/devel/qemu/block/qcow2-threads.c:157:
> undefined reference to `inflate'
> /tmp/qemu-test/../../home/thuth/devel/qemu/block/qcow2-threads.c:169:
> undefined reference to `inflateEnd'
> etc.
> 
> Not sure whether this is due to the recent conversion to meson, or a
> recent change to that file ... anybody got a clue what's going on here?

It's a missing zlib dependency for the qcow2 files:

diff --git a/block/meson.build b/block/meson.build
index 4dbbfe60b4..a3e56b7cd1 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -40,9 +40,9 @@ block_ss.add(files(
   'vmdk.c',
   'vpc.c',
   'write-threshold.c',
-), zstd)
+), zstd, zlib)

-block_ss.add(when: [zlib, 'CONFIG_QCOW1'], if_true: files('qcow.c'))
+block_ss.add(when: 'CONFIG_QCOW1', if_true: files('qcow.c'))
 block_ss.add(when: 'CONFIG_VDI', if_true: files('vdi.c'))
 block_ss.add(when: 'CONFIG_CLOOP', if_true: files('cloop.c'))
 block_ss.add(when: 'CONFIG_BOCHS', if_true: files('bochs.c'))

(and then it becomes redundant for qcow1).  I'll send a formal patch
shortly.

Paolo


