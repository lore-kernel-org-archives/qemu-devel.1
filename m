Received: from eggs.gnu.org ([2001:4830:134:3::10]:48880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSjR9-0004oA-GX
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:06:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSjR6-0005Gl-A9
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:06:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSjR6-0005GF-0x
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:06:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0688AC058CAB
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 14:06:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 30 Nov 2018 14:06:04 +0000
Message-Id: <20181130140615.19937-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 00/11] Add a standard authorization framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

An update to

 v2: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg04469.html
 v3: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05660.html
 v4: https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg02961.html
 v5: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01613.html
 v6: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg04435.html

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

Changed in v6:

 - Change file monitor object to allow multiple instances
   instead of being a singleton
 - Use stubs when inotify is not available
 - Use GArray for managing watches
 - Report errno when failing to read from inotify
 - Check for closed inotify FD before reading
 - Monitor file attribute changes to detect chmod/chown/etc
 - Unregister event loop FD handler when watches are removed
 - Fix mutex unlock call when removing watches
 - Remove file monitor watch when free'ing MTP object
 - Rename MTP watchfd field to watchid
 - Free file monitor when deleting MTP device
 - Use error_report instead of fprintf for MTP errors
 - Use GPattern instead of fnmatch
 - Use enum _str() helper functions
 - Add unit/functional test for inotify file monitor
 - Add unit test for simple authz impl
 - Add unit test for list file authz impl
 - Add unit test for PAM authz impl

Changed in v6:

 - Fix consistency of object variable names
 - Fix command line example quoting
 - Use 'false' not '0' for bool return values
 - Remove empty 'complete' methods
 - Fix leak of rules in finalizer
 - Fix missing {} around conditional
 - Refactor rule refresh to use goto & invert conditional

Changed in v5:

 - Rebase to latest git master

Changed in v4:

 - Rebase to latest git master

Changed in v3:

 - Added docs for object types in qemu-options.hx
 - Added example CLI syntax in header files
 - Improved commit messages

Changed in v2:

 - Switch to a global shared instance of the file monitor so only
   a single inotify file descriptor is required

 - Require all watches to be registered against directories. File
   watches are useless in Linux, since they are tied to inodes, and
   so stop working when editors save by doing a tmpfile + rename
   dance.

 - Change auth list impl to use a directory based watch instead
   of filename

 - Put MTP const-ness fixes in separate patch

 - Split QOM change off into separate patch

 - Fix conditionals on Win32 build

Daniel P. Berrang=C3=A9 (11):
  util: add helper APIs for dealing with inotify in portable manner
  qom: don't require user creatable objects to be registered
  hw/usb: don't set IN_ISDIR for inotify watch in MTP driver
  hw/usb: fix const-ness for string params in MTP driver
  hw/usb: switch MTP to use new inotify APIs
  authz: add QAuthZ object as an authorization base class
  authz: add QAuthZSimple object type for easy whitelist auth checks
  authz: add QAuthZList object type for an access control list
  authz: add QAuthZListFile object type for a file access control list
  authz: add QAuthZPAM object type for authorizing using PAM
  authz: delete existing ACL implementation

 .gitignore                     |   4 +
 MAINTAINERS                    |  15 +
 Makefile                       |  17 +-
 Makefile.objs                  |  12 +-
 Makefile.target                |   2 +
 authz/Makefile.objs            |   7 +
 authz/base.c                   |  82 ++++
 authz/list.c                   | 285 ++++++++++++++
 authz/listfile.c               | 283 ++++++++++++++
 authz/pamacct.c                | 149 +++++++
 authz/simple.c                 | 115 ++++++
 authz/trace-events             |  18 +
 configure                      |  37 ++
 crypto/tlssession.c            |  35 +-
 crypto/trace-events            |   2 +-
 hw/usb/dev-mtp.c               | 278 ++++++-------
 hw/usb/trace-events            |   2 +-
 include/authz/base.h           | 112 ++++++
 include/authz/list.h           | 106 +++++
 include/authz/listfile.h       | 111 ++++++
 include/authz/pamacct.h        | 100 +++++
 include/authz/simple.h         |  84 ++++
 include/qemu/acl.h             |  66 ----
 include/qemu/filemonitor.h     | 128 ++++++
 monitor.c                      | 185 ++++++---
 qapi/authz.json                |  58 +++
 qapi/qapi-schema.json          |   1 +
 qemu-options.hx                | 105 +++++
 qom/object.c                   |  12 +-
 qom/object_interfaces.c        |  16 +-
 tests/Makefile.include         |  16 +-
 tests/test-authz-list.c        | 159 ++++++++
 tests/test-authz-listfile.c    | 195 ++++++++++
 tests/test-authz-pam.c         | 124 ++++++
 tests/test-authz-simple.c      |  50 +++
 tests/test-crypto-tlssession.c |  15 +-
 tests/test-io-channel-tls.c    |  16 +-
 tests/test-util-filemonitor.c  | 685 +++++++++++++++++++++++++++++++++
 ui/vnc-auth-sasl.c             |  23 +-
 ui/vnc-auth-sasl.h             |   5 +-
 ui/vnc-auth-vencrypt.c         |   2 +-
 ui/vnc-ws.c                    |   2 +-
 ui/vnc.c                       |  37 +-
 ui/vnc.h                       |   4 +-
 util/Makefile.objs             |   4 +-
 util/acl.c                     | 179 ---------
 util/filemonitor-inotify.c     | 338 ++++++++++++++++
 util/filemonitor-stub.c        |  59 +++
 util/trace-events              |   9 +
 49 files changed, 3803 insertions(+), 546 deletions(-)
 create mode 100644 authz/Makefile.objs
 create mode 100644 authz/base.c
 create mode 100644 authz/list.c
 create mode 100644 authz/listfile.c
 create mode 100644 authz/pamacct.c
 create mode 100644 authz/simple.c
 create mode 100644 authz/trace-events
 create mode 100644 include/authz/base.h
 create mode 100644 include/authz/list.h
 create mode 100644 include/authz/listfile.h
 create mode 100644 include/authz/pamacct.h
 create mode 100644 include/authz/simple.h
 delete mode 100644 include/qemu/acl.h
 create mode 100644 include/qemu/filemonitor.h
 create mode 100644 qapi/authz.json
 create mode 100644 tests/test-authz-list.c
 create mode 100644 tests/test-authz-listfile.c
 create mode 100644 tests/test-authz-pam.c
 create mode 100644 tests/test-authz-simple.c
 create mode 100644 tests/test-util-filemonitor.c
 delete mode 100644 util/acl.c
 create mode 100644 util/filemonitor-inotify.c
 create mode 100644 util/filemonitor-stub.c

--=20
2.19.2
