Received: from eggs.gnu.org ([2001:4830:134:3::10]:48041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMQgT-0002Us-W9
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 23:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMQgQ-00051i-He
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 23:15:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dMQgQ-00050k-87
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 23:15:26 -0400
Date: Sun, 18 Jun 2017 00:15:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170618031516.GN22043@thinpad.lan.raisama.net>
References: <20170615141715.17708-1-sferdjao@redhat.com>
	<20170615141715.17708-2-sferdjao@redhat.com>
	<2bb5a8a3-37c9-3dd2-4483-c8a2fed5bb4d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bb5a8a3-37c9-3dd2-4483-c8a2fed5bb4d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu: add capability for vhost-net
 busy polling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laine Stump <laine@redhat.com>
Cc: libvir-list@redhat.com, sferdjao@redhat.com, berrange@redhat.com, Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

(CCing qemu-devel and the QAPI maintainers.  I have a question
about introspection below.)

On Sat, Jun 17, 2017 at 11:48:10AM -0400, Laine Stump wrote:
[...]
> > +    /* Support for busy polling on vhost-net devices ("-netdev
> > +     * tap,...,poll-us=n") */
> > +    if (qemuCaps->version >= 2007000)
> > +        virQEMUCapsSet(qemuCaps, QEMU_CAPS_VHOST_NET_POLL_US);
> > +
> 
> Enabling a capability based purely on the qemu binary version is
> something that's only done as a last resort if it can't be determined by
> QMP probes. This is because the version number is an inaccurate
> indicator - it often happens that a new capability is added to upstream
> in qemu version "Y", but then that feature is backported to qemu version
> "X" in some downstream distro package; if we based the capability on
> version number, then libvirt wouldn't take advantage of the feature even
> though qemu had it.
> 
> 
> What *should* get us the info we need is to add a table entry to
> virQEMUCapsCommandLine to check whether or not the poll-us option exists
> in the current qemu binary. Something like this:
> 
> static struct virQEMUCapsCommandLineProps virQEMUCapsCommandLine[] = {
>     ...
>     { "netdev", "poll-us", QEMU_CAPS_NETDEV_POLL_US },
> 
> 
> Unfortunately when I add that and regenerate the .replies file for qemu
> 2.9.0 (with the command "tests/qemucapsprobe
> /usr/bin/qemu-system-x86_64"), this is the info it finds for netdev:
> 
>     {
>       "parameters": [
>       ],
>       "option": "netdev"
>     },
> 
> My understanding was that the possible parameters to the netdev
> commandline option should be listed, but instead the parameters list is
> empty :-/.
> 
> Maybe Eduardo can help me understand why the parameters are empty, and
> (more importantly) what needs to be done to get the supported parameters
> for -netdev - basically we need to know what are the available
> parameters to "-netdev tap,...". I hope we don't end up needing to base
> the check purely on qemu version.

query-command-line-options is incomplete and useless on many
cases (including but not limited to -device, -object, and
-netdev).  It is not capable to model cases where the set of
accepted options depends on a discriminator option (e.g. a
"driver" or "type" option).

Fortunately, netdev options are modelled in the QAPI schema as
union Netdev.  However, 'query-qmp-schema' doesn't seem to
include union Netdev because it is not referenced by any QMP
command or event.

Markus, Eric, Michael: is there any way libvirt can query the
definition of union Netdev from the schema with current QEMU?

-- 
Eduardo
