Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F89C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 20:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4BB021744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 20:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzSThaLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BB021744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1bkc-0004Lh-1Z
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 16:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k1bjm-0003sm-TE
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 16:34:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32554
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k1bjk-0005BH-4b
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 16:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596227678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=js3+HA4mUGeolvcG9BUF7iQizao1JWnNJYQPMsyi8AU=;
 b=gzSThaLZld+nt1k+IiymVS5VW/69T6p3hP25OoFy8QvZOxy7RTx9mcEgoIkViOA3A/842D
 zypi+EXFYGQRtmSd7/7Z/uH7fQ6B4Mb3dMKsaOfMTDUEyf1rBnsvM/Q0GjWB1xjc/6s/RQ
 rB1Jz/+wIv5rwXJJjLEPIa5WPcJSYdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-2LTS78IqN2GMADMznVLRqQ-1; Fri, 31 Jul 2020 16:34:30 -0400
X-MC-Unique: 2LTS78IqN2GMADMznVLRqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1378D1005504;
 Fri, 31 Jul 2020 20:34:29 +0000 (UTC)
Received: from localhost (ovpn-120-33.rdu2.redhat.com [10.10.120.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 825C91001B0B;
 Fri, 31 Jul 2020 20:34:28 +0000 (UTC)
Date: Fri, 31 Jul 2020 16:34:27 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: ia-32/ia-64 fxsave64 instruction behavior when saving mmx
Message-ID: <20200731203427.GJ225270@habkost.net>
References: <BL0PR2101MB1026B7400F5A568C9D5FC9DBD68F0@BL0PR2101MB1026.namprd21.prod.outlook.com>
 <BL0PR2101MB1026CD468E4F0929086C177FD68D0@BL0PR2101MB1026.namprd21.prod.outlook.com>
 <0670bf89-5b16-3a58-ef2f-d063ee9d5a5e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0670bf89-5b16-3a58-ef2f-d063ee9d5a5e@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:28:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Robert Henry <robhenry@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 01, 2020 at 08:19:51AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Robert.
> 
> Top-posting is difficult to read on technical lists,
> it's better to reply inline.
> 
> Cc'ing the X86 FPU maintainers:
> 
> ./scripts/get_maintainer.pl -f target/i386/fpu_helper.c
> Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86 TCG CPUs)
> Richard Henderson <rth@twiddle.net> (maintainer:X86 TCG CPUs)
> Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86 TCG CPUs)
> 
> On 6/1/20 1:22 AM, Robert Henry wrote:
> > Here's additional information.
> > 
> > All of the remill tests of the legacy MMX instructions fail. These
> > instructions work on 64-bit registers aliased with the lower 64-bits of
> > the x87 fp80 registers. Â The tests fail because remill expects the
> > fxsave64 instruction to deliver 16 bits of 1's (infinity or nan prefix)
> > in the fp80 exponent, eg bits 79:64. Â Metal does this, but QEMU does not.
> 
> Metal is what matters, QEMU should emulate it when possible.
> 
> > 
> > Reading of Intel Software development manual, table 3.44
> > (https://www.felixcloutier.com/x86/FXSAVE.html#tbl-3-44) says these 16
> > bits are reserved, but another version of the manual
> > (http://math-atlas.sourceforge.net/devel/arch/ia32_arch.pdf) section
> > 9.6.2 "Transitions between x87 fpu and mmx code" says a write to an MMX
> > register sets those 16 bits to all 1s.
> 
> You are [1] here answering [2] you asked below.
> 
> > 
> > In digging through the code for the implementation of the SSE/mmx
> > instruction pavgb I see a nice clean implementation in the SSE_HELPER_B
> > macro which takes a MMXREG which is an MMREG_UNION which does not
> > provide, to the extent that I can figure this out, a handle to bits
> > 79:64 of the aliased-with x87 register.
> > 
> > I find it hard to believe that an apparent bug like this has been here
> > "forever". Am I missing something?
> 
> Likely the developer who implemented this code didn't have all the
> information you found, nor the test-suite, and eventually not even the
> hardware to compare.
> 
> Since you have a good understanding of Intel FPU and hardware to
> compare, do you mind sending a patch to have QEMU emulate the correct
> hardware behavior?
> 
> If possible add a test case to tests/tcg/i386/test-i386.c (see
> test_fxsave there).

Was this issue addressed, or does it remain unfixed?  I remember
seeing x86 FPU patches merged recently, but I don't know if they
were related to this.

> 
> > 
> > Robert Henry
> > ------------------------------------------------------------------------
> > *From:* Robert Henry
> > *Sent:* Friday, May 29, 2020 10:38 AM
> > *To:* qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> > *Subject:* ia-32/ia-64 fxsave64 instruction behavior when saving mmx
> > Â 
> > Background: The ia-32/ia-64 fxsave64 instruction saves fp80 or legacy
> > SSE mmx registers. The mmx registers are saved as if they were fp80
> > values. The lower 64 bits of the constructed fp80 value is the mmx
> > register.Â  The upper 16 bits of the constructed fp80 value are reserved;
> > see the last row of table 3-44
> > ofÂ https://www.felixcloutier.com/x86/fxsave#tbl-3-44
> > 
> > The Intel core i9-9980XE Skylake metal I have puts 0xffff into these
> > reserved 16 bits when saving MMX.
> > 
> > QEMU appears to put 0's there.
> > 
> > Does anybody have insight as to what "reserved" really means, or must
> > be, in this case?
> 
> You self-answered to this [2] in [1] earlier.
> 
> > I take the verb "reserved" to mean something other
> > than "undefined".
> > 
> > I came across this issue when running the remill instruction test
> > engine.Â  See my
> > issueÂ https://github.com/lifting-bits/remill/issues/423Â For better or
> > worse, remill assumes that those bits are 0xffff, not 0x0000
> > 
> 
> Regards,
> 
> Phil.
> 

-- 
Eduardo


