Received: from eggs.gnu.org ([209.51.188.92]:37564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guh7b-0006r3-5d
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guh7Y-0007zU-U2
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:17:54 -0500
Date: Fri, 15 Feb 2019 17:17:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190215171713.GI14454@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190215171345.30280-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190215171345.30280-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/17] Add authorization support to all
 network services
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Max Reitz <mreitz@redhat.com>, libvir-list@redhat.com, qemu-block@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

mis-fire.

Ignore this one, I used the wrong base branch to git-publish and didn't
interrupt it quickly enough

Re-posted v4 with correct base.

On Fri, Feb 15, 2019 at 05:13:28PM +0000, Daniel P. Berrang=C3=A9 wrote:
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg04482.ht=
ml
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05727.ht=
ml
>   v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01639.ht=
ml
>=20
> This series builds on the core authorization framework:
>=20
>   v8: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg04253.ht=
ml
>=20
> enabling its use with the VNC, chardev, NBD and migration network serve=
rs.
>=20
> In combination with TLS x509 client certificates, this allows these
> services to whitelist specific clients, which avoids the need to setup
> restricted child certificate authorities.
>=20
> In VNC it also allows whitelisting based on SASL user names.
>=20
> Changed in v4:
>=20
>   - Update deprecation versions to 4.0
>   - Rebased to latest git
>=20
> Changed in v3:
>=20
>   - Rebased to latest git master
>=20
> Changed in v2:
>=20
>  - Document that authz objects are resolved at time of use, not
>    time of network service activation
>  - Improve docs for tls-authz parameters on services
>  - Fix 2.13 -> 3.0 version tags
>  - Remove redundant conditionals around g_strdup
>  - Fix arg syntax for qemu-nbd  s/-/--/
>  - Remove QAPI (optional) annotation
>  - Fix some outdated usage example
>=20
> Based-on: <20190215155709.15777-1-berrange@redhat.com>
>=20
> Daniel P. Berrang=C3=A9 (17):
>   util: add helper APIs for dealing with inotify in portable manner
>   qom: don't require user creatable objects to be registered
>   hw/usb: don't set IN_ISDIR for inotify watch in MTP driver
>   hw/usb: fix const-ness for string params in MTP driver
>   hw/usb: switch MTP to use new inotify APIs
>   authz: add QAuthZ object as an authorization base class
>   authz: add QAuthZSimple object type for easy whitelist auth checks
>   authz: add QAuthZList object type for an access control list
>   authz: add QAuthZListFile object type for a file access control list
>   authz: add QAuthZPAM object type for authorizing using PAM
>   authz: delete existing ACL implementation
>   qemu-nbd: add support for authorization of TLS clients
>   nbd: allow authorization with nbd-server-start QMP command
>   migration: add support for a "tls-authz" migration parameter
>   chardev: add support for authorization for TLS clients
>   vnc: allow specifying a custom authorization object name
>   monitor: deprecate acl_show, acl_reset, acl_policy, acl_add,
>     acl_remove
>=20
>  MAINTAINERS                    |  15 +
>  Makefile                       |  10 +-
>  Makefile.objs                  |  10 +-
>  Makefile.target                |   2 +
>  authz/Makefile.objs            |   7 +
>  authz/base.c                   |  82 ++++
>  authz/list.c                   | 271 +++++++++++++
>  authz/listfile.c               | 283 ++++++++++++++
>  authz/pamacct.c                | 149 +++++++
>  authz/simple.c                 | 115 ++++++
>  authz/trace-events             |  18 +
>  blockdev-nbd.c                 |  11 +-
>  chardev/char-socket.c          |  12 +-
>  chardev/char.c                 |   3 +
>  configure                      |  54 ++-
>  crypto/tlssession.c            |  35 +-
>  crypto/trace-events            |   2 +-
>  hmp.c                          |  11 +-
>  hw/usb/dev-mtp.c               | 281 ++++++--------
>  hw/usb/trace-events            |   2 +-
>  include/authz/base.h           | 112 ++++++
>  include/authz/list.h           | 106 +++++
>  include/authz/listfile.h       | 111 ++++++
>  include/authz/pamacct.h        | 100 +++++
>  include/authz/simple.h         |  84 ++++
>  include/block/nbd.h            |   4 +-
>  include/qemu/acl.h             |  66 ----
>  include/qemu/filemonitor.h     | 128 ++++++
>  migration/migration.c          |   8 +
>  migration/tls.c                |   2 +-
>  monitor.c                      | 202 +++++++---
>  nbd/server.c                   |  10 +-
>  qapi/authz.json                |  58 +++
>  qapi/block.json                |   8 +-
>  qapi/char.json                 |   6 +
>  qapi/migration.json            |  14 +-
>  qapi/qapi-schema.json          |   1 +
>  qemu-deprecated.texi           |  11 +
>  qemu-nbd.c                     |  14 +-
>  qemu-nbd.texi                  |   4 +
>  qemu-options.hx                | 149 ++++++-
>  qom/object.c                   |  12 +-
>  qom/object_interfaces.c        |  16 +-
>  tests/Makefile.include         |  16 +-
>  tests/qemu-iotests/233         |  31 +-
>  tests/qemu-iotests/233.out     |  11 +
>  tests/test-authz-list.c        | 159 ++++++++
>  tests/test-authz-listfile.c    | 195 ++++++++++
>  tests/test-authz-pam.c         | 124 ++++++
>  tests/test-authz-simple.c      |  50 +++
>  tests/test-crypto-tlssession.c |  15 +-
>  tests/test-io-channel-tls.c    |  16 +-
>  tests/test-util-filemonitor.c  | 685 +++++++++++++++++++++++++++++++++
>  ui/vnc-auth-sasl.c             |  23 +-
>  ui/vnc-auth-sasl.h             |   5 +-
>  ui/vnc-auth-vencrypt.c         |   2 +-
>  ui/vnc-ws.c                    |   2 +-
>  ui/vnc.c                       |  85 +++-
>  ui/vnc.h                       |   4 +-
>  util/Makefile.objs             |   4 +-
>  util/acl.c                     | 179 ---------
>  util/filemonitor-inotify.c     | 338 ++++++++++++++++
>  util/filemonitor-stub.c        |  59 +++
>  util/trace-events              |   9 +
>  64 files changed, 4013 insertions(+), 598 deletions(-)
>  create mode 100644 authz/Makefile.objs
>  create mode 100644 authz/base.c
>  create mode 100644 authz/list.c
>  create mode 100644 authz/listfile.c
>  create mode 100644 authz/pamacct.c
>  create mode 100644 authz/simple.c
>  create mode 100644 authz/trace-events
>  create mode 100644 include/authz/base.h
>  create mode 100644 include/authz/list.h
>  create mode 100644 include/authz/listfile.h
>  create mode 100644 include/authz/pamacct.h
>  create mode 100644 include/authz/simple.h
>  delete mode 100644 include/qemu/acl.h
>  create mode 100644 include/qemu/filemonitor.h
>  create mode 100644 qapi/authz.json
>  create mode 100644 tests/test-authz-list.c
>  create mode 100644 tests/test-authz-listfile.c
>  create mode 100644 tests/test-authz-pam.c
>  create mode 100644 tests/test-authz-simple.c
>  create mode 100644 tests/test-util-filemonitor.c
>  delete mode 100644 util/acl.c
>  create mode 100644 util/filemonitor-inotify.c
>  create mode 100644 util/filemonitor-stub.c
>=20
> --=20
> 2.20.1
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
