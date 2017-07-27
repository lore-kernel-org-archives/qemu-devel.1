Received: from eggs.gnu.org ([2001:4830:134:3::10]:52354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dakB5-0004os-JJ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dakB1-00059e-Hy
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:54:15 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dakB1-00058Z-8C
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:54:11 -0400
Received: by mail-wm0-f43.google.com with SMTP id c184so107538653wmd.0
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 07:54:11 -0700 (PDT)
References: <20170727024224.22900-1-f4bug@amsat.org>
	<20170727024224.22900-17-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1fac8158-b1b4-5dea-9111-ef6ed3602ee4@redhat.com>
Date: Thu, 27 Jul 2017 16:54:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170727024224.22900-17-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 17/20] bt-sdp: fix memory leak
 in sdp_service_record_build()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 27/07/2017 04:42, Philippe Mathieu-Daudé wrote:
> hw/bt/sdp.c:753:5: warning: Potential leak of memory pointed to by 'data'
>     qsort(record->attribute_list, record->attributes,
>     ^~~~~
> 
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> hw/bt/*:
> get_maintainer.pl: No maintainers found
> 
>  hw/bt/sdp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/bt/sdp.c b/hw/bt/sdp.c
> index f67b3b89c0..7b2186e1f4 100644
> --- a/hw/bt/sdp.c
> +++ b/hw/bt/sdp.c
> @@ -711,7 +711,7 @@ static void sdp_service_record_build(struct sdp_service_record_s *record,
>                  struct sdp_def_service_s *def, int handle)
>  {
>      int len = 0;
> -    uint8_t *data;
> +    uint8_t *buf, *data;
>      int *uuid;
>  
>      record->uuids = 0;
> @@ -725,7 +725,8 @@ static void sdp_service_record_build(struct sdp_service_record_s *record,
>              g_malloc0(record->attributes * sizeof(*record->attribute_list));
>      record->uuid =
>              g_malloc0(record->uuids * sizeof(*record->uuid));
> -    data = g_malloc(len);
> +    buf = g_malloc(len);
> +    data = buf;
>  
>      record->attributes = 0;
>      uuid = record->uuid;
> @@ -748,6 +749,7 @@ static void sdp_service_record_build(struct sdp_service_record_s *record,
>          record->attribute_list[record->attributes ++].len = len;
>          data += len;
>      }
> +    g_free(buf);
>  
>      /* Sort the attribute list by the AttributeID */
>      qsort(record->attribute_list, record->attributes,
> 

This is wrong, but the code is insane and wrong too so it's not your
fault. :)  The allocated memory escapes here:
    
            record->attribute_list[record->attributes].pair = data;
    
So clang is correct that the memory might leak if len is zero.  We
know it isn't, so there is no leak.  An assertion could shut up clang.

But the craziness doesn't end there.  The memory is freed by
bt_l2cap_sdp_close_ch:
    
           g_free(sdp->service_list[i].attribute_list->pair);
    
which actually should have been written:
    
           g_free(sdp->service_list[i].attribute_list[0].pair);

because the first element of the array points to the malloc-ed buffer.

The attribute_list is sorted with qsort, which would be very fishy,
but indeed the first entry of attribute_list should point to data
even after the qsort, because the first record has id
SDP_ATTR_RECORD_HANDLE, whose numeric value is zero.  Another
assertion will help here but... hang on...

the qsort function is
    
        static int sdp_attributeid_compare(
                    const struct sdp_service_attribute_s *a,
                    const struct sdp_service_attribute_s *b)
        {
            return (int) b->attribute_id - a->attribute_id;
        }
    
and _no one ever_ writes attribute_id.  So it only works if qsort is
stable, and who knows what else is broken, but we can fix it by
setting attribute_id in the while loop.

The patch after the signature should do it.  Please review carefully
because I've no idea how to test this stuff.

Paolo

diff --git a/hw/bt/sdp.c b/hw/bt/sdp.c
index f67b3b89c0..f16a0f0b09 100644
--- a/hw/bt/sdp.c
+++ b/hw/bt/sdp.c
@@ -580,7 +580,7 @@ static void bt_l2cap_sdp_close_ch(void *opaque)
     int i;
 
     for (i = 0; i < sdp->services; i ++) {
-        g_free(sdp->service_list[i].attribute_list->pair);
+        g_free(sdp->service_list[i].attribute_list[0].pair);
         g_free(sdp->service_list[i].attribute_list);
         g_free(sdp->service_list[i].uuid);
     }
@@ -720,6 +720,8 @@ static void sdp_service_record_build(struct sdp_service_record_s *record,
         len += sdp_attr_max_size(&def->attributes[record->attributes ++].data,
                         &record->uuids);
     }
+
+    assert(len > 0);
     record->uuids = pow2ceil(record->uuids);
     record->attribute_list =
             g_malloc0(record->attributes * sizeof(*record->attribute_list));
@@ -730,12 +730,14 @@ static void sdp_service_record_build(struct sdp_service_record_s *record,
     record->attributes = 0;
     uuid = record->uuid;
     while (def->attributes[record->attributes].data.type) {
+        int attribute_id = def->attributes[record->attributes].id;
         record->attribute_list[record->attributes].pair = data;
+        record->attribute_list[record->attributes].attribute_id = attribute_id;
 
         len = 0;
         data[len ++] = SDP_DTYPE_UINT | SDP_DSIZE_2;
-        data[len ++] = def->attributes[record->attributes].id >> 8;
-        data[len ++] = def->attributes[record->attributes].id & 0xff;
+        data[len ++] = attribute_id >> 8;
+        data[len ++] = attribute_id & 0xff;
         len += sdp_attr_write(data + len,
                         &def->attributes[record->attributes].data, &uuid);
 
@@ -749,10 +751,15 @@ static void sdp_service_record_build(struct sdp_service_record_s *record,
         data += len;
     }
 
-    /* Sort the attribute list by the AttributeID */
+    /* Sort the attribute list by the AttributeID.  The first must be
+     * SDP_ATTR_RECORD_HANDLE so that bt_l2cap_sdp_close_ch can free
+     * the buffer.
+     */
     qsort(record->attribute_list, record->attributes,
                     sizeof(*record->attribute_list),
                     (void *) sdp_attributeid_compare);
+    assert(record->attribute_list[0].pair == data);
+
     /* Sort the searchable UUIDs list for bisection */
     qsort(record->uuid, record->uuids,
                     sizeof(*record->uuid),
