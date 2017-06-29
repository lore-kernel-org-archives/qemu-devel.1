Received: from eggs.gnu.org ([2001:4830:134:3::10]:39324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQXwA-0002rf-2Z
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQXw5-0003BU-KC
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:48:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQXw5-0003AQ-E1
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:48:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49C86C0C0548
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 11:48:36 +0000 (UTC)
Date: Thu, 29 Jun 2017 12:48:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170629114832.GF2894@work-vm>
References: <1490860207-8302-1-git-send-email-thuth@redhat.com>
	<1490860207-8302-4-git-send-email-thuth@redhat.com>
	<5d9cb505-1f1f-8d34-d4bb-dc38f2f1dff7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d9cb505-1f1f-8d34-d4bb-dc38f2f1dff7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tests: Add a tester for HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

* Eric Blake (eblake@redhat.com) wrote:
> On 03/30/2017 02:50 AM, Thomas Huth wrote:
> > HMP commands do not get any automatic testing yet, so on certain
> > QEMU machines, some HMP commands were causing crashes in the past.
> > Thus we should test HMP commands in our test suite, too, to avoid
> > that such problems creep in again in the future.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> 
> > +static const char *hmp_cmds[] = {
> > +    "boot_set ndc",
> 
> > +/* Run through the list of pre-defined commands */
> > +static void test_commands(void)
> > +{
> > +    char *response;
> > +    int i;
> > +
> > +    for (i = 0; hmp_cmds[i] != NULL; i++) {
> > +        if (verbose) {
> > +            fprintf(stderr, "\t%s\n", hmp_cmds[i]);
> > +        }
> > +        response = hmp(hmp_cmds[i]);
> 
> I failed to notice this sooner, but hmp() is passing its first arg as a
> format string through a printf family.  If hmp_cmds[i] ever gets
> modified to include something with a %, it will misbehave.  Better is to
> use hmp("%s", variable).
> 
> I've patched it locally as part of rebasing my work on avoiding dynamic
> JSON format strings, if no one beats me to a fix (my series also adds
> the gcc format attribute tag, so that the compiler catches any further
> mismatches in hmp() format vs. arguments).

Ah yes, good spot.  Please include that fix.

Dave

> > +    while (*info) {
> > +        /* Extract the info command, ignore parameters and description */
> > +        g_assert(strncmp(info, "info ", 5) == 0);
> > +        endp = strchr(&info[5], ' ');
> > +        g_assert(endp != NULL);
> > +        *endp = '\0';
> > +        /* Now run the info command */
> > +        if (verbose) {
> > +            fprintf(stderr, "\t%s\n", info);
> > +        }
> > +        resp = hmp(info);
> 
> Another instance.
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
