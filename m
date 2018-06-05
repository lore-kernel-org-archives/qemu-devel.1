Received: from eggs.gnu.org ([2001:4830:134:3::10]:48187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQ0HP-0006oh-F5
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 20:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQ0HK-0003tC-Jy
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 20:56:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fQ0HK-0003sr-Ca
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 20:56:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56B843007B36
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 00:56:49 +0000 (UTC)
Date: Mon, 4 Jun 2018 21:56:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180605005647.GE3184@localhost.localdomain>
References: <20180604120345.12955-1-berrange@redhat.com>
	<20180604120345.12955-2-berrange@redhat.com>
	<2604e5d5-0e56-62e7-91eb-fd207a907ac8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2604e5d5-0e56-62e7-91eb-fd207a907ac8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vl: don't use RUN_STATE_PRECONFIG
 as initial state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Jun 04, 2018 at 04:21:47PM +0200, Michal Privoznik wrote:
[...]
> > @@ -3572,7 +3570,12 @@ int main(int argc, char **argv, char **envp)
> >                  }
> >                  break;
> >              case QEMU_OPTION_preconfig:
> > -                preconfig_exit_requested = false;
> > +                if (!runstate_check(RUN_STATE_NONE)) {
> > +                    error_report("'--preconfig' and '--incoming' options are "
> > +                                 "mutually exclusive");
> > +                    exit(EXIT_FAILURE);
> > +                }
> > +                runstate_set(RUN_STATE_PRECONFIG);
> 
> Specifying --preconfig twice on the command line now fails with a very
> cryptic message (there's no --incoming).
> 
> >                  break;
> >              case QEMU_OPTION_enable_kvm:
> >                  olist = qemu_find_opts("machine");
> > @@ -3768,9 +3771,12 @@ int main(int argc, char **argv, char **envp)
> >                  }
> >                  break;
> >              case QEMU_OPTION_incoming:
> > -                if (!incoming) {
> > -                    runstate_set(RUN_STATE_INMIGRATE);
> > +                if (!runstate_check(RUN_STATE_NONE)) {
> > +                    error_report("'--preconfig' and '--incoming' options are "
> > +                                 "mutually exclusive");
> > +                    exit(EXIT_FAILURE);
> >                  }
> > +                runstate_set(RUN_STATE_INMIGRATE);
> 
> Same here. Specifying --incoming twice fails with cryptic message. But
> one can argue that specifying --incoming twice is wrong anyway.
> 

Initially I was going to suggest simply not changing runstate
during option parsing to avoid this kind of problem, but maybe
this would be a nice way to implement the command-line parsing
rules:


    case QEMU_OPTION_preconfig:
        /*
         * A INCOMING -> PRECONFIG transition would call:
         *   error_setg("--preconfig and --incoming options are mutually exclusive");
         */
        try_runstate_set(RUN_STATE_PRECONFIG, &error_fatal);
        break;
    case QEMU_OPTION_incoming:
        /*
         * A PRECONFIG -> INCOMING transition would also call:
         *   error_setg("--preconfig and --incoming options are mutually exclusive");
         *
         * Maybe a INCOMING -> INCOMING transition could
         * result in:
         *   error_setg("--incoming can't be specified twice");
         */
        try_runstate_set(RUN_STATE_INMIGRATE, &error_fatal);
        break;


> >                  incoming = optarg;
> >                  break;
> >              case QEMU_OPTION_only_migratable:
> 
> Michal
> 

-- 
Eduardo
