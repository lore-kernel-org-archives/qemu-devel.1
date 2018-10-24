Received: from eggs.gnu.org ([2001:4830:134:3::10]:56182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gFRcc-0001Ca-5b
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 18:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gFRcQ-00015h-ER
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 18:27:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gFRcP-000103-PP
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 18:27:14 -0400
References: <1540243704-17090-1-git-send-email-george.kennedy@oracle.com>
	<596ea83a-279e-3a76-ead3-14aa8efe0a1d@redhat.com>
	<43e65c7a-f44d-797b-ab0c-389eaa0c0f82@oracle.com>
	<0e52d605-871e-cdac-c1ae-b0da912611ba@redhat.com>
	<adc9e69a-487b-44a6-7029-bff65f25801b@oracle.com>
	<baf9d1db-51b7-939f-1f46-553c4fdd5939@redhat.com>
	<51309caa-23eb-9c3b-329e-2885fe13d905@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <394610f8-1bfd-62ef-247b-8ad6330f3d4a@redhat.com>
Date: Thu, 25 Oct 2018 00:27:01 +0200
MIME-Version: 1.0
In-Reply-To: <51309caa-23eb-9c3b-329e-2885fe13d905@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] lsi: Reselection needed to remove
 pending commands from queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: George Kennedy <george.kennedy@oracle.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 24/10/2018 15:06, George Kennedy wrote:
>>
>>
>> Why didn't lsi_do_command invoke lsi_queue_command?=C2=A0 That would s=
et
>> s->current to NULL (on the SCSI level, that means the bus is freed; on
>> the QEMU level, the idea is that lsi_transfer_data would then start a
>> reselection).
>=20
> Through the extended period of time with no call to lsi_reselect(), the
> check of "s->command_complete" in lsi_do_command() is always "1" and
> therefore no call to lsi_queue_command() occurs.
>=20
> "s->command_complete" is set to "1" in lsi_transfer_data().

Ok, I think we're getting closer.  If the data transfer is from the
device (read), then you can disconnect until the read is complete.

If the data transfer however is to the device (write), there will be
immediately a call to scsi_transfer_data, in order to get the written
data, and s->command_complete is set to 1.

However, this is wrong: the DMA transfer doesn't per se prevent a
disconnect and a later reselect, and this might be the bug.  Basically
we want to get rid of the "s->command_complete =3D 1" case completely.
The patch to do this change in the SCSI bus handling would look
something like this (untested):

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d1e6534311..c32ef40e78 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -565,6 +565,21 @@ static void lsi_bad_selection(LSIState *s, uint32_t =
id)
     lsi_disconnect(s);
 }

+/* Disconnect when DMA has finished but the command did not
+ * complete immediately.
+ */
+static void lsi_maybe_disconnect(LSIState *s)
+{
+    if (!s->current->dma_len && !s->command_complete) {
+        lsi_add_msg_byte(s, 2); /* SAVE DATA POINTER */
+        lsi_add_msg_byte(s, 4); /* DISCONNECT */
+        /* wait data */
+        lsi_set_phase(s, PHASE_MI);
+        s->msg_action =3D 1;
+        lsi_queue_command(s);
+    }
+}
+
 /* Initiate a SCSI layer data transfer.  */
 static void lsi_do_dma(LSIState *s, int out)
 {
@@ -612,6 +627,7 @@ static void lsi_do_dma(LSIState *s, int out)
     if (s->current->dma_len =3D=3D 0) {
         s->current->dma_buf =3D NULL;
         scsi_req_continue(s->current->req);
+        lsi_maybe_disconnect(s);
     } else {
         s->current->dma_buf +=3D count;
         lsi_resume_script(s);
@@ -631,7 +647,6 @@ static void lsi_queue_command(LSIState *s)
     s->current =3D NULL;

     p->pending =3D 0;
-    p->out =3D (s->sstat1 & PHASE_MASK) =3D=3D PHASE_DO;
 }

 /* Queue a byte for a MSG IN phase.  */
@@ -746,7 +761,7 @@ static void lsi_command_complete(SCSIRequest *req,
     out =3D (s->sstat1 & PHASE_MASK) =3D=3D PHASE_DO;
     trace_lsi_command_complete(status);
     s->status =3D status;
-    s->command_complete =3D 2;
+    s->command_complete =3D 1;
     if (s->waiting && s->dbc !=3D 0) {
         /* Raise phase mismatch for short transfers.  */
         lsi_bad_phase(s, out, PHASE_ST);
@@ -781,7 +796,6 @@ static void lsi_transfer_data(SCSIRequest *req,
     /* host adapter (re)connected */
     trace_lsi_transfer_data(req->tag, len);
     s->current->dma_len =3D len;
-    s->command_complete =3D 1;
     if (s->waiting) {
         if (s->waiting =3D=3D 1 || s->dbc =3D=3D 0) {
             lsi_resume_script(s);
@@ -819,28 +833,12 @@ static void lsi_do_command(LSIState *s)
                                    s->current);

     n =3D scsi_req_enqueue(s->current->req);
+    s->current->out =3D (n < 0);
+    lsi_set_phase(s, s->current->out ? PHASE_DO : PHASE_DI);
     if (n) {
-        if (n > 0) {
-            lsi_set_phase(s, PHASE_DI);
-        } else if (n < 0) {
-            lsi_set_phase(s, PHASE_DO);
-        }
         scsi_req_continue(s->current->req);
     }
-    if (!s->command_complete) {
-        if (n) {
-            /* Command did not complete immediately so disconnect.  */
-            lsi_add_msg_byte(s, 2); /* SAVE DATA POINTER */
-            lsi_add_msg_byte(s, 4); /* DISCONNECT */
-            /* wait data */
-            lsi_set_phase(s, PHASE_MI);
-            s->msg_action =3D 1;
-            lsi_queue_command(s);
-        } else {
-            /* wait command complete */
-            lsi_set_phase(s, PHASE_DI);
-        }
-    }
+    lsi_maybe_disconnect(s);
 }

 static void lsi_do_status(LSIState *s)


Of course, this doesn't include the change to WAIT RESELECT handling.
It only ensures (or attempts to ensure) that the bus is disconnected and
later reselected on long-running I/O, no matter the data direction.

Thanks,

Paolo
