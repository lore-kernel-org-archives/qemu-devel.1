Received: from eggs.gnu.org ([2001:4830:134:3::10]:56114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQ66q-0001Zz-7M
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 03:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQ66l-0002rw-8s
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 03:10:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34874 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQ66l-0002rP-42
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 03:10:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FCA481A32B9
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 07:10:18 +0000 (UTC)
Date: Tue, 5 Jun 2018 09:10:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180605091016.261ce2bf@redhat.com>
In-Reply-To: <20180605010635.GG3184@localhost.localdomain>
References: <20180604120345.12955-1-berrange@redhat.com>
	<20180604120345.12955-3-berrange@redhat.com>
	<fecc57bf-78a3-065c-729d-a465c974b2c5@redhat.com>
	<20180604170111.33480718@redhat.com>
	<20180605010635.GG3184@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vl: fix use of --daemonize with
 --preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Michal Privoznik <mprivozn@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 4 Jun 2018 22:06:35 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Jun 04, 2018 at 05:01:11PM +0200, Igor Mammedov wrote:
> [...]
> > I'd prefer your patch, as it doesn't break error handling,
> > or maybe even shorter version which keeps state transitions in one place:
> > 
> > diff --git a/vl.c b/vl.c
> > index c4fe255..fa44138 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -1956,7 +1956,7 @@ static void main_loop(void)
> >  #ifdef CONFIG_PROFILER
> >      int64_t ti;
> >  #endif
> > -    do {
> > +    while (!main_loop_should_exit()) {
> >  #ifdef CONFIG_PROFILER
> >          ti = profile_getclock();
> >  #endif
> > @@ -1964,7 +1964,7 @@ static void main_loop(void)
> >  #ifdef CONFIG_PROFILER
> >          dev_time += profile_getclock() - ti;
> >  #endif
> > -    } while (!main_loop_should_exit());
> > +    }
> >  }  
> 
> Would this also fix the bug mentioned at:
> "vl.c: make default main_loop_wait() timeout independed of slirp"?
> 

it would mask it,
I'd apply slirp fix as well while we have a reason to clean it up
