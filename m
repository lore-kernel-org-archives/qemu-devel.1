Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574A9C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 05:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1E920704
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 05:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arZ9WUo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1E920704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwIal-00081E-Bq
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 01:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jwIaA-0007ZZ-9V
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 01:06:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23768
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jwIa7-0005aG-L8
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 01:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594962405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2DuMKp/dEPtaPi2R3Bx2B1IiE7XOp/+bsR6qrDcbV2g=;
 b=arZ9WUo2vBWhG8aMRD7hbzvKbjgBwTPqHNrbBP7fQb87YXkV+Guk7tXAARF6azMFuCfPpi
 kNLyrmTbH7/xctPiRVKlE+65iNcayoaEW8XBKQzvvyZbgQW96hDo06JazWYV38xwcNJHmv
 jlbJovaMi5clAFFSKQ6EwOvHw2rn37g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-QnbRtYBeOI6enloWu0KQZQ-1; Fri, 17 Jul 2020 01:06:40 -0400
X-MC-Unique: QnbRtYBeOI6enloWu0KQZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83B1C100CCC2;
 Fri, 17 Jul 2020 05:06:39 +0000 (UTC)
Received: from kaapi (unknown [10.74.8.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A73D212CB4;
 Fri, 17 Jul 2020 05:06:36 +0000 (UTC)
Date: Fri, 17 Jul 2020 10:36:34 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] net: check payload length limit for all frames
In-Reply-To: <4e4909ae-db2f-4a32-ae5c-d52149e80a8c@redhat.com>
Message-ID: <nycvar.YSQ.7.78.906.2007171016480.950384@xnncv>
References: <20200716192335.1212638-1-ppandit@redhat.com>
 <CAKXe6SKL3aNiOKKLEMof6GGNjYLcX9fvfSf-0PBSX48rh4--FQ@mail.gmail.com>
 <20200717012151.tlfmc6hsfia22f4e@mozz.bu.edu>
 <4e4909ae-db2f-4a32-ae5c-d52149e80a8c@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-554925844-1594962398=:950384"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:06:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-554925844-1594962398=:950384
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

  Hello Jason, all

+-- On Fri, 17 Jul 2020, Jason Wang wrote --+
| On 2020/7/17 上午9:21, Alexander Bulekov wrote:
| > On 200717 0853, Li Qiang wrote:
| >> Which issue are you trying to solve, any reference linking?
| >> I also send a patch related this part and also a UAF.
| >
| > I reported a UAF privately to QEMU-Security in May. I believe the one Li
| > is referring to is this one https://bugs.launchpad.net/qemu/+bug/1886362
| >
| > When I saw Prasad's email, I was worried that I reported the same bug
| > twice, but I can still reproduce LP#1886362 with Prasad's patch.
| >
| > On the other hand, I cannot reproduce either issue with Li's patch:
| > Message-Id: <20200716161453.61295-1-liq3ea@163.com>
| >
| > Based on this, I think there were two distinct issues.

  Yes, LP#1886362 looks different that the one fixed here.

| Could you describe the issue you saw in details? (E.g the calltrace?) The
| commit log does not explain where we can get OOB or UAF.

I should've included the backtrace in the commit message. It crossed my mind 
after I sent the patch. Sorry.

===
1040323==ERROR: AddressSanitizer: heap-use-after-free on address 0x6060000344d8 at pc 0x5571b8fb9ce7 bp 0x7ffede5a2290 sp 0x7ffede5a2280
READ of size 8 at 0x6060000344d8 thread T0
    #0 0x5571b8fb9ce6 in e1000e_write_packet_to_guest hw/net/e1000e_core.c:1587
    #1 0x5571b8fba8fc in e1000e_receive_iov hw/net/e1000e_core.c:1709
    #2 0x5571b8f9cb08 in e1000e_nc_receive_iov hw/net/e1000e.c:213
    #3 0x5571b8f90285 in net_tx_pkt_sendv hw/net/net_tx_pkt.c:544
    #4 0x5571b8f90aaa in net_tx_pkt_send hw/net/net_tx_pkt.c:620
    #5 0x5571b8f90b2e in net_tx_pkt_send_loopback hw/net/net_tx_pkt.c:633
    #6 0x5571b8fb3c3b in e1000e_tx_pkt_send hw/net/e1000e_core.c:664
    #7 0x5571b8fb43dd in e1000e_process_tx_desc hw/net/e1000e_core.c:743
    #8 0x5571b8fb5b4f in e1000e_start_xmit hw/net/e1000e_core.c:934
    #9 0x5571b8fbe2ad in e1000e_set_tdt hw/net/e1000e_core.c:2451
    #10 0x5571b8fc01e0 in e1000e_core_write hw/net/e1000e_core.c:3265
    #11 0x5571b8f9c387 in e1000e_mmio_write hw/net/e1000e.c:109
    ...
0x6060000344d8 is located 24 bytes inside of 64-byte region [0x6060000344c0,0x606000034500)
freed by thread T0 here:
    #0 0x7f89e3b87307 in __interceptor_free (/lib64/libasan.so.6+0xb0307)
    #1 0x7f89e37c7a6c in g_free (/lib64/libglib-2.0.so.0+0x58a6c)
    #2 0x5571b8f95fc7 in net_rx_pkt_pull_data hw/net/net_rx_pkt.c:103
    #3 0x5571b8f969b3 in net_rx_pkt_attach_iovec_ex hw/net/net_rx_pkt.c:158
    #4 0x5571b8fba6bc in e1000e_receive_iov hw/net/e1000e_core.c:1695
    #5 0x5571b8f9cb08 in e1000e_nc_receive_iov hw/net/e1000e.c:213
    #6 0x5571b8f90285 in net_tx_pkt_sendv hw/net/net_tx_pkt.c:544
    #7 0x5571b8f90aaa in net_tx_pkt_send hw/net/net_tx_pkt.c:620
    #8 0x5571b8f90b2e in net_tx_pkt_send_loopback hw/net/net_tx_pkt.c:633
    #9 0x5571b8fb3c3b in e1000e_tx_pkt_send hw/net/e1000e_core.c:664
    #10 0x5571b8fb43dd in e1000e_process_tx_desc hw/net/e1000e_core.c:743
    #11 0x5571b8fb5b4f in e1000e_start_xmit hw/net/e1000e_core.c:934
    #12 0x5571b8fbe011 in e1000e_set_tctl hw/net/e1000e_core.c:2431
    #13 0x5571b8fc01e0 in e1000e_core_write hw/net/e1000e_core.c:3265
    #14 0x5571b8f9c387 in e1000e_mmio_write hw/net/e1000e.c:109
    ...
previously allocated by thread T0 here:
    #0 0x7f89e3b87667 in __interceptor_malloc (/lib64/libasan.so.6+0xb0667)
    #1 0x7f89e37c7978 in g_malloc (/lib64/libglib-2.0.so.0+0x58978)
    #2 0x5571b8f95fc7 in net_rx_pkt_pull_data hw/net/net_rx_pkt.c:103
    #3 0x5571b8f969b3 in net_rx_pkt_attach_iovec_ex hw/net/net_rx_pkt.c:158
    #4 0x5571b8fba6bc in e1000e_receive_iov hw/net/e1000e_core.c:1695
    #5 0x5571b8f9cb08 in e1000e_nc_receive_iov hw/net/e1000e.c:213
    #6 0x5571b8f90285 in net_tx_pkt_sendv hw/net/net_tx_pkt.c:544
    #7 0x5571b8f90aaa in net_tx_pkt_send hw/net/net_tx_pkt.c:620
    #8 0x5571b8f90b2e in net_tx_pkt_send_loopback hw/net/net_tx_pkt.c:633
    #9 0x5571b8fb3c3b in e1000e_tx_pkt_send hw/net/e1000e_core.c:664
    #10 0x5571b8fb43dd in e1000e_process_tx_desc hw/net/e1000e_core.c:743
    #11 0x5571b8fb5b4f in e1000e_start_xmit hw/net/e1000e_core.c:934
    #12 0x5571b8fbe2ad in e1000e_set_tdt hw/net/e1000e_core.c:2451
    #13 0x5571b8fc01e0 in e1000e_core_write hw/net/e1000e_core.c:3265
    #14 0x5571b8f9c387 in e1000e_mmio_write hw/net/e1000e.c:109
===
 
| >>> --- a/hw/net/net_tx_pkt.c
| >>> +++ b/hw/net/net_tx_pkt.c
| >>> @@ -607,12 +607,10 @@ bool net_tx_pkt_send(struct NetTxPkt *pkt,
| >>> NetClientState *nc)
| >>>        * Since underlying infrastructure does not support IP datagrams
| >>>        longer
| >>>        * than 64K we should drop such packets and don't even try to send
| >>>        */
| >>> -    if (VIRTIO_NET_HDR_GSO_NONE != pkt->virt_hdr.gso_type) {
| >>> -        if (pkt->payload_len >
| >>> -            ETH_MAX_IP_DGRAM_LEN -
| >>> -            pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len) {
| >>> -            return false;
| >>> -        }
| >>> +    if (pkt->payload_len >
| >>> +        ETH_MAX_IP_DGRAM_LEN -
| >>> +        pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len) {
| >>> +        return false;
| >>>       }

Nevertheless, checking 'payload_len' for all packets irrespective of the 
'gso_type' does seem reasonable.


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-554925844-1594962398=:950384--


