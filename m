Received: from eggs.gnu.org ([2001:4830:134:3::10]:57382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f7zxC-0003Ty-TP
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f7zxA-0000Mn-82
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:57:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59058 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f7zxA-0000M5-2L
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:57:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B991D4068045
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 08:57:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180413161842.5117-1-marcandre.lureau@redhat.com>
	<20180413161842.5117-4-marcandre.lureau@redhat.com>
Date: Mon, 16 Apr 2018 10:57:19 +0200
In-Reply-To: <20180413161842.5117-4-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 13 Apr 2018 18:18:41 +0200")
Message-ID: <878t9nsf4g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 3/4] qobject: replace
 qobject_incref/QINCREF qobject_decref/QDECREF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Now that we can safely call QOBJECT() on QObject * and children types,
> we can have a single macro to ref/unref the object.
>
> Change the incref/decref prefix name for the more common ref/unref.
>
> Note that before the patch, "QDECREF(obj)" was problematic because it
> would expand to "obj ? obj : ...", which could evaluate "obj" multiple
> times.

Problematic just in theory, or have you seen problematic uses?

Perhaps what you want to say is that spelling your new macros lower case
is okay, because they evaluate their argument just like a function.

Suggest

  Now that we can safely call QOBJECT() on QObject * as well as its
  subtypes, we can have macros qobject_ref() / qobject_unref() that work
  everywhere instead of having to use QINCREF() / QDECREF() for QObject
  and qobject_incref() / qobject_decref() for its subtypes.

  Note that the new macros evalcuate their argument exactly once, thus
  no need to shout them.

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/events.py              |   2 +-
>  include/qapi/qmp/qnull.h            |   2 +-
>  include/qapi/qmp/qobject.h          |  36 +++++-----
>  block.c                             |  78 +++++++++++-----------
>  block/blkdebug.c                    |   4 +-
>  block/blkverify.c                   |   4 +-
>  block/crypto.c                      |   4 +-
>  block/gluster.c                     |   4 +-
>  block/iscsi.c                       |   2 +-
>  block/nbd.c                         |   4 +-
>  block/nfs.c                         |   4 +-
>  block/null.c                        |   2 +-
>  block/nvme.c                        |   2 +-
>  block/parallels.c                   |   4 +-
>  block/qapi.c                        |   2 +-
>  block/qcow.c                        |   8 +--
>  block/qcow2.c                       |   8 +--
>  block/qed.c                         |   4 +-
>  block/quorum.c                      |   2 +-
>  block/rbd.c                         |  14 ++--
>  block/sheepdog.c                    |  12 ++--
>  block/snapshot.c                    |   4 +-
>  block/ssh.c                         |   4 +-
>  block/vdi.c                         |   2 +-
>  block/vhdx.c                        |   4 +-
>  block/vpc.c                         |   4 +-
>  block/vvfat.c                       |   2 +-
>  block/vxhs.c                        |   2 +-
>  blockdev.c                          |  16 ++---
>  hw/i386/acpi-build.c                |  12 ++--
>  hw/ppc/spapr_drc.c                  |   2 +-
>  hw/usb/xen-usb.c                    |   4 +-
>  migration/migration.c               |   4 +-
>  migration/qjson.c                   |   2 +-
>  monitor.c                           |  50 +++++++-------
>  qapi/qapi-dealloc-visitor.c         |   4 +-
>  qapi/qmp-dispatch.c                 |   6 +-
>  qapi/qobject-input-visitor.c        |   8 +--
>  qapi/qobject-output-visitor.c       |   8 +--
>  qemu-img.c                          |  18 ++---
>  qemu-io.c                           |   6 +-
>  qga/main.c                          |  12 ++--
>  qmp.c                               |   4 +-
>  qobject/json-parser.c               |  10 +--
>  qobject/qdict.c                     |  38 +++++------
>  qobject/qjson.c                     |   2 +-
>  qobject/qlist.c                     |   4 +-
>  qom/object.c                        |  16 ++---
>  qom/object_interfaces.c             |   2 +-
>  target/ppc/translate_init.c         |   2 +-
>  target/s390x/cpu_models.c           |   2 +-
>  tests/ahci-test.c                   |   6 +-
>  tests/check-qdict.c                 | 100 ++++++++++++++--------------
>  tests/check-qjson.c                 |  84 +++++++++++------------
>  tests/check-qlist.c                 |   8 +--
>  tests/check-qlit.c                  |  10 +--
>  tests/check-qnull.c                 |  10 +--
>  tests/check-qnum.c                  |  28 ++++----
>  tests/check-qobject.c               |   2 +-
>  tests/check-qstring.c               |  10 +--
>  tests/cpu-plug-test.c               |   4 +-
>  tests/device-introspect-test.c      |  24 +++----
>  tests/drive_del-test.c              |   4 +-
>  tests/libqos/libqos.c               |   8 +--
>  tests/libqos/pci-pc.c               |   2 +-
>  tests/libqtest.c                    |  24 +++----
>  tests/machine-none-test.c           |   2 +-
>  tests/migration-test.c              |  24 +++----
>  tests/numa-test.c                   |  16 ++---
>  tests/pvpanic-test.c                |   2 +-
>  tests/q35-test.c                    |   2 +-
>  tests/qmp-test.c                    |  38 +++++------
>  tests/qom-test.c                    |   8 +--
>  tests/tco-test.c                    |  12 ++--
>  tests/test-char.c                   |   2 +-
>  tests/test-keyval.c                 |  82 +++++++++++------------
>  tests/test-netfilter.c              |  26 ++++----
>  tests/test-qemu-opts.c              |  14 ++--
>  tests/test-qga.c                    |  76 ++++++++++-----------
>  tests/test-qmp-cmds.c               |  24 +++----
>  tests/test-qmp-event.c              |   2 +-
>  tests/test-qobject-input-visitor.c  |  10 +--
>  tests/test-qobject-output-visitor.c |  18 ++---
>  tests/test-visitor-serialization.c  |   6 +-
>  tests/test-x86-cpuid-compat.c       |  14 ++--
>  tests/tmp105-test.c                 |   4 +-
>  tests/vhost-user-test.c             |   6 +-
>  tests/virtio-net-test.c             |   6 +-
>  tests/vmgenid-test.c                |   2 +-
>  tests/wdt_ib700-test.c              |  14 ++--
>  util/keyval.c                       |  12 ++--
>  util/qemu-config.c                  |   4 +-
>  docs/devel/qapi-code-gen.txt        |   2 +-
>  scripts/coccinelle/qobject.cocci    |   8 +--
>  94 files changed, 606 insertions(+), 610 deletions(-)

It's a lot of churn.  I'm willing to accept the one-time pain because
the result is easier on the eyes.

> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
> index 3dc523cf39..4426861ff1 100644
> --- a/scripts/qapi/events.py
> +++ b/scripts/qapi/events.py
> @@ -142,7 +142,7 @@ out:
>  ''')
>      ret +=3D mcgen('''
>      error_propagate(errp, err);
> -    QDECREF(qmp);
> +    qobject_unref(qmp);
>  }
>  ''')
>      return ret
> diff --git a/include/qapi/qmp/qnull.h b/include/qapi/qmp/qnull.h
> index e8ea2c315a..75b29c6a39 100644
> --- a/include/qapi/qmp/qnull.h
> +++ b/include/qapi/qmp/qnull.h
> @@ -23,7 +23,7 @@ extern QNull qnull_;
>=20=20
>  static inline QNull *qnull(void)
>  {
> -    QINCREF(&qnull_);
> +    qobject_ref(&qnull_);
>      return &qnull_;
>  }
>=20=20
> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
> index 7e6fed242e..fce4a1cd75 100644
> --- a/include/qapi/qmp/qobject.h
> +++ b/include/qapi/qmp/qobject.h
> @@ -16,16 +16,16 @@
>   *
>   *  - Returning references: A function that returns an object may
>   *  return it as either a weak or a strong reference.  If the reference
> - *  is strong, you are responsible for calling QDECREF() on the reference
> + *  is strong, you are responsible for calling qobject_unref() on the re=
ference

Long line.

>   *  when you are done.
>   *
>   *  If the reference is weak, the owner of the reference may free it at
>   *  any time in the future.  Before storing the reference anywhere, you
> - *  should call QINCREF() to make the reference strong.
> + *  should call qobject_ref() to make the reference strong.
>   *
>   *  - Transferring ownership: when you transfer ownership of a reference
>   *  by calling a function, you are no longer responsible for calling
> - *  QDECREF() when the reference is no longer needed.  In other words,
> + *  qobject_unref() when the reference is no longer needed.  In other wo=
rds,
>   *  when the function returns you must behave as if the reference to the
>   *  passed object was weak.
>   */
[...]
