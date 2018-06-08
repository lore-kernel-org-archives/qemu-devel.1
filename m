Received: from eggs.gnu.org ([2001:4830:134:3::10]:39256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRKtT-000786-LT
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRKtP-0008Hw-Ah
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:09:43 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri,  8 Jun 2018 18:09:25 +0100
Message-Id: <20180608170933.9137-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/8] Add a standard authorization framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>

The current network services now support encryption via TLS and in some
cases support authentication via SASL. In cases where SASL is not
available, x509 client certificates can be used as a crude authorization
scheme, but using a sub-CA and controlling who you give certs to. In
general this is not very flexible though, so this series introduces a
new standard authorization framework.

It comes with four initial authorization mechanisms

 - Simple - an exact username match. This is useful when there is
   exactly one user that is known to connect. For example when live
   migrating from one QEMU to another with TLS, libvirt would use
   the simple scheme to whitelist the TLS cert of the source QEMU.

 - List - an full access control list, with optional regex matching.
   This is more flexible and is used to provide 100% backcompat with
   the existing HMP ACL commands. The caveat is that we can't create
   these via the CLI -object arg yet.

 - ListFile - the same as List, but with the rules stored in JSON
   format in an external file. This avoids the -object limitation
   while also allowing the admin to change list entries on the file.
   QEMU uses inotify to notice these changes and auto-reload the
   file contents. This is likely a good default choice for most
   network services, if the "simple" mechanism isn't sufficient.

 - PAM - delegate the username lookup to a PAM module, which opens
   the door to many options including things like SQL/LDAP lookups.

A later series that follows will integrate this framework into the VNC,
NBD, migration, and character device servers.

Daniel P. Berrang=C3=A9 (8):
  util: add helper APIs for dealing with inotify
  hw/usb: switch MTP to use new inotify APIs
  authz: add QAuthZ object as an authorization base class
  authz: add QAuthZSimple object type for trivial auth checks
  authz: add QAuthZList object type for an access control list
  authz: add QAuthZListFile object type for a file access control list
  authz: add QAuthZPAM object type for authorizing using PAM
  authz: delete existing ACL implementation

 .gitignore                     |   4 +
 MAINTAINERS                    |  14 ++
 Makefile                       |  17 +-
 Makefile.objs                  |  10 ++
 Makefile.target                |   2 +
 authz/Makefile.objs            |   7 +
 authz/base.c                   |  82 +++++++++
 authz/list.c                   | 315 +++++++++++++++++++++++++++++++++
 authz/listfile.c               | 252 ++++++++++++++++++++++++++
 authz/pam.c                    | 149 ++++++++++++++++
 authz/simple.c                 | 122 +++++++++++++
 authz/trace-events             |  18 ++
 configure                      |  36 ++++
 crypto/tlssession.c            |  35 ++--
 crypto/trace-events            |   2 +-
 hw/usb/dev-mtp.c               | 238 ++++++++++---------------
 include/authz/base.h           | 112 ++++++++++++
 include/authz/list.h           | 106 +++++++++++
 include/authz/listfile.h       | 104 +++++++++++
 include/authz/pam.h            |  84 +++++++++
 include/authz/simple.h         |  81 +++++++++
 include/qemu/acl.h             |  66 -------
 include/qemu/inotify.h         |  49 +++++
 monitor.c                      | 180 ++++++++++++-------
 qapi/authz.json                |  58 ++++++
 qapi/qapi-schema.json          |   1 +
 qom/object.c                   |  12 +-
 qom/object_interfaces.c        |  16 +-
 tests/.gitignore               |   1 +
 tests/Makefile.include         |   8 +-
 tests/test-authz-list.c        | 171 ++++++++++++++++++
 tests/test-crypto-tlssession.c |  15 +-
 tests/test-io-channel-tls.c    |  16 +-
 ui/vnc-auth-sasl.c             |  23 ++-
 ui/vnc-auth-sasl.h             |   5 +-
 ui/vnc-auth-vencrypt.c         |   2 +-
 ui/vnc-ws.c                    |   2 +-
 ui/vnc.c                       |  37 ++--
 ui/vnc.h                       |   4 +-
 util/Makefile.objs             |   2 +-
 util/acl.c                     | 179 -------------------
 util/inotify.c                 | 138 +++++++++++++++
 42 files changed, 2258 insertions(+), 517 deletions(-)
 create mode 100644 authz/Makefile.objs
 create mode 100644 authz/base.c
 create mode 100644 authz/list.c
 create mode 100644 authz/listfile.c
 create mode 100644 authz/pam.c
 create mode 100644 authz/simple.c
 create mode 100644 authz/trace-events
 create mode 100644 include/authz/base.h
 create mode 100644 include/authz/list.h
 create mode 100644 include/authz/listfile.h
 create mode 100644 include/authz/pam.h
 create mode 100644 include/authz/simple.h
 delete mode 100644 include/qemu/acl.h
 create mode 100644 include/qemu/inotify.h
 create mode 100644 qapi/authz.json
 create mode 100644 tests/test-authz-list.c
 delete mode 100644 util/acl.c
 create mode 100644 util/inotify.c

--=20
2.17.0
