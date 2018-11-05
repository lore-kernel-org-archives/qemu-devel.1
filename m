Received: from eggs.gnu.org ([2001:4830:134:3::10]:47789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJbiL-0001EI-Ho
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJbi3-00028K-EC
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:02:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gJbi1-0000ct-8m
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:02:15 -0500
References: <20181101021226.6353-1-zhangckid@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f1b5db6b-bd49-6b51-2bfa-be8c8d218cde@redhat.com>
Date: Mon, 5 Nov 2018 11:02:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181101021226.6353-1-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2] migration/colo.c: Fix compilation issue
 when disable replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>

On 2018-11-01 03:12, Zhang Chen wrote:
> This compilation issue will occur when user use --disable-replication
> to config Qemu.
>=20
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  migration/colo.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)

Thanks, this fixes the compilation problem with --disable-replication
for me:

Tested-by: Thomas Huth <thuth@redhat.com>

BTW, if colo can't be used without CONFIG_REPLICATION, would it make
sense to disable the related objects (for the "--object" parameter) in
an additional patch, too? Something like this (untested):

diff --git a/net/Makefile.objs b/net/Makefile.objs
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -10,7 +10,7 @@ common-obj-$(CONFIG_NETMAP) +=3D netmap.o
 common-obj-y +=3D filter.o
 common-obj-y +=3D filter-buffer.o
 common-obj-y +=3D filter-mirror.o
-common-obj-y +=3D colo-compare.o
+common-obj-$(CONFIG_REPLICATION) +=3D colo-compare.o
 common-obj-y +=3D colo.o
 common-obj-y +=3D filter-rewriter.o
 common-obj-y +=3D filter-replay.o

  Thomas
