Received: from eggs.gnu.org ([209.51.188.92]:36851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guh4m-0004QF-RO
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guh4l-00060u-To
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:15:00 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Feb 2019 17:14:30 +0000
Message-Id: <20190215171436.30457-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/6] Add authorization support to all
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
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, libvir-list@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

  v1: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg04482.html
  v2: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05727.html
  v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01639.html

This series builds on the core authorization framework:

  v8: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg04253.html

enabling its use with the VNC, chardev, NBD and migration network servers=
.

In combination with TLS x509 client certificates, this allows these
services to whitelist specific clients, which avoids the need to setup
restricted child certificate authorities.

In VNC it also allows whitelisting based on SASL user names.

Changed in v4:

  - Update deprecation versions to 4.0
  - Rebased to latest git

Changed in v3:

  - Rebased to latest git master

Changed in v2:

 - Document that authz objects are resolved at time of use, not
   time of network service activation
 - Improve docs for tls-authz parameters on services
 - Fix 2.13 -> 3.0 version tags
 - Remove redundant conditionals around g_strdup
 - Fix arg syntax for qemu-nbd  s/-/--/
 - Remove QAPI (optional) annotation
 - Fix some outdated usage example

Based-on: <20190215155709.15777-1-berrange@redhat.com>

Daniel P. Berrang=C3=A9 (6):
  qemu-nbd: add support for authorization of TLS clients
  nbd: allow authorization with nbd-server-start QMP command
  migration: add support for a "tls-authz" migration parameter
  chardev: add support for authorization for TLS clients
  vnc: allow specifying a custom authorization object name
  monitor: deprecate acl_show, acl_reset, acl_policy, acl_add,
    acl_remove

 blockdev-nbd.c             | 11 ++++++--
 chardev/char-socket.c      | 12 +++++++-
 chardev/char.c             |  3 ++
 hmp.c                      | 11 +++++++-
 include/block/nbd.h        |  4 +--
 migration/migration.c      |  8 ++++++
 migration/tls.c            |  2 +-
 monitor.c                  | 23 +++++++++++++++
 nbd/server.c               | 10 +++----
 qapi/block.json            |  8 +++++-
 qapi/char.json             |  6 ++++
 qapi/migration.json        | 14 ++++++++-
 qemu-deprecated.texi       | 11 ++++++++
 qemu-nbd.c                 | 14 ++++++++-
 qemu-nbd.texi              |  4 +++
 qemu-options.hx            | 44 +++++++++++++++++++++--------
 tests/qemu-iotests/233     | 31 ++++++++++++++++++--
 tests/qemu-iotests/233.out | 11 ++++++++
 ui/vnc.c                   | 58 ++++++++++++++++++++++++++++++++------
 19 files changed, 245 insertions(+), 40 deletions(-)

--=20
2.20.1
