Received: from eggs.gnu.org ([2001:4830:134:3::10]:58863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dianchen.tdc@gmail.com>) id 1eMPSq-0003Vw-TF
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 21:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dianchen.tdc@gmail.com>) id 1eMPSq-0002F5-3j
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 21:29:36 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dianchen.tdc@gmail.com>)
	id 1eMPSp-0002EY-QB
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 21:29:36 -0500
Received: by mail-oi0-x244.google.com with SMTP id x20so1619461oix.12
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 18:29:35 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?55Sw5q6/6Iej?= <dianchen.tdc@gmail.com>
Date: Wed, 6 Dec 2017 10:29:34 +0800
Message-ID: <CABkJTM4RL4cZ0euYX7d8xPd7ozrN76nr0rafut0LBJmZWFD+Vw@mail.gmail.com>
Content-Type: multipart/mixed; boundary="001a11408d96e1e667055fa2b870"
Subject: [Qemu-devel] [PATCH] input: free InputEvent when it can't be
 inserted into a full kdb queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: icymemo@gmail.com, quan.xu0@gmail.com

--001a11408d96e1e667055fa2b870
Content-Type: text/plain; charset="UTF-8"

>From e8c03f405c2112428e79bb82064c7b7743d0cc86 Mon Sep 17 00:00:00 2001
From: Tian Dianchen <dianchen.tdc@gmail.com>
Date: Tue, 5 Dec 2017 14:03:53 +0800
Subject: [PATCH] input: free InputEvent when it can't be inserted into a
full
 kdb queue

When the kdb queue is full, the evt can't be placed in it, so it should
be released to free the memory.

Impact: Without this limit vnc clients can exhaust host memory by keep
sending keyboard events when kdb queue is full.

Reviewed-by: Zhang Chao <icymemo@gmail.com>
Reviewed-by: Quan Xu <quan.xu0@gmail.com>
Signed-off-by: Tian Dianchen <dianchen.tdc@gmail.com>
---
 ui/input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ui/input.c b/ui/input.c
index 3e2d324..e5b78aa 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -421,6 +421,8 @@ void qemu_input_event_send_key(QemuConsole *src,
KeyValue *key, bool down)
     } else if (queue_count < queue_limit) {
         qemu_input_queue_event(&kbd_queue, src, evt);
         qemu_input_queue_sync(&kbd_queue);
+    } else {
+        qapi_free_InputEvent(evt);
     }
 }

-- 
1.8.3.1

--001a11408d96e1e667055fa2b870
Content-Type: application/octet-stream;
	name="0001-input-free-InputEvent-when-it-can-t-be-inserted-into.patch"
Content-Disposition: attachment;
	filename="0001-input-free-InputEvent-when-it-can-t-be-inserted-into.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jaufjxnl0

RnJvbSBlOGMwM2Y0MDVjMjExMjQyOGU3OWJiODIwNjRjN2I3NzQzZDBjYzg2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaWFuIERpYW5jaGVuIDxkaWFuY2hlbi50ZGNAZ21haWwuY29t
PgpEYXRlOiBUdWUsIDUgRGVjIDIwMTcgMTQ6MDM6NTMgKzA4MDAKU3ViamVjdDogW1BBVENIXSBp
bnB1dDogZnJlZSBJbnB1dEV2ZW50IHdoZW4gaXQgY2FuJ3QgYmUgaW5zZXJ0ZWQgaW50byBhIGZ1
bGwKIGtkYiBxdWV1ZQoKV2hlbiB0aGUga2RiIHF1ZXVlIGlzIGZ1bGwsIHRoZSBldnQgY2FuJ3Qg
YmUgcGxhY2VkIGluIGl0LCBzbyBpdCBzaG91bGQKYmUgcmVsZWFzZWQgdG8gZnJlZSB0aGUgbWVt
b3J5LgoKSW1wYWN0OiBXaXRob3V0IHRoaXMgbGltaXQgdm5jIGNsaWVudHMgY2FuIGV4aGF1c3Qg
aG9zdCBtZW1vcnkgYnkga2VlcApzZW5kaW5nIGtleWJvYXJkIGV2ZW50cyB3aGVuIGtkYiBxdWV1
ZSBpcyBmdWxsLgoKUmV2aWV3ZWQtYnk6IFpoYW5nIENoYW8gPGljeW1lbW9AZ21haWwuY29tPgpS
ZXZpZXdlZC1ieTogUXVhbiBYdSA8cXVhbi54dTBAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBU
aWFuIERpYW5jaGVuIDxkaWFuY2hlbi50ZGNAZ21haWwuY29tPgotLS0KIHVpL2lucHV0LmMgfCAy
ICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdWkvaW5w
dXQuYyBiL3VpL2lucHV0LmMKaW5kZXggM2UyZDMyNC4uZTViNzhhYSAxMDA2NDQKLS0tIGEvdWkv
aW5wdXQuYworKysgYi91aS9pbnB1dC5jCkBAIC00MjEsNiArNDIxLDggQEAgdm9pZCBxZW11X2lu
cHV0X2V2ZW50X3NlbmRfa2V5KFFlbXVDb25zb2xlICpzcmMsIEtleVZhbHVlICprZXksIGJvb2wg
ZG93bikKICAgICB9IGVsc2UgaWYgKHF1ZXVlX2NvdW50IDwgcXVldWVfbGltaXQpIHsKICAgICAg
ICAgcWVtdV9pbnB1dF9xdWV1ZV9ldmVudCgma2JkX3F1ZXVlLCBzcmMsIGV2dCk7CiAgICAgICAg
IHFlbXVfaW5wdXRfcXVldWVfc3luYygma2JkX3F1ZXVlKTsKKyAgICB9IGVsc2UgeworICAgICAg
ICBxYXBpX2ZyZWVfSW5wdXRFdmVudChldnQpOwogICAgIH0KIH0KIAotLSAKMS44LjMuMQoK
--001a11408d96e1e667055fa2b870--
