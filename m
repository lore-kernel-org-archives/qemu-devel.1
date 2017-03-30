Received: from eggs.gnu.org ([2001:4830:134:3::10]:48553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ctc0o-0006jz-Eg
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ctc0n-00027k-27
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:29:22 -0400
Date: Thu, 30 Mar 2017 17:29:13 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170330152913.orppqht62xrl2rmw@eukaryote>
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490879707-6060-1-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC v2 for-2.9 00/10] Fixes and
 cleanups around SocketAddress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, mreitz@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

On Thu, Mar 30, 2017 at 03:14:57PM +0200, Markus Armbruster wrote:
> What makes this 2.9 material is the crash bug fixed in PATCH 2 and the
> QAPI/QMP interface cleanups in PATCH 7+8.
> 
> This is RFC because:
> 
> 1. To give you one more chance to ask for undocumented -drive
>    driver=nbd usage compatibility [PATCH 08+09].
> 
> 2. Another round of sheepdog tests is still in progress (with
>    Kashyap's help).
> 
> Max, please have a close look at PATCH 11, I hope this is what you
> meant when you asked for "parsing @server".
> 
> v2:
> * PATCH 01+02+04+05 unchanged.
> * PATCH 03 error message improved, blank line [Max]
> * PATCH 06 commit message typo [Max]
> * PATCH 07 new, factored out of old PATCH 7
> * PATCH 08-10 updated, please re-review
> 
> Markus Armbruster (10):
>   nbd sockets vnc: Mark problematic address family tests TODO
>   char: Fix socket with "type": "vsock" address
>   io vnc sockets: Clean up SocketAddressKind switches
>   block: Document -drive problematic code and bugs
>   gluster: Prepare for SocketAddressFlat extension
>   qapi-schema: SocketAddressFlat variants 'vsock' and 'fd'
>   sockets: New helper socket_address_crumple()
>   nbd: Tidy up blockdev-add interface
>   squash! nbd: Tidy up blockdev-add interface
>   sheepdog: Fix blockdev-add

FWIW:

Tested-by: Kashyap Chamarthy <kchamart@redhat.com>

Details:

Env
~~~

I prepared a two-node Sheepdog cluster with Corosync.  Setup info:

	https://kashyapc.fedorapeople.org/virt/sheepdog-qemu-corosync.txt

And used Markus' branch 'blockdev-fixes-debug':

    http://repo.or.cz/qemu/armbru.git/tree/refs/heads/blockdev-fixes-dbg

    $ git describe
    pull-misc-2017-03-28-27-g885750d
    
    $ ./qemu-system-x86_64 -version
    QEMU emulator version 2.8.92 (v2.9.0-rc1-110-g885750d)
    Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

Tests
~~~~~

There are four of them (thanks Markus):

[OK] Test-1: Syntax: sheepdog:hostname:port:Alice
[OK] Test-2: Syntax: sheepdog://hostname:port/Alice
[OK] Test-3: Syntax: -drive if=none,driver=sheepdog,server.type=inet,server.host=hostname,server.port=port,vdi=Alice
[OK] Test-4: Syntax: -blockdev node-name=nn,driver=sheepdog,server.type=inet,server.host=host,server.port=port,vdi=Alice

Complete test invocation 
~~~~~~~~~~~~~~~~~~~~~~~~

Test-1: Syntax: sheepdog:hostname:port:Alice
-----------------------------------------------------------------------
$ ./qemu-system-x86_64 -display none -nodefconfig -nodefaults sheepdog:192.168.122.84:7000:Alice
@@@ server.host=192.168.122.84
@@@ server.port=7000
@@@ tag=
@@@ server.type=inet
@@@ vdi=Alice
### vdi=Alice addr=192.168.122.84:7000 snap-id=(null) tag=
WARNING: Image format was not specified for 'json:{"server.host": "192.168.122.84", "server.port": "7000", "tag": "", "driver": "sheepdog", "server.type": "inet", "vdi": "Alice"}' and probing guessed raw.
         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
-----------------------------------------------------------------------

Test-2: Syntax: sheepdog://hostname:port/Alice
-----------------------------------------------------------------------
$ ./qemu-system-x86_64 -display none -nodefconfig -nodefaults sheepdog://192.168.122.84:7000/Alice
@@@ server.host=192.168.122.84
@@@ server.port=7000
@@@ tag=
@@@ server.type=inet
@@@ vdi=Alice
### vdi=Alice addr=192.168.122.84:7000 snap-id=(null) tag=
WARNING: Image format was not specified for 'json:{"server.host": "192.168.122.84", "server.port": "7000", "tag": "", "driver": "sheepdog", "server.type": "inet", "vdi": "Alice"}' and probing guessed raw.
         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
-----------------------------------------------------------------------

Test-3: Syntax: -drive \
if=none,driver=sheepdog,server.type=inet,server.host=hostname,server.port=port,vdi=Alice
-----------------------------------------------------------------------
$ ./qemu-system-x86_64 -display none -nodefconfig -nodefaults -drive if=none,driver=sheepdog,server.type=inet,server.host=192.168.122.84,server.port=7000,vdi=Alice
@@@ server.host=192.168.122.84
@@@ server.port=7000
@@@ server.type=inet
@@@ vdi=Alice
### vdi=Alice addr=192.168.122.84:7000 snap-id=(null) tag=
-----------------------------------------------------------------------

Test-4: Syntax: -blockdev \
node-name=nn,driver=sheepdog,server.type=inet,server.host=host,server.port=port,vdi=Alice
-----------------------------------------------------------------------
$ ./qemu-system-x86_64 -display none -nodefconfig -nodefaults -blockdev node-name=nn,driver=sheepdog,server.type=inet,server.host=192.168.122.84,server.port=7000,vdi=Alice
@@@ server.port=7000
@@@ server.host=192.168.122.84
@@@ server.type=inet
@@@ vdi=Alice
### vdi=Alice addr=192.168.122.84:7000 snap-id=(null) tag=
-----------------------------------------------------------------------


-- 
/kashyap
