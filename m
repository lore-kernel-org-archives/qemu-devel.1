Received: from eggs.gnu.org ([209.51.188.92]:44918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hH70o-0004Da-4d
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 09:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hH70n-0005ir-AL
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 09:23:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hH70n-0005iK-55
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 09:23:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0293D7FDE9
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 13:23:32 +0000 (UTC)
Date: Thu, 18 Apr 2019 10:23:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190418132329.GF25134@habkost.net>
References: <20190418034501.5038-1-ehabkost@redhat.com>
	<20190418132216.7a53f1ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418132216.7a53f1ce@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] cpu: Fix crash with empty -cpu option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

On Thu, Apr 18, 2019 at 01:22:16PM +0200, Igor Mammedov wrote:
> On Thu, 18 Apr 2019 00:45:01 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > Fix the following crash:
> > 
> >   $ qemu-system-x86_64 -cpu ''
> >   qemu-system-x86_64: qom/cpu.c:291: cpu_class_by_name: \
> >       Assertion `cpu_model && cc->class_by_name' failed.
> > 
> > Regression test script included.
> > 
> > Fixes: commit 99193d8f2ef5 ("cpu: drop unnecessary NULL check and cpu_common_class_by_name()")
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  exec.c                              |  4 ++++
> >  tests/acceptance/empty_cpu_model.py | 19 +++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> >  create mode 100644 tests/acceptance/empty_cpu_model.py
> > 
> > diff --git a/exec.c b/exec.c
> > index 1ca95df9d8..d816b38863 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -999,6 +999,10 @@ const char *parse_cpu_option(MachineState *machine, const char *cpu_option)
> >      const char *cpu_type;
> >  
> >      model_pieces = g_strsplit(cpu_option, ",", 2);
> > +    if (!model_pieces[0]) {
> > +        error_report("-cpu option cannot be empty");
> > +        exit(1);
> 
> s/1/EXIT_FAILURE/

Why?

There are 753 instances of "exit(1)" in the tree, and 171
instances of "exit(EXIT_FAILURE)".

-- 
Eduardo
