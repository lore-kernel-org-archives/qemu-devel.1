Received: from eggs.gnu.org ([2001:4830:134:3::10]:52001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cnOzP-0008ED-0n
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cnOzM-0006hi-Qv
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:22:15 -0400
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:34860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cnOzM-0006gZ-AQ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:22:12 -0400
Received: by mail-lf0-x22e.google.com with SMTP id j90so62814965lfk.2
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 05:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<CAJ+F1CKiE2FHjS0_K2F+yS-ByZMtVVFh6+NLm_q4_myeg=_KdQ@mail.gmail.com>
	<87lgs974rd.fsf@dusky.pond.sub.org>
In-Reply-To: <87lgs974rd.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 13 Mar 2017 12:21:59 +0000
Message-ID: <CAJ+F1CL_iQNVN5a=rZ93bWnnG89710aBkN7iT_eiqNtwJRk=7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 00/47] qapi: Put type information
 back into QMP documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Hi

On Mon, Mar 13, 2017 at 4:14 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > Hi
> >
> > On Mon, Mar 13, 2017 at 10:23 AM Markus Armbruster <armbru@redhat.com>
> > wrote:
> >
> >> I'm proposing this is 2.9 because it fixes a documentation regression.
> >> It affects only documentation; generated C code is unchanged except
> >> for the removal of trailing space in PATCH 46.
> >>
> >> Based on my qapi-next branch, which contains Marc-Andr=C3=A9's PATCH 1=
/2.
> >>
> >> Marc-Andr=C3=A9's work to merge qmp-commands.txt and qmp-events.txt in=
to
> >> the QAPI schema and generate their replacements from the schema
> >> (commit b6af8ea..56e8bdd) was a big step forward.  As committed, it
> >> also was a step back: the documentation lost information on JSON
> >> types, because I didn't like Marc-Andr=C3=A9's patch to add it.  He
> >> reposted it for further review afterwards:
> >>
> >>     Subject: [PATCH 0/2] qapi2texi: add type information
> >>     Message-Id: <20170125130308.16104-1-marcandre.lureau@redhat.com>
> >>     https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05432.htm=
l
> >>
> >> His PATCH 1/2 is a straightforward cleanup.  His PATCH 2/2 adds type
> >> descriptions in a new formal language to the generated documentation.
> >> Quoting the commit message:
> >>
> >>     Array types have the following syntax: type[]. Ex: str[].
> >>
> >>     - Struct, commands and events use the following members syntax:
> >>
> >>       { 'member': type, ('foo': str), ... }
> >>
> >>     Optional members are under parentheses.
> >>
> >>     A structure with a base type will have 'BaseStruct +' prepended.
> >>
> >>     - Alternates use the following syntax:
> >>
> >>       [ 'foo': type, 'bar': type, ... ]
> >>
> >>     - Simple unions use the following syntax:
> >>
> >>       { 'type': str, 'data': 'type' =3D [ 'foo': type, 'bar': type... =
] }
> >>
> >>     - Flat unions use the following syntax:
> >>
> >>       BaseStruct + 'discriminator' =3D [ 'foo': type, 'bar': type... ]
> >>
> >> End quote.  Looks like this in generated documentation:
> >>
> >>  -- Event: VNC_CONNECTED {'server': VncServerInfo, 'client':
> >>           VncBasicInfo}
> >>
> >>      Emitted when a VNC client establishes a connection
> >>      ''server''
> >>           server information
> >>      ''client''
> >>           client information
> >>
> >>      Note: This event is emitted before any authentication takes place=
,
> >>      thus the authentication ID is not provided
> >> [...]
> >>
> >>  -- Struct: VncServerInfo VncBasicInfo + {('auth': str)}
> >>
> >>      The network connection information for server
> >>      ''auth'' (optional)
> >>           authentication method used for the plain (non-websocket) VNC
> >>           server
> >>
> >>      Since: 2.1
> >>
> >>  -- Simple Union: SocketAddress { 'type': str, 'data': 'type' =3D ['in=
et':
> >>           InetSocketAddress, 'unix': UnixSocketAddress, 'vsock':
> >>           VsockSocketAddress, 'fd': String] }
> >>
> >>      Captures the address of a socket, which could also be a named fil=
e
> >>      descriptor
> >>
> >>      Since: 1.3
> >>
> >> Here's my counter-proposal: instead of inventing a formal language,
> >> fix the natural language documentation to actually mention *all*
> >> members, and add type information in a plain, easy-to-understand way.
> >> Looks like this:
> >>
> >>  -- Event: VNC_CONNECTED
> >>
> >>      Emitted when a VNC client establishes a connection
> >>
> >>      Arguments:
> >>      'server: VncServerInfo'
> >>           server information
> >>      'client: VncBasicInfo'
> >>           client information
> >>
> >>      Note: This event is emitted before any authentication takes place=
,
> >>      thus the authentication ID is not provided
> >> [...]
> >>
> >>  -- Object: VncServerInfo
> >>
> >>      The network connection information for server
> >>
> >>      Members:
> >>      'auth: string' (optional)
> >>           authentication method used for the plain (non-websocket) VNC
> >>           server
> >>      The members of 'VncBasicInfo'
> >>
> >>      Since: 2.1
> >>
> >>  -- Object: SocketAddress
> >>
> >>      Captures the address of a socket, which could also be a named fil=
e
> >>      descriptor
> >>
> >>      Members:
> >>      'type'
> >>           One of "inet", "unix", "vsock", "fd"
> >>      'data: InetSocketAddress' when 'type' is "inet"
> >>      'data: UnixSocketAddress' when 'type' is "unix"
> >>      'data: VsockSocketAddress' when 'type' is "vsock"
> >>      'data: String' when 'type' is "fd"
> >>
> >>      Since: 1.3
> >>
> >>
> > I like both, to me they serve different purposes. I like to have a shor=
t
> > overview / signature and then a more detailed documentation for each
> field.
>
> I sympathize with the argument.  Unfortunately, the "short" signatures
> are anything but for real-world QAPI:
>

That's a worse case, a regular case is more readable. And it is still
useful anyway since the common members would be listed first.


>  -- Flat Union: BlockdevOptions {'driver': BlockdevDriver, ('node-name':
>           str), ('discard': BlockdevDiscardOptions), ('cache':
>           BlockdevCacheOptions), ('read-only': bool), ('detect-zeroes':
>           BlockdevDetectZeroesOptions)} + 'driver' =3D ['archipelago':
>           BlockdevOptionsArchipelago, 'blkdebug':
>           BlockdevOptionsBlkdebug, 'blkverify':
>           BlockdevOptionsBlkverify, 'bochs':
>           BlockdevOptionsGenericFormat, 'cloop':
>           BlockdevOptionsGenericFormat, 'dmg':
>           BlockdevOptionsGenericFormat, 'file': BlockdevOptionsFile,
>           'ftp': BlockdevOptionsCurl, 'ftps': BlockdevOptionsCurl,
>           'gluster': BlockdevOptionsGluster, 'host_cdrom':
>           BlockdevOptionsFile, 'host_device': BlockdevOptionsFile,
>           'http': BlockdevOptionsCurl, 'https': BlockdevOptionsCurl,
>           'iscsi': BlockdevOptionsIscsi, 'luks': BlockdevOptionsLUKS,
>           'nbd': BlockdevOptionsNbd, 'nfs': BlockdevOptionsNfs,
>           'null-aio': BlockdevOptionsNull, 'null-co':
>           BlockdevOptionsNull, 'parallels':
>           BlockdevOptionsGenericFormat, 'qcow2': BlockdevOptionsQcow2,
>           'qcow': BlockdevOptionsGenericCOWFormat, 'qed':
>           BlockdevOptionsGenericCOWFormat, 'quorum':
>           BlockdevOptionsQuorum, 'raw': BlockdevOptionsRaw, 'rbd':
>           BlockdevOptionsRbd, 'replication': BlockdevOptionsReplication,
>           'sheepdog': BlockdevOptionsSheepdog, 'ssh':
>           BlockdevOptionsSsh, 'vdi': BlockdevOptionsGenericFormat,
>           'vhdx': BlockdevOptionsGenericFormat, 'vmdk':
>           BlockdevOptionsGenericCOWFormat, 'vpc':
>           BlockdevOptionsGenericFormat, 'vvfat': BlockdevOptionsVVFAT]
>
>      Options for creating a block device.  Many options are available
>      for all block devices, independent of the block driver:
>      ''driver''
>           block driver name
>      ''node-name'' (optional)
>           the node name of the new node (Since 2.0).  This option is
>           required on the top level of blockdev-add.
>      ''discard'' (optional)
>           discard-related options (default: ignore)
>      ''cache'' (optional)
>           cache-related options
>      ''read-only'' (optional)
>           whether the block device should be read-only (default: false)
>      ''detect-zeroes'' (optional)
>           detect and optimize zero writes (Since 2.1) (default: off)
>      Remaining options are determined by the block driver.
>
>      Since: 1.7
>
> >> Additionally, my series fixes a number of bugs and cleans up along the
> >> way.  In particular, it converts qapi2texi.py from parse trees to the
> >> visitor interface the other generators use.
> >>
> >>
> > Your series failed to apply in patchew, and I can't find the branch in
> your
> > repo. Could you publish it?
>
> Done: branch qapi-doc at http://repo.or.cz/w/qemu/armbru.git
>
>
thanks


> >> Future generated documentation work includes eliding types that aren't
> >> visible in QMP (like introspection does), and making uses of type
> >> names links in HTML.
> >>
> >>
> > Yes, links would be really nice.
>
> Your work brought them into reach, let's grab them :)
>
--=20
Marc-Andr=C3=A9 Lureau
