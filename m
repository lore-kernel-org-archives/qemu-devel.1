Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC61C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 05:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5889D2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 05:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrDMeE+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5889D2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJJ6-00014C-K5
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 01:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jwJIT-0000dn-8H
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 01:52:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50926
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jwJIQ-0002ZE-BF
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 01:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594965152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+kMxF4ezUDK+LGZPIi4luOEw3BKiTZCt9j+FO4WNOIU=;
 b=OrDMeE+clf3m0vNq/DlECnwEM42IU+xn9BoU5XjEPvtJ6b1ULCApMdH+PCGhTtUpvcijWe
 m8PLgCAGAounIMwD6jTvQ3LXg/3gtjpjHQ3QpaQ44c4AmGRX3M/CHo4jvAPKK8vOwk38EO
 Ha+HfKZghZyzsOaUfBEOBMKCHdNhbYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-G8_bZmUYM32_WKq2IEe3AA-1; Fri, 17 Jul 2020 01:52:29 -0400
X-MC-Unique: G8_bZmUYM32_WKq2IEe3AA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AC2F184C5EC;
 Fri, 17 Jul 2020 05:52:28 +0000 (UTC)
Received: from [10.72.12.157] (ovpn-12-157.pek2.redhat.com [10.72.12.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6B62619B5;
 Fri, 17 Jul 2020 05:52:00 +0000 (UTC)
Subject: Re: [PATCH] net: check payload length limit for all frames
To: P J P <ppandit@redhat.com>
References: <20200716192335.1212638-1-ppandit@redhat.com>
 <CAKXe6SKL3aNiOKKLEMof6GGNjYLcX9fvfSf-0PBSX48rh4--FQ@mail.gmail.com>
 <20200717012151.tlfmc6hsfia22f4e@mozz.bu.edu>
 <4e4909ae-db2f-4a32-ae5c-d52149e80a8c@redhat.com>
 <nycvar.YSQ.7.78.906.2007171016480.950384@xnncv>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3620abab-a464-8e3c-d5b9-0bd80b35e2f1@redhat.com>
Date: Fri, 17 Jul 2020 13:51:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.78.906.2007171016480.950384@xnncv>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/17 下午1:06, P J P wrote:
>    Hello Jason, all
>
> +-- On Fri, 17 Jul 2020, Jason Wang wrote --+
> | On 2020/7/17 上午9:21, Alexander Bulekov wrote:
> | > On 200717 0853, Li Qiang wrote:
> | >> Which issue are you trying to solve, any reference linking?
> | >> I also send a patch related this part and also a UAF.
> | >
> | > I reported a UAF privately to QEMU-Security in May. I believe the one Li
> | > is referring to is this one https://bugs.launchpad.net/qemu/+bug/1886362
> | >
> | > When I saw Prasad's email, I was worried that I reported the same bug
> | > twice, but I can still reproduce LP#1886362 with Prasad's patch.
> | >
> | > On the other hand, I cannot reproduce either issue with Li's patch:
> | > Message-Id: <20200716161453.61295-1-liq3ea@163.com>
> | >
> | > Based on this, I think there were two distinct issues.
>
>    Yes, LP#1886362 looks different that the one fixed here.
>
> | Could you describe the issue you saw in details? (E.g the calltrace?) The
> | commit log does not explain where we can get OOB or UAF.
>
> I should've included the backtrace in the commit message. It crossed my mind
> after I sent the patch. Sorry.


Thanks but I don't see a direct relation between 64K limit and this 
calltrace.

Maybe you can elaborate more on this?

Thanks


>
> ===
> 1040323==ERROR: AddressSanitizer: heap-use-after-free on address 0x6060000344d8 at pc 0x5571b8fb9ce7 bp 0x7ffede5a2290 sp 0x7ffede5a2280
> READ of size 8 at 0x6060000344d8 thread T0
>      #0 0x5571b8fb9ce6 in e1000e_write_packet_to_guest hw/net/e1000e_core.c:1587
>      #1 0x5571b8fba8fc in e1000e_receive_iov hw/net/e1000e_core.c:1709
>      #2 0x5571b8f9cb08 in e1000e_nc_receive_iov hw/net/e1000e.c:213
>      #3 0x5571b8f90285 in net_tx_pkt_sendv hw/net/net_tx_pkt.c:544
>      #4 0x5571b8f90aaa in net_tx_pkt_send hw/net/net_tx_pkt.c:620
>      #5 0x5571b8f90b2e in net_tx_pkt_send_loopback hw/net/net_tx_pkt.c:633
>      #6 0x5571b8fb3c3b in e1000e_tx_pkt_send hw/net/e1000e_core.c:664
>      #7 0x5571b8fb43dd in e1000e_process_tx_desc hw/net/e1000e_core.c:743
>      #8 0x5571b8fb5b4f in e1000e_start_xmit hw/net/e1000e_core.c:934
>      #9 0x5571b8fbe2ad in e1000e_set_tdt hw/net/e1000e_core.c:2451
>      #10 0x5571b8fc01e0 in e1000e_core_write hw/net/e1000e_core.c:3265
>      #11 0x5571b8f9c387 in e1000e_mmio_write hw/net/e1000e.c:109
>      ...
> 0x6060000344d8 is located 24 bytes inside of 64-byte region [0x6060000344c0,0x606000034500)
> freed by thread T0 here:
>      #0 0x7f89e3b87307 in __interceptor_free (/lib64/libasan.so.6+0xb0307)
>      #1 0x7f89e37c7a6c in g_free (/lib64/libglib-2.0.so.0+0x58a6c)
>      #2 0x5571b8f95fc7 in net_rx_pkt_pull_data hw/net/net_rx_pkt.c:103
>      #3 0x5571b8f969b3 in net_rx_pkt_attach_iovec_ex hw/net/net_rx_pkt.c:158
>      #4 0x5571b8fba6bc in e1000e_receive_iov hw/net/e1000e_core.c:1695
>      #5 0x5571b8f9cb08 in e1000e_nc_receive_iov hw/net/e1000e.c:213
>      #6 0x5571b8f90285 in net_tx_pkt_sendv hw/net/net_tx_pkt.c:544
>      #7 0x5571b8f90aaa in net_tx_pkt_send hw/net/net_tx_pkt.c:620
>      #8 0x5571b8f90b2e in net_tx_pkt_send_loopback hw/net/net_tx_pkt.c:633
>      #9 0x5571b8fb3c3b in e1000e_tx_pkt_send hw/net/e1000e_core.c:664
>      #10 0x5571b8fb43dd in e1000e_process_tx_desc hw/net/e1000e_core.c:743
>      #11 0x5571b8fb5b4f in e1000e_start_xmit hw/net/e1000e_core.c:934
>      #12 0x5571b8fbe011 in e1000e_set_tctl hw/net/e1000e_core.c:2431
>      #13 0x5571b8fc01e0 in e1000e_core_write hw/net/e1000e_core.c:3265
>      #14 0x5571b8f9c387 in e1000e_mmio_write hw/net/e1000e.c:109
>      ...
> previously allocated by thread T0 here:
>      #0 0x7f89e3b87667 in __interceptor_malloc (/lib64/libasan.so.6+0xb0667)
>      #1 0x7f89e37c7978 in g_malloc (/lib64/libglib-2.0.so.0+0x58978)
>      #2 0x5571b8f95fc7 in net_rx_pkt_pull_data hw/net/net_rx_pkt.c:103
>      #3 0x5571b8f969b3 in net_rx_pkt_attach_iovec_ex hw/net/net_rx_pkt.c:158
>      #4 0x5571b8fba6bc in e1000e_receive_iov hw/net/e1000e_core.c:1695
>      #5 0x5571b8f9cb08 in e1000e_nc_receive_iov hw/net/e1000e.c:213
>      #6 0x5571b8f90285 in net_tx_pkt_sendv hw/net/net_tx_pkt.c:544
>      #7 0x5571b8f90aaa in net_tx_pkt_send hw/net/net_tx_pkt.c:620
>      #8 0x5571b8f90b2e in net_tx_pkt_send_loopback hw/net/net_tx_pkt.c:633
>      #9 0x5571b8fb3c3b in e1000e_tx_pkt_send hw/net/e1000e_core.c:664
>      #10 0x5571b8fb43dd in e1000e_process_tx_desc hw/net/e1000e_core.c:743
>      #11 0x5571b8fb5b4f in e1000e_start_xmit hw/net/e1000e_core.c:934
>      #12 0x5571b8fbe2ad in e1000e_set_tdt hw/net/e1000e_core.c:2451
>      #13 0x5571b8fc01e0 in e1000e_core_write hw/net/e1000e_core.c:3265
>      #14 0x5571b8f9c387 in e1000e_mmio_write hw/net/e1000e.c:109
> ===
>   
> | >>> --- a/hw/net/net_tx_pkt.c
> | >>> +++ b/hw/net/net_tx_pkt.c
> | >>> @@ -607,12 +607,10 @@ bool net_tx_pkt_send(struct NetTxPkt *pkt,
> | >>> NetClientState *nc)
> | >>>        * Since underlying infrastructure does not support IP datagrams
> | >>>        longer
> | >>>        * than 64K we should drop such packets and don't even try to send
> | >>>        */
> | >>> -    if (VIRTIO_NET_HDR_GSO_NONE != pkt->virt_hdr.gso_type) {
> | >>> -        if (pkt->payload_len >
> | >>> -            ETH_MAX_IP_DGRAM_LEN -
> | >>> -            pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len) {
> | >>> -            return false;
> | >>> -        }
> | >>> +    if (pkt->payload_len >
> | >>> +        ETH_MAX_IP_DGRAM_LEN -
> | >>> +        pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len) {
> | >>> +        return false;
> | >>>       }
>
> Nevertheless, checking 'payload_len' for all packets irrespective of the
> 'gso_type' does seem reasonable.
>
>
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


