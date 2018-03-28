Received: from eggs.gnu.org ([2001:4830:134:3::10]:50532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f194k-00063X-AA
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 07:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f194f-0005LT-Aa
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 07:17:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44200 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f194f-0005Kt-6S
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 07:17:01 -0400
Date: Wed, 28 Mar 2018 13:16:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180328131653.0a936cef@redhat.com>
In-Reply-To: <20180323212732.GG28161@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-5-git-send-email-imammedo@redhat.com>
	<20180323212732.GG28161@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/9] hmp: disable monitor in preconfig
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Fri, 23 Mar 2018 18:27:32 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Mar 12, 2018 at 02:11:10PM +0100, Igor Mammedov wrote:
> > Ban it for now, if someone would need it to work early,
> > one would have to implement checks if HMP command is valid
> > at preconfig state.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v4:
> >   * v3 was only printing error but not preventing command execution,
> >     Fix it by returning after printing error message.
> >     ("Dr. David Alan Gilbert" <dgilbert@redhat.com>)
> > ---
> >  monitor.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/monitor.c b/monitor.c
> > index a4417f2..ea0ca57 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -3104,6 +3104,11 @@ static void handle_hmp_command(Monitor *mon, const char *cmdline)
> >  
> >      trace_handle_hmp_command(mon, cmdline);
> >  
> > +    if (runstate_check(RUN_STATE_PRECONFIG)) {
> > +        monitor_printf(mon, "HMP not available in preconfig state\n");
> > +        return;  
> 
> Not even the "cont" command?  It would be useful for testing
> -preconfig.
As someone already said on the list it's very easy to test with
QMP nowdays, just use qmp-shell for that.
So if someone isn't willing to learn to use QMP, one can write
HMP part with proper white-listing.

I can extend error message like this:

"HMP not available in preconfig state, use QMP instead\n"
