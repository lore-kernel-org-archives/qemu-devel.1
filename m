Received: from eggs.gnu.org ([2001:4830:134:3::10]:60750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eo5Uo-00013m-Cg
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:50:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eo5Ul-0000un-A1
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:50:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eo5Ul-0000pq-01
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:49:59 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1KAmuGW049571
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 05:49:51 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g8j3kgd7n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 05:49:51 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 20 Feb 2018 10:49:48 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 20 Feb 2018 11:49:42 +0100
In-Reply-To: <20180220104942.14531-1-groug@kaod.org>
References: <20180220104942.14531-1-groug@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180220104942.14531-3-groug@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] 9p: fix leak in synth_name_to_path()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Leak found thanks to ASAN:

Direct leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x55995789ac90 in __interceptor_malloc (/home/elmarco/src/qemu/bui=
ld/x86_64-softmmu/qemu-system-x86_64+0x1510c90)
    #1 0x7f0a91190f0c in g_malloc /home/elmarco/src/gnome/glib/builddir/.=
./glib/gmem.c:94
    #2 0x5599580a281c in v9fs_path_copy /home/elmarco/src/qemu/hw/9pfs/9p=
.c:196:17
    #3 0x559958f9ec5d in coroutine_trampoline /home/elmarco/src/qemu/util=
/coroutine-ucontext.c:116:9
    #4 0x7f0a8766ebbf  (/lib64/libc.so.6+0x50bbf)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-synth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 18082dffe865..54239c9bbf32 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -495,6 +495,7 @@ static int synth_name_to_path(FsContext *ctx, V9fsPat=
h *dir_path,
     }
 out:
     /* Copy the node pointer to fid */
+    g_free(target->data);
     target->data =3D g_memdup(&node, sizeof(void *));
     target->size =3D sizeof(void *);
     return 0;
--=20
2.13.6
