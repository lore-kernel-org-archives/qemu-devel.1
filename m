Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262C9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 17:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A1F2074F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 17:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hU0kLmtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A1F2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Syg-00020e-6E
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 13:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1k0SxY-0001AZ-FF
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 13:00:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44654
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1k0SxW-0008IT-Do
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 13:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595955609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9cZzSn4IjU36micyQk1wsFI1iJ4axgLvgIp1B4iNxt0=;
 b=hU0kLmtXtVweVYdwCSJtfU2E9YlV3AGb39kQ6tvI2/vRKjoPgCia5/cko7I1Uq7mCcYZsk
 xWS4Nzqyca1zNhpWj0f00RJ/F8JgkO6qp9tMEIcMiVqgtLZ0dXFW6XQZrJGBu7GGVn6+o5
 1IskiPa/VTuQZTacCaupZIvJTwUM++E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-I_GqSLthNUy0d9lSWKIKBg-1; Tue, 28 Jul 2020 13:00:04 -0400
X-MC-Unique: I_GqSLthNUy0d9lSWKIKBg-1
Received: by mail-ej1-f72.google.com with SMTP id d16so7440522eje.20
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 10:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9cZzSn4IjU36micyQk1wsFI1iJ4axgLvgIp1B4iNxt0=;
 b=tkpxB9wm5CSsgNS2a4LALqhmilVKrm/CCsWLFhogVu88ZRDXKyKWqNzYpum4iXK776
 6V7INkdxcEkUxSlvEQUzylkZNeGXAfKdMKuEyvv/sxKUa3NNyG6QUi40TNl5DMjCnd1q
 PWkWlVU3hF47L9OR80r/pXPMeolhZgtnyfO3UVDb3GVBD/wdSiVp3AugqRctwX+A6U3x
 OMaOHjx2uO5EQG/eWMafyrhLEnsG9ME9/2zn19OD2Tn1CWpByHj492T4yiRd90DNSh2B
 F5WjL/2RFhEMjQoB20oSMA58T7x6znZffQnPBnXwg3dmRGAKuRafMxeWXBpmMs3MsC4F
 1GqQ==
X-Gm-Message-State: AOAM531l22Ol6AudkvUSaYwYkoBAGYo6npXLfjnjXNyyvBpmBvaFsxNT
 9s2wuXzZfjjM/aQkCXf5EiVNIERdpthgyCym4tAOq0S0OHWmmfnOC00QqXQmc61hta8wT+01/ln
 IDFBI7tOUzte7zF9Cqod2gKuwZlZLXbg=
X-Received: by 2002:a17:906:388b:: with SMTP id
 q11mr454869ejd.100.1595955603559; 
 Tue, 28 Jul 2020 10:00:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIy2QqBGkRM7m8AHoZOATC+ZgSUWMEm3DrSZTzak+TuOZ0jGMk6/RW19TTIwTJ2UehyLXgoSWyi/n5SH+UlJA=
X-Received: by 2002:a17:906:388b:: with SMTP id
 q11mr454848ejd.100.1595955603218; 
 Tue, 28 Jul 2020 10:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200727170838.1101775-1-mcascell@redhat.com>
 <20200727172929.5nnasrbvp2gg3yyv@mozz.bu.edu>
In-Reply-To: <20200727172929.5nnasrbvp2gg3yyv@mozz.bu.edu>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Tue, 28 Jul 2020 18:59:52 +0200
Message-ID: <CAA8xKjVMnF3KZPcaiVgWr_1fN-=CKvNQj+WQ0azyqPTGLpsf7Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] assertion failure in net_tx_pkt_add_raw_fragment() in
 hw/net/net_tx_pkt.c
To: Alexander Bulekov <alxndr@bu.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, ziming zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you Alexander for testing the patch and providing the
reproducer. I think you should be credited, along with Ziming, for
independently reporting the same issue.

On Mon, Jul 27, 2020 at 7:40 PM Alexander Bulekov <alxndr@bu.edu> wrote:
>
> I sent a reproducer for the to the list some time ago, but never created
> a Launchpad bug...
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg701930.html
>
> Anyways.. I can confirm that I can't reproduce the issue with these
> patches.
>
> Minimized Reproducer:
> cat << EOF | ./i386-softmmu/qemu-system-i386 -M pc-q35-5.0 -nographic \
> -display none -serial none -monitor none -qtest stdio
> outl 0xcf8 0x80001010
> outl 0xcfc 0xe1020000
> outl 0xcf8 0x80001004
> outw 0xcfc 0x7
> write 0xe10207e8 0x4 0x25ff13ff
> write 0xe10200b8 0x7 0xe3055e411b0202
> write 0xe1020100 0x5 0x5e411b0202
> write 0xe1020110 0x4 0x1b0202e1
> write 0xe1020118 0x4 0x06fff105
> write 0xe1020128 0x7 0xf3055e411b0202
> write 0xe1020402 0x2 0x5e41
> write 0xe1020420 0x4 0x1b0202e1
> write 0xe1020428 0x4 0x06ff6105
> write 0xe1020438 0x1 0x63
> write 0xe1020439 0x1 0x05
> EOF
>
> -Alex
>
> On 200727 1908, Mauro Matteo Cascella wrote:
> > An assertion failure issue was reported by Mr. Ziming Zhang (CC'd).
> > It occurs in the code that processes network packets while adding data
> > fragments into packet context. This flaw could potentially be abused by
> > a malicious guest to abort the QEMU process on the host. This two patch
> > series does a couple of things:
> >
> > - introduces a new function in net_tx_pkt.{c,h} to check the maximum number
> >   of data fragments
> > - adds a check in both e1000e and vmxnet3 devices to skip the packet if the
> >   current data fragment exceeds max_raw_frags, preventing
> >   net_tx_pkt_add_raw_fragment() to be called with an invalid raw_frags
> >
> > Mauro Matteo Cascella (2):
> >   hw/net/net_tx_pkt: add function to check pkt->max_raw_frags
> >   hw/net: check max_raw_frags in e1000e and vmxnet3 devices
> >
> >  hw/net/e1000e_core.c | 3 ++-
> >  hw/net/net_tx_pkt.c  | 5 +++++
> >  hw/net/net_tx_pkt.h  | 8 ++++++++
> >  hw/net/vmxnet3.c     | 3 ++-
> >  4 files changed, 17 insertions(+), 2 deletions(-)
> >
> > --
> > 2.26.2
> >
> >
>


-- 
Mauro Matteo Cascella, Red Hat Product Security
6F78 E20B 5935 928C F0A8  1A9D 4E55 23B8 BB34 10B0


