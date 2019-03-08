Received: from eggs.gnu.org ([209.51.188.92]:38366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h2LSC-0007RI-BR
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h2LSB-0004Uv-ET
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:46:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1h2LSB-0004Su-4m
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:46:47 -0500
From: Bandan Das <bsd@redhat.com>
References: <20190307095441.31921-1-kraxel@redhat.com>
	<20190307095441.31921-4-kraxel@redhat.com>
	<CAFEAcA_HzSj7sQ+aKEwHmJXkJcG8yLmn5ZsZKM5xxYUrBxO2rQ@mail.gmail.com>
Date: Fri, 08 Mar 2019 14:46:41 -0500
In-Reply-To: <CAFEAcA_HzSj7sQ+aKEwHmJXkJcG8yLmn5ZsZKM5xxYUrBxO2rQ@mail.gmail.com>
	(Peter Maydell's message of "Fri, 8 Mar 2019 17:06:08 +0000")
Message-ID: <jpg36nxf8ta.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 3/4] usb-mtp: prevent null dereference while
 deleting objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 7 Mar 2019 at 09:56, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>> From: Bandan Das <bsd@redhat.com>
>>
>> Spotted by Coverity: CID 1399144
>>
>> Signed-off-by: Bandan Das <bsd@redhat.com>
>> Message-id: 20190306210409.14842-4-bsd@redhat.com
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  hw/usb/dev-mtp.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
>> index 1f22284949df..06e376bcd211 100644
>> --- a/hw/usb/dev-mtp.c
>> +++ b/hw/usb/dev-mtp.c
>> @@ -1177,9 +1177,7 @@ static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
>>              usb_mtp_object_free_one(s, o);
>>              success = true;
>>          }
>> -    }
>> -
>> -    if (o->format == FMT_ASSOCIATION) {
>> +    } else if (o->format == FMT_ASSOCIATION) {
>>          if (rmdir(o->path)) {
>>              partial_delete = true;
>>          } else {
>> --
>
> Hi; following this change Coverity now complains (CID 1399414)
> about dead code later in the file:
>
> In this set of if/else clauses, either we
> set partial_delete to true, or we set success to
> true, but never both:
>
>     if (o->format == FMT_UNDEFINED_OBJECT) {
>         if (remove(o->path)) {
>             partial_delete = true;
>         } else {
>             usb_mtp_object_free_one(s, o);
>             success = true;
>         }
>     } else if (o->format == FMT_ASSOCIATION) {
>         if (rmdir(o->path)) {
>             partial_delete = true;
>         } else {
>             usb_mtp_object_free_one(s, o);
>             success = true;
>         }
>     }
>
> and so here:
>
>     if (success && partial_delete) {
>         return PARTIAL_DELETE;
>     }
>
> the condition can never be true and the code inside
> the if () {} is dead.
>
> When is the routine intended to return the PARTIAL_DELETE
> return value ?
>

This is very broken! I think something like this should work:
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 06e376bcd2..87a4bfb415 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1138,8 +1138,8 @@ static MTPData *usb_mtp_get_object_prop_value(MTPState *s, MTPControl *c,
 /* Return correct return code for a delete event */
 enum {
     ALL_DELETE,
-    PARTIAL_DELETE,
     READ_ONLY,
+    PARTIAL_DELETE,
 };
 
 /* Assumes that children, if any, have been already freed */
@@ -1155,8 +1155,7 @@ static void usb_mtp_object_free_one(MTPState *s, MTPObject *o)
 static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
 {
     MTPObject *iter, *iter2;
-    bool partial_delete = false;
-    bool success = false;
+    int ret = 0;
 
     /*
      * TODO: Add support for Protection Status
@@ -1165,34 +1164,28 @@ static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
     QLIST_FOREACH(iter, &o->children, list) {
         if (iter->format == FMT_ASSOCIATION) {
             QLIST_FOREACH(iter2, &iter->children, list) {
-                usb_mtp_deletefn(s, iter2, trans);
+                ret |= usb_mtp_deletefn(s, iter2, trans);
             }
         }
     }
 
     if (o->format == FMT_UNDEFINED_OBJECT) {
         if (remove(o->path)) {
-            partial_delete = true;
+            ret |= READ_ONLY;
         } else {
             usb_mtp_object_free_one(s, o);
-            success = true;
+            ret |= ALL_DELETE;
         }
     } else if (o->format == FMT_ASSOCIATION) {
         if (rmdir(o->path)) {
-            partial_delete = true;
+            ret |= READ_ONLY;
         } else {
             usb_mtp_object_free_one(s, o);
-            success = true;
+            ret |= ALL_DELETE;
         }
     }
 
-    if (success && partial_delete) {
-        return PARTIAL_DELETE;
-    }
-    if (!success && partial_delete) {
-        return READ_ONLY;
-    }
-    return ALL_DELETE;
+    return ret;
 }
 
 static void usb_mtp_object_delete(MTPState *s, uint32_t handle,

I will test this and send a patch...

Bandan

> thanks
> -- PMM
