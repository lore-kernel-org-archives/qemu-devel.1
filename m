Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F86C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 11:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D61A24641
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 11:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="kF3CJVyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D61A24641
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWHg7-000361-Cp
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 07:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kWHen-0002Ym-B1
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 07:24:21 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:55953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kWHel-0000xY-9b
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 07:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=/do8Z5bCL/tiZ7OXP0vxO4ekeFeWE3ZXlgQdEOinvCI=; b=kF3CJVyBY1nFi+JzazFlM+cq9c
 rNk52nTI3DWuImldGBJala4+0HKqn+GMUjfDAF1CiQ9EEGFvDrHqlhlPRiHFYstpmvwPinREjvSXn
 4RPmZ4tI0MuPFdm9sOBsptld/Tpsg3hdLrOhRCUzz/3wsygR/kmg95961gpt7KTXXOzHFKSgvfUTs
 0PrIBLTbXP4bawjwchVDIHBrz1NS+icHQZ/HW3i4GdS8ytAZVfXftDmeu/akTXBbnFOMLGSIeOwM7
 etEyUQFMAceuu5vzY3Tv44gQnfdT8oyez5G0V1e/4wRuKxDP0/dDsGAL0TcDBUBH+guB5J7i98Uvf
 Swt67BQw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 04/12] libqos/qgraph: add qos_dump_graph()
Date: Sat, 24 Oct 2020 13:24:15 +0200
Message-ID: <6217010.FX5ceaG2Km@silver>
In-Reply-To: <8c8c8cf1-ed97-3f27-2d0e-7440433169f7@redhat.com>
References: <cover.1602182956.git.qemu_oss@crudebyte.com>
 <5f493b816595f0f6fe50a3f83e46432ab48d881b.1602182956.git.qemu_oss@crudebyte.com>
 <8c8c8cf1-ed97-3f27-2d0e-7440433169f7@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 06:39:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Samstag, 24. Oktober 2020 08:04:20 CEST Thomas Huth wrote:
> On 08/10/2020 20.34, Christian Schoenebeck wrote:
> > This new function is purely for debugging purposes. It prints the
> > current qos graph to stdout and allows to identify problems in the
> > created qos graph e.g. when writing new qos tests.
> > 
> > Coloured output is used to mark available nodes in green colour,
> > whereas unavailable nodes are marked in red colour.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> > 
> >  tests/qtest/libqos/qgraph.c | 56 +++++++++++++++++++++++++++++++++++++
> >  tests/qtest/libqos/qgraph.h | 20 +++++++++++++
> >  2 files changed, 76 insertions(+)
> > 
> > diff --git a/tests/qtest/libqos/qgraph.c b/tests/qtest/libqos/qgraph.c
> > index 61faf6b27d..af93e38dcb 100644
> > --- a/tests/qtest/libqos/qgraph.c
> > +++ b/tests/qtest/libqos/qgraph.c
> > @@ -805,3 +805,59 @@ void qos_delete_cmd_line(const char *name)
> > 
> >          node->command_line = NULL;
> >      
> >      }
> >  
> >  }
> > 
> > +
> > +#define RED(txt) (    \
> > +    "\033[0;91m" txt  \
> > +    "\033[0m"         \
> > +)
> > +
> > +#define GREEN(txt) (  \
> > +    "\033[0;92m" txt  \
> > +    "\033[0m"         \
> > +)
> 
> I don't think this is very portable - and it will only make logs ugly to
> read in text editors. Could you please simply drop these macros?
> 
>  Thomas

The precise way I did it here is definitely unclean. And the use case is 
trivial, so on doubt I could just drop it of course.

But allow me one attempt to promote coloured terminal output in general: These 
are ANSI color escape sequences, a standard with its youngest revision dating 
back to 1991. It is a well supported standard on all major platforms nowadays:

	https://en.wikipedia.org/wiki/ANSI_escape_code

It works on macOS's standard terminal for at least 20 years, with cmd.exe on 
Windows 10, on essentially all Linux and BSD distros, and even on many web 
based CI platforms.

So what about introducing some globally shared macros for coloured output 
instead? Then there would be one central place for changing coloured output 
support for the entire code base; and I would change the macros to fallback to 
plain text output if there is any doubt the terminal would not support it.

Besides, QEMU just switched to meson which uses coloured output as well, as do 
clang, GCC, git and many other tools in your build chain.

Best regards,
Christian Schoenebeck



