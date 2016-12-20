Received: from eggs.gnu.org ([2001:4830:134:3::10]:35639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJTVT-0003Uz-N3
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJTVS-0006hB-I0
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:07:39 -0500
Received: from hera.aquilenet.fr ([2a01:474::1]:39510)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJTVS-0006gY-7E
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:07:38 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 21 Dec 2016 00:07:32 +0100
Message-Id: <20161220230732.17862-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20161220230732.17862-1-samuel.thibault@ens-lyon.org>
References: <20161220230732.17862-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] slirp: support dynamic block size for TFTP
 transfers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

The blocksize option is defined in RFC 1783 and RFC 2348.
We now support block sizes between 1 and 1428 bytes, instead of 512 only.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/tftp.c | 26 ++++++++++++++------------
 slirp/tftp.h |  8 +++++---
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/slirp/tftp.c b/slirp/tftp.c
index c1859066cc..50e714807d 100644
--- a/slirp/tftp.c
+++ b/slirp/tftp.c
@@ -72,6 +72,7 @@ static int tftp_session_allocate(Slirp *slirp, struct s=
ockaddr_storage *srcsas,
   memset(spt, 0, sizeof(*spt));
   spt->client_addr =3D *srcsas;
   spt->fd =3D -1;
+  spt->block_size =3D 512;
   spt->client_port =3D tp->udp.uh_sport;
   spt->slirp =3D slirp;
=20
@@ -115,7 +116,7 @@ static int tftp_read_data(struct tftp_session *spt, u=
int32_t block_nr,
     }
=20
     if (len) {
-        lseek(spt->fd, block_nr * 512, SEEK_SET);
+        lseek(spt->fd, block_nr * spt->block_size, SEEK_SET);
=20
         bytes_read =3D read(spt->fd, buf, len);
     }
@@ -189,7 +190,8 @@ static int tftp_send_oack(struct tftp_session *spt,
                       values[i]) + 1;
     }
=20
-    m->m_len =3D sizeof(struct tftp_t) - 514 + n - sizeof(struct udphdr)=
;
+    m->m_len =3D sizeof(struct tftp_t) - (TFTP_BLOCKSIZE_MAX + 2) + n
+               - sizeof(struct udphdr);
     tftp_udp_output(spt, m, recv_tp);
=20
     return 0;
@@ -214,7 +216,7 @@ static void tftp_send_error(struct tftp_session *spt,
   tp->x.tp_error.tp_error_code =3D htons(errorcode);
   pstrcpy((char *)tp->x.tp_error.tp_msg, sizeof(tp->x.tp_error.tp_msg), =
msg);
=20
-  m->m_len =3D sizeof(struct tftp_t) - 514 + 3 + strlen(msg)
+  m->m_len =3D sizeof(struct tftp_t) - (TFTP_BLOCKSIZE_MAX + 2) + 3 + st=
rlen(msg)
              - sizeof(struct udphdr);
   tftp_udp_output(spt, m, recv_tp);
=20
@@ -240,7 +242,8 @@ static void tftp_send_next_block(struct tftp_session =
*spt,
   tp->tp_op =3D htons(TFTP_DATA);
   tp->x.tp_data.tp_block_nr =3D htons((spt->block_nr + 1) & 0xffff);
=20
-  nobytes =3D tftp_read_data(spt, spt->block_nr, tp->x.tp_data.tp_buf, 5=
12);
+  nobytes =3D tftp_read_data(spt, spt->block_nr, tp->x.tp_data.tp_buf,
+                           spt->block_size);
=20
   if (nobytes < 0) {
     m_free(m);
@@ -252,10 +255,11 @@ static void tftp_send_next_block(struct tftp_sessio=
n *spt,
     return;
   }
=20
-  m->m_len =3D sizeof(struct tftp_t) - (512 - nobytes) - sizeof(struct u=
dphdr);
+  m->m_len =3D sizeof(struct tftp_t) - (TFTP_BLOCKSIZE_MAX - nobytes)
+             - sizeof(struct udphdr);
   tftp_udp_output(spt, m, recv_tp);
=20
-  if (nobytes =3D=3D 512) {
+  if (nobytes =3D=3D spt->block_size) {
     tftp_session_update(spt);
   }
   else {
@@ -385,13 +389,11 @@ static void tftp_handle_rrq(Slirp *slirp, struct so=
ckaddr_storage *srcsas,
       } else if (strcasecmp(key, "blksize") =3D=3D 0) {
           int blksize =3D atoi(value);
=20
-          /* If blksize option is bigger than what we will
-           * emit, accept the option with our packet size.
-           * Otherwise, simply do as we didn't see the option.
-           */
-          if (blksize >=3D 512) {
+          /* Accept blksize up to our maximum size */
+          if (blksize > 0) {
+              spt->block_size =3D MIN(blksize, TFTP_BLOCKSIZE_MAX);
               option_name[nb_options] =3D "blksize";
-              option_value[nb_options] =3D 512;
+              option_value[nb_options] =3D spt->block_size;
               nb_options++;
           }
       }
diff --git a/slirp/tftp.h b/slirp/tftp.h
index 2cd276dec6..a4c4a64e64 100644
--- a/slirp/tftp.h
+++ b/slirp/tftp.h
@@ -15,6 +15,7 @@
 #define TFTP_OACK   6
=20
 #define TFTP_FILENAME_MAX 512
+#define TFTP_BLOCKSIZE_MAX 1428
=20
 struct tftp_t {
   struct udphdr udp;
@@ -22,13 +23,13 @@ struct tftp_t {
   union {
     struct {
       uint16_t tp_block_nr;
-      uint8_t tp_buf[512];
+      uint8_t tp_buf[TFTP_BLOCKSIZE_MAX];
     } tp_data;
     struct {
       uint16_t tp_error_code;
-      uint8_t tp_msg[512];
+      uint8_t tp_msg[TFTP_BLOCKSIZE_MAX];
     } tp_error;
-    char tp_buf[512 + 2];
+    char tp_buf[TFTP_BLOCKSIZE_MAX + 2];
   } x;
 } __attribute__((packed));
=20
@@ -36,6 +37,7 @@ struct tftp_session {
     Slirp *slirp;
     char *filename;
     int fd;
+    uint16_t block_size;
=20
     struct sockaddr_storage client_addr;
     uint16_t client_port;
--=20
2.11.0
