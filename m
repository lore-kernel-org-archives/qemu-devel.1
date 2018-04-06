Received: from eggs.gnu.org ([2001:4830:134:3::10]:41995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f4MMA-0008MV-D0
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 04:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f4MM9-0005kI-5o
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 04:04:22 -0400
Date: Fri, 6 Apr 2018 10:04:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180406080406.GA4850@localhost.localdomain>
References: <20180405170619.20480-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405170619.20480-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC][BROKEN] rbd: Allow configuration of
 authentication scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, jdurgin@redhat.com, jcody@redhat.com, eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Am 05.04.2018 um 19:06 hat Kevin Wolf geschrieben:
> The legacy command line syntax supports a "password-secret" option that
> allows to pass an authentication key to Ceph. This was not supported in
> QMP so far.
> 
> This patch introduces authentication options in the QAPI schema, makes
> them do the corresponding rados_conf_set() calls and adds compatibility
> code that translates the old "password-secret" option both for opening
> and creating images to the new set of options.
> 
> Note that the old option didn't allow to explicitly specify the set of
> allowed authentication schemes. The compatibility code assumes that if
> "password-secret" is given, only the cephx scheme is allowed. If it's
> missing, both none and cephx are allowed because the configuration file
> could still provide a key.

There is another problem here that suggests that maybe this is not the
right QAPI schema after all: The defaults needed for command line
compatibility and those promised in the QAPI schema are conflicting.

The required command line behaviour is as described above:

* password-secret given: only cephx
* no options given: cephx, none

The desired QMP default behaviour is:

* auth-cephx given: allow cephx
* auth-none given: allow none
* both given: allow both
* no options given: error

In .bdrv_open() there is no way to distinguish the "no options given" of
the command line from that of QMP. The current implementation allows
everything if no options are given, i.e. it keeps existing command lines
working, but it doesn't correctly implement the behaviour described in
the QAPI schema.

I don't think changing the description of the QAPI schema would be a
good idea, it would be a rather surprising interface.

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
> 
> This doesn't actually work correctly yet because the way that options
> are passed through the block layer (QAPI -> QemuOpts -> QDict). Before
> we fix or hack around this, let's make sure this is the schema that we
> want.
> 
> The two known problems are:
> 
> 1. QDict *options in qemu_rbd_open() may contain options either in their
>    proper QObject types (if passed from blockdev-add) or as strings
>    (-drive). Both forms can be mixed in the same options QDict.
> 
>    rbd uses the keyval visitor to convert the options into a QAPI
>    object. This means that it requires all options to be strings. This
>    patch, however, introduces a bool property, so the visitor breaks
>    when it gets its input from blockdev-add.
> 
>    Options to hack around the problem:
> 
>    a. Do an extra conversion step or two and go through QemuOpts like
>       some other block drivers. When I offered something like this to
>       Markus a while ago in a similar case, he rejected the idea.
> 
>    b. Introduce a qdict_stringify_entries() that just does what its name
>       says. It would be called before the running keyval visitor so that
>       only strings will be present in the QDict.
> 
>    c. Do a local one-off hack that checks if the entry with the key
>       "auth-none" is a QBool, and if so, overwrite it with a string. The
>       problem will reappear with the next non-string option.
> 
>    (d. Get rid of the QDict detour and work only with QAPI objects
>        everywhere. Support rbd authentication only in QEMU 4.0.)
> 
> 2. The proposed schema allows 'auth-cephx': {} as a valid option with
>    the meaning that the cephx authentication scheme is enabled, but no
>    key is given (e.g. it is taken from the config file).
> 
>    However, an empty dict cannot currently be represented by flattened
>    QDicts. We need to find a way to enable this. I think this will be
>    externally visible because it directly translates into the dotted
>    syntax of -blockdev, so we may want to be careful.
> 
> Any thoughts on the proposed QAPI schema or the two implementation
> problems are welcome.

Kevin
