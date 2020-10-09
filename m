Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E793C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 11:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC5A2226B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 11:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlwmiIPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC5A2226B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQqv5-0005AW-At
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 07:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQqtx-0004Jw-42
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 07:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQqtu-0004Dq-OL
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 07:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602244169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ykg7h7a/7nyUI0qYIMKROyPxLo/sqSpfEIeJg/dMaAY=;
 b=SlwmiIPR+x5yzdrD8ntlf6NWvd5Z3mPnOEpS7H9xjm0OiDIEyjXwCczpUluyDpGZa2edPv
 ScDpIp4bfy3rpm6DcCGWMbJ+hqtdqfODijY0KwugCnbFFBGUq2xh7iqDjIICjkdi7uv+K4
 VQ2TrL2YCaeMiEQH19/rOl89Hteo8R4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-_yegioG6NQ2Ov30CTLIZOA-1; Fri, 09 Oct 2020 07:49:28 -0400
X-MC-Unique: _yegioG6NQ2Ov30CTLIZOA-1
Received: by mail-wr1-f72.google.com with SMTP id k14so4426748wrd.6
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 04:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ykg7h7a/7nyUI0qYIMKROyPxLo/sqSpfEIeJg/dMaAY=;
 b=IvkC1bzx+Hg28zuY9H6TNfBHpYuZosmmLUdgx4mWe8sGbpY7CVLfegcuCWLfT9kZEX
 /XAGYGkynDjxs5SbgqTysNNdZSWk8BBPnCUJjyzpEBXcxRC5Lr6jH1QmHwk2z4n5cByj
 fHS/oLnF8Uiop+qrss7NbVapAD4dr6BL19+I/rKsed+h6Ipf/E8jN8Yhmvr/Qc45wMm9
 ZJLalhfLztJQIslWEGAeHJV9Q9ah/xZ8AH+2ykzqU19xwlUOBAuy2uupKcR+8BKoiDxF
 4c49Au+HJ/CUfeZhhqIzE7Oxf9tfuGi1aPgWfvgj4l4N7tkIRgSCLf4QX/3XiEwaoaXa
 oVVg==
X-Gm-Message-State: AOAM532Kdp5Jh1v7NF0B/rzEW3zSzAKkGlYyq5wvOITnUK08w+gHDj+f
 nBVzDtP4usgyGjHpJP1K512nOKZXL/gZniM8TMqO2MJp8Mdqzy+8SeKbxEsFb3LX5X4Yn8f1HB0
 HHsTNDGVN1CJXpek=
X-Received: by 2002:a7b:cf04:: with SMTP id l4mr13903608wmg.33.1602244166788; 
 Fri, 09 Oct 2020 04:49:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJiosB6RMkDzHYIhqwbixcCHFIGKwtFW0J+7Plf67GAENjpFcUe+ZhZvthuxib4WXrjBaKzg==
X-Received: by 2002:a7b:cf04:: with SMTP id l4mr13903592wmg.33.1602244166588; 
 Fri, 09 Oct 2020 04:49:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cee1:4797:6958:7698?
 ([2001:b07:6468:f312:cee1:4797:6958:7698])
 by smtp.gmail.com with ESMTPSA id c4sm11567549wrp.85.2020.10.09.04.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 04:49:26 -0700 (PDT)
Subject: Re: does make check now require TCG? Or is it a parallelism issue?
To: Claudio Fontana <cfontana@suse.de>
References: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
 <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
 <d21dff22-90b1-4769-0948-6bc37eaeb885@linaro.org>
 <6fe91a5a-c136-9af3-c48a-97ccdca7a543@suse.de>
 <3c527b0f-afa1-4b86-4fa5-9acca2a296bd@linaro.org>
 <CABgObfYWK2E8PsSFOcHpuA2vuA3HWgvtuLbrtQCWA=9=r07=5w@mail.gmail.com>
 <a1694fe3-9bc8-df93-345f-29f0de37b923@suse.de>
 <8cedd3e4-dc6a-30ee-fd71-f4776aa8c953@redhat.com>
 <48641901-68e7-7e34-5046-31eea3967701@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eba000db-c0d1-8474-15cc-6fa6e864bb88@redhat.com>
Date: Fri, 9 Oct 2020 13:49:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <48641901-68e7-7e34-5046-31eea3967701@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/20 12:28, Claudio Fontana wrote:
> Running test qtest-x86_64: qos-test
> ERROR qtest-x86_64: bios-tables-test - too few tests run (expected 23, got 22)
> make: *** [Makefile.mtest:1326: run-test-187] Error 1
> make: *** Waiting for unfinished jobs....
> 
> What am I missing here?

This is something else that is crashing.

You want to do (as for any other test; this should be documented)

  make -j12 check-qtest V=1

and then cut-and-paste the bios-tables-test line, which should be something like

  QTEST_QEMU_IMG=./qemu-img \
    G_TEST_DBUS_DAEMON=/home/pbonzini/work/upstream/qemu/tests/dbus-vmstate-daemon.sh \
    QTEST_QEMU_BINARY=./qemu-system-x86_64 \
    tests/qtest/bios-tables-test --tap -k

Paolo


