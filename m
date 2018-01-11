Received: from eggs.gnu.org ([2001:4830:134:3::10]:55743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZdoy-0005wQ-EW
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:27:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZdox-0001Nx-D7
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:27:08 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <76a29a1e-7fdb-37a8-9f79-df618d385b05@virtuozzo.com>
Date: Thu, 11 Jan 2018 17:26:52 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [Qemu-devel] qcow2 autoloading bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Cc: "Denis V. Lunev" <den@openvz.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

Hi all!

I've just noted that there is an unfortunate contradiction between qcow2=20
spec and qapi.

In qcow2 we have:
1: auto
 =C2=A0The bitmap must reflect all changes of the virtual
 =C2=A0disk by any application that would write to this qcow2
 =C2=A0file (including writes, snapshot switching, etc.). The
 =C2=A0type of this bitmap must be 'dirty tracking bitmap'.


so auto means enabled bitmaps, which must track dirtiness. It's logical=20
to auto-load them
on Qemu start and make them enabled dirty bitmaps.

In Qapi we have:

# @autoload: the bitmap will be automatically loaded when the image it=20
is stored
#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in is o=
pened. This flag may only be specified for persistent
#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmaps=
. Default is false for block-dirty-bitmap-add.=20
(Since: 2.10)

so, if we consider only enabled bitmaps it is ok to direct map autoload=20
<=3D> auto.

But now we've faced into necessity of load/store disabled bitmaps.

Current behavior is definitely wrong: user sets autoload flag for=20
disabled bitmap, but on next
Qemu start the bitmap will be autoloaded and enabled.


Proposed solution:
 =C2=A0- deprecate @autoload flag for bitmap creation, ignore it
 =C2=A0- save persistent enabled bitmaps with "auto" flag
 =C2=A0- save persistent disabled bitmaps without "auto" flag
 =C2=A0- on Qemu start load all bitmaps, mapping "auto" flag state to=20
"enabled" state.


Note: we may store a lot of disabled bitmaps in qcow2 image, but loading=20
them all into RAM may be
inefficient. Actually such bitmap will be needed only on demand (for=20
export through nbd or
making some kind of backup). So in future it may be optimized by "lazy=20
load" of disabled bitmaps,
postponing their actual load up to first read or enabling. This=20
optimization doesn't need changing
of qapi or qcow2 format (at first sight).


Note2: now there is no way to disable/enable bitmaps, but there is a
 =C2=A0 [PATCH for-2.12 0/4] qmp dirty bitmap API
with big conversation, but I hope, I'll post a new version with a small=20
fix soon and it will be merged.

--=20
Best regards,
Vladimir
