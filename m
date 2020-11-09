Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55541C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 02:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994CF206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 02:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J72QUDLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994CF206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbx5N-0007d1-HZ
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 21:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kbx4T-0007CQ-4x
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 21:38:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kbx4P-0003YT-Gq
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 21:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604889492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t3pWU1gxZ+akoCSpZHt44RAwt+4e84oVO00iGuAkT74=;
 b=J72QUDLu1n+0DvtJCdV/59tvkycwMPXkR8S8vHfYl8tRwqNYhyN0qrjHVN+smOf0p1k6ui
 cISYMmZV/5cbI7ePstTa2/ADxSZqKpZOVV0RRLGHd/BjMOCqrzmVcsGusoCGj+0c8kxx9x
 Hf49teLy/PfqdtqsyzYHDzgonvJqwlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-m7EigrZaOgus109Z_DtthQ-1; Sun, 08 Nov 2020 21:38:07 -0500
X-MC-Unique: m7EigrZaOgus109Z_DtthQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B4EA87950D;
 Mon,  9 Nov 2020 02:38:05 +0000 (UTC)
Received: from [10.72.12.244] (ovpn-12-244.pek2.redhat.com [10.72.12.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 457771002D76;
 Mon,  9 Nov 2020 02:38:03 +0000 (UTC)
Subject: Re: [PATCH] net/e1000e_core: make sure RDH never exceeds RDT in
 e1000e_ring_advance()
To: Mauro Matteo Cascella <mcascell@redhat.com>, qemu-devel@nongnu.org
References: <20201105105616.327593-1-mcascell@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b34f724a-b4fc-6dbd-b660-2dfc2b8e943f@redhat.com>
Date: Mon, 9 Nov 2020 10:38:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105105616.327593-1-mcascell@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 21:14:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: gaoning.pgn@antgroup.com, 330cjfdn@gmail.com, dmitry.fleytman@gmail.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/11/5 下午6:56, Mauro Matteo Cascella wrote:
> The e1000e_write_packet_to_guest() function iterates over a set of
> receive descriptors by advancing rx descriptor head register (RDH) from
> its initial value to rx descriptor tail register (RDT). The check in
> e1000e_ring_empty() is responsible for detecting whether RDH has reached
> RDT, terminating the loop if that's the case. Additional checks have
> been added in the past to deal with bogus values submitted by the guest
> to prevent possible infinite loop. This is done by "wrapping around" RDH
> at some point and detecting whether it assumes the original value during
> the loop.
>
> However, when e1000e is configured to use the packet split feature, RDH is
> incremented by two instead of one, as the packet split descriptors are
> 32 bytes while regular descriptors are 16 bytes. A malicious or buggy
> guest may set RDT to an odd value and transmit only null RX descriptors.
> This corner case would prevent RDH from ever matching RDT, leading to an
> infinite loop. This patch adds a check in e1000e_ring_advance() to make
> sure RDH does never exceed RDT.
>
> This issue was independently reported by Gaoning Pan (Zhejiang University)
> and Cheolwoo Myung.
>
> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> Reported-by: Gaoning Pan <gaoning.pgn@antgroup.com>
> Reported-by: Cheolwoo Myung <330cjfdn@gmail.com>
> ---
> References:
> https://git.qemu.org/?p=qemu.git;a=commit;h=dd793a74882477ca38d49e191110c17dfe
> https://git.qemu.org/?p=qemu.git;a=commit;h=4154c7e03fa55b4cf52509a83d50d6c09d743b7
> http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
>
>   hw/net/e1000e_core.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index bcd186cac5..4c4d14b6ed 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -831,6 +831,10 @@ e1000e_ring_advance(E1000ECore *core, const E1000E_RingInfo *r, uint32_t count)
>   {
>       core->mac[r->dh] += count;
>   
> +    if (core->mac[r->dh] > core->mac[r->dt]) {
> +        core->mac[r->dh] = core->mac[r->dt];
> +    }
> +
>       if (core->mac[r->dh] * E1000_RING_DESC_LEN >= core->mac[r->dlen]) {
>           core->mac[r->dh] = 0;
>       }


A question here.

When count > 1, is this correct to reset dh here?

Thanks


