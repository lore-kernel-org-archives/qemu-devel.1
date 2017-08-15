Received: from eggs.gnu.org ([2001:4830:134:3::10]:44458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhicT-0000Q1-33
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 16:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhicP-0001N6-6W
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 16:39:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhicO-0001Ml-Tz
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 16:39:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C717372D80
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 20:39:15 +0000 (UTC)
Date: Tue, 15 Aug 2017 17:39:09 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170815203909.GY3108@localhost.localdomain>
References: <20170808203935.30021-1-ehabkost@redhat.com>
	<20170808203935.30021-5-ehabkost@redhat.com>
	<87fuctp2pi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fuctp2pi.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2 4/5] qmp-shell: Accept QMP
 command as argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Aug 15, 2017 at 12:03:53PM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> Suggest to insert here:
> 
>   If additional arguments QMP-COMMAND ARG=VAL... are given, run just
>   that QMP command instead of the REPL.
> 
> Question: is this limited to simple arguments?  If no, how would I write
> an object argument?  For instance, how would I do
> 
>     { "execute": "blockdev-add", "arguments": { "node-name": "foo", "driver": "nbd", "server": { "type": "inet", "host": "localhost", "port": "12345" } } }
> 
> ?

Exactly the same way you would write it when running qmp-shell in
interactive mode.  e.g.:

  $ ./scripts/qmp/qmp-shell /tmp/qmp blockdev-add driver=qcow2 node-name=node-E 'file={"driver":"file","filename":"/path/to/file.qcow2"}'


> 
> > This is useful for testing QMP commands in scripts.
> >
> > Example usage, combined with 'jq' for filtering the results:
> >
> >   $ ./scripts/qmp/qmp-shell /tmp/qmp qom-list path=/ | jq -r .return[].name
> >   machine
> >   type
> >   chardevs
> >   backend
> 
> What's jq?

https://stedolan.github.io/jq/

"like sed for JSON data"

> 
> >   $
> 
> Let's drop this line.

Will do it.

> 
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Changes v1 -> v2:
> > * Rewritten using optparse module
> > ---
> >  scripts/qmp/qmp-shell | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> > index 4b9a420..4b7374e 100755
> > --- a/scripts/qmp/qmp-shell
> > +++ b/scripts/qmp/qmp-shell
> > @@ -400,7 +400,7 @@ def die(msg):
> >  
> >  def main():
> >      parser = optparse.OptionParser(description='QMP shell utility')
> > -    parser.set_usage("%prog [options] <UNIX socket path> | <TCP address:port>")
> > +    parser.set_usage("%prog [options] <UNIX socket path> | <TCP address:port> [COMMAND [ARG=VALUE]...]")
> >      parser.add_option('-v', action='store_true', dest='verbose',
> >          help='Verbose (echo command sent and received)')
> >      parser.add_option('-p', action='store_true', dest='pretty',
> > @@ -411,10 +411,11 @@ def main():
> >          default=True, help='Skip negotiate (for qemu-ga)')
> >      opts,args = parser.parse_args()
> >  
> > -    if len(args) != 1:
> > +    if len(args) < 1:
> >          parser.print_help(sys.stderr)
> >          sys.exit(1)
> >      addr = args[0]
> > +    cmdargs = args[1:]
> >  
> >      try:
> >          if opts.hmp:
> > @@ -433,10 +434,13 @@ def main():
> >      except qemu.error:
> >          die('Could not connect to %s' % addr)
> >  
> > -    qemu.show_banner()
> >      qemu.set_verbosity(opts.verbose)
> > -    while qemu.read_exec_command(qemu.get_prompt()):
> > -        pass
> > +    if len(cmdargs):
> 
> Superfluous len().

Will fix it in the next version.

> 
> > +        qemu.execute_cmdargs(cmdargs)
> > +    else:
> > +        qemu.show_banner()
> > +        while qemu.read_exec_command(qemu.get_prompt()):
> > +            pass
> >      qemu.close()
> >  
> >  if __name__ == '__main__':

-- 
Eduardo
