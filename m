Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08618C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E6B206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Xg/oGSiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E6B206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw1Z6-0006kn-1m
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jw1YI-0006Jl-VU
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:55:47 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:58702 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jw1YC-0008Mo-M7
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:55:42 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id B38A94C905;
 Thu, 16 Jul 2020 10:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-transfer-encoding:content-disposition
 :content-type:content-type:mime-version:references:message-id
 :subject:subject:from:from:date:date:received:received:received;
 s=mta-01; t=1594896936; x=1596711337; bh=7Rso1JH+ojDerzZW0selQ2
 736zLgLVh+BdSUGLmO4Xk=; b=Xg/oGSiFdIaV2udSr6lsjQlu0j4Nq/99lUMaz+
 nsDf6bcaHABz1IppvflyWRX7NNWoW/Z/OM+lqmST2zYAih8TLYERlkLHH5/BIt8r
 SkXATGPQDv2I5uCs5mcSBF6kvK7adGVZ34pCRVv93J1dxmcMJj3YkSCLVsyt7FrD
 qxZzc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pp7gV5FJ47Y2; Thu, 16 Jul 2020 13:55:36 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 9C4C54C852;
 Thu, 16 Jul 2020 13:55:36 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 16
 Jul 2020 13:55:36 +0300
Date: Thu, 16 Jul 2020 13:55:35 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 4/4] net/colo: Match is-enabled probe to tracepoint
Message-ID: <20200716105535.GE90799@SPB-NB-133.local>
References: <20200716081754.22422-1-r.bolshakov@yadro.com>
 <20200716081754.22422-5-r.bolshakov@yadro.com>
 <20200716085127.GB227735@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200716085127.GB227735@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 06:55:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Zhang Chen <chen.zhang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 09:51:27AM +0100, Daniel P. Berrangé wrote:
> Adding Stefan to CC as the trace maintainer.
> 
> On Thu, Jul 16, 2020 at 11:17:54AM +0300, Roman Bolshakov wrote:
> > Build of QEMU with dtrace fails on macOS:
> > 
> >   LINK    x86_64-softmmu/qemu-system-x86_64
> > error: probe colo_compare_miscompare doesn't exist
> > error: Could not register probes
> > ld: error creating dtrace DOF section for architecture x86_64
> > 
> > The reason of the error is explained by Adam Leventhal [1]:
> > 
> >   Note that is-enabled probes don't have the stability magic so I'm not
> >   sure how things would work if only is-enabled probes were used.
> > 
> > net/colo code uses is-enabled probes to determine if other probes should
> > be used but colo_compare_miscompare itself is not used explicitly.
> > Linker doesn't include the symbol and build fails.
> > 
> > The issue can be resolved if is-enabled probe matches the actual trace
> > point that is used inside the test.
> > 
> > 1. http://markmail.org/message/6grq2ygr5nwdwsnb
> > 
> > Fixes: f4b618360e ("colo-compare: add TCP, UDP, ICMP packet comparison")
> > Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Cc: Cameron Esfahani <dirty@apple.com>
> > Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> > ---
> >  net/colo-compare.c    | 12 +++++++-----
> >  net/filter-rewriter.c |  8 ++++++--
> >  net/trace-events      |  2 --
> >  3 files changed, 13 insertions(+), 9 deletions(-)
> > 
> > diff --git a/net/colo-compare.c b/net/colo-compare.c
> > index 398b7546ff..9525ed703b 100644
> > --- a/net/colo-compare.c
> > +++ b/net/colo-compare.c
> > @@ -327,7 +327,7 @@ static int colo_compare_packet_payload(Packet *ppkt,
> >                                         uint16_t len)
> >  
> >  {
> > -    if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
> > +    if (trace_event_get_state_backends(TRACE_COLO_COMPARE_IP_INFO)) {
> >          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
> >  
> >          strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
> > @@ -492,7 +492,7 @@ sec:
> >          g_queue_push_head(&conn->primary_list, ppkt);
> >          g_queue_push_head(&conn->secondary_list, spkt);
> >  
> > -        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
> > +        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_TCP_INFO)) {
> >              qemu_hexdump((char *)ppkt->data, stderr,
> >                          "colo-compare ppkt", ppkt->size);
> >              qemu_hexdump((char *)spkt->data, stderr,
> 
> Not your fault, as this problem is pre-existing, but IMHO this block of code
> is simply broken by design. It is checking a trace event enablement state,
> and then not emitting any trace event, but instead dumping info to stderr.
> This is mis-use of the trace framework, and changing the event name fixes
> your immediate macOS bug but the code is still flawed.
> 
> Basically it is using the trace framework as a way to dynamically turn on /
> off general debugging information.
> 
> I'm not quite sure what todo to fix it, but I don't think it should be wrapped
> in any trace_event_get_state_backends() call at all.
> 
> The simplest immediate option I think is to change it to be a compile time
> debug
> 
>   // #define DEBUG_COLO_PACKETS
> 
> and then use
> 
>   #ifdef DEBUG_COLO_PACKETS
>       qemu_hexdump(...)
>   #endif
> 
> and then leave it upto the maintainer to come up with a more advanced
> solution if they want to make it runtime configurable again, but not
> abusing the trace framework.
> 


Hi Daniel,

It makes sense, compile-time define works better because the trace data
doesn't go into a trace point. I'll use that approach in v2.

> > @@ -533,7 +533,8 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
> >                                      ppkt->size - offset)) {
> >          trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
> >          trace_colo_compare_udp_miscompare("Secondary pkt size", spkt->size);
> > -        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
> > +        if (trace_event_get_state_backends(
> > +              TRACE_COLO_COMPARE_UDP_MISCOMPARE)) {
> >              qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
> >                           ppkt->size);
> >              qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
> 
> Same brokenness
> 
> > @@ -576,7 +577,8 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
> >                                             ppkt->size);
> >          trace_colo_compare_icmp_miscompare("Secondary pkt size",
> >                                             spkt->size);
> > -        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
> > +        if (trace_event_get_state_backends(
> > +              TRACE_COLO_COMPARE_ICMP_MISCOMPARE)) {
> >              qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
> >                           ppkt->size);
> >              qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
> 
> Same brokenness
> 
> > @@ -597,7 +599,7 @@ static int colo_packet_compare_other(Packet *spkt, Packet *ppkt)
> >      uint16_t offset = ppkt->vnet_hdr_len;
> >  
> >      trace_colo_compare_main("compare other");
> > -    if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
> > +    if (trace_event_get_state_backends(TRACE_COLO_COMPARE_IP_INFO)) {
> >          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
> >  
> >          strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
> > diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
> > index 1aaad101b6..ff04165cc4 100644
> > --- a/net/filter-rewriter.c
> > +++ b/net/filter-rewriter.c
> > @@ -76,7 +76,9 @@ static int handle_primary_tcp_pkt(RewriterState *rf,
> >      struct tcp_hdr *tcp_pkt;
> >  
> >      tcp_pkt = (struct tcp_hdr *)pkt->transport_header;
> > -    if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_DEBUG)) {
> > +    if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_PKT_INFO) ||
> > +        trace_event_get_state_backends(
> > +          TRACE_COLO_FILTER_REWRITER_CONN_OFFSET)) {
> >          trace_colo_filter_rewriter_pkt_info(__func__,
> >                      inet_ntoa(pkt->ip->ip_src), inet_ntoa(pkt->ip->ip_dst),
> >                      ntohl(tcp_pkt->th_seq), ntohl(tcp_pkt->th_ack),
> 
> Since there are two separate trace events here, each should be wrapped with
> its own check. IOW, two completely separate if (...) trace(..); blocks
> 


Agreed, I'll do that, thanks!

> > @@ -180,7 +182,9 @@ static int handle_secondary_tcp_pkt(RewriterState *rf,
> >  
> >      tcp_pkt = (struct tcp_hdr *)pkt->transport_header;
> >  
> > -    if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_DEBUG)) {
> > +    if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_PKT_INFO) ||
> > +        trace_event_get_state_backends(
> > +          TRACE_COLO_FILTER_REWRITER_CONN_OFFSET)) {
> >          trace_colo_filter_rewriter_pkt_info(__func__,
> >                      inet_ntoa(pkt->ip->ip_src), inet_ntoa(pkt->ip->ip_dst),
> >                      ntohl(tcp_pkt->th_seq), ntohl(tcp_pkt->th_ack),
> 
> Same here.
> 
> 

Best regards,
Roman

