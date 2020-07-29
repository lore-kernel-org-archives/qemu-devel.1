Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF31EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 12:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9961920809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 12:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="TfQcozpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9961920809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0lHf-0007Ay-Pa
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 08:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k0lH2-0006lF-Cx
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 08:33:32 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:49110 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k0lGy-0001pq-Os
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 08:33:32 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 5CB3B4C878;
 Wed, 29 Jul 2020 12:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-transfer-encoding:content-disposition
 :content-type:content-type:mime-version:references:message-id
 :subject:subject:from:from:date:date:received:received:received;
 s=mta-01; t=1596026003; x=1597840404; bh=lIF3nA57f+ndrtHEMXnMF6
 IbMclXoeWqZnXcMSL+6z8=; b=TfQcozpJLIul4aoVAdx9WKwT9nhMNRURuEwdCh
 usj5xLMj9Bnn47kE8dFf/mLXjaGo97yeu9uZjKFZtwsjiu6zYABgVkQWSeaDHpuH
 FhpymDzukVJngtDyVwWykH4aIU0A7BgjwtRujw2ELzfc3jlixStlsBjKjdy+uVGT
 rvkHc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DgNW5bZ82SXp; Wed, 29 Jul 2020 15:33:23 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 61A174C85F;
 Wed, 29 Jul 2020 15:33:23 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jul 2020 15:33:22 +0300
Date: Wed, 29 Jul 2020 15:33:22 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "Zhang,
 Chen" <chen.zhang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 4/4] net/colo: Match is-enabled probe to tracepoint
Message-ID: <20200729123322.GB34804@SPB-NB-133.local>
References: <20200717093517.73397-1-r.bolshakov@yadro.com>
 <20200717093517.73397-5-r.bolshakov@yadro.com>
 <3f6bcf74d3c348f9b7744305a6343a79@intel.com>
 <20200721140657.GI843362@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200721140657.GI843362@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 08:33:25
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
Cc: Cameron Esfahani <dirty@apple.com>, Jason Wang <jasowang@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 21, 2020 at 03:06:57PM +0100, Daniel P. Berrangé wrote:
> On Sat, Jul 18, 2020 at 05:58:56PM +0000, Zhang, Chen wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Roman Bolshakov <r.bolshakov@yadro.com>
> > > Sent: Friday, July 17, 2020 5:35 PM
> > > To: qemu-devel@nongnu.org
> > > Cc: Daniel P. Berrangé <berrange@redhat.com>; Stefan Hajnoczi
> > > <stefanha@redhat.com>; Cameron Esfahani <dirty@apple.com>; Roman
> > > Bolshakov <r.bolshakov@yadro.com>; Philippe Mathieu-Daudé
> > > <philmd@redhat.com>; Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> > > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>
> > > Subject: [PATCH v2 4/4] net/colo: Match is-enabled probe to tracepoint
> > > 
> > > Build of QEMU with dtrace fails on macOS:
> > > 
> > >   LINK    x86_64-softmmu/qemu-system-x86_64
> > > error: probe colo_compare_miscompare doesn't exist
> > > error: Could not register probes
> > > ld: error creating dtrace DOF section for architecture x86_64
> > > 
> > > The reason of the error is explained by Adam Leventhal [1]:
> > > 
> > >   Note that is-enabled probes don't have the stability magic so I'm not
> > >   sure how things would work if only is-enabled probes were used.
> > > 
> > > net/colo code uses is-enabled probes to determine if other probes should be
> > > used but colo_compare_miscompare itself is not used explicitly.
> > > Linker doesn't include the symbol and build fails.
> > > 
> > > The issue can be resolved if is-enabled probe matches the actual trace point
> > > that is used inside the test. Packet dump toggle is replaced with a compile-
> > > time conditional definition.
> > > 
> > > 1. http://markmail.org/message/6grq2ygr5nwdwsnb
> > > 
> > > Fixes: f4b618360e ("colo-compare: add TCP, UDP, ICMP packet comparison")
> > > Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> > > Cc: Cameron Esfahani <dirty@apple.com>
> > > Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> > > ---
> > >  net/colo-compare.c    | 42 ++++++++++++++++++++++--------------------
> > >  net/filter-rewriter.c | 10 ++++++++--
> > >  net/trace-events      |  2 --
> > >  3 files changed, 30 insertions(+), 24 deletions(-)
> 
> 
> > > (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))
> > > {
> > > +    if (trace_event_get_state_backends(TRACE_COLO_COMPARE_IP_INFO))
> > > {
> > >          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
> > > 
> > >          strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src)); @@ -492,12 +494,12
> > > @@ sec:
> > >          g_queue_push_head(&conn->primary_list, ppkt);
> > >          g_queue_push_head(&conn->secondary_list, spkt);
> > > 
> > > -        if
> > > (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))
> > > {
> > > -            qemu_hexdump((char *)ppkt->data, stderr,
> > > -                        "colo-compare ppkt", ppkt->size);
> > > -            qemu_hexdump((char *)spkt->data, stderr,
> > > -                        "colo-compare spkt", spkt->size);
> > > -        }
> > > +#ifdef DEBUG_COLO_PACKETS
> > > +        qemu_hexdump((char *)ppkt->data, stderr,
> > > +                     "colo-compare ppkt", ppkt->size);
> > > +        qemu_hexdump((char *)spkt->data, stderr,
> > > +                     "colo-compare spkt", spkt->size); #endif
> > > 
> > >          colo_compare_inconsistency_notify(s);
> > >      }
> > > @@ -533,12 +535,12 @@ static int colo_packet_compare_udp(Packet *spkt,
> > > Packet *ppkt)
> > >                                      ppkt->size - offset)) {
> > >          trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
> > >          trace_colo_compare_udp_miscompare("Secondary pkt size", spkt-
> > > >size);
> > > -        if
> > > (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))
> > > {
> > > -            qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
> > > -                         ppkt->size);
> > > -            qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
> > > -                         spkt->size);
> > > -        }
> > > +#ifdef DEBUG_COLO_PACKETS
> > > +        qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
> > > +                     ppkt->size);
> > > +        qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
> > > +                     spkt->size);
> > > +#endif
> > 
> > Hi Roman,
> > 
> > I think change the " trace_event_get_state_backends()" to
> > "trace_colo_compare_main("Dump packet hex: ")" is a better choice here.
> > It will keep the original code logic and avoid the problem here.
> 
> That may workaround the immediate bug, but this is still a misuse of the
> tracing code. Use of any trace point should only trigger actions in the
> trace infrastructure.
> 
> If I'm using dtrace backend to monitor events I don't want to see QEMU
> dumping stuff to stderr. Anything written to stderr is going to trigger
> disk I/O writing to the VM's logfile, and is also liable to trigger rate
> limiting which can impact the guest performance.
> 

Hi Daniel, Chen, Stefan,

So, what do we want to do about the series? Do we have an agreement? Is
the patch okay or I should make a change?

BTW. I've found that Apple added trace probes to Hypervisor.framework in
Big Sur and there're fbt probes in AppleHV.kext. Addition of dtrace on
macOS helps to find performance or functional issues. (I'm using the
series in my private branches for debugging).

Thanks,
Roman

