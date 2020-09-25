Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD36C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78594208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grxk61O4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78594208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLr0V-0007TS-II
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLqzO-0006QO-CJ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLqzM-0002xe-Ec
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:54:30 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601052867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=udMze7wlsH+98stNRJJD3uviz0gHGx42D2MN156LbVk=;
 b=grxk61O4wlTsTP3+rAO2fVVKCX+LMrOouChlVDrL6T7Biv5WZ3a0z0LvBRjxGLGolPoWDp
 hXWCWZ/D5E4VIjg6TSqFBQoZomgRJqndcy/fvN4JLnhUFsMs/kyd1wn7CZoltkeOcp+xEv
 OQmNCZj9qBn65tOSc9zIR/w+9x72ibo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-sBX4c_M1NDCmYg1TJQYW1A-1; Fri, 25 Sep 2020 12:54:23 -0400
X-MC-Unique: sBX4c_M1NDCmYg1TJQYW1A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A88B8100CA88;
 Fri, 25 Sep 2020 16:54:22 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76BFE55788;
 Fri, 25 Sep 2020 16:54:21 +0000 (UTC)
Date: Fri, 25 Sep 2020 12:54:15 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Strong, Beeman" <beeman.strong@intel.com>
Subject: Re: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
Message-ID: <20200925165415.GT3717385@habkost.net>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
 <1582580312-19864-2-git-send-email-luwei.kang@intel.com>
 <20200925161539.GS3717385@habkost.net>
 <MW3PR11MB46655375CAECC74BA2D7CAECF2360@MW3PR11MB4665.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MW3PR11MB46655375CAECC74BA2D7CAECF2360@MW3PR11MB4665.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Kang,
 Luwei" <luwei.kang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 25, 2020 at 04:42:26PM +0000, Strong, Beeman wrote:
> LIP=0 will differ from LIP=1 behavior only when CSbase is non-zero, which requires 32-bit code.  In that case a LIP=0 implementation will provide only the EIP offset from CSbase in IP packets (like TIP or FUP), while LIP=1 implementation will provide the full LIP (CSbase + EIP offset).
> 

Thanks.  Is it possible to make KVM emulate LIP=0 behavior
correctly on LIP=1 hosts, or vice versa?


> -----Original Message-----
> From: Eduardo Habkost <ehabkost@redhat.com> 
> Sent: Friday, September 25, 2020 9:16 AM
> To: Kang, Luwei <luwei.kang@intel.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; qemu-devel@nongnu.org; Strong, Beeman <beeman.strong@intel.com>
> Subject: Re: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for Intel PT
> 
> On Tue, Feb 25, 2020 at 05:38:30AM +0800, Luwei Kang wrote:
> > The Intel PT packets which contain IP payloads will have LIP values, 
> > and it will include the CS base component if the 
> > CPUID.(EAX=14H,ECX=0H).ECX.[bit31]
> > is set. But it will disabled the Intel PT in kvm guest because of the 
> > need of live migration safe(c078ca9 i386: Disable Intel PT if packets 
> > IP payloads have LIP values).
> > 
> > This patch will revert the previous limitation because the Intel new 
> > hardware will set this bit and LIP == RIP for most/all real code.
> 
> "works most of the time" might be good enough if it's a conscious user choice, but not for something we might be enabling by default.  Under which conditions this wouldn't work?  Can we detect those conditions somehow?
> 
> To allow live migration between LIP=0 and LIP=1 hosts, we need KVM to be able to properly emulate LIP=0 on LIP=1 hosts.  Does the hardware make this possible?
> 
> If KVM can't emulate LIP=0 on a LIP=1 host, what you can do here is to make the flag configurable and check if the configured value matches the one in the host.  This way we can support both types of hosts, just not allow live migration between them.
> 
> 
> > 
> > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > ---
> >  target/i386/cpu.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c index 
> > 69f518a..8c0d1e4 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -688,8 +688,6 @@ static CPUCacheInfo legacy_l3_cache = {
> >   * bit[02]: Support Single-Range Output scheme;
> >   */
> >  #define INTEL_PT_MINIMAL_ECX     0x7
> > -/* generated packets which contain IP payloads have LIP values */
> > -#define INTEL_PT_IP_LIP          (1 << 31)
> >  #define INTEL_PT_ADDR_RANGES_NUM 0x2 /* Number of configurable 
> > address ranges */  #define INTEL_PT_ADDR_RANGES_NUM_MASK 0x3
> >  #define INTEL_PT_MTC_BITMAP      (0x0249 << 16) /* Support ART(0,3,6,9) */
> > @@ -6281,8 +6279,7 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
> >             ((eax_1 & INTEL_PT_ADDR_RANGES_NUM_MASK) <
> >                                             INTEL_PT_ADDR_RANGES_NUM) ||
> >             ((ebx_1 & (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) !=
> > -                (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) ||
> > -           (ecx_0 & INTEL_PT_IP_LIP)) {
> > +                (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP))) {
> >              /*
> >               * Processor Trace capabilities aren't configurable, so if the
> >               * host can't emulate the capabilities we report on
> > --
> > 1.8.3.1
> > 
> 
> -- 
> Eduardo
> 

-- 
Eduardo


